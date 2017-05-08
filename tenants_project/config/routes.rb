class SubdomainConstraint
  def self.matches?(request)
    subdomains = %w{ www admin }
    request.subdomain.present? && !subdomains.include?(request.subdomain)
  end
end

Rails.application.routes.draw do
  get 'home/index'
  root :to => "home#index", :id => '1'

  resources :institutions

  constraints SubdomainConstraint do
    resources :groups
    devise_for :users  
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end