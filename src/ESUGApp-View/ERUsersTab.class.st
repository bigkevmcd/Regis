Class {
	#name : #ERUsersTab,
	#superclass : #ERConfigurationTab,
	#instVars : [
		'formUser',
		'newUser'
	],
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERUsersTab >> addUser [
	self initializeFormAddUser.
	content state: formUser
	
]

{ #category : #rendering }
ERUsersTab >> addUserToConference [
	| result |
	result := controller addUser: newUser.
	result
		ifNil: [ Transcript show: 'This email already registered' ]
		ifNotNil: [ content state: content lastState ]
]

{ #category : #rendering }
ERUsersTab >> blockTableToExecute [
	^ [ :user | 
	OrderedCollection new
		add: ([ :att | att firstName ] value: user);
		add: ([ :att | att rolesAsString ] value: user);
		add: ([ :att | att email ] value: user);
		yourself ]
]

{ #category : #rendering }
ERUsersTab >> deleteUser: user [
]

{ #category : #rendering }
ERUsersTab >> exportUsers [
	(self fileExists: 'users.cvs')
		ifFalse: [ controller exportUsers ]
		ifTrue: [ Transcript show: 'File Exist' ]
]

{ #category : #rendering }
ERUsersTab >> headers [
	^ #('Name' 'Admin Role' 'Email' '')
]

{ #category : #rendering }
ERUsersTab >> initializeFormAddUser [
	newUser := ERAttendee new.
	formUser := ERBasicInformationView
		on: newUser
		withContent: content
		withAction: [ self addUserToConference ]
]

{ #category : #rendering }
ERUsersTab >> listDataToRenderButton [
	^ OrderedCollection new
		add:
			(Array
				with: 'Modify'
				with: [ :user | self modifyUserFormGroup: user ]
				with: [ :user | user id , '-modify' ]);
		add:
			(Array
				with: 'Delete'
				with: [ :user | self deleteUser: user ]
				with: [ :user | user id , '-delete' ]);
		add:
			(Array
				with: 'Reset Password'
				with: [ :user | self resetPassword: user ]
				with: [ :user | user id , '-resetPassword' ]);
		yourself
]

{ #category : #rendering }
ERUsersTab >> renderButtons: html [
	self
		createColoredAnchorButton: 'Add'
		with: [ self addUser ]
		id: 'addUser'
		on: html.
	self
		createColoredAnchorButton: 'Export'
		with: [ self exportUsers ]
		id: 'exportUsers'
		on: html
]

{ #category : #rendering }
ERUsersTab >> renderContainer: html [
	html form
		method: 'post';
		id: 'formAllUsers';
		with: [ self renderButtons: html.
			html horizontalRule.
			self renderTableOfUsers: html ]
]

{ #category : #rendering }
ERUsersTab >> renderTableOfUsers: html [
	| table |
	table := ERTable new
		headers: self headers;
		levelTotal: 6;
		listObject: self users;
		blockToExecute: self blockTableToExecute;
		listToRenderButton: self listDataToRenderButton.
	html render: table
]

{ #category : #rendering }
ERUsersTab >> resetPassword: user [
]

{ #category : #accessing }
ERUsersTab >> tabId [
	^ 'allUsers'
]

{ #category : #accessing }
ERUsersTab >> tabName [
	^ 'Users'
]

{ #category : #accessing }
ERUsersTab >> title [
	^ 'All User'
]

{ #category : #rendering }
ERUsersTab >> users [
	^ controller users
]