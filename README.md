# shellcheck.kak
[ShellCheck](https://www.shellcheck.net) integration for [Kakoune](https://kakoune.org)

## Installation

First, install `shellcheck`. See [here](https://github.com/koalaman/shellcheck#installing) for directions.

To install the plugin:

```bash
git clone https://github.com/whereswaldon/shellcheck.kak
ln -sv $PWD/shellcheck.kak/shellcheck.kak ~/.config/kak/autoload/
```

**Note:** If this is your first time installing a Kakoune plugin and you don't already
have a `~/.config/kak/autoload/` folder, I recommend following these steps to create
it:

```bash
mkdir -p ~/.config/kak/autoload/
ln -sv $(dirname $(which kak))/../share/kak/autoload ~/.config/kak/autoload/system
```

If you don't symlink the system-wide `autoload` folder, all of the default Kakoune
commands will not be available next time you start your editor.

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

