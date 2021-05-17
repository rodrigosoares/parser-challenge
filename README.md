# Publitas Backend Code Challenge

This Ruby program parses a XML feed file and sends the content in the form of multiple batches to an external service. Each batch has a size of 5 MB or less.

## Requirements

- Ruby version 2.7.x.

## How to run

- Install [RVM](https://rvm.io/).
- Run `rvm use` to set Ruby version to 2.7.x and use the gemset `parser`.
- Run `bundle install` to install all dependencies.
- Run `ruby main.rb [FILE_PATH]` passing the path of the XML file.
