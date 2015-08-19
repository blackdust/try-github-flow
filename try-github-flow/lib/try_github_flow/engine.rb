module TryGithubFlow
  class Engine < ::Rails::Engine
    isolate_namespace TryGithubFlow
    config.to_prepare do
      ApplicationController.helper ::ApplicationHelper
    end
  end
end