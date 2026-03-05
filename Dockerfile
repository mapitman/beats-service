# build stage
FROM golang:1.25 AS build-env
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o beats-service .

# final stage
FROM gcr.io/distroless/base
WORKDIR /app
COPY --from=build-env /app/beats-service /app/beats-service
COPY --from=build-env /app/templates/beats.html /app/templates/beats.html
EXPOSE 8080/tcp

ENTRYPOINT ["/app/beats-service"]