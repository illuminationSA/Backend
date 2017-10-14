# Backend

## Getting Started
```
$ git config --global user.email "aapiragautau@unal.edu.co"
$ git config --global user.name "Anni Piragauta"

$ git clone https://github.com/illuminationSA/Backend.git
$ cd Backend

$ git flow init
$ git flow feature start #-card-on-trello
$ gst -sb
$ ga .
$ gc -m "SOMETHING YOU WANT TO COMMIT"
$ git flow feature publish #-card-on-trello
$ git flow feature finish #-card-on-trello
$ git push
```

### Prerequisites

You should have these software installed: <br />
```
virtualbox v5.1
docker-ce v17.06.1
docker-machine v0.12.2
docker-compose v1.8.0
ruby v2.4.0
Rails v5.0.6
httpie
```

### Configuration
```
Install all dependencies:       $ bundle install
Clear rancher-node1:            $ sh zclear
```

### Database creation
```
For http://localhost:3000       $ sh z1 -l
For http://192.168.99.101:3000  $ sh z1 -d
```

### Database initialization
```
For http://localhost:3000       $ sh z2 -l
For http://192.168.99.101:3000  $ sh z2 -d
```
