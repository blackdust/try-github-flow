module TryGithubFlow
  class ApplicationController < ActionController::Base
    layout "try_github_flow/application"

    if defined? PlayAuth
      helper PlayAuth::SessionsHelper
    end
  end
end