"
Description
--------------------

A ERTestBackupAndRestore is a test class for testing the behavior of backup and restore of the page
"
Class {
	#name : #ERBackupAndRestoreTest,
	#superclass : #ERTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #accessing }
ERBackupAndRestoreTest >> backupDirectory [
	"Directory of Backup files"

	^ (FileSystem workingDirectory asFileReference / 'Backup')
		 ensureCreateDirectory
]

{ #category : #accessing }
ERBackupAndRestoreTest >> filesSizeOfBackup [
	"Size of Backup file"

	^ self backupDirectory files size
]

{ #category : #tests }
ERBackupAndRestoreTest >> testBackupAfterRegisterAttendee [

	| filesAfterBackup filesBeforeBackup |
	filesBeforeBackup := self filesSizeOfBackup.
	self registerAttendee.
	self wait.
	filesAfterBackup := self filesSizeOfBackup.
	self assert: filesBeforeBackup < filesAfterBackup
]

{ #category : #tests }
ERBackupAndRestoreTest >> testBackupAfterRegisterAttendeeFromGroup [

	| filesAfterBackup filesBeforeBackup user group aController |
	user := self registerAsGroupManager.
	filesBeforeBackup := self filesSizeOfBackup.
	user := self registerAsGroupManager.
	group := self groupOfUser: user.
	aController := ERGroupController new group: group.
	aController addAttendee: (self class testAttendee: 'test1@gmail.com').
	self wait.
	filesAfterBackup := self filesSizeOfBackup.
	self assert: filesBeforeBackup < filesAfterBackup
]

{ #category : #tests }
ERBackupAndRestoreTest >> testBackupAfterRegisterGroupManager [

	| filesAfterBackup filesBeforeBackup |
	filesBeforeBackup := self filesSizeOfBackup.
	self registerAsGroupManager.
	self wait.
	filesAfterBackup := self filesSizeOfBackup.
	self assert: filesBeforeBackup < filesAfterBackup
]

{ #category : #tests }
ERBackupAndRestoreTest >> testRestoreData [

	"This test verify that the state after restore is equal to data was removed"

	| stateBefore stateAfter |
	self registerAsGroupManager.
	self wait.
	stateBefore := ERBackupRestore new objectsToBackup.
	ESUGSetUp
		cleanDatabase;
		restoreData.
	self wait.
	stateAfter := ERBackupRestore new objectsToBackup.

	self assertCollection: stateBefore hasSameElements: stateAfter
]

{ #category : #accessing }
ERBackupAndRestoreTest >> wait [

	"Since the backup process is in a fork, we need to wait to ensure the backup happened."

	(Delay forSeconds: 3) wait
]
