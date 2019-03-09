#!/usr/bin/env bash

backendId=$(docker-compose ps -q backend | head -1)
databaseId=$(docker-compose ps -q db | head -1)

docker cp $1 $backendId:/var/lib/backend/backup.tar.gz
docker exec -w /var/lib/backend -i $backendId bash -c 'tar -xvf backup.tar.gz \
  && mv backup/media /var/lib/backend \
  && mv backup/.env /app \'

docker exec -i $backendId python3 manage.py makemigrations api
docker exec -i $backendId python3 manage.py migrate api
docker exec -i $backendId python3 manage.py makemigrations
docker exec -i $backendId python3 manage.py migrate

docker exec -i $databaseId \
  pg_restore -U postgres -d postgres --verbose --clean /var/lib/backend/backup/db.dump
