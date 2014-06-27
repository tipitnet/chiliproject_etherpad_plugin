class PadsController < ApplicationController

  before_filter :find_project
  before_filter :authorize

  def pad_host
    ENV['PAD_HOST']
  end

  def pad_key
    ENV['PAD_KEY']
  end

  def pad_domain
    ENV['PAD_DOMAIN']
  end

  def index
    @pad_host = self.pad_host
    session[:ep_sessions] = {} if session[:ep_sessions].nil?
    ether = EtherpadLite.connect(@pad_host, self.pad_key)
    group = ether.group(@project.identifier)
    @pads = group.pads
  end

  def new
    if request.post?
      @pad_host = self.pad_host
      pad_title = params[:pad][:title]
      session[:ep_sessions] = {} if session[:ep_sessions].nil?
      ether = EtherpadLite.connect(@pad_host, self.pad_key)
      @group = ether.group(@project.identifier)
      if @group.pads.select { |p| p.name == pad_title }.size == 0
        @pad = @group.pad(pad_title)
        flash[:notice] = l(:notice_successful_create)
     else
        flash[:error] = l(:error_pad_exists, :pad_title => pad_title)
      end
      redirect_to :action => :index, :project_id => @project
    end
  end


  def show
    @pad_host = self.pad_host
    session[:ep_sessions] = {} if session[:ep_sessions].nil?
    ether = EtherpadLite.connect(@pad_host, self.pad_key)
    # Get the EtherpadLite Group and Pad by id
    @group = ether.group(@project.identifier)
    @target_pad = params[:pad_id]
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
    cookies[:sessionID] = {:value => sess.id, :domain => self.pad_domain}
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end