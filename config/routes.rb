Rails.application.routes.draw do
  get "projects/index"
  get "projects/show"
  get "posts/index"
  get "posts/show"
  get "services/index"
  get "services/show"
  get "programs/index"
  get "programs/show"
  get "pages/home"
  get "pages/about"
  get "pages/impact"
  get "pages/contact"
  namespace :admin do
    root to: "dashboard#index"
    resources :programs
    resources :services
    resources :posts
    resources :projects
    resources :team_members
    resources :partnerships
    resources :payments, only: [ :index, :show ]
    resources :enrollments, only: [ :index, :show ]
    resources :inquiries, only: [ :index, :show, :destroy ]
    resources :plans
    resources :partners
    resources :emails, only: [ :index, :show, :new, :create ]
    resources :project_applications, only: [ :index, :show, :update, :destroy ]
    resources :project_partnerships, only: [ :index, :show, :update, :destroy ]
    resources :events
    resources :gallery_images
  end

  # Public Routes
  root to: "pages#home"
  get "about", to: "pages#about"
  get "contact", to: "pages#contact"
  get "gallery", to: "galleries#index"

  resources :programs, only: [ :index, :show ] do
    member do
      post :enroll
    end
  end
  resources :events, only: [ :index, :show ]
  resources :services, only: [ :index, :show ]
  resources :posts, only: [ :index, :show ], path: "news"
  resources :projects, only: [ :index ], path: "our-work"
  resources :payments, only: [ :new, :create ] do
    collection do
      get :callback
    end
  end
  resources :inquiries, only: [ :create ]
  resources :bookings, only: [ :create ]
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  # Top-level Project Slugs (keep at bottom to avoid conflicts)
  get ":id", to: "projects#show", as: :project
  get ":id/apply", to: "projects#apply", as: :apply_project
  post ":id/apply", to: "projects#submit_application"
  get ":id/partner", to: "projects#partner", as: :partner_project
  post ":id/partner", to: "projects#submit_partnership"
end
