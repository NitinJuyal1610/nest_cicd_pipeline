
# Building layer
FROM node:16-alpine as development

WORKDIR /app

# Copy configuration files
COPY tsconfig*.json ./
COPY package*.json ./

# Install dependecies
RUN npm ci

# Copy application sources (.ts, .tsx, js)
COPY src/ src/

# Build application (produces dist/ folder)
RUN npm run build

# Runtime (production) layer
FROM node:16-alpine as production

WORKDIR /app

# Copy dependencies files
COPY package*.json ./

# Install runtime dependecies (without dev/test dependecies)
RUN npm ci --omit=dev

# Copy production build
COPY --from=development /app/dist/ ./dist/

ARG RDS_HOSTNAME
ENV RDS_HOSTNAME=$RDS_HOSTNAME
ARG RDS_USERNAME
ENV RDS_USERNAME=$RDS_USERNAME
ARG RDS_DATABASE
ENV RDS_DATABASE=$RDS_DATABASE
ARG RDS_PASSWORD
ENV RDS_PASSWORD=$RDS_PASSWORD


# Expose application port
EXPOSE 3000

# Start application
CMD [ "npm","run", "start:prod" ]