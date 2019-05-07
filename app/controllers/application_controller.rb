class ApplicationController < ActionController::API
  def standby_db
    render plain: (all_db_names - [active_db_name]).first
  end

  def active_db
    render plain: active_db_name
  end

  def active_db_name
    Rails.configuration.database_configuration[Rails.env]['database']
  end

  def all_db_names
    Rails.configuration.database_configuration[Rails.env]['databases'].split(', ')
  end
end
