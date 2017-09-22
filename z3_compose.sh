eval $(docker-machine env rancher-node1)
docker-compose build
docker-compose run --rm web rails db:create
docker-compose run --rm web rails db:migrate
docker-compose up
