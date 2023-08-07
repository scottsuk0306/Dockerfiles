FROM python:3.9.16-slim

ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install Python 3.9 and dependencies
RUN apt-get update && apt-get install -y \
  sudo \
  gcc \
  make \
  vim.tiny \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

RUN ln -s /usr/bin/python3 /usr/bin/python

EXPOSE 8080
EXPOSE 3000

COPY . .

CMD tail -F /dev/null