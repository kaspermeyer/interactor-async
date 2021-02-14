# Interactor::Async

Extends the [Interactor](https://github.com/collectiveidea/interactor) gem API with a single method: `call_later`.

Use this method whenever you want to offload an interactor call to a background job.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'interactor-async'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install interactor-async

## Example

```ruby
class User::SendOnboardingMail
  include ::Interactor

  def call
    UserMailer.with(user: context.user).onboarding.deliver_now
  end
end

# Send the mail now
User::SendOnboardingMail.call(user: user)

# Send the mail later
User::SendOnboardingMail.call_later(user: user)
```

## Usage

The gem will work out-of-the-box with any app that uses Active Job. Just replace any standard interactor `call` with `call_later` to execute it asynchronously.

### Configuration

An internal job is used to wrap the interactor call whenever `call_later` is invoked.  If you want more control over the job implementation, or if you use another framework to handle background jobs, you can configure a custom job wrapper class:

```ruby
Interactor::Async.configure do
  config.job_wrapper = CustomJobWrapper
end
```

The configured class must implement the `perform` method, which is invoked every time `call_later` is called on an interactor. It takes two arguments:

* `name` — the interactor class name (stringified)
* `*args` — all arguments passed to `call_later`


### Caveats
* All arguments to `call_later` must be serializable.
* The `call_later` method falls back to the standard `call` method if the project does not use Active Job and no custom job wrapper is configured.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
