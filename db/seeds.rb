# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Link.create( [
              { :original_link => 'ya.ru' },
              { :original_link => 'mail.ru/sd-sd'} ,
              { :original_link => 'http://rusrails.ru/dzfzf' },
              { :original_link => 'https://rubylearning.com/' },
              { :original_link => 'ftp://ua.lol' },
              { :original_link => 'https://www.google.ru' },
              { :original_link => 'http://stacklow.com/sd.php' }
              ]
            )