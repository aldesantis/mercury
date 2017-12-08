#!/bin/bash
git remote add heroku-dev git@heroku.com:b911-mercury-dev.git
git remote add heroku-release git@heroku.com:b911-mercury-release.git
git remote add heroku-staging git@heroku.com:b911-mercury-staging.git
git remote add heroku-production git@heroku.com:b911-mercury-production.git

cat >> ~/.ssh/config << EOF
  VerifyHostKeyDNS yes
  StrictHostKeyChecking no
EOF
