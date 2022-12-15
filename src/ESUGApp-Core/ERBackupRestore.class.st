"
Description
--------------------

I am a class that control the generation of backup of page.

Instance Variables
--------------------
	version: a Number with that each backup will be saved
"
Class {
	#name : #ERBackupRestore,
	#superclass : #Object,
	#instVars : [
		'version'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : #'ESUGApp-Core'
}

{ #category : #accessing }
ERBackupRestore class >> uniqueInstance [
	^ uniqueInstance ifNil: [ uniqueInstance := super new ]
]

{ #category : #'actions api' }
ERBackupRestore >> backup [

	[ 
	[ 
	self lock critical: [ 
		| file |
		file := self referenceFile.
		self deleteBackupsOlderThan10Versions.
		self writeSTONFile: file ] ]
		on: Error
		do: [ :error | ERException backupError signal ] ] forkAt: Processor userBackgroundPriority named: self subProcessName
]

{ #category : #accessing }
ERBackupRestore >> backupDirectory [

	^ (FileSystem workingDirectory / self nameDirectory) ensureCreateDirectory
]

{ #category : #accessing }
ERBackupRestore >> backupFiles [

	^ self backupDirectory files select: [ :fileName | fileName basenameWithoutExtension = self fileNamePrefix ]
]

{ #category : #actions }
ERBackupRestore >> deleteBackupsOlderThan10Versions [

	self backupDirectory allFiles
		select: [ :n | n extension asNumber <= (self version - 10) ]
		thenDo: #delete
]

{ #category : #accessing }
ERBackupRestore >> fileNamePrefix [
	^ 'esug'
]

{ #category : #actions }
ERBackupRestore >> incrementVersionNumber [
	^ version := self version + 1
]

{ #category : #accessing }
ERBackupRestore >> lastBackup [

	^ self lastBackupFile ifNotNil: [ :lastBackup | self readSTONOf: lastBackup ]
]

{ #category : #accessing }
ERBackupRestore >> lastBackupFile [

	^ self backupFiles detectMax: #version
]

{ #category : #'actions api' }
ERBackupRestore >> lock [ 
	^ Semaphore forMutualExclusion 
]

{ #category : #accessing }
ERBackupRestore >> nameDirectory [
	^ 'Backup'
]

{ #category : #accessing }
ERBackupRestore >> objectsToBackup [
	^ OrderedCollection new
		add: ERFee findAll;
		add: ERUserAccount findAll;
		add: ERReductionTicket findAll;
		add: ERAttendee findAll;
		add: ERGroup findAll;
		add: ERAward findAll;
		add: ERTalk findAll;
		add: ERConference findAll;
		yourself
]

{ #category : #'actions api' }
ERBackupRestore >> readSTONOf: aFile [
	^ aFile readStreamDo: [ :stream | STON fromString: stream contents ]
]

{ #category : #'actions api' }
ERBackupRestore >> referenceFile [

	^ self backupDirectory / (self fileNamePrefix , '.' , self incrementVersionNumber asString)
]

{ #category : #'actions api' }
ERBackupRestore >> restoreBackup [
	self updateVersionToLastVersionOfBackup.
	self lastBackup ifNotNil: [ :backup | backup do: 
		[ :aClass | aClass do: [ :anObject | anObject save ] ] ]
]

{ #category : #'actions api' }
ERBackupRestore >> restoreBackup: aFilePath [

	| aFile |
	self flag: #todo. "This does not seems right. We never set anything in the #aFile variable..."
	self updateVersionToLastVersionOfBackup: aFilePath.
	aFile ifNotNil: [ :backup | backup do: [ :aClass | aClass do: [ :anObject | anObject save ] ] ]
]

{ #category : #'actions api' }
ERBackupRestore >> subProcessName [

	^ 'backup:' , self version asString
]

{ #category : #'actions api' }
ERBackupRestore >> updateVersionToLastVersionOfBackup [

	self version: self lastBackupFile version
]

{ #category : #'actions api' }
ERBackupRestore >> updateVersionToLastVersionOfBackup: aFilePath [

	self flag: #todo. "I don't really understand the logic here"
	self version: (self class new lastBackupFile
			 ifNil: [ (aFilePath substrings: '.') last asInteger ]
			 ifNotNil: #version)
]

{ #category : #accessing }
ERBackupRestore >> version [

	^ version ifNil: [ version := 0 ]
]

{ #category : #accessing }
ERBackupRestore >> version: aNumber [

	version := aNumber
]

{ #category : #'actions api' }
ERBackupRestore >> writeSTONFile: file [

	^ file writeStreamDo: [ :stream | stream nextPutAll: (STON toStringPretty: self objectsToBackup) ]
]
