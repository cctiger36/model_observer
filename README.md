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

## Log

The ModelObserver log will look like:

    ===== Model Observer Start =====
    Author: 1 sum(10ms) avg(10ms)
    Book: 36 sum(13ms) avg(0ms)
      id(20): 2
      id(50): 9
      id(61): 4
      id(68): 2
      id(111): 2
      id(123): 3
      id(124): 3
    ===== Model Observer End =====
