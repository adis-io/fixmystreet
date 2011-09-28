Fixmystreet::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root :to => "countries#show"

  match 'about' => 'reports#about', :as => :about
  match 'contacts' => 'reports#contacts', :as => :contacts
  match 'feed' => 'reports#feed', :as => :feed

  resources :reports, :only => [:new, :create]

  scope ":city" do
    resources :reports, :only => [:show, :edit, :update, :destroy] do
      collection do
        get '', :action => :index, :as => :list
      end
      member do
        get 'fixed'
      end
    end
  end

end
