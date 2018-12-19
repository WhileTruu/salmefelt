# salmefelt-backend

```

# backup db
docker exec -u postgres $CONTAINER_ID pg*dump -Fc postgres > ~/backups/pg_dump*`date -u +"%Y-%m-%dT%H:%M:%SZ"`.sql

# backup media
cp -R media backups

# restore

docker exec -i $CONTAINER_ID pg_restore -U postgres -d postgres --verbose --clean < ~/Desktop/backups/db.dump
```
