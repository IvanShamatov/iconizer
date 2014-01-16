require 'rubygems'
require 'bundler'
require 'sinatra/flash'

Bundler.require(:default)

require './processor'
require './app'
run App