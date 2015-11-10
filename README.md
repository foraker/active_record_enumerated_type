# ActiveRecord Enumerated Type

Integrates [EnumeratedType](https://github.com/rafer/enumerated_type) with ActiveRecord.

## Installation

Add this line to your application's Gemfile:

    gem 'active_record_enumerated_type'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install active_record_enumerated_type

## Usage

__1. Create a formal type__

For example, per the [EnumeratedType](https://github.com/rafer/enumerated_type) documentation, a `JobStatus`:

```Ruby
class JobStatus
  include EnumeratedType

  declare :started
  declare :finished
end
```

__2. Restrict an ActiveRecord attribute to the type.__

For example, assuming a `Job` class with a `status` attribute:

```Ruby
class Job < ActiveRecord::Base
  restrict_type_of :status, to: JobStatus
end
```

This allows one to set attributes symbolically or as formal types.

```Ruby
job = Job.new(status: JobStatus[:started])
job.status # => JobStatus[:started]

job = Job.new(status: :started)
job.status # => JobStatus[:started]

job = Job.new(status: nil)
job.status # => nil
```

Setting an invalid type raises an exception.

```Ruby
job = Job.new(status: :pending)
# => "'pending' is not a valid type for status. Valid types include 'started' and 'finished'."
```

### I18n support
Type names can be translated with I18n.

```YML
en:
  enumerated_type:
    job_status:
      finished: Finito
```

```Ruby
job = Job.new(status: :finished)
job.status.human
# => 'Finito'

job = Job.new(status: :started)
job.status.human
# => 'started'
```

### Custom serialization
For performance reasons, it is sometimes advantageous to store enum values as integers. This can be achieved via custom serialization.

```Ruby
class JobStatus
  include EnumeratedType

  declare :started, id: 1
  declare :finished, id: 2

  def self.deserialize(value)
    detect { |type| type.id == value.to_i }
  end

  def serialize
    id
  end
end

job = Job.new(status: :finished)
# => #<Job status: 2>

job.status
#<JobStatus:finished>
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## About Foraker Labs

![Foraker Logo](http://assets.foraker.com/attribution_logo.png)

Foraker Labs builds exciting web and mobile apps in Boulder, CO. Our work powers a wide variety of businesses with many different needs. We love open source software, and we're proud to contribute where we can. Interested to learn more? [Contact us today](https://www.foraker.com/contact-us).

This project is maintained by Foraker Labs. The names and logos of Foraker Labs are fully owned and copyright Foraker Design, LLC.

