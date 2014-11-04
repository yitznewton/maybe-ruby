![Travis build status](http://img.shields.io/travis/yitznewton/maybe-ruby.svg)
![BSD 2-Clause license](http://img.shields.io/packagist/l/yitznewton/maybe-ruby.svg)

# A Maybe monad implementation for Ruby

This project was wholly inspired by
[a blog post](http://linepogl.wordpress.com/2011/03/15/a-php-maybe-monad-2/)
by @linepogl.

## Motivation

Dealing with `nil` values is tedious and prone
to developer error (viz the null pointer exception, trying to dereference
a `nil`).

In my exposure to Haskell, I learned about the awesomeness of pattern matching,
whereby you can get the compiler to force yourself to handle all possibilities.
This combines with a tool called `Maybe` to require specific handling for
"null" and "non-null" possibilities.

Ruby does not offer pattern matching, but we can still use classes to wrap raw
values, and require us to handle null conditions, without repeated explicit
nil checking and conditionals.

## Examples

### Simple

Before:

```ruby
blogpost = repository.get(blogpost_id)
puts blogpost.teaser  # oh noe! what if blogpost is nil?! :boom:
```

After:

```ruby
blogpost = Maybe.new(repository.get(blogpost_id))
puts blogpost.select { |bp| bp.teaser }.value_or 'No blogpost found'
```

### With block

```ruby
blogpost = Maybe.new(repository.get(blogpost_id))
puts blogpost.select { |bp| bp.teaser }.value_or do
  do_some_expensive_thing
end
```
