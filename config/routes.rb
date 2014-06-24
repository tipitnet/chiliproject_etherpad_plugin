
ActionController::Routing::Routes.draw do |map|

  map.with_options :controller => 'pads' do |pad_routes|
    pad_routes.with_options :conditions => {:method => :get} do |pad_views|
      pad_views.connect 'projects/:project_id/pad', :action => 'show'
    end
  end

end