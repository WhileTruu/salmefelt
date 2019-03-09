# salmefelt

## How to run?

```
-p defined a project name, which is prepended to container names
docker-compose -p salmefelt up

```

## How to restore from backup?

\$pathToBackup - backup tar.gz file containing the media folder, .env file and the db dump

```
./restoreFromBackup $pathToBackup
```

TODO: How to create backup from data volume?

## How to run

1. docker-compose up
2. ./restoreFromBackup
3. run again since `docker-compose up` had error with django connecting to psql (could not something something host)

## How to remove most stuff

docker-compose down && docker container prune && docker volume prune
