### Java - Pre-Commit Checkstyle

## Detailed Installation Guide

This is a detailed version to install this useful hook.

# Let`s do it!

First install and setup the check in pre-commit:
### Pre-Commit Checkstyle
Install the gem

    $ gem install pre-commit

### Install the Java-checkstyle gem

Add this line to your application's Gemfile:

    gem 'java-checkstyle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install java-checkstyle

Now your pre-commit hook has been installed.

## Using in your project

Create your project folder and start a git repository

```bash
mkdir awesome_project
cd awesome_project
git init
```
**Install the hook for this repository**

Use the pre-commit command to generate a stub pre-commit hook
```bash
# Inside of your project with git
pre-commit install
```
This creates a .git/hooks/pre-commit script which will check your git config and run checks that are enabled.

**Enable the java checkstyle checks**

``` bash
pre-commit enable git checks checkstyle
```

OR

``` bash
pre-commit enable yaml checks checkstyle
```

Then the pre commmit has been configured! For this your repository.

## Let`s test it!
Create a new java code with some style errors see: [Google checkstyle guide](http://google.github.io/styleguide/javaguide.html)

```java
class HelloWorld
{
  public static void main(String[] args)
  {
    System.out.println("Hello World!");
  }
}
```
Then add it and try commit
``` bash
git add .
git commit -m "Time's up, let's do this! Leeeeeeeeeeeeeroy Jjjjjjenkinsss!!"
```

Still don`t know our hero Leroy Jenkis? Oh man! see [here](https://www.youtube.com/watch?v=LkCNJRfSZBU)

![My awesome change has been catch. Oh boy!](https://raw.githubusercontent.com/CristianOliveiraDaRosa/java-checkstyle/master/demo.png)

---
## Installing with RVM

If you are using rvm you need to install pre-commit into the ```default``` gemset, because it does not use the ```current``` environment

    $ rvm default do gem install pre-commit

Alternatively you can configure pre-commit to use the ```current``` rvm gemset

    $ git config pre-commit.ruby "rvm `rvm current` do ruby"

More details about this part see on:
[pre-commit](https://github.com/jish/pre-commit)

## Authors:
 - Allen Madsen (Original Version 0.0.1)
 - Alex Rocha
 - Cristian Oliveira
