#if defined?(Konacha)
  module Joker
    module Rails
      class Engine < ::Rails::Engine
        def self.routes
          Konacha::Engine.routes.draw do
            get "/users" => "users#users"
            get '/iframe/*name' => 'specs#iframe', :format => false, :as => :iframe
            root :to    => 'specs#parent'
            get '*path' => 'specs#parent', :format => false
          end
        end
        initializer :joker_routes, :after => :add_routing_paths do
          begin
            _routes = Rails::Application.routes
            _routes.disable_clear_and_finalize = true
            _routes.clear!
            #Rails::Application.routes_reloader.paths.each{ |path| load(path) }
            _routes.draw do
              get "/users" => "users#users"
              get '/iframe/*name' => 'specs#iframe', :format => false, :as => :iframe
              root :to    => 'specs#parent'
              get '*path' => 'specs#parent', :format => false
            end
            ActiveSupport.on_load(:action_controller) { _routes.finalize! }
          ensure
            _routes.disable_clear_and_finalize = false
          end
        end
      end
    end
  end
#end
