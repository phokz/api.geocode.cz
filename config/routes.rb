Rails.application.routes.draw do
  get 'addresses/autocomplete'
  get 'addresses/:id', controller: :addresses, action: :show, as: :show_address
  get 'standby_db', controller: :application, action: 'standby_db'
  get 'active_db', controller: :application, action: 'active_db'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
