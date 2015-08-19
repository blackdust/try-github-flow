Rails.application.routes.draw do
  mount TryGithubFlow::Engine => '/', :as => 'try_github_flow'
  mount PlayAuth::Engine => '/auth', :as => :auth
end
