## NavyKit :blueberries:

[![NavyKit](https://img.shields.io/gem/v/navykit?label=NavyKit&color=dc3519)](https://rubygems.org/gems/navykit)

NavyKit, formerly known as navy_framework, is a simple, lightweight server routing framework for Ruby that helps build web servers with ease. It provides the core functionalities to route requests and send responses, making it ideal for creating RESTful services or APIs with minimal overhead.

```ruby
app = NavyKit.new

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

NavyKit is available on [rubygems](https://rubygems.org/gems/navykit). To install NavyKit, install it on gem:

```
gem install navykit
```

## Live Demo

For a live demo, go to [navy-demo-app.vercel.app](https://navy-demo-app.vercel.app/). It covers the basic use of static and dynamic routing.

## Documentation

Read the full documentation [here](https://clover-stallion-989.notion.site/NavyKit-1e114c1327fb80c4a9adf06dbc766844?pvs=74)
