./rancher-compose --project-name illuminationbackendweb \
    --url http://192.168.99.100:8080/v1/projects/1a5 \
    --access-key 2563E70DC819B8930FBC \
    --secret-key NEWvbDm5fZeYfM6Aoc93cwM4gysMGSi5ycCkDJPR \
    -f docker-compose.yml \
    --verbose up \
    -d --force-upgrade \
    --confirm-upgrade
