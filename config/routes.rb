ActionController::Routing::Routes.draw do |map|

  map.with_options :path_prefix => 'compte', :name_prefix => 'admin_' do |admin|
    admin.resources :shows do |shows|
      shows.resources :posts
    end
  end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  # map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  map.connect 'compte/activate/:code', :controller => 'account', :action => 'activate'
  map.connect 'compte/:action', :controller => 'account'

  map.connect 'ep/:episode_slug', :controller => 'public', :action => 'episode'
  map.connect 'ep/:episode_slug/ecoute/:content_slug', :controller => 'public', :action => 'content'
  map.connect 'ep/:episode_slug/ecouter/:content_slug', :controller => 'public', :action => 'playlist'
  map.connect 'vote/:episode_id', :controller => 'public', :action => 'vote'
  map.connect 'tags/:search', :controller => 'public', :action => 'tags'
  map.connect 'feed', :controller => 'public', :action => 'feed'
  map.connect 'robots.txt', :controller => 'public', :action => 'robots'

  # You can have the root of your site routed by hooking up ''
  # -- just remember to delete public/index.html.
  map.connect '', :controller => "public", :action => "welcome"
  map.connect '', :controller => "public", :action => "show"

  map.connect '/:action', :controller => "public"

  # Install the default route as the lowest priority.
  map.connect 'compte/emission/:action/:id', :controller => "show"
  map.connect 'compte/episode/:action/:id', :controller => "episode"

  # Allow downloading Web Service WSDL as a file with an extension
  # instead of a file named 'wsdl'
  map.connect ':controller/service.wsdl', :action => 'wsdl'

  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
