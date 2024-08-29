Specifications for Phase 3
===

As part of phase 3, you will have to create models for the remaining entities and write unit tests for these models.  To make sure you are able to build these models and tests, below are some specs for each of these models.

**Please read this file online at GitHub or using a Markdown preview browser** (built into VS Code or stand-alone app like [MacDown](https://macdown.uranusjr.com/)) so there are no mistakes with escape characters (i.e., backslashes)

---
_Categories must:_

1.	have all proper relationships specified
2.	have a name and the name must be unique (case insensitive)
3. not allow category records to be destroyed
4.	have the following scopes:
	- 'active' -- returns only active categories
	- 'inactive' -- returns all inactive categories
	- 'alphabetical' -- orders results alphabetically by name
5.	have the following methods:
	-	'make\_active' -- which flips an active boolean from inactive to active and updates the record in the database.
	-	'make\_inactive' -- which flips an active boolean from active to inactive and updates the record in the database.


---
_Items must:_

1.	have all proper relationships specified
2.	have values which are the proper data type and within proper ranges. Remembering the 2nd Rule of Software Development, that means:
	- a numeric value for weight that is greater than zero
	- a integer value for inventory level that is greater than or equal to zero
	- a integer value for reorder level that is greater than or equal to zero
	- restrict category\_ids to categories which exist and are active in the system
	- verifies that a name is present and unique in the system (case-insensitive)
3. can only be destroyed if they have never been part of any order
4.	have the following scopes:
	- 'active' -- returns only active categories
	- 'inactive' -- returns all inactive categories
	- 'alphabetical' -- orders results alphabetically by name
	- 'featured' -- returns all the items that are currently featured
	- 'to_reorder' -- returns all the items that have inventory levels at or below reorder levels
	- 'for\_category' -- returns all the items for a given category (parameter: category _object_)
5.	have the following methods:
	-	'make\_active' -- which flips an active boolean from inactive to active and updates the record in the database.
	-	'make\_inactive' -- which flips an active boolean from active to inactive and updates the record in the database.
	- 'current\_retail\_price' -- which returns the current retail price of an item or returns nil if a price has not yet been set
	- retail\_price\_on\_date' -- which returns the retail price of an item for a given date or returns nil if a price has not yet been set (parameter: date)


---
_Item Prices must:_

1.	have all proper relationships specified
2.	have values which are the proper data type and within proper ranges. Remembering the 2nd Rule of Software Development, that means:
	- a numeric value for price that is greater than or equal to zero
	- restrict item\_ids to items which exist and are active in the system
3. not allow price records to be destroyed
4.	have the following scopes:
	- 'current' -- returns only current item prices
	- 'chronological' -- orders results by start date, descending 
	- 'for\_date' -- returns all the item prices for a given date (parameter: date)
	- 'for\_item' -- returns all the item prices for a given item id (parameter: item_id)
5. Before a new item price is created, the current price end date for that item must be set for today
6. When a new item price is created, the price start date must be set for the next day (i.e., tomorrow) since new prices can't go into effect in the middle of a business day

---
_Order Items must:_

1.	have all proper relationships specified, including relationships to customer and address
2.	have values which are the proper data type and within proper ranges. Remembering the 2nd Rule of Software Development, that means:
	- a integer value for quantity that is greater than zero
	- if provided, a valid shipped_on date
	- restrict item\_ids to items which exist and are active in the system
3. have the following scopes:
	- 'shipped' -- returns only order items that have been shipped
	- 'unshipped' -- returns only order items that haven't been shipped
	- 'alphabetical' -- orders results alphabetically by the item name

4.	have the following methods:
	-	'subtotal' -- returns the price * quantity for an order item.  The price used is dependent on the retail price on the date passed into the method; if no date is passed, then the current date is used.  If there is no price for that date, then nil is returned. (parameter: date)

---
_Users must:_

1.	have all proper relationships specified
2. implement has\_secure\_password protocols for password management
3.	have values which are the proper data type and within proper ranges.  Remembering the 2nd Rule of Software Development, that means:
	- usernames are required and must be unique (case-insensitive) in the system
	- role field must be limited to: admin, shipper, customer
	- password and password_confirmation must exist and match each other when a new user is being created
	- a password must have a minimum length of four characters
4. not allow user records to be destroyed
5.	have the following scopes:
	- 'active' -- returns only active users
	- 'inactive' -- returns all inactive users
	- 'alphabetical' -- orders results alphabetically by username
	- 'by\_role' -- orders results by role
	- 'employees' -- returns only those users who are employees (i.e., not customers)
6.	have the following methods:
	- 'role?' -- which returns true if the user's role listing in the database matches the role parameter passed in. (parameter: authorized_role, as a symbol)

---
_Customers, in addition to previous requirements, must:_

1.	must have a connection to user (relationship already included, but database must be modified with a new migration; do NOT edit the existing customer migration)
2. all tests must pass with customers who are now users
3.	not allow customer records to be destroyed
4.	should make the user associated with a customer inactive if the customer is made inactive


---
_Orders, in addition to previous requirements, must:_

1.	the following methods are given, but need to be tested completely:
   - 'total_weight': calculates the total weight of all the items associated with the order
   - 'not_shipped': a class method that finds all the distinct orders with one or more unshipped items and returns it as an ActiveRecordRelation

---
Note 1: there are methods in `Order` associated with credit card validation that are fully tested, but not needed until future phases -- they can safely be ignored for now.

Note 2: there are no changes in `Address` this phase.


