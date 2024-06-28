#!/bin/bash

gem update --system 3.2.3

gem install bundler -v 2.3.27

bundle update --bundler

bundle install

echo 'setup completed!'
