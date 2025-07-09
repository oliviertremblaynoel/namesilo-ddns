# namesilo-ddns

A DDNS container for Namesilo records. The current script expects that you have A records for <your_domain> and wildcard *.<your_domain>. Modify the script to your needs.

## How to use

- Schedule with [ofelia](https://github.com/mcuadros/ofelia). An example is provided.
- Use `docker compose up --pull-always` to run the script once.

## Development

- Linting is done with pre-commit. For this to work, you need an environment with docker (for hadolint and dclint).
