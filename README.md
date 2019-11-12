# shellcheck.kak
[ShellCheck](https://www.shellcheck.net) integration for [Kakoune](https://kakoune.org)

## Installation

First, install `shellcheck`. See [here](https://github.com/koalaman/shellcheck#installing) for directions.

### With plug.kak

To install the plugin, I recommend using [`plug.kak`](https://github.com/andreyorst/plug.kak). You can install it by adding the following to your `kakrc`:

```
plug "whereswaldon/shellcheck.kak"
```

### Manually

If you prefer to install it manually, you can use:

```bash
mkdir -p ~/.config/kak/plugins/
git clone https://github.com/whereswaldon/shellcheck.kak ~/.config/kak/plugins/shellcheck.kak/
```

You'll need to add the following to your kakrc as well:

```
source "%val{config}/plugins/shellcheck.kak/shellcheck.kak"
```

## Commands

- `shellcheck-enable` starts linting the current window with shellcheck when you `:write` it.
- `shellcheck-disable` turns off linting the current window.

## Configuration

Currently, the plugin will automatically enable linting when kakoune
determines that the current filetype is a shell script.

## Contribute

Feature requests and pull requests welcome!

## License

Unlicense

