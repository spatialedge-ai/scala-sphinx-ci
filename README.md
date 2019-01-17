CI Pipeline tools for Scala/SBT/Sphinx builds
=============================================

Build a docker container that and push it to dockerhub. This assumes that you have
logged into [DockerHub](https://hub.docker.com) using `docker login`.

```bash
docker build --tag=spatialedge/scala-sphinx-ci:latest .
docker push spatialedge/scala-sphinx-ci:latest
```

And you are done. The image preparation takes a while....