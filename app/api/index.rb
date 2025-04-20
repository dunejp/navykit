require_relative 'navy'
app = Navy.new
Handler = Proc.new do |req, res|
  app.use(req, res)
end

app.get("/") do |req, res|
  res.type("text/plain")
  res.send(200, "Hello from /\n\nRoutes:\n/about\n/user/:username/\n/user/:username/:repository")
end

app.get("/about") do |req, res|
  res.type("text/plain")
  res.send(200, "Hello from /about")
end

app.get("/user/:username") do |req, res|
  username = req.param("username")
  res.type("text/plain")
  res.send(200, "Hello, #{username}")
end

app.get("/user/:username/:repository") do |req, res|
  res.type("application/json")
  res.send(200, {
    username: req.param("username"),
    repository: req.param("repository")
  }.to_json)
end

app.notfound do |req, res|
  res.type("text/plain")
  res.send(200, "Hello from fallback route (notfound)")
end