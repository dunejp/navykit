require 'json'
require 'uri'
require 'cgi'

class Request
  def initialize(real, params={})
    uri = URI.parse(real.request_uri)
    @real = real
    @params = params
    @query = CGI.parse(uri.query || "").transform_values do |values|
      values.size == 1 ? values[0] : values
    end
  end
  
  def query(key)
    return @query[key]
  end
  
  def param(key)
    return @params[key.to_s]
  end
  
  def method
    return @real.request_method
  end
  
  def header(key)
    return @real.header[key]
  end
  
  def text
    return @real.body
  end
  
  def json
    return JSON.parse(text)
  end
  
  def path
    return @real.path
  end
end

class Response
  def initialize(real)
    @real = real
  end
  
  def header(key, value)
    @real.header[key.downcase] = value.to_s
  end
  
  def type(value)
    header("content-type", value)
  end
  
  def send(status, body)
    @real.status = status
    @real.body = body
  end
end

class NavyKit
  @@version = "1.0.2"
  
  def initialize
    @routes = []
    @fallback = nil
  end
  
  def use(req, res)
    path = req.path
    method = req.request_method
    response = Response.new(res)
    
    _route = find_route(method, path)
    if _route != nil
      rpath = _route[:path]
      rhandler = _route[:handler]
      params = get_params(path, rpath)
      rhandler.call(Request.new(req, params), response)
    elsif @fallback != nil
      @fallback.call(Request.new(req), response)
    else
      native_fallback(req, res)
    end
  end
  
  def notfound(handler=nil, &block)
    @fallback = block_given? ? block : handler
  end
  
  def route(method, path, handler=nil, &block)
    segments = parse_path(path)
    @routes << {
      path: segments,
      method: method,
      handler: block_given? ? block : handler
    }
  end
  
  def get(path, handler=nil, &block)
    route("GET", path, handler, &block)
  end
  
  def post(path, handler=nil, &block)
    route("POST", path, handler, &block)
  end
  
  private
  def parse_path(path)
    segments = path[1..].split("/")
    if segments.size == 0
      segments[0] = "/"
    else
      segments.unshift("/")
    end
    return segments
  end
  
  def find_route(method, path)
    segments = parse_path(path)
    matching = @routes.clone
    matching.select! { |y|
      y[:method] == method
    }
    segments.each_with_index do |seg, i|
      matching.select! { |y|
        if y[:path].size != segments.size
          false
        elsif y[:path][i].start_with?(":")
          true
        else
          y[:path][i] == seg
        end
      }
    end
    return matching.size > 0 ? matching[0] : nil
    return route
  end
  
  def get_params(path, pattern)
    segments = parse_path(path)
    params = {}
    pattern.each_with_index do |y, i|
      if y.start_with?(":")
        params[y[1..]] = segments[i]
      end
    end
    return params
  end
  
  def native_fallback(req, res)
    res.header["content-type"] = "text/plain"
    res.status = "200"
    res.body = "#{req.request_method} #{req.path}\n[NavyKit v#{@@version}] No route matched\n\nThere's nothing here yet. Add a route to get started."
  end
end