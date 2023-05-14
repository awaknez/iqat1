Rails.application.routes.draw do
  # get 'contacts/new'
  # get 'contacts/create'
  root to: 'questions#choose'
  resources :questions, only: [ :index] do
    collection do
      get 'choose'
      get 'ask'
      post 'ask'
      get 'next_question'
      post 'next_question'
      post 'check'
      get 'print'
      post 'print'
      get 'score'
      get 'retry'
      post 'retry'
    end
  end
  # お問い合わせページへのアクセス
  get '/contacts', to: 'contacts#new'
  # お問い合わせ内容の送信
  post '/contacts', to: 'contacts#create'
  # 利用規約・プライバシーポリシーページへのアクセス
  get '/policy', to: 'contacts#policy'
  # 使い方ページへのアクセス
  get '/howtouse', to: 'contacts#howtouse'
end
