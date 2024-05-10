ARG APP_NAME=<app_name>
ARG PORT=3000

### STAGE 1: install cargo chef
FROM rust:1.76 AS chef
ARG APP_NAME
RUN cargo install cargo-chef
WORKDIR /${APP_NAME}

### STAGE 2: create cargo chef recipe.json
FROM chef AS planner
ARG APP_NAME
COPY . .
RUN cargo chef prepare --recipe-path recipe.json

### STAGE 3: build dependencies from recipe.json and build the app
FROM chef AS builder
ARG APP_NAME
COPY --from=planner /${APP_NAME}/recipe.json recipe.json
# Build dependencies - this is the caching Docker layer!
RUN cargo chef cook --release --recipe-path recipe.json
# Build application
COPY . .
RUN cargo build --release

### STAGE 4: run the app
# We do not need the Rust toolchain to run the binary!
FROM gcr.io/distroless/cc-debian12
ARG APP_NAME
ARG PORT
EXPOSE ${PORT}
COPY --from=builder /${APP_NAME}/target/release/${APP_NAME} ${APP_NAME}
# RUN chmod +x ./${APP_NAME}
ENTRYPOINT [ "./<app_name>" ]
