# NGINX - Traceable
<!-- ABOUT THE PROJECT -->
## About This Project

nginx-traceable is a docker image that will run a simple nginx reverse proxy with the Traceable AI nginx plugin.

This can be used in docker compose files alongside the traceable agent for lab testing.

This is meant for lab & testing purposes only.

<!-- GETTING STARTED -->
## Getting Started

Docker:
Pre-built AMD64 and ARM images are available, these contain all the required depdendencies [hub.docker.com/nginx-traceable](https://hub.docker.com/repository/docker/wasptree/nginx-traceable)

Alternatively build your own image from this repository:

  ```sh
    $ git clone https://gitlab.com/wasptree/nginx-traceable
    $ cd nginx-traceable
    $ docker build -t nginx-traceable .
  ```

<!-- SETUP -->
## Setup

The image requires three environment variables to be set.
When working with Docker - These can either be set in the current terminal or in an .env file.

| Env Variable    | Description                                                |
|-----------------|------------------------------------------------------------|
| BACKEND_HOST    | The running web application that the NGINX proxy will route traffic to.       |
| COLLECTOR_HOST  | The network address of the Traceable Agent.        |
| SERVICE_NAME    | Default: "nginx". Set a service name for mapping in the Traceable UI. |

The variables are loaded into the nginx.conf at runtime.

A Traceable TPA ( Traceable Platform Agent ) and token will be required to work with the included docker compose examples.
This is generated on the Traceable platform and requires a valid subscription.

<!-- USAGE EXAMPLES -->
## Usage Example

The image can be run directly passing in environment variables as follows 

For example if you have a web application already running on port 8080 locally, this will proxy traffic on port 80 to the application.
```
docker run -d \
  -e BACKEND_HOST=127.0.0.1:8080 \
  -e SERVICE_NAME=nginx \
  -e ENVIRONMENT_NAME=local-testing \
  -e COLLECTOR_HOST=localhost \
  -p 80:80 \
  wasptree/nginx-traceable:1.18-beta1.0
```

<!-- DOCKER COMPOSE USAGE EXAMPLES -->
## docker compose Example

See the docker-compose.yml file in the /crAPI and /vAmPI example folders

Example docker-compose snippet ( Not including the web application images ).

```
...
...
  nginx-traceable:
    container_name: nginx-traceable
    image: wasptree/nginx-traceable:1.18-beta1.0
    environment:
      - BACKEND_HOST=127.0.0.1:8080
      - COLLECTOR_HOST=127.0.0.1
      - SERVICE_NAME=nginx-lab
    ports:
      - "127.0.0.1:80:80"
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 256M

  traceable-agent:
    image: traceableai/traceable-agent:latest
    container_name: traceable-agent
    environment:
      - TA_ENVIRONMENT=${TA_ENVIRONMENT}
      - TA_REMOTE_ENDPOINT=${TA_REMOTE_ENDPOINT}
      - TA_REFRESH_TOKEN=${TA_REFRESH_TOKEN}
    deploy:
      resources:
        limits:
          cpus: '0.5'
          memory: 512M
...
...
```

<!-- TESTING BLOCKING RULES -->
## Testing Blocking Rules in Browser

If you are running this locally on your computer, the real source IP address will probably be a private internal address of the Docker bridge adapter. 
This will therefore not enable Traceable blocking rules. 

To test blocking rules in the Traceable Protection module - you will need to set an x-forwarded-for header to a public IP address in your browser.

There are browser plugins to help do this easily. e.g. 
[Chrome Plugin - X Forward For Header ](https://chromewebstore.google.com/detail/x-forwarded-for-header/hkghghbnihliadkabmlcmcgmffllglin)

If using Postman - you can set the x-forwarded-for header in the settings.

<!-- To Do -->
## To Do

- Add TLS support
- Add more examples
