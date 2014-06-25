require 'redmine'

Redmine::Plugin.register :chiliproject_etherpad do
  name 'Chiliproject Etherpad plugin'
  author 'NicoPaez'
  description 'This plugin integrates Etherpad into Chiliproject'
  version '1.0.0'
  url 'http://www.tipit.net'
end

Redmine::MenuManager.map :project_menu do |menu|
  menu.push(:pad, { :controller => 'pads', :action => 'show' },{:param => :project_id})
end

Redmine::AccessControl.map do |map|
  map.project_module :documents do |map|
    map.permission :access_pad, {:pads => [:show]}
  end
end