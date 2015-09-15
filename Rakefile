# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :delete_obsolete_links do
  Link.where("destroy_at > ?", Time.now).delete_all
  p 'Ссылки удалены :)'
end