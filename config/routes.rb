#connect 'projects/:project_id/pad', :controller => 'pads',  :action => 'show'

ActionController::Routing::Routes.draw do |map|

  map.connect 'projects/:project_id/pad', :controller => 'pads',  :action => 'show'

end
