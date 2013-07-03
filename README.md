## AttributeStruct

This is a helper library that essentially builds hashes. It
wraps hash building with a nice DSL to make it slightly cleaner,
more robust, and provide extra features.

### Usage

```ruby
require 'attribute_struct'

struct = AttributeStruct.new
struct.settings do
  ui.admin do
    enabled true
    port 8080
    bind '*'
  end
  ui.public do
    enabled true
    port 80
    bind '*'
  end
  client('general') do
    enabled false
  end
end
```

Now we have an attribute structure that we can
query and modify. To force it to a hash, we
can simply dump it:

```ruby
require 'pp'

pp struct._dump
```

which gives:

```ruby
{"settings"=>
  {"ui"=>
    {"admin"=>{"enabled"=>true, "port"=>8080, "bind"=>"*"},
     "public"=>{"enabled"=>true, "port"=>80, "bind"=>"*"}},
   "client"=>{"general"=>{"enabled"=>false}}}}
```

## Information

* Repo: https://github.com/chrisroberts/attribute_struct