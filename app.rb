class App < Sinatra::Base

  get '/' do
    haml :index
  end

  post '/' do
    uploader = IconUploader.new
    uploader.cache!(params[:icon])
    puts uploader.inspect
    redirect '/'
  end

end