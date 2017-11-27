Rake.application.remove_task 'db:test:load'
Rake.application.remove_task 'db:test:purge'

namespace :db do
 namespace :test do 
   task :load do |t|
     # rewrite the task to not do anything you don't want
   end
   task :purge do |t|
      # rewrite the task to not do anything you don't want
   end  
  end
end
