namespace :links do
  desc "Delete obsolete links"
  task :delobs => :environment do # delobs - delete obsolete
    Link.where('destroy_at < ?', Time.now).delete_all  # < - правильное
  end
end