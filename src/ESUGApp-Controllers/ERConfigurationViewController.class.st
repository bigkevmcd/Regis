Class {
	#name : #ERConfigurationViewController,
	#superclass : #ERLoggedController,
	#category : #'ESUGApp-Controllers'
}

{ #category : #adding }
ERConfigurationViewController >> addAttendee: anAttendee [
	| anAttendeeSaved |
	(ERUserAccount findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			conference addUser: userSaved.
			anAttendeeSaved := (anAttendee userAccount: userSaved) save.
			conference addAttendee: anAttendeeSaved.
			conference save.
			^ anAttendeeSaved ].
	^ nil
]

{ #category : #adding }
ERConfigurationViewController >> addUser: anAttendee [
	(ERUserAccount findUserByEmail: anAttendee email)
		ifNil: [ | userSaved |
			userSaved := anAttendee userAccount save.
			conference addUser: userSaved.
			^ userSaved ].
	^ nil
]

{ #category : #accessing }
ERConfigurationViewController >> attends [
	^ conference attends 
]

{ #category : #rendering }
ERConfigurationViewController >> createFile: aNameFile [
	^ FileStream newFileNamed: aNameFile.
]

{ #category : #rendering }
ERConfigurationViewController >> deleteFee: aFee [
	conference fees removeAllSuchThat: [ :each | each id = aFee id ].
	^ aFee delete.
]

{ #category : #'as yet unclassified' }
ERConfigurationViewController >> deleteReductionTicket: aReductionTicket [
	aReductionTicket usersOfTickets size > 0
		ifTrue: [ ^ nil ]
		ifFalse: [ conference reductionTickets
				removeAllSuchThat: [ :each | each ticketId = aReductionTicket ticketId ].
				aReductionTicket delete ]
]

{ #category : #rendering }
ERConfigurationViewController >> deleteUser: anUser [
	"The admin user can not be deleted"
	anUser isAdmin ifFalse: [  ]
	ifTrue: [ ^ nil ]
]

{ #category : #rendering }
ERConfigurationViewController >> exportAttends [
	| file cvs |
	file := self createFile: 'attends.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs writeHeader: self headerAttendee.
	self attends
		do: [ :each | 
			cvs
				nextPut:
					{each id.
					each firstName.
					each lastName.
					each email.
					each password.
					each userAccount rolesAsString.
					each address.
					each address2.
					each city.
					each country.
					each province.
					each postal.
					each facebookURL.
					each twitterURL.
					each homePage.
					''.
					each gender.
					each tshirtSize.
					each foodPreference.
					each attendSocialEvent asString.
					each addedToMainList asString.
					each orgName.
					each orgAddrees1.
					each orgAddrees2.
					each orgCity.
					each orgCountry.
					each orgProvince.
					each orgPostal.
					each membershipType.
					each keywords.
					each additionalText.
					each paymentType.
					each coupon.
					each paymentCurrency} ]
]

{ #category : #rendering }
ERConfigurationViewController >> exportAwards [
	| file cvs |
	file := self createFile: 'awards.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs writeHeader: self hearderAwards.
	self submittedAwards
		do: [ :each | 
			cvs
				nextPut:
					{each name1.
					each submittedBy.} ]
]

{ #category : #rendering }
ERConfigurationViewController >> exportGroupManagers [
	| file cvs |
	file := self createFile: 'groupManagers.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs writeHeader: self headerGroups.
	self groups
		do: [ :each | 
			cvs
				nextPut:
					{each groupManager id.
					each groupManager firstName.
					each groupManager lastName.
					each groupManager email.
					each groupManager password.
					each groupManager userAccount rolesAsString.
					each groupManager orgName.
					each groupManager orgAddrees1.
					each groupManager orgAddrees2.
					each groupManager orgCity.
					each groupManager orgCountry.
					each groupManager orgProvince.
					each groupManager orgPostal.
					each groupManager membershipType} ]
]

{ #category : #rendering }
ERConfigurationViewController >> exportTalks [
	| file cvs |
	file := self createFile: 'talks.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs writeHeader: self headerTalks.
	self submittedTalks
		do: [ :each | 
			cvs
				nextPut:
					{each name1.
					each submittedBy.
					each uploadFile} ]
]

{ #category : #rendering }
ERConfigurationViewController >> exportUsers [
	| file cvs |
	file := self createFile: 'users.cvs'.
	cvs := NeoCSVWriter on: file.
	cvs
		writeHeader: self headerUser.
	self users
		do: [ :each | 
			cvs
				nextPut:
					{each id.
					each firstName.
					each lastName.
					each email.
					each password.
					each rolesAsString} ]
]

{ #category : #accessing }
ERConfigurationViewController >> fees [
	^ conference fees
]

{ #category : #accessing }
ERConfigurationViewController >> groups [
	^ conference groups 
]

{ #category : #rendering }
ERConfigurationViewController >> headerAttendee [
	^ #('Id' 'FirstName' 'LastName' 'Email' 'Password' 'Role' 'Address Line1' 'Address Line2' 'City' 'Country' 'Province' 'Postal' 'Facebook URL' 'Twitter URL' 'Home Page' 'Days' 'Gender' 'T-Shirt' 'Preference Food' 'Social Event' 'Added main List' 'Org. Name' 'Org. Address1' 'Org. Address2' 'Org. City' 'Org. Country' 'Org. Province' 'Org. Postal' 'Org. Membership' 'keywords' 'Additional text' 'Payment Type' 'Reduction ticket' 'Currency' )
]

{ #category : #rendering }
ERConfigurationViewController >> headerGroups [
	^ #('id' 'First Name' 'Last Name' 'Email' 'Password' 'Org. Name' 'Org. Address1' 'Org. Address2' 'Org. City' 'Org. Country' 'Org. Province' 'Org. Postal' 'Org. Membership')
]

{ #category : #rendering }
ERConfigurationViewController >> headerTalks [
	^ #('Name' 'Submitted By' 'Uploaded File')
]

{ #category : #rendering }
ERConfigurationViewController >> headerUser [
	^ #('id' 'firstName' 'lastName' 'email' 'password' 'role')
]

{ #category : #rendering }
ERConfigurationViewController >> hearderAwards [
	^ #('Name' 'Submitted by')
]

{ #category : #accessing }
ERConfigurationViewController >> reductionTickets [
	^ conference reductionTickets
]

{ #category : #adding }
ERConfigurationViewController >> registerAsAttendee [
	attendee userAccount
		roleAdd: 'attendee';
		save.
	attendee save.
	conference addAttendee: attendee.
	conference save.
	^ attendee
]

{ #category : #adding }
ERConfigurationViewController >> registerAsGroupManager [
	attendee userAccount
		roleAdd: 'groupManager';
		save.
	attendee save.
	conference addAttendee: attendee.
	conference save.
	^ attendee
]

{ #category : #accessing }
ERConfigurationViewController >> submittedAwards [
	^ conference submittedAwards
]

{ #category : #accessing }
ERConfigurationViewController >> submittedTalks [
	^ conference submittedTalks
]

{ #category : #accessing }
ERConfigurationViewController >> users [
	^ conference users
]