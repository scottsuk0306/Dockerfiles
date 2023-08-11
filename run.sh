#!/bin/bash

docker run -d --gpus all --name juyoung-dev juyoung-torch:0.2.0 tail -F /dev/null
docker exec -it juyoung-dev /bin/bash