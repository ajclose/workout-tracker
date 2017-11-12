RailsAdmin.config do |config|

  config.authorize_with do |controller|
    unless session[:user_id] && User.find(session[:user_id]).admin?
    flash[:danger] = "You are not authorized to view that page"
    redirect_to main_app.root_path
  end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
