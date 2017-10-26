#!/bin/bash
git remote add heroku-dev https://git.heroku.com/b911-mercury-dev.git
git remote add heroku-staging https://git.heroku.com/b911-mercury-staging.git
git remote add heroku-production https://git.heroku.com/b911-mercury-production.git

cat > ~/.netrc << EOF
machine api.heroku.com
  login $HEROKU_LOGIN
  password $HEROKU_API_KEY
machine git.heroku.com
  login $HEROKU_LOGIN
  password $HEROKU_API_KEY
EOF

# Add heroku.com to the list of known hosts
ssh-keyscan -H heroku.com >> ~/.ssh/known_hosts
