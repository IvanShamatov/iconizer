class App < Sinatra::Base
  
  enable :sessions

  get '/' do
    haml :index
  end

  post '/' do
    unless params[:icon] &&
           (tmpfile = params[:icon][:tempfile]) &&
           (name = params[:icon][:filename])
      return haml :index
    end
    images = Processor.create(tmpfile, session[:session_id])
    send_file images.zipped, filename: "icons.zip"
    redirect '/'
  end

end