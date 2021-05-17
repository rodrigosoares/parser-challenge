# Parser Challenge

This Ruby program parses a XML feed file and sends the content in the form of multiple batches to an external service. Each batch has a size of 5 MB or less.

This code is part of an assessment.

## Requirements

- [RVM](https://rvm.io/).
- Ruby version 2.7.x.

## How to run

- Run `rvm use` to set Ruby version to 2.7.x and the gemset to `parser`.
- Run `bundle install` to install all dependencies.
- Run `ruby main.rb [FILE_PATH]` passing the path of the target XML file.
- Run `rspec` to run test cases describing used methods (optional).
