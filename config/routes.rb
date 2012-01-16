Fixmystreet::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }


  match 'about' => 'reports#about', :as => :about
  match 'contacts' => 'reports#contacts', :as => :contacts
  match 'feed' => 'reports#feed', :as => :feed

  resources :reports, :only => [:new, :create]
  resources :cities, :only => :index

  scope ":city" do
    resources :reports, :only => [:show, :edit, :update, :destroy] do
      collection do
        get '', :action => :index, :as => :list
        get 'fixed'
        get 'waiting_moderation'
        get 'waiting_confirmation'
        get 'inactive'
      end

      member do
        get 'inactivate'
        get 'accept'
        get 'decline'
        get 'activate'
        get 'request_fixed'
        get 'confirm_fixed'
        get 'decline_fixed'
      end
    end
  end

  root :to => "cities#index"
end
