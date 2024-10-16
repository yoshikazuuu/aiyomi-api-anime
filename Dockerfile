FROM imbios/bun-node:18-slim

RUN apt-get update && apt-get upgrade -y && apt-get autoclean -y && apt-get autoremove -y && apt-get install -y curl

WORKDIR /usr/src/app
COPY package.json bun.lockb ./
RUN bun install --frozen-lockfile
COPY . .
COPY .env ./
EXPOSE 8080
ENV NODE_ENV=production

# add an healthcheck, useful
# healthcheck with curl, but not recommended
HEALTHCHECK CMD curl --fail http://localhost:3000/health || exit 1

CMD ["bun", "start"]