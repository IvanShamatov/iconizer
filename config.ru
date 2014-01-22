require 'rubygems'
require 'bundler'
require 'sinatra/flash'
require 'json'

Bundler.require(:default)

require './processor'
require './app'
run App