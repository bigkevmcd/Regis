Class {
	#name : #ERFieldCheckerTest,
	#superclass : #ERTest,
	#category : #'ESUGApp-Tests-UnitTest'
}

{ #category : #tests }
ERFieldCheckerTest >> testFirstNameFieldWithFormat [

	| errors userAccount |
	userAccount := (self class testUserAccount) firstName: 'John'; yourself.
	errors := userAccount asComponent validate; errors.
	self assert: 0 equals: errors size.
]

{ #category : #tests }
ERFieldCheckerTest >> testFirstNameFieldWithoutFormat [

	| errors userAccount |
	userAccount := (self class testUserAccount) firstName: '123456789'; yourself.
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'Please enter a valid firstName' equals: ((errors at:1) collection at:1) messageText.
]

{ #category : #tests }
ERFieldCheckerTest >> testLastNameFieldWithFormat [

	| errors userAccount |
	userAccount := (self class testUserAccount) lastName: 'Anderson'; yourself.
	errors := userAccount asComponent validate; errors.
	self assert: 0 equals: errors size.
]

{ #category : #tests }
ERFieldCheckerTest >> testLastNameFieldWithoutFormat [

	| errors userAccount |
	userAccount := (self class testUserAccount) lastName: '123456789'; yourself.
	errors := userAccount asComponent validate; errors.
	self assert: 1 equals: errors size.
	self assert: 'Please enter a valid lastName' equals: ((errors at:1) collection at:1) messageText.
]
