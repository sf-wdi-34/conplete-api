<!--
Creator: SF Team (Alex, Travis)
Last edited by: Brianna
Location: SF
-->

![](https://ga-dash.s3.amazonaws.com/production/assets/logo-9f88ae6c9c3871690e33280fcf557f33.png)

# Rails 5 JSON API

### Why is this important?
*This workshop is important because:*
- Rails is a powerful tool for building APIs with RESTful routes very quickly
- API mode is now built in to Rails 5


### What are the objectives?
<!-- specific/measurable goal for students to achieve -->
*After this workshop, developers will be able to:*

- Build a Rails API to CRUD a resource
- Use the `jbuilder` gem to generate JSON from templates
- Enable cross-origin resource sharing so a non-Rails front end can access your API

### Where should we be now?
*Before this workshop, developers should already be able to:*

- Create a Ruby on Rails CRUD app
- Make requests with Postman or `curl`


<!-- - Create an Angular CRUD app using an external API -->

Meta-goals:

  * Practice finding and using documentation.
  * Practice picking out key words from project descriptions.
  * Explain pros and cons of using code generators.
  

## How to use this resource

This lesson is structured as a self-guided lab in which you'll build an API with Rails 5.  It has a series of steps listed that you should take in order. 

There are hints or code snippets with some of the steps.  You'll usually have to click to see them.

Sometimes, you'll find steps that are missing or ambiguous and don't have hints.  You have the skills and resources to figure out these steps yourselves, especially if you work together and share tips with all of your colleagues. 


## The "Con-plete" API

The "con-plete" API aims to give a complete list of talks going on at different conferences.  Conferences have many talks! This API helps track them. It processes requests as JSON request, with a permissive JSON API.

This repo holds the completed app solution.

[Link to completed app on heroku.](https://con-pletionist.herokuapp.com)


### Set Up Conferences

1. Generate a new rails project (called `con-pletionist`).  Use a postgres database, skip Rails' built-in Minitest tests, and use the `--api` option to let Rails know your app should be set up as just a back-end API.

  <details>
    <summary>Stuck? Click to see the Terminal command to run.</summary>
    In your Terminal, run `rails new con-pletionist  --database=postgresql -T --api`
  </details>  

  **Next up:** explore scaffolding

2. In your Rails app, generate a [scaffold](http://guides.rubyonrails.org/command_line.html#rails-generate) for a `conference` resource that includes the conference's name (a string) and location (also a string, for now). Carefully read the output in the Terminal. Scaffolding generates a **lot** of files when we have a full Rails app, but the number is more managable when you're just building an API.


  > While scaffolding will get you up and running quickly, the code it generates is unlikely to be a perfect fit for your application. You’ll most probably want to customize the generated code. Many experienced Rails developers avoid scaffolding entirely, preferring to write all or most of their source code from scratch.
  > - [Rails Guides: Getting Started (version 3.2.9)](http://guides.rubyonrails.org/v3.2.9/getting_started.html)

3. Set up your database, start your server, and run `rails routes`.  Read terminal output carefully starting with the top of any error messages. 

  <details>
    <summary>Stuck? Click to see some Terminal commands you'll want to use to get the server going.</summary>
    ```bash
    $ rails db:create
    $ rails db:migrate
    $ rails server
    ```
  </details>
  
  <details><summary>click to see `rails routes` output</summary>
  ```
          Prefix Verb   URI Pattern                Controller#Action
   conferences GET    /conferences(.:format)     conferences#index
               POST   /conferences(.:format)     conferences#create
    conference GET    /conferences/:id(.:format) conferences#show
               PATCH  /conferences/:id(.:format) conferences#update
               PUT    /conferences/:id(.:format) conferences#update
               DELETE /conferences/:id(.:format) conferences#destroy
  ```
  </details>

4.  Once you have your Rails server running, spend 10 minutes interacting with the site through Postman. Try all CRUD actions for conferences, using the routes listed in your `rails routes`. 

5. Spend 10 minutes looking through the code Rails generated.  Pay particular attention to `app/controllers/conferences_controller.rb`, and answer the following questions with a partner:

  * In the conferences controller, what does the line `  before_action :set_conference, only: [:show, :update, :destroy]` do?

  * Taking a hint from the generated comments in the conferences controller, visit the `/conferences` endpoint in your browser. What do you see?


  * In the conferences controller, what is the `conference_params` private method for? What does the `params.fetch(:conference, {})` line do?
  
  * Note that the  `render` line with a hash like `{ json: @conferences }`  is rendering `@conferences` very directly to JSON. If we want something more complex, we can use a gem called `jbuilder`. 

  **Next up**: build better JSON with `jbuilder`
  
6. In the Gemfile, add the gem `jbuilder`. 

  <details><summary>did you remember to...</summary> bundle?</details>

7. Change the conference routes to use a default format of JSON.

8. In the conferences controller `show` method, remove the line that says `render json: @conference` so that it doesn't directly render JSON. What kind of error do you get if you visit the url for a single conference in your browser? (Make sure you're trying to access a conference that does exist in your database.) 

9. Create a `jbuilder` template for the show view: `views/conferences/show.json.jbuilder`.  Inside this file, add a line that says `json.name @name`.  What do you see in if you visit a conference show page now?  

10. Modify the template so that the conference's `location` is also included. 

10. Look over the first example input and output in the [`jbuilder` docs](https://github.com/rails/jbuilder) to see more examples of how `jbuilder` creates structured data. 

7. Edit `views/conferences/show.json.jbuilder` so that it includes a field for the url of the conference (like you've been visiting in your browser). Use url helpers to generate the correct url for each conference, and set the format of the url to JSON. Hint: you'll use `url_for` or `conference_path`. 

  <details>
    <summary>Stuck? Click to see suggestions about where to look for more information.</summary>
    * search for "Rails url helper"
    * search for "Rails url helper JSON format"
    * revisit the example in the `jbuilder` documentation, and look for urls
  </details>

8. Create a view for the index of conferences. This view should result in an array of conferences, each with the `name`, `location`, and direct link `url`. Hint: 'json.array!'.

### Incorporate Talks

  **Next up**: scaffold talks

8. Generate a scaffold for a `talk` resource. Talk information should include the talk's title, the speaker's name, the start time, and the end time (use the `datetime` type to capture dates and times).  Also add an attribute for the conference a talk belongs to. If you're not sure how to generate a scaffold for an association in rails, do a search for that.

  <details>
    <summary>Click to see the Terminal command used to generate the scaffold in the solutions.</summary>
    ```bash
    $ rails g scaffold talk title:string speaker_name:string start_time:datetime end_time:datetime conference:belongs_to
    ```
  </details>

9. Take a look at the files that were generated for you this time.  Now that `jbuilder` is installed, you should see some JSON templates generated for you. 

9. Get your rails server running again with talks, and spend 2-5 minutes using the API through your browser, Postman, or `curl`. Try CRUD operations on talks.

  **Next up**: solidify the association

10. Look at the list of files Rails generated or updated. Where would you expect to see the association between conferences and talks reflected?

11. Wait to make changes, but explore the following files or directories and see how or if the association is reflected in each. When you're finished with a file or directory, click the file or directory name to compare notes.

  * <details><summary>views/talks/</summary>
    show and index JSON templates include the conference id</details>
  * <details><summary>config/routes.rb</summary> routes for talks and conferences are both included, but talks aren't nested in conferences </details>
  * <details><summary>app/controllers/talks_controller.rb</summary> the conference id is brought in as a permitted parameter in `talk_params` </details>
  * <details><summary>app/models/talk.rb</summary> `belongs_to :conference` is set up! </details>
  * <details><summary>app/models/conference.rb</summary> the association is not set up on this side; you'll add `has_many :talks` here </details>
  * <details><summary>db/migrate/</summary> there's a new migration file to create the talks table, and it includes a `t.belongs_to` or `t.references` for the conference foreign key </details>
  * <details><summary>db/schema.rb</summary> since you had to run `rake db:migrate` to get talks working, there should be a talks table here with the foreign key set up </details>


12. Create a one-to-many association by coding the fact that a conference has many talks into your conference model. Also make sure that a conference's talks are destroyed when the conference is destroyed.  

13. Your `rails generate scaffold` command clearly showed that each talk references (or belongs to) one conference.  Why do you suppose the scaffold didn't add `has_many :talks` to the conference model code? Discuss with others until you're satisfied with an answer.

  **Next up:** more complex custom jbuilder view

13. Update the JSON show view for single conferences so that conference JSON lists all of the conference's talks in an embedded array.  Each talk should include a url link to its individual JSON page, but they don't need to include times they were created or updated.

  **Next up:** seeds!

14. Add seed data to your project to create at least 2 conferences and 5 talks. Test your CRUD methods in the Rails console.

  <details><summary>Click for tips for seeding times in Rails.</summary>
    * you can use `Time.current` to get a time with time zone information (the default time zone is UTC)
    * (you can set the time zone with `Time.zone=` or `config.time_zone`)
    * you can use methods like `2.5.hours` to create amounts of time that can be added or subtracted with other times
    * you can also use methods like `1.days.from_now.at_noon` to create times
  </details>

15. Seed your database, and run through your app to confirm that your JSON views are working as expected.

**Note:** At this point, with JSON view templates and routes, we are basically set up to use Angular on the front end.  We could add Angular directly to this project, but for now, we'll allow any front end to access the API instead.


### Share your API

**Note:** Rails generally assumes that only the Rails front-end will be consuming the data stored in the Rails project database. The API of this site will be open to other requesters, though. In fact, we'll open it up to any request origin that wants to use or change the data here.

17. Use `cURL` to test access to the following routes on your Rails site:
  * `GET /talks`
  * `GET /conferences/:id` (for some id you know exists on your site)
  * `POST /talks`
  * `DELETE /talks/:id` (for some id you know exists on your site)

  <details><summary>Click for suggestions about where to find out how to do this!</summary>
  * search "curl json format rails"
  </details>

  Write your `cURL` commands down to use again later.

  <details><summary>Stuck? Click to see a sample verbose `cURL` command to get JSON for `GET /conferences/3`. (You'll need to modify it!)</summary>`$ curl -v -H "Accept: application/json" -H "Content-type: appliction/json" -X GET https://con-pletionist.herokuapp.com/conferences/3`</details>

  <details><summary>Stuck? Click to see a sample verbose `cURL` command for `POST /talks`. (You'll need to modify it!)</summary>`$ curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"talk":{"title":"The Future of Kia Automobiles","speaker_name":"Chip Cilantro"}}'  https://con-pletionist.herokuapp.com/talks`</details>

18. Do you see errors or unexpected results when you run your `cURL` commands?

  **Next up:** change the CSRF protection strategy to allow cross-site requests

19. Rails provides a lot of [security features](http://guides.rubyonrails.org/security.html).  One such security feature is a token that Rails places on every page to protect from Cross-Site Request Forgery (CSRF).   Unfortunately, this protection throws an exception and doesn't let anyone else use our api.  Configure Rails to protect the site from forgery with the `null_session` strategy instead of with an exception.

  <details><summary>Click for a suggestion about where to find more information.</summary>
    * search "Rails CSRF null_session"
  </details>

20. Try your `cURL` commands again.

  **Next up:** configure CORS headers with `rack-cors`

21. Cross-Origin Resource Sharing (CORS) is a standard for sharing resources across domains. The gem `rack-cors` can help configure Rails apps to use CORS. Un-comment [`rack-cors`](https://github.com/cyu/rack-cors) in your Gemfile to add this gem to your project.  You'll also need to change your `config/applciation.rb` -- use the [Rails 5 example code](https://github.com/cyu/rack-cors#rails-configuration) from the documentation.

22. Try your `cURL` commands again. All of them should be successful!



## Extra Challenge Ideas


### HATEOAS

Level up knowledge of REST with some research, and practice `jbuilder`. Solution not provided.

1. HATEOAS, like RESTful routing, is a part of the REST convention. HATEOAS makes it easy to discover resources on a site.  It's less frequently used than RESTful routing but still very common.

2. Update your JSON views to include more links, implementing (or approaching) HATEOAS.  


### Nest Talk Routes in Conferences

More conventional treatment of dependent resource, talks.  Solution provided.

This bonus involves changing many files throughout the app. It will be time-consuming. If you choose to work on it, start a new branch. Consider changing over routes one or two at a time instead of doing them all at once.

1. Use shallow nesting to nest the talk routes inside conference routes, and run `rails routes`.

  ```ruby
  resources :conferences except: [:new, :edit] do
    resources :talks, only: [:index, :create] 
  end
  resources :talks, only: [:show, :update, :destroy]
  ```

4. Update the `talks` JSON views to take the new routes, paths, and urls into account.

2. Update your talks controller to take the new route structure into account (by looking up the conference for actions that need it).  Make sure actions are modifying the conference if needed, too.

4. Update your talks controller JSON responses to reflect the change in routes.
