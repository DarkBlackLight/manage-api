#!/bin/bash
bundle exec whenever --update-crontab
service cron restart
bundle exec puma -C config/puma.rb