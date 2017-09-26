# Backend

## Getting Started
```
it flow init
git config --global user.email "aapiragautau@unal.edu.co"
git config --global user.name "Anni Piragauta"
git flow feature start #-card-on-trello
gst -sb
ga .
gc -m "OMETHING YOU WANT TO COMMIT"
git flow feature publish #-card-on-trello
git flow feature finish #-card-on-trello
git push origin develop

git flow release start 1.0.0
git flow release finish 1.0.0
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
```

### Configuration
```
$ sh z1_bundle.sh
$ sh z2_machine.sh
```

### Database creation

### Database initialization
```
$ sh z3_compose.sh
```
