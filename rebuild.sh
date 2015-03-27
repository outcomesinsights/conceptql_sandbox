#!/bin/sh

rm db/site_data.db
rm public/*.png
rm results/*.json results/*.sql
bundle exec sequel -m db/migrations/ sqlite://db/site_data.db
bundle exec ruby convert.rb
bundle exec ruby precache.rb
