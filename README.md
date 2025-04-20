## navy

Navy is a simple, lightweight server routing framework for Ruby that helps build web servers with ease. It provides the core functionalities to route requests and send responses, making it ideal for creating RESTful services or APIs with minimal overhead.

With support for custom route handling, dynamic parameters, and a fallback for unmatched routes, Navy is designed for developers who need a fast and flexible routing solution.

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

To install navy, install it on gem:

```
gem install navy_framework
```

Alternatively, you can install navy via gemfile:

```ruby
gem 'navy_framework', '~> 1.0', '>= 1.0.2'
```
