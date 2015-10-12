## Java - Pre-Commit Checkstyle
[![Gem Version](https://badge.fury.io/rb/java-checkstyle.svg)](https://badge.fury.io/rb/java-checkstyle)
[![Build Status](https://travis-ci.org/CristianOliveiraDaRosa/java-checkstyle.svg?branch=dev)](https://travis-ci.org/CristianOliveiraDaRosa/java-checkstyle)
[![Code Climate](https://codeclimate.com/github/CristianOliveiraDaRosa/java-checkstyle/badges/gpa.svg)](https://codeclimate.com/github/CristianOliveiraDaRosa/java-checkstyle)
[![Test Coverage](https://codeclimate.com/github/CristianOliveiraDaRosa/java-checkstyle/badges/coverage.svg)](https://codeclimate.com/github/CristianOliveiraDaRosa/java-checkstyle/coverage)

Useful pre-commit hook for linting Java code.

It uses the famous [Checkstyle](http://checkstyle.sourceforge.net/) linter as a plugin for [pre-commit](https://github.com/jish/pre-commit).

## Demo

![My awesome change has been catch. Oh boy!](https://raw.githubusercontent.com/CristianOliveiraDaRosa/java-checkstyle/master/demo.png)

## Installation

First install and setup the check in pre-commit:
### Pre-Commit Checkstyle
Install the gem

    $ gem install pre-commit

Use the pre-commit command to generate a stub pre-commit hook

    # In your git repo
    $ pre-commit install

This creates a .git/hooks/pre-commit script which will check your git config and run checks that are enabled.

**RVM**

If you are using rvm you need to install pre-commit into the ```default``` gemset, because it does not use the ```current``` environment

    $ rvm default do gem install pre-commit

Alternatively you can configure pre-commit to use the ```current``` rvm gemset

    $ git config pre-commit.ruby "rvm `rvm current` do ruby"

More details about this part see on:
[pre-commit](https://github.com/jish/pre-commit)

### Java-checkstyle

Add this line to your application's Gemfile:

    gem 'java-checkstyle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install java-checkstyle

## Enabling checks

Make sure the gem is installed and setup the check in [pre-commit](https://github.com/jish/pre-commit) with:

``` bash
pre-commit enable git checks checkstyle
```

OR

``` bash
pre-commit enable yaml checks checkstyle
```

And your pre-commit hook is configured.

## Tests
Running tests with rspec

Make sure you have been executed:
```bash
bundle install
```
Then run:

```bash
rspec
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

#### Codeclimate
Before push, make sure you have been executed rubocop
``` bash
rubocop lib/*
```

*Pull request should have Unit Tests*

## Authors:
 - Allen Madsen (Original Version 0.0.1)
 - Alex Rocha
 - Cristian Oliveira
