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



insert sample data
==================
rails c

::

  user = User.create(name: "Tyler Long")
  user2 = User.create(name: "Peter Lau")
  article = user.articles.create(name: "Rails rocks")
  event = user.events.create(name: "RubyCon")



how to use
==========
rails c

::

  user.follow(article)
  user.follow(event)
  user.follow(user2)
  user2.follow(user)

  article.followers
  event.followers
  user.followers
  user2.followers

  user.followed_articles
  user.followed_events
  user.followed_users
  user2.followed_users

  user.followed? article
  user.followed_by? user2
  user2.followed? event
  event.followed_by? user
  event.followed_by? user2



dive into
=========

::

  user.followships.create(followable: article)
  user.followships.create(followable: event)
  user.followships.create(followable: user2)
  user2.followships.create(followable: user)

  article.followedships
  event.followedships
  user.followedships
  user2.followedships
  user.followships
  user2.followships


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
#. user follow himself?
