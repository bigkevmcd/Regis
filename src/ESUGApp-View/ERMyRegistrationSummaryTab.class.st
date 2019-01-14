Class {
	#name : #ERMyRegistrationSummaryTab,
	#superclass : #ERContainerTab,
	#category : #'ESUGApp-View-Tab'
}

{ #category : #rendering }
ERMyRegistrationSummaryTab >> getInvoice [
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> modifyRegistration [
	callback := [ self updateMyRegistration ].
	formWithoutBasicInfo := ERContainerTabs
		formWithoutBasicInfoOn: attendee
		withCallback: callback
		content: content.
	content state: formWithoutBasicInfo
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> pay [
	attendee paymentTypeIsBankTransfer
		ifTrue: [ ^ self redirectViewForBankTransfer ].
	attendee paymentTypeIsCreditCard
		ifTrue: [ ^ self redirectionPayPAL ]
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> redirectViewForBankTransfer [
	| bankTransferView |
	bankTransferView := ERBankTransferPaymentInfoView
		on: attendee
		withContent: content.
	content state: bankTransferView 
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> redirectionPayPAL [
	| url |
	url := ERController new payPalUrlFor: attendee.
	self requestContext redirectTo: url
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderButtons: html [
	self
		createRaisedRippleEffectAnchorButton: 'Modify Registration Information'
		with: [ self modifyRegistration ]
		id: 'modifyRegistration'
		on: html.
	self
		createRaisedRippleEffectAnchorButton: 'Pay'
		with: [ self pay ]
		id: 'pay'
		on: html.
	html mdlAnchorButton
		raised;
		colored;
		rippleEffect;
		id: 'invoice';
		callback: [ self getInvoice ];
		with: 'Get my invoice'
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderContainer: html [ 	
	html horizontalRule .
	self renderLabelsSummary: html.
	self renderButtons: html.
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> renderLabelsSummary: html [
	self createTextStrong: 'Attendace Date(s): ' withText: 'Monday 10, Tuesday 11, Wednesday 12, Thursday 13 and Friday 14' on: html.
	self createTextStrong: 'Payment Status: ' withText: 'Payment no registered yet. Amount due: 660.00 Euros (NOTE: you could have paid but we could have not registered it yet)' on: html
]

{ #category : #accessing }
ERMyRegistrationSummaryTab >> tabId [
	^ 'summary'
]

{ #category : #accessing }
ERMyRegistrationSummaryTab >> tabName [
	^ 'Summary'
]

{ #category : #accessing }
ERMyRegistrationSummaryTab >> title [
	^ 'Registration Summary'
]

{ #category : #rendering }
ERMyRegistrationSummaryTab >> updateMyRegistration [
	(ERRegistrationController attendee: attendee) validateRegister .
	attendee save.
	content state: content lastState
]