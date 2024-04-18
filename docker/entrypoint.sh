#!/bin/bash
bundle exec whenever --update-crontab
service cron restart
rails server