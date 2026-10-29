# Homebrew Tap

## Projects

| Name                                              | Description                                | Installation command                       |
| ------------------------------------------------- | ------------------------------------------ | ------------------------------------------ |
| [hanko](https://github.com/marvinvogt/hanko)           | Keeps your allowed signers file up to date | `brew install --cask marvinvogt/tap/hanko`      |
| [slopfilter](https://github.com/marvinvogt/slopfilter) | Scores text for likely AI authorship       | `brew install --cask marvinvogt/tap/slopfilter` |

## Updating casks

This repository includes a `justfile` to help bump casks to their latest version.

```bash
# Bump a single cask
just bump-version hanko

# Bump all casks in Casks/
just bump-all
```
