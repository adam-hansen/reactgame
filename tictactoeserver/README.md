# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# something of note with Rails, a concept of Fat Model, Skinny Control seems common
# basically logic and processing goes into the model classes and the controls are primarily for routing / filtering type activities
# so for the tic tac toe game it seems like have the logic of calculating changes to the game such as "is the play valid, did the play produce a winning result" are things that we would have functions on the model for