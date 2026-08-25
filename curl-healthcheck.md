# HTTP Health Check with curl

Use in CI/CD pipelines to verify a service is healthy before proceeding.

```bash
curl -fsS -o /dev/null -w '%{http_code}\n' https://example.com/health
```

`-f` fails on HTTP errors, `-s` silent, `-S` shows errors, `-o /dev/null` discards body.

Check response time:

```bash
curl -fsS -o /dev/null -w 'HTTP %{http_code} in %{time_total}s\n' https://example.com/health
```
