Class {
	#name : #ERConference,
	#superclass : #SDActiveRecord,
	#instVars : [
		'attends',
		'fees',
		'reductionTickets',
		'submittedTalks',
		'submittedAwards',
		'payments',
		'groups',
		'users',
		'configuration',
		'active'
	],
	#category : #'ESUGApp-Models'
}

{ #category : #accessing }
ERConference >> active [
	^ active
]

{ #category : #accessing }
ERConference >> active: anObject [
	active := anObject
]

{ #category : #initialization }
ERConference >> addAttendee: anAttendee [
	attends add: anAttendee 
]

{ #category : #initialization }
ERConference >> addFee: aFee [
	fees add: aFee 
]

{ #category : #initialization }
ERConference >> addGroup: aGroup [
	groups add: aGroup 
]

{ #category : #initialization }
ERConference >> addPayment: aPayment [
	payments add: aPayment 
]

{ #category : #accessing }
ERConference >> addReductionTicket: aReductionTicket [
	reductionTickets add: aReductionTicket 
]

{ #category : #accessing }
ERConference >> addSubmittedAward: aSubmittedAward [
	submittedAwards add: aSubmittedAward 
]

{ #category : #accessing }
ERConference >> addSubmittedTalk: aSubmittedTalk [
	submittedTalks add: aSubmittedTalk 
]

{ #category : #accessing }
ERConference >> addUser: anUser [
	users add: anUser 
]

{ #category : #accessing }
ERConference >> attends [
	^ attends
]

{ #category : #accessing }
ERConference >> attends: anObject [
	attends := anObject
]

{ #category : #accessing }
ERConference >> configuration [
	^ configuration
]

{ #category : #accessing }
ERConference >> configuration: anObject [
	configuration := anObject
]

{ #category : #accessing }
ERConference >> fees [
	^ fees
]

{ #category : #accessing }
ERConference >> fees: anObject [
	fees := anObject
]

{ #category : #accessing }
ERConference >> groups [
	^ groups
]

{ #category : #accessing }
ERConference >> groups: anObject [
	groups := anObject
]

{ #category : #initialization }
ERConference >> initialize [
	super initialize.
	attends := OrderedCollection new.
	fees := OrderedCollection new.
	groups := OrderedCollection new.
	payments := OrderedCollection new.
	reductionTickets := OrderedCollection new.
	submittedAwards := OrderedCollection new.
	submittedTalks := OrderedCollection new.
	users := OrderedCollection new.
	active := false
]

{ #category : #accessing }
ERConference >> payments [
	^ payments
]

{ #category : #accessing }
ERConference >> payments: anObject [
	payments := anObject
]

{ #category : #accessing }
ERConference >> reductionTickets [
	^ reductionTickets
]

{ #category : #accessing }
ERConference >> reductionTickets: anObject [
	reductionTickets := anObject
]

{ #category : #accessing }
ERConference >> submittedAwards [
	^ submittedAwards
]

{ #category : #accessing }
ERConference >> submittedAwards: anObject [
	submittedAwards := anObject
]

{ #category : #accessing }
ERConference >> submittedTalks [
	^ submittedTalks
]

{ #category : #accessing }
ERConference >> submittedTalks: anObject [
	submittedTalks := anObject
]

{ #category : #accessing }
ERConference >> users [
	^ users
]

{ #category : #accessing }
ERConference >> users: anObject [
	users := anObject
]