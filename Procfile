web: bundle exec puma -C config/puma.rb
release: bundle exec rails db:migrate
worker: bundle exec sidekiq -q default -q mailers
scheduler: bundle exec clockwork config/clock.rb
rpush: bundle exec rpush start -f -e $RACK_ENV
