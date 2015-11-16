## Java - Pre-Commit Checkstyle
[![Gem Version](https://badge.fury.io/rb/java-checkstyle.svg)](https://badge.fury.io/rb/java-checkstyle)
[![Build Status](https://travis-ci.org/cristianoliveira/java-checkstyle.svg)](https://travis-ci.org/CristianOliveiraDaRosa/java-checkstyle)
[![Code Climate](https://codeclimate.com/github/cristianoliveira/java-checkstyle/badges/gpa.svg)](https://codeclimate.com/github/cristianoliveira/java-checkstyle)
[![Test Coverage](https://codeclimate.com/github/cristianoliveira/java-checkstyle/badges/coverage.svg)](https://codeclimate.com/github/cristianoliveira/java-checkstyle/coverage)

Useful git pre-commit hook for linting Java code.

It uses as default [The Google Style Guide](https://google.github.io/styleguide/javaguide.html)
and the famous [Checkstyle](http://checkstyle.sourceforge.net/) linter as a plugin for [pre-commit](https://github.com/jish/pre-commit).

## Demo

![My awesome change has been catch. Oh boy!](https://raw.githubusercontent.com/cristianoliveira/java-checkstyle/master/readmedemo.png)
[Don't you know who is Leeroy Jenkins?](https://www.youtube.com/watch?v=mLyOj_QD4a4)

## Installation

First install the gems.
#### Pre-Commit Checkstyle

    gem install pre-commit

#### Java Checkstyle Plugin

    gem install java-checkstyle

##### (optional) If you use RVM
Take a look here [Install with RVM](https://github.com/jish/pre-commit#rvm)

### Configuring
Use the pre-commit command to generate a stub pre-commit hook.
Inside folder of your git repo:

```bash
pre-commit install
```

It will create a .git/hooks/pre-commit script which will check your git config and run checks that are enabled.

#### Enabling checks

``` bash
pre-commit enable git checks checkstyle
```

### Result
Every time you try to commit some java code with style errors it will validate
for you ensuring that your code will be always awesome.

---
#### Detailed version to install.
Still don't work? Try the detailed version [here](https://github.com/cristianoliveira/java-checkstyle/blob/master/DETAILED_TUTORIAL.md)

---

## Checkstyle Guide

It uses as default [The Google Style Guide](https://google.github.io/styleguide/javaguide.html).

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
