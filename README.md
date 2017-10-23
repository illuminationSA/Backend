# Backend

## Getting Started
```
$ git config --global user.email "aapiragautau@unal.edu.co"
$ git config --global user.name "Anni Piragauta"

$ git clone https://github.com/illuminationSA/Backend.git
$ cd Backend

$ git flow init
$ bundle install
$ git flow feature start #-card-on-trello
$ git status
$ git add .
$ git commit -m "SOMETHING THAT YOU WANT TO COMMIT"
$ git flow feature publish #-card-on-trello
$ git flow feature finish #-card-on-trello
$ git push
```

### Prerequisites

You should have these software installed: <br />
```
virtualbox v5.1.26
docker-ce v17.06.1
docker-machine v0.12.2
docker-compose v1.8.0
ruby v2.4.0
rails v5.0.6
httpie v0.9.2
```

### Configuration
```
Install all dependencies:       $ bundle install
Clear rancher-node1:            $ sh zc
```

### Database creation
```
For http://localhost:3000       $ sh zb -l
For http://localhost:3000       $ sh zb -l -r (drop database)
For http://192.168.99.101:3000  $ sh zb -d
For http://192.168.99.101:3000  $ sh zb -d -r (drop database)
```

### Database initialization
```
For http://localhost:3000       $ sh zp -l
For http://192.168.99.101:3000  $ sh zp -d
```