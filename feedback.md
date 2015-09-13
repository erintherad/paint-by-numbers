# Project 3 Feedback

## Project Strengths

* Very ambitious project executed fantastically once again! Throughout the course I've been consistently impressed with your ability to take concepts we've learned in class and stretch them far beyond what we covered.
* Well-researched and planned out in terms of technologies and libraries you needed to use. I'm also impressed by your ability to identify potential roadblocks early and come up with a plan to address them.
* Code is very organized, logical, and DRY.
* Nice use of AJAX as needed and page refreshes where appropriate.
* User flow is easy to navigate and design complements the app's functionality.
* Fun to use and love the social aspect as well!

## Areas of Improvement

* See code comments marked with `CJ`
* Consider adding an `.example_env` file NOT included in your `.gitignore` that lists examples of the secret keys you used. This will help other devs to know when environment variables they need when pulling down the code. Something like this:

  ```ruby
  # .sample_env
  S3_BUCKET=YOUR_S3_BUCKET
  S3_KEY=YOUR_S3_KEY
  ```
* Also consider adding additional instructions for the `rmagick` gem, since it requires some prerequisites. Even a link the the `rmagick` docs would work.
* Incorporate Rails helpers where you can -- great job with `form_for`; there are a few places in the code that could be refactored with `link_to`.
* Add error-handing around users saving a blank painting (i.e. if they have not uploaded an image yet, don't let them save).
* Small thing, but commit messages are typically phrased in the present tense :)
