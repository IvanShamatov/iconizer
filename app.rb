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
    puts params.inspect
    content_type :json
    images = Processor.create(tmpfile, session[:session_id], params[:style] == "launch" ? :launch : :icon)
    images.zipped

    # "size" => размер архива, можно будет выводить его где-нибудь, если добавить в структуру
    {"icon" => [
      {
        "url" => "#{session[:session_id]}.zip"
      }
    ]}.to_json
  end

end