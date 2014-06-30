
ActionController::Routing::Routes.draw do |map|

  map.with_options :controller => 'pads' do |pad_routes|
    pad_routes.with_options :conditions => {:method => :get} do |pad_actions|
      pad_actions.connect 'projects/:project_id/pads', :action => 'index'
      pad_actions.connect 'projects/:project_id/pads/new', :action => 'new'
      pad_actions.connect 'projects/:project_id/pads/:pad_id', :action => 'show'
    end
    pad_routes.with_options :conditions => {:method => :post} do |pad_actions|
      pad_actions.connect 'projects/:project_id/pads/new', :action => 'new'
      pad_actions.connect 'projects/:project_id/pads/:pad_id/destroy', :action => 'destroy'
    end
  end

end