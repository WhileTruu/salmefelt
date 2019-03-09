# salmefelt-backend

```bash

# backup db
docker exec -u postgres $CONTAINER_ID pg*dump -Fc postgres > ~/backups/pg_dump*`date -u +"%Y-%m-%dT%H:%M:%SZ"`.sql

# backup media
cp -R media backups

# restore

docker exec -i $CONTAINER_ID pg_restore -U postgres -d postgres --verbose --clean < ~/Desktop/backups/db.dump

# migrations
docker-compose run backend_web python3 manage.py makemigrations api\
docker-compose run backend_web python3 manage.py migrate api\
docker-compose run backend_web python3 manage.py makemigrations\
docker-compose run backend_web python3 manage.py migrate
```
