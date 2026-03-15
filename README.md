# Homebrew Tap

## Projects

| Name                                    | Description                                | Installation command                  |
| --------------------------------------- | ------------------------------------------ | ------------------------------------- |
| [hanko](https://github.com/SRv6d/hanko) | Keeps your allowed signers file up to date | `brew install --cask srv6d/tap/hanko` |

## Updating casks

This repository includes a `justfile` to help bump casks to their latest version.

```bash
# Bump a single cask
just bump-version hanko

# Bump all casks in Casks/
just bump-all
```
