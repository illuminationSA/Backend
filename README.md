# Backend

## Getting Started
```
git config --global user.email "aapiragautau@unal.edu.co"
git config --global user.name "Anni Piragauta"

git clone https://github.com/illuminationSA/Backend.git

git flow init
git flow feature start #-card-on-trello
gst -sb
ga .
gc -m "SOMETHING YOU WANT TO COMMIT"
git flow feature publish #-card-on-trello
git flow feature finish #-card-on-trello
git push
```

### Prerequisites

You need to install these software: <br />
```
virtualbox-5.1_5.1.26
docker-ce_17.06.1
docker-machine version 0.12.2
docker-compose version 1.8.0
git-core curl zlib1g-dev build-essential libssl-dev
libreadline-dev libyaml-dev libsqlite3-dev sqlite3
libxml2-dev libxslt1-dev libcurl4-openssl-dev
python-software-properties libffi-dev nodejs
ruby 2.4.0
Rails 5.0.6
libmysqlclient-dev ruby-mysql2
httpie
```

### Configuration
```
Install all dependencies: $ bundle install
Start machines:           $ sh dmachines
Clear rancher-node1:      $ sh dclear
```

### Database creation
```
For localhost:3000:       $ sh start
For 192.168.99.101:3000:  $ sh dstart
```

### Database initialization
```
For localhost:3000:       $ sh post
For 192.168.99.101:3000:  $ sh dpost
```
