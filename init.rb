require 'redmine'

Redmine::Plugin.register :chiliproject_etherpad do
  name 'Chiliproject Etherpad plugin'
  author 'NicoPaez'
  description 'This plugin integrates Etherpad into Chiliproject'
  version '1.0.0'
  url 'http://www.tipit.net'
end

Redmine::AccessControl.map do |map|
  map.project_module :pads do |map|
    map.permission :access_pads, {:pads => [:index, :show]}
    map.permission :create_pads, {:pads => [:new]}
  end
end

Redmine::MenuManager.map :project_menu do |menu|
  menu.push(:pads, { :controller => 'pads', :action => 'index' },{:param => :project_id})
  menu.push(:new_pad, { :controller => 'pads', :action => 'new' }, {
      :param => :project_id,
      :caption => :label_pad_new,
      :parent => :pads,
      :if => Proc.new {|p| User.current.allowed_to?(:create_pads, p) }
  })
end
