FROM golang:alpine AS build
ADD . /src
WORKDIR /src
RUN go build -o app

FROM alpine
WORKDIR /app
COPY --from=build /src/app /app
ENTRYPOINT ./app
