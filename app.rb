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
    file = images.zipped
    images.clean
    send_file file, filename: "icons.zip", stream: false
    FileUtils.rm file 
  end

end