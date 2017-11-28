FROM golang:alpine AS build
ADD . /src
WORKDIR /src
RUN go build -o app

FROM alpine
ADD index.html /
COPY --from=build /src/app /app
ENTRYPOINT ./app
