if defined?(Konacha)
  Konacha::Engine.routes.clear!
  Konacha::Engine.routes.draw do
    get "/users.json" => "users#users"
    get "/users/:id.json" => "users#get_user"
    put "/users/:id.json" => "users#get_user"
    post "/users.json" => "users#users"
    delete "/users/:id.json" => "users#users"
    get '/iframe/*name' => 'specs#iframe', :format => false, :as => :iframe
    root :to    => 'specs#parent'
    get '*path' => 'specs#parent', :format => false
  end
end