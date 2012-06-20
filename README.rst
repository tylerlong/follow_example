follow example
==============
example of user follow user, article, event...etc.


notes
=====
#. user follow user is interesting


how to setup
============

::

  require "followable"
  include Followable


how to use
==========
rails c

::

  user = User.create(name: "Tyler Long")
  article = user.articles.create(name: "Rails rocks")
  event = user.events.create(name: "RubyCon")

  user.follow(article)
  user.follow(event)

  article.followers
  event.followers

  user.followed_articles
  user.followed_events



dive into
=========

::

  user = User.create(name: "Tyler Long")
  article = user.articles.create(name: "Rails rocks")
  event = user.events.create(name: "RubyCon")

  user.followships.create(followable: article)
  user.followships.create(followable: event)

  article.followships
  event.followships
  user.followships

  followship = Followship.first
  followship.followable
  followship.user



todo list
=========
#. make it a ruby gem
#. release it to rubygems.org
#. write documents
#. make the user model name configurable
#. generator for db migration
