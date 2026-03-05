# beats-service
Web service which provides the current _[Internet Time](https://en.wikipedia.org/wiki/Swatch_Internet_Time)_ in beats.  
Welcome to 1998!

## Running with Docker

Pull and run the pre-built image directly from Docker Hub — no local Go installation needed:

```bash
docker run --rm -p 8080:8080 mapitman/beats-service:latest
```

The service will be available at `http://localhost:8080/beats`.

## Running Locally

Build and run the service directly with Go:

```bash
make build
./beats-service
```

The service listens on port `8080` by default.

## Calling the Web Service

The service supports content negotiation via the `Accept` request header. Pass `Accept: application/json` to receive a JSON response, or omit it (or pass `Accept: text/html`) to receive an HTML page.

### HTML response

```bash
curl http://localhost:8080/beats
```

### JSON response

```bash
curl -H "Accept: application/json" http://localhost:8080/beats
```

Example JSON response:

```json
{"beats": 42}
```
