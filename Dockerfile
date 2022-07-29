# using AS can tag everything as a "builder" phase
FROM node:16-alpine AS builder

WORKDIR '/app'

COPY package.json .
RUN npm i

COPY . .

# build folder while be in the working directory /app/build
RUN ["npm", "run", "build"]

# next phase
FROM nginx
# using --from=tagname for multiphase
# Configuration can be found on nginx documentation on docker hub
COPY --from=builder /app/build /usr/share/nginx/html
# nginx default is startup
