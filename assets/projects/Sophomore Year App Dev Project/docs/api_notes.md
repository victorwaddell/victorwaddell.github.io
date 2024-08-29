GPBO API Notes
---
In the `docs/api_json_samples` directory, you will find sample JSON generated for two API endpoints for your application.  The first is `orders`, which returns a list of order objects and related data.  The second is `customers/:id`, which returns a particular customer object, as well as related data.  Both are read-only routes passed as a GET request.

A couple of notes in building this API:

1. We have already given you the appropriate `ApplicationController` needed to build your controllers for orders and customers.
2. We have already installed the `fast_jsonapi` gem in your `Gemfile` -- you simply need to run `bundle install` to get it.
3. Since there are only two routes for this API, we want you to build each route manually as demo'd in class.  Do NOT use the `resources` method to build other CRUD routes that you have no intention of implementing at this time.
4. We are NOT requiring authorization on these endpoints; do not add it in anyways as it will negatively impact the autograder, and consequently, your grade.
5. In this phase we are not requiring any testing of the controllers as we haven't covered controller testing yet.
6. Documentation for the API is optional and will not be tested or graded.
7. In the final test of the endpoints, we will modify the test data slightly to detect anyone who is hard-coding any parts of the endpoint responses. 
8. The `orders` endpoint does not require anything new beyond phase 2 models you are starting with, but the `customers/:id` endpoint will require `Item` and `OrderItem` to be implemented before it can be completed.