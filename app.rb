class App < Sinatra::Base

  enable :sessions

  get '/' do
    haml :index
  end

  post '/' do
    unless params[:icon] &&
           (tmpfile = params[:icon][:tempfile]) &&
           (name = params[:icon][:filename]) &&
           (["image/png","image/gif","image/jpg","image/jpeg"].include?(params[:icon][:type]))
      return haml :index
    end

    # begin
    images = Processor.create(tmpfile, session[:session_id])
    images.clean
    file = images.zipped
    send_file file, filename: "icons.zip", stream: false
    FileUtils.rm file

    redirect '/'
  end

end