require 'bundler/setup'

require_relative '../lib/category.rb'
require_relative '../lib/question.rb'
require_relative '../lib/scraper.rb'

require "pry"
require "open-uri"
require "net/http"
require "json"