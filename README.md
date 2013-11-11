# ModelObserver

A rails plugin to count the model object creations between each request, and help to find out the duplication.

[![Build Status](https://travis-ci.org/cctiger36/model_observer.png?branch=master)](https://travis-ci.org/cctiger36/model_observer) [![Gem Version](https://badge.fury.io/rb/model_observer.png)](http://badge.fury.io/rb/model_observer) [![Code Climate](https://codeclimate.com/github/cctiger36/model_observer.png)](https://codeclimate.com/github/cctiger36/model_observer) [![Coverage Status](https://coveralls.io/repos/cctiger36/model_observer/badge.png)](https://coveralls.io/r/cctiger36/model_observer)

## Installation

Add to your Gemfile

    group :development do
      gem 'model_observer'
    end

and bundle

    bundle

## Query Log

The duration include instantiate models will be logged after each sql log like this:

    Author Load (0.5ms)  SELECT `authors`.* FROM `authors` WHERE `authors`.`id` = 1 LIMIT 1
    Author Instantiate (1.5ms)  SELECT `authors`.* FROM `authors` WHERE `authors`.`id` = 1 LIMIT 1

1.5ms == 0.5ms(DB query) + 1.0ms(model instantiation)

## Summary Log

The summary of each request will be added to the end like this:

    ===== Model Observer Start =====
    Author: 1 sum(10.6ms) avg(10.6ms)
    Book: 27 sum(25.7ms) avg(1.0ms)
      id(319): 3
      id(377): 3
      id(487): 3
      id(489): 3
      id(493): 3
      id(496): 3
      id(499): 3
      id(507): 3
      id(536): 3
    ===== Model Observer End =======

`id(319): 3` means the models with same class(Book) and same id(319) have been instantiated three times.
