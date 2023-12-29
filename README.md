# BP-SHELL-STEP-TEMPLATE
I'll <do xyz>

## Setup
* Clone the code available at [BP-SHELL-STEP-TEMPLATE](https://github.com/OT-BUILDPIPER-MARKETPLACE/BP-SHELL-STEP-TEMPLATE)

* Build the docker image
```
git submodule init
git submodule update
docker build -t ot/helm:0.1 .
```

* Do local testing
```
docker run -it --rm -v $PWD:/src -e WORKSPACE=/src -e CODEBASE_DIR=/ -e BASE_PATH="charts/mysql" -e var2="key2" ot/helm:0.1
docker run -it --rm -v $PWD:/src -e WORKSPACE=/src -e CODEBASE_DIR=/ -e BASE_PATH="charts/mysql" -e INSTRUCTION="install" ot/helm:0.1

```

* Debug
```
docker run -it --rm -v $PWD:/src -e WORKSPACE=/src -e CODEBASE_DIR=/ -e BASE_PATH="charts/mysql" -e var2="key2" --entrypoint sh  ot/helm:0.1
```