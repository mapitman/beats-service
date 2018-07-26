# build stage
FROM golang:1.10 as build-env
ADD . /go/src/mapitman/beats-service
RUN cd /go/src/mapitman/beats-service && go get ./... && go build

# final stage
# FROM scratch
FROM gcr.io/distroless/base
WORKDIR /app
COPY --from=build-env /go/src/mapitman/beats-service/beats-service /app/beats-service
COPY --from=build-env /go/src/mapitman/beats-service/templates/beats.html /app/templates/beats.html
EXPOSE 8080/tcp

ENTRYPOINT ["/app/beats-service"]