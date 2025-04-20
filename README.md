> Working in progress... :construction:

## navy

A simple, lightweight server routing framework for Ruby.

```ruby
app = Navy.new

# /greet/trulyursdelv
# Hello, trulyursdelv
app.get("/greet/:name") do |req, res|
  name = req.param("name")
  res.type("text/plain")
  res.send(200, "Hello, #{name}")
end
```

## Installation

Before installing Navy, you need to install its dependencies.

```
gem install webrick
```

Download the [https://github.com/trulyursdelv/navy/blob/main/app/api/navy.rb](navy) ruby file and embed it in your project, then relatively import it.


```ruby
require_relative 'navy'
```

> [!IMPORTANT]
> Please stay still. This framework will be uploaded to Gem soon! :diamond:

## Documentation
For quick and easy way to use Navy, is to integrate it on Vercel.

### Navy on Vercel

### Navy on Localhost

### Custom Deployment
