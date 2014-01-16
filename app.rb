class App < Sinatra::Base

  get '/' do
    haml :index
  end

  post '/' do
    puts params.inspect
    redirect '/'
  end

end