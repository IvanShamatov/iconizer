require 'goliath'

class AsyncUpload < Goliath::API
  use Goliath::Rack::DefaultMimeType

  def on_headers(env, headers)
    env.logger.info 'received headers: ' + headers.inspect
    env['async-headers'] = headers
  end

  def on_body(env, data)
    env.logger.info 'received data: ' + data
    (env['async-body'] ||= '') << data
  end

  def on_close(env)
    env.logger.info 'closing connection'
  end

  def response(env)
    [200, {}, {body: "OK", head: env['async-headers']}]
  end
end