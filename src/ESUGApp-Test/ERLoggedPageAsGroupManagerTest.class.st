"
A ERLoggedPageAsGroupManagerTest is a test class for testing the behavior of page when the user sign in as GroupManager
"
Class {
	#name : #ERLoggedPageAsGroupManagerTest,
	#superclass : #ERParasolTest,
	#instVars : [
		'group'
	],
	#category : #'ESUGApp-Test-Parasol'
}

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> addGroupManagerAsAttendee [
	self clickElementWithID: 'contactInfoForm-nextButton'.
	self clickElementWithID: 'conferenceOptionsForm-nextButton'.
	self clickElementWithID: 'affiliationInfoForm-nextButton'.
	self clickElementWithID: 'additionalInfoForm-nextButton'.
	self clickElementWithID: 'paymentInformationForm-nextButton'.
	self clickElementWithID: 'registerButton'.
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> fillAllUserFields [
	self selectElementWithID: 'firstName' send: 'register'.
	self selectElementWithID: 'lastName' send: 'register'.
	self selectElementWithID: 'email' send: 'register@gmail.com'.
	self selectElementWithID: 'password' send: '12345678'.
	self selectElementWithID: 'confirmPassword' send: '12345678'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> firstName: aString1 lastName: aString2 email: aString3 password: aString4 confirmPassword: aString5 [
	|firstName lastName email password confirmPassword|
	firstName := driver findElementByID: 'firstName'.
	lastName := driver findElementByID: 'lastName'.
	email := driver findElementByID: 'email'.
	password := driver findElementByID: 'password'.
	confirmPassword := driver findElementByID: 'confirmPassword'.
	firstName sendKeys: aString1 .
	lastName sendKeys: aString2.
	email sendKeys: aString3.
	password sendKeys: aString4.
	confirmPassword sendKeys: aString5.
]

{ #category : #'as yet unclassified' }
ERLoggedPageAsGroupManagerTest >> loginAsGroupManager [
	self selectElementWithID: 'email-login' send: group groupManager userAccount email.
	self selectElementWithID: 'password-login' send: '12345678'.
	self clickElementWithID:'login-button'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressDoneButton [
	self pressNextButtonPayment .
	self clickElementWithID: 'registerButton'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonAdditional [
	self pressNextButtonAffiliation .
	self clickElementWithID: 'additionalInfoForm-nextButton'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonAffiliation [ 
	self pressNextButtonConference .
	self clickElementWithID: 'affiliationInfoForm-nextButton'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonConference [
	self pressNextButtonContact .
	self clickElementWithID: 'conferenceOptionsForm-nextButton'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonContact [
	self pressNextButtonUser.
	self clickElementWithID: 'contactInfoForm-nextButton'
	
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonPayment [
	self pressNextButtonAdditional.
	self clickElementWithID: 'paymentInformationForm-nextButton'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> pressNextButtonUser [
	self fillAllUserFields.
	self clickElementWithID: 'basicInfoForm-nextButton'
]

{ #category : #'as yet unclassified' }
ERLoggedPageAsGroupManagerTest >> pressOptionGroupRegistration [
	self clickElementWithID: 'Group Registration-option'
]

{ #category : #'as yet unclassified' }
ERLoggedPageAsGroupManagerTest >> selectMembersTab [
	self clickElementWithID: 'tab-Members'
]

{ #category : #accessing }
ERLoggedPageAsGroupManagerTest >> setUp [
	super setUp.
	ERTest generateDataForTest .
	controller := ERGroupManagerController new.
	group := controller conference groups first.
	self loginAsGroupManager .
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testModifyAffiliationOfSummary [
	self pressOptionGroupRegistration.
	self clickElementWithID: 'modifyAffiliation'.
	self assert: (self textOfTagName: 'h3') equals: 'Affiliation Information'
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testPressDeleteAttendeeAcceptAlert [
	|attendee cantOfAttendees|
	attendee := group listAttends first.
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	self clickElementWithID: attendee id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees - 1
	
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testPressDeleteAttendeeDismissAlert [
	|attendee cantOfAttendees|
	attendee := group listAttends first.
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	self clickElementWithID: attendee id, '-delete'.
	driver dismissAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees
	
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testPressDeleteGroupManagerAttendeeAcceptAlert [
	|attendee cantOfAttendees|
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	self clickElementWithID: 'registerMyselfAsAttendee'.
	self addGroupManagerAsAttendee.
	attendee := group listAttends detect: [:att | att userAccount id = group groupManager userAccount id].
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	self clickElementWithID: attendee id, '-delete'.
	driver acceptAlert .
	(Delay forSeconds: 2) wait.
	self assert: group listAttends size equals: cantOfAttendees - 1.
	self deny:
	 (ERUserAccount detect: [:user | user id = group groupManager userAccount id])= nil
	
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testPressExportInvoiceButtonOfSummary [
	|href|
	self createDownloadDirectory .
	self pressOptionGroupRegistration .
	href := (driver findElementByID: 'exportInvoice') getAttribute: 'href'.
	self downloadFileOf: href to: ( 'Download' asFileReference ) /'invoice.pdf'
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testPressGroupManagerOption [
	self pressOptionGroupRegistration.
	self assert: (self textOfTagName: 'h3') equals: 'Group Manager Short Description'.
	self shouldnt: [driver findElementByID: 'modifyAffiliation'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'pay'] raise: BPNoSuchElementException .
	self shouldnt: [driver findElementByID: 'exportInvoice'] raise: BPNoSuchElementException .
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testRegisterMyselfAsAttendee [
	|cantOfAttendees|
	self pressOptionGroupRegistration .
	self selectMembersTab.
	cantOfAttendees := group listAttends size.
	self clickElementWithID: 'registerMyselfAsAttendee'.
	self addGroupManagerAsAttendee.
	self assert: group listAttends size equals: cantOfAttendees + 1.
	self assert: group groupManager userAccount isAttendee .
	self deny: (group listAttends detect: 
		[:att | att userAccount id = group groupManager userAccount id]) = nil
	
]

{ #category : #groupManagerMembersTabTests }
ERLoggedPageAsGroupManagerTest >> testRegisterNewAttendeeToGroup [
	|cantOfAttendees|
	self pressOptionGroupRegistration .
	self selectMembersTab .
	cantOfAttendees := group listAttends size.
	self clickElementWithID: 'registerAttendee'.
	self pressDoneButton .
	self assert: group listAttends size equals: cantOfAttendees + 1
	
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testUpdateAffiliationWithEmptyOrganizationAddress [
	self pressOptionGroupRegistration .
	self clickElementWithID: 'modifyAffiliation'.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationAddrees1' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Address 1')
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testUpdateAffiliationWithEmptyOrganizationCity [
	self pressOptionGroupRegistration .
	self clickElementWithID: 'modifyAffiliation'.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationCity' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'City')
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testUpdateAffiliationWithEmptyOrganizationName [
	self pressOptionGroupRegistration .
	self clickElementWithID: 'modifyAffiliation'.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationName' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Organization Name')
]

{ #category : #groupManagerSumaryTests }
ERLoggedPageAsGroupManagerTest >> testUpdateAffiliationWithEmptyOrganizationPostal [
	self pressOptionGroupRegistration .
	self clickElementWithID: 'modifyAffiliation'.
	acceptFormButton := 'accept-change-affiliation'.
	self updateField: 'organizationPostal' with: ''.
	self assert: self getTextOfError 
		equals: (self messageIsRequiredFor: 'Postal/Zipcode')
]