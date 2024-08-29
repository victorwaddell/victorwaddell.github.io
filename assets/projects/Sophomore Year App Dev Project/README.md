[![Open in Visual Studio Code](https://classroom.github.com/assets/open-in-vscode-f059dc9a6f8d3a56e377f745f24479a46679e63a5d9fe6f495e02850cd0d8118.svg)](https://classroom.github.com/online_ide?assignment_repo_id=7452060&assignment_repo_type=AssignmentRepo)
67-272: GPBO Project - Phase 4
===
We will continue our project to develop a foundation for the Baking Outlet system in this phase. We will focus our efforts on building out the controllers and views to make for an effective front end for our e-commerce platform. This is a test-driven phase -- we give you all the tests this time and your job is to pass these tests.  In this process, you will see how our testing suite can serve as documentation and help us define system requirements.

**Grading**

This phase will constitute 15 percent of your final course grade and is broken down into the following three components:


1. **Creation of Controllers**: We have given you all the controller tests that your controllers must pass. Of course, these controllers must also be able to generate the code needed to pass the Cucumber tests, so reading the two sets of tests together is advisable. All tests must pass and the coverage is to be at 100 percent; if you add additional methods that we do not test (so coverage is not at 100 percent), expect a substantial penalty.  The project must be **using Rails 5.2.6 and Ruby 2.6.9 and the gems specified in the Gemfile.**

2. **Creation of Views**: We are going to have you complete key elements of the system front end by building views for customers and administrators.  We have given you a series of Cucumber tests that test the full stack (model-view-controller); however, if your models and controllers are at 100 percent test coverage, these Cucumber tests will effectively serve as view tests. 

    Note that in the interest of time, we are not requiring views for every single model and controller.  Instead, we have crafted a set of key scenarios that hit at the core of the system and are focusing on those. For example, a key feature of the system would be the ability of customers to shop for items and add them to a shopping cart.  Another key feature would be for guests to create customer accounts as well as be able to log in and see their purchase histories.

3. **Visual Design**: To prevent attempts to hack the test suites, we will be manually checking each application to make sure that the key elements are not hard-coded into the response.  While doing that, we will also assess the quality of your visual design on a 5-point scale.  While we use [MaterializeCSS](https://materializecss.com/) in class and in PATS, you do have the freedom to choose other CSS frameworks if you prefer. (That said, we are providing no support in OH or Piazza for other frameworks we may be unfamiliar with.) Please note that while using MaterializeCSS is advised, you cannot simply copy over all the PATS styling; _if it looks like a clone or near-twin to PATS, expect a score of 1 out of 5 on the visual design aspect._


**Checkpoints**

There are two checkpoints for this phase.

1. On **April 3rd**, the controllers for `customers`, `categories`, `addresses`, `users`, `sessions`, and `items` must be complete and passing all tests at 100 percent coverage.  In addition, the controller tests for handling 404 errors must also pass.  

2. On **April 11th**, in addition to the previous checkpoint working, all remaining controllers must be complete and passing at 100 percent coverage. Additionally, the first four sets of Cucumber tests (features 0-3) must pass.


All checkpoints are due in your GitHub repository before 11:59pm EST on the date specified.  We are not explicitly checking for test coverage on checkpoints, only that the specified tests exist and they pass.  Checkpoints will be submitted via GitHub and Gradescope (additional instructions to follow).

**Other Notes**

1. There are no spec files given this phase -- part of the purpose of this phase is to get you familiar with testing as a form of documentation.  **Because of this, if you ask a general question about requirements on Piazza or in office hours, our first response will be to ask you what the tests tell you.**  If you have specific questions about the tests and how they work, we are happy to answer those, _but we will not interpret the tests for you -- it's your job to turn those tests into requirements._

2. We have given you a reasonable testing context that can be easily set up with the command: `rails db:contexts`. Note that the autograder will have a tweaked version of the context with slightly different names, prices, and the like, to try to discourage students from hard-coding the responses.

3. Note that the models we've given you are feature complete and no additional methods are needed to complete this phase. That said, we have also given you a few extra methods that were not part of the previous, so reviewing the models would be helpful. If you do feel compelled to add new methods to your models, you are responsible for writing tests for those methods so the coverage remains at 100 percent.

4. As you know from the previous phase, we use a series of helpers that allow us to not have to copy-paste certain methods and keep our code cleaner.  To reduce issues of object management, we have moved key functionality for the both the cart and shipping into modules found in `lib/helpers`.  You can add these modules into any relevant controller with the `include <module>` command.  We strongly recommend you review these two new helper modules as they have lots of functionality that will make controller programming much easier.

5. We have also included a set of partials from PATS that can help you build your views.  Using these are not required, but they are what we used to build the solution, so they have some value.  Again, we strongly recommend reading them over before just firing away and trying to use them without understanding them.

6. We strongly advise you _NOT_ to use `rails generate scaffold ...` but rather `rails generate controller ...` in creating your controller for this phase. (Or even better, just use `touch <filename>` on the command line to generate blank files to work with.) Also, be sure not to overwrite the controller tests if you do use the generators.  Be forewarned: scaffolding will generate lots of extra code that may inadvertently impact your test coverage and cause you to lose points. We will have no sympathy if you ignore this warning and lose points.

7. The only cucumber tests that are not working right now are the final set on searching, but only because cucumber does not support key stroke recognition and are trying to develop a work-around for identifying when the user presses `enter`.  When that comes, we will publish the revised helper code and help you get that installed so you can uncomment and run those tests. You have the scenarios we will test and should make those scenarios work on the app so that when we have the fix, you can simply apply it and see the tests pass.

8. Doing the checkpoints will keep you from getting too far behind, **but _only_ doing the minimum each week will pretty much ensure a miserable final week.** Our advice, as it has been throughout the semester, is to follow the path but work ahead of the minimum requirements.

**Turning in Phase 4**

Your project should be turned in via your private repository on GitHub **before 11:59 pm (EST) on Sunday, April 17th, 2022**. Once it's in your repo, you will then submit it from there to Gradescope. More instructions on submitting to the autograder will be posted separately. The solution for this phase (i.e., starter code for the next phase) will be released soon after; no late assignments will be accepted after solutions are released.

Again, if you have questions regarding the turn-in of this project or problems downloading any of the materials below, please post them on Piazza or ask someone well in advance of the turn-in date. Waiting until the day before it is due to get help is unwise -- you risk not getting a timely response that close to the deadline and will not be given an extension because of such an error.
