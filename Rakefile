# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative 'config/application'

Rake::TaskManager.class_eval do
  def remove_task(task_name)
   @tasks.delete(task_name.to_s)
 end
end

Rails.application.load_tasks

