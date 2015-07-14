require 'capybara/rails'
require 'capybara/poltergeist'


desc "Simulate load against Blogger application"
task :load_test => :environment do
  4.times.map { Thread.new { browse } }.map(&:join)
end

def browse
  session = Capybara::Session.new(:poltergeist)
  loop do
    session.visit("https://evening-temple-1086.herokuapp.com/")
    session.all("li.article a").sample.click
  end
end