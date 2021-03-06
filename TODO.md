## Progress Status

### Roles

* [x] Admin / Organizer
* [x] Attendee
* [x] Team Manager / Secretary
* [x] Student Volunter

### Attendee

* [x] create an account
* [x] register: days, participate to social dinner, vegetarian/vegans/..., polo gender/size (Man XS, Woman XS, M/W M, M/W L, M/W XL, => M/W 4XL), social networks info
* [x] coupon to pay less/free
* [x] can get its invoice -> unique invoice number
* [x] add an extra person to the social diner
* [x] get a *pdf* invoice (current Patagonia send it in HTML...) re-ask me a template
* [x] pay using paypal URL (cf. PatagoniaForESUG-Example.st)
* [x] submit an ESUG Award	

### Team Manager-Secretary

* [x] registers/manages multiple attendees
* [x] get one bill for registered people -> unique invoice number (all these attendees will have this number)

### Admin-Organizer

* [x] setup infos (cf. PatagoniaForESUG-Example.st) :
* [x] admin credentials (login/password)
* [x] ESUG dates : start & stop
* [x] prices : early 1 day, early full, late 1 day, late full
* [x] price for extra person to the social dinner
* [x] STMP server : currently we use a REST service to send emails (PatSmtpToPostMarkClientAdapter) and this is  easier than having its own SMTP server
* [x] Open / close registration
* [x] create coupons : percentage discount, fixed reduction, limited usage
	cf. https://esug.github.io/become_sponsor.html when clicking on a coupon -> see all registrations that used it 
* [x] modify a registration
* [x] apply a coupon on a registration
* [ ] Report to see who paid 
* [x] mark a bill as paid => all registration of this bill are marked as paid

### CVS export 

* [x] full export (for us)
* [x] attendees list should only contain: names, mail, Organisation, Country

### Statistics to organize
* [x] number of participants to lunches per day and per types. Example: Monday: 120 normal attendees, 10 vegetarians, 3 vegans ... 	Tuesday: ...
* [x] polos: 40 Man S, 10 Woman S, 10 Woman M, 10 Man M, 30 Man XL, 4 Man 3XL, ...
* [x] number of participants to social dinner (same)
* [x] download all invoices in one zip

## Student Volunter

* [x] check that a participant has been registered
* [ ] add an extra person to the social diner to an attendee -> email to pay extra fee + invoice?


