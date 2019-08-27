ARG NODE_BASE=10-slim
FROM node:${NODE_BASE}

# Use --no-cache to avoid rm -rf /var/cache/apk/*
RUN apt-get --update --no-cache install python make g++

CMD ["/bin/sh"]
