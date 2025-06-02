Rails.application.routes.draw do
  # Deviseのルートを定義。ただし`registrations#create` をスキップ
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "devise_invitable/registrations"
  }, skip: [:registrations]

  # 必要な `registrations` アクションのみを個別に復活
  as :user do
    get "users/sign_up", to: "devise_invitable/registrations#new", as: :new_user_registration
    get "users/edit", to: "devise_invitable/registrations#edit", as: "edit_user_registration"
    patch "users", to: "devise_invitable/registrations#update", as: "user_registration"
    put "users", to: "devise_invitable/registrations#update"
    delete "users", to: "devise_invitable/registrations#destroy"
  end

  # カスタムルートの追加
  devise_scope :user do
    # Magic Link のエントリーポイント
    post "/users", to: "users/sessions#send_magic_link"
    post "/magic_login", to: "users/sessions#send_magic_link", as: :send_magic_link
    get "/magic_login/:token", to: "users/sessions#magic_link_login", as: :magic_login
  end

  # アプリケーションの正常性確認エンドポイント
  get "up" => "rails/health#show", as: :rails_health_check

  # ルートパスを定義
  root "index#index"

  # posts用ルートの定義 (必要なアクションのみ)
  resources :posts, only: [:new, :create]
end