Specifications for Phase 2
===

As part of phase 2, you will have to create models for `Customer`, `Address`, and `Order` and write unit tests for these models.  To make sure you are able to build these models and tests, below are some specs for each of these models.

---
_Customers must:_

1.	have all proper relationships specified
2.	have values which are the proper data type and within proper ranges.  Remembering the 2nd Rule of Software Development, that means:
	- email addresses must be present and should be legitimate email addresses, validated with a regex
	- phone must be present and a 10 digit number, but the user may input values with dashes, dots or other common formats – e.g., 999-999-9999; 999.999.9999; (999) 999-9999 are all acceptable
3.	have a first name, last name (no other validation required)
4. have phone values that are saved in the system as a string of 10 digits only, regardless of the format the user inputs.
5.	have the following scopes:
	- 'active' -- returns only active customers
	- 'inactive' -- returns all inactive customers
	- 'alphabetical' -- orders results alphabetically by last name, first name
6.	have the following methods:
	- 'name' -- which returns the customer name as a string "last\_name, first\_name" in that order
	- 'proper\_name' -- which returns the customer name as a string "first\_name last\_name" in that order with a space between them
	-	'make\_active' -- which flips an active boolean from inactive to active and updates the record in the database.
	-	'make\_inactive' -- which flips an active boolean from active to inactive and updates the record in the database.
	- 'billing_address' -- which returns the first active billing address associated with the customer.


---
_Addresses must:_

1.	have all proper relationships specified
2. have a recipient, a primary street address and city (no other validation required)
3.	have values which are the proper data type and within proper ranges. Remembering the 2nd Rule of Software Development, that means:
	- a proper 5-digit zip code must be given and validated by a regex
	- must have a state that is one of the 50 states or D.C. (e.g., it cannot be something bogus like "PN" or the "state of confusion")
4.	restrict customer\_ids to customers which exist and are active in the system
5.	have a method called 'already\_exists?' which should determine whether or not an address is already in the system for this customer. For now, a duplicate address is defined as same recipient and zip code for a particular customer. Note that two different customers could have an address to the same recipient and zip code.
6.	should not allow duplicate addresses to be added in the system
	(**warning:** a check for duplicates should _only_ run when a new record is created.  If the validation were to be run when editing a record, it would make it difficult to edit the record because that particular address already exists.)
7. should ensure that if the customer has any addresses, one of them is a billing address.
8. should ensure that the billing address for the customer is always active.
9. only allow for one billing address per customer at a time. If the customer has a billing address and a new billing address is added, the older one is automatically removed as a billing address (but stays as a shipping address).
10.	have the following scopes:
	- 'active' -- returns only active addresses
	- 'inactive' -- returns all inactive addresses
	- 'by\_recipient' -- orders results alphabetically by recipient name
	- 'by\_customer' -- orders results alphabetically by customer's last name, first name
	- 'shipping' -- returns all addresses which are just shipping addresses
	-  'billing' -- returns all addresses which are also billing addresses
11.	have the following methods:
	-	'make\_active' -- which flips an active boolean from inactive to active and updates the record in the database.
	-	'make\_inactive' -- which flips an active boolean from active to inactive and updates the record in the database.



---
_Orders must:_

1.	have all proper relationships specified
2.	have values which are the proper data type and within proper ranges. Remembering the 2nd Rule of Software Development, that means:
	- all costs are numeric values greater than or equal to zero.
	- dates are legitimate dates
3.	restrict customer\_ids to customers which exist and are active in the system
4.	restrict address\_ids to addresses which exist and are active in the system
5. have an instance method called 'grand\_total' that is the sum of the products total, shipping, and taxes. Since these values are all floats, be sure that this method returns at most two decimal places.
6.	have an instance method called 'pay' that will create a base64 encoded payment string that will serve as the payment receipt and updates that field in the database.  For now, the encoded string should be of the format "order: \<the order id\>; amount_paid: \<grand total\>; received: \<the order date\>".  To prevent double-payments, the method should only generate payment receipts for orders that have not already been paid for and return false if it has been paid. If the method does generate a payment receipt, the database is updated and the receipt string is returned by the method. 
7.	have the following scopes:
	- 'chronological' -- orders results chronologically with most recent 
		     orders listed at the top
	- 'paid' -- returns all orders that have been paid (i.e., have a 
              payment receipt recorded)
	- 'for_customer' –- returns all the orders for a particular customer 
          (parameter: customer\_id)



NOTE: 	In this phase we will _not_ validate that any `active` field is actually a boolean. 
