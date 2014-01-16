class App < Sinatra::Base

  enable :sessions
  register Sinatra::Flash


  get '/' do
    haml :index
  end

  post '/' do
    unless params[:icon] &&
           (tmpfile = params[:icon][:tempfile]) &&
           (name = params[:icon][:filename])
      return haml :index
    end

    begin
      images = Processor.create(tmpfile, session[:session_id])
    rescue Exception => e
      flash[:error] = "Extension was wrong, or something bad has happened."

      redirect '/'
    end

    images.clean
    file = images.zipped
    send_file file, filename: "icons.zip", stream: false
    FileUtils.rm file

    redirect '/'
  end

end