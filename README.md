CI Pipeline tools for Scala/SBT/Sphinx builds
=============================================

A docker image with Scala, SBT and Sphinx (based on [hseeberger's image](https://github.com/hseeberger/scala-sbt)).
We use it as part of our [GitLab](https://gitlab.com) CI pipeline. It builds automatically using 
[DockerHub](https://cloud.docker.com/u/spatialedge/repository/docker/spatialedge/scala-sphinx-ci).

If you do need to build it locally, use the following commands:

```bash
docker build --tag=spatialedge/scala-sphinx-ci:latest .
docker push spatialedge/scala-sphinx-ci:latest
```

And you are done. The image preparation takes a while....
