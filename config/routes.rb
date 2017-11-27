Rails.application.routes.draw do
  get 'addresses/autocomplete'
  get 'addresses/:id', controller: :addresses, action: :show, as: :show_address

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
