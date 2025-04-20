## navy

A simple, lightweight server routing framework for Ruby.

```ruby
app = Navy.new

app.get("/greet/:name") do |req, res|
  name = req.param("name")
  res.type("text/plain")
  res.send(200, "Hello, #{name}")
end

# Example:
# /greet/trulyursdelv
# Hello, trulyursdelv
```

## Installation

```
gem install navy_framework
```
