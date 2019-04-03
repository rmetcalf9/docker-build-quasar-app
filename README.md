# docker-build-quasar-app
Docker image to build a Quasar App


# Steps to release a new version

```
git tag -l
git tag NEW_VER
git add --all
git commit -m"Releasing NEW_VER"
git push
git push --tags
goto docker hub (https://hub.docker.com/r/metcarob/docker-build-quasar-app/~/settings/automated-builds/) Change latest tag to NEW_VER Press Trigger
```

