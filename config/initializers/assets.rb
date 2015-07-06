# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are
# already added.
# Rails.application.config.assets.precompile += %w( search.js )

module CustomHamlEngine
  class HamlTemplate < Tilt::HamlTemplate
    def evaluate(scope, locals, &block)
      scope.class_eval do
        include Rails.application.routes.url_helpers
        include Rails.application.routes.mounted_helpers
        include ActionView::Helpers
      end

      super
    end
  end
end

Rails.application.assets.register_engine '.haml', CustomHamlEngine::HamlTemplate
