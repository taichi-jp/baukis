# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
### Rake 11.0.1 removes the last_comment method which rspec-core (< 3.4.4) uses. (from StackOvewFlow)
module TempFixForRakeLastComment
  def last_comment
    last_description
  end
end
Rake::Application.send :include, TempFixForRakeLastComment
###

Rails.application.load_tasks
