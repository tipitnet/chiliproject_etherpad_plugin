class PadsController < ApplicationController

  before_filter :find_project

  def show
    @pad_host = ENV['PAD_HOST']
    pad_key = ENV['PAD_KEY']
    domain = ENV['PAD_DOMAIN']
    session[:ep_sessions] = {} if session[:ep_sessions].nil?
    ether = EtherpadLite.connect(@pad_host, pad_key)
    # Get the EtherpadLite Group and Pad by id
    @group = ether.group(@project.identifier)
    @target_pad = "#{@group.id}$defaultpad"
    @pad = @group.pad(@target_pad)
    @user_name = User.current.name
    # Map the user to an EtherpadLite Author
    author = ether.author("my_app_user_#{User.current.id}", :name => User.current.name)
    # Get or create an hour-long session for this Author in this Group
    sess = session[:ep_sessions][@group.id] ? ether.get_session(session[:ep_sessions][@group.id]) : @group.create_session(author, 60)
    if sess.expired?
      sess.delete
      sess = @group.create_session(author, 60)
    end
    session[:ep_sessions][@group.id] = sess.id
    # Set the EtherpadLite session cookie. This will automatically be picked up by the jQuery plugin's iframe.
    cookies[:sessionID] = {:value => sess.id, :domain => domain}
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end