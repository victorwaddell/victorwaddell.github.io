[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-f059dc9a6f8d3a56e377f745f24479a46679e63a5d9fe6f495e02850cd0d8118.svg)](https://classroom.github.com/online_ide?assignment_repo_id=7181745&assignment_repo_type=AssignmentRepo)
67-272: GPBO Project - Phase 3
===
We will continue our project to develop a foundation for the Baking Outlet system in this phase. We will focus our efforts on building out the models for the three entities given to you in the this phase's ERD in `docs/gpbo_erd_p3.pdf` and adding all necessary business logic. In addition, you will have to write unit tests for all models and ensure that test coverage is complete. 

We will also be doing some simple API building in this phase and introduce you to authentication and authorization.

**Grading**

This phase will constitute 15 percent of your final course grade and is broken down into the following four components:


1. **Creation of Models**: Models for the entities listed in the ERD found in this project's `docs` directory need to be created that have not already been created. Also, in the `docs` directory, you are given a spec sheet on essential methods each model must have; those methods must be fully implemented. The project must be **using Rails 5.2.6 and Ruby 2.6.9**

2. **Unit Testing**: Unit tests for all methods in all models must be written and fully passing. We will check to ensure there is 100 percent code coverage for unit tests using the `simplecov` gem used in class and lab. Because `simplecov` suffers from some false positives (as mentioned in class), we may spot-check tests to ensure specific tests were included. Only the models in this phase need complete coverage. There are steep penalties for less than 100 percent coverage and no credit at all for less than 90 percent coverage. 

3. **Additional Testing**: To expose you to authorization and to service objects, we are giving you the following testing challenges: 
  - For authorization, we've given you a working context and a set of tests that describe the authorizations of each role.  Read through these materials and build an `app/models/ability.rb` file that will pass these test. 
  - For services, we have given you a `ShippingCalculator` in the `app/services` directory and the start of a test file in `test/services`.  Your job is to write the tests needed to make sure this service is at full test coverage. _Note that simplecov will miss certain cases that you must identify on your own._

4. **API Endpoints**: You have to develop two API endpoints, one for `orders` and another for `customers/:id`.  See the API notes as well as the sample JSON both found in the `docs` directory for more information.

**Checkpoints**

Due to spring break, there are only two checkpoints and the first can (and probably should) be completed prior to spring break.

1. On **March 13th**, the `User` model must be created and tested, and a new migration adding the user foreign key to the `customers` table must be created. In addition, any test code related to customer or using a customer context must be updated so that it works properly with the new association in `Customer` and passes all existing tests. Finally, all authorization/ability tests must be passing. 

2. On **March 20th**, in addition to the previous checkpoint working, all remaining scopes must be completed and tested. All entities that cannot be destroyed (see specs sheet) should have that protection added in and tested.  Additionally, the `Category` and `ItemPrice` models must be completed (all specs) and tested.


All checkpoints are due in your GitHub repository before 11:59pm EST on the date specified.  We are not explicitly checking for test coverage on checkpoints, only that the specified tests exist and they pass.  Checkpoints will be submitted via GitHub and Gradescope (additional instructions to follow).

**Other Notes**

1. Note that unlike phase 2, we are giving you all the factories and the testing context that works in our solution.  You can use if it you like or build your own -- it's your decision -- but we know if you build your models properly, these contexts will work just fine.

2. In the initial phase 1 write-up, there was a discussion related to calculating taxes.  That has been dropped for this phase and does not need to be implemented.

3. In the initial phase 1 write-up, there was a discussion related to retail versus wholesale prices.  That has been dropped for this phase and does not need to be implemented.  All prices this phases are retail prices.

4. Note that in the models we've given you, we use a series of helpers that allow us to not have to copy-paste certain methods, such as `make_inactive` and `is_active_in_system`, and keep our code cleaner.  You are welcome to use these helpers yourself (and cut back on copy-paste) and can see the code for this in `lib/helpers` if you want to study it more for yourself.  You are also free to continue copy-pasting code if you prefer and are comfortable with the risk of error.

5. We strongly advise you _NOT_ to use `rails generate scaffold ...` but rather `rails generate model ...` in creating your models for this phase. Scaffolding will generate lots of extra code that may inadvertently impact your test coverage and cause you to lose points. We will have no sympathy if you ignore this warning and lose points.

6. If we have installed a gem in the `Gemfile`, then use the version we've specified. However, be aware that there are gems that we've demo'ed in class that you will have to install yourself for this phase.

7. Doing the checkpoints will keep you from getting too far behind, **but _only_ doing the minimum each week will pretty much ensure a miserable final week.** The path of coding and testing relationships first, then scopes, then other methods is highly recommended, and the checkpoints lead you in that path. But the other methods become tricky, and waiting until the last week to do them all can lead to lots of stress in that last week. Our advice is to follow the path but work ahead of the minimum requirements.

**Turning in Phase 3**

Your project should be turned in via your private repository on GitHub **before 11:59 pm (EST) on Sunday, March 27th, 2022**. Once it's in your repo, you will then submit it from there to Gradescope. More instructions on submitting to the autograder will be posted separately. The solution for this phase (i.e., starter code for the next phase) will be released soon after; no late assignments will be accepted after solutions are released.

Again, if you have questions regarding the turn-in of this project or problems downloading any of the materials below, please post them on Piazza or ask someone well in advance of the turn-in date. Waiting until the day before it is due to get help is unwise -- you risk not getting a timely response that close to the deadline and will not be given an extension because of such an error.
