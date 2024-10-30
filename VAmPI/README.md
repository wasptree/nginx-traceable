The following 3 environment variables must be set before running the docker compose.

These can be set as environment variables or set in the .env file.

The REFRESH_TOKEN is generated on the Traceable platform under settings > Agents

- TA_ENVIRONMENT
- TA_REMOTE_ENDPOINT
- TA_REFRESH_TOKEN

Example : 

```
TA_ENVIRONMENT=testing-lab
TA_REMOTE_ENDPOINT=api.eu.traceable.ai
TA_REFRESH_TOKEN=oijsdfw4309u823rsdoijf0234rsdf_dafsw
```

Once these are set you can run with :

```
docker compose up -d 
```