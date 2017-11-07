#  Bugreport Sinatra

```ruby
bundle install
bundle exec ruby -Ilib:test test/nested_namespaces_test.rb
```

The output will show `NoMethodError: undefined method 'this_method_does_not_exist'`
