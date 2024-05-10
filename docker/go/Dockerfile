FROM golang:1.22.0-buster AS builder

ARG GITHUB_TOKEN
ARG PRIVATE_REPO="your-private-repo-link"
ARG APP_NAME="your-app-name"

# Install Base Image Requirement
RUN apt-get update && apt-get install -y \
  bash \
  curl \
  git \
  openssh-client

# Add github into known_hosts record
RUN mkdir ~/.ssh \
  && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts

# Set go mod on
ENV GO111MODULE=on

# Set private repo into go env
RUN go env -w GOPRIVATE=${PRIVATE_REPO}

# Always set workdir into application root
WORKDIR /src

# Copy the source code into container for compiling
COPY . /src

# Configure github auth
RUN git config --global url."https://${GITHUB_TOKEN}:x-oauth-basic@github.com/".insteadOf "https://github.com/"
RUN export GOPRIVATE=${PRIVATE_REPO}

# download dependencies
RUN if [ ! -d ./vendor ]; then go mod download; fi;

# build app
RUN if [ ! -f ./bin/${APP_NAME} ]; then GOOS=linux go build -ldflags '-w -s' -a -o ./bin/${APP_NAME} ./cmd/${APP_NAME}; fi;

# Copy release binary that already compiled into distroless
FROM gcr.io/distroless/cc-debian12
ARG PORT
COPY --from=builder /src /app
EXPOSE ${PORT}
ENTRYPOINT [ "/app/bin/<YOUR_APP_NAME>" ]