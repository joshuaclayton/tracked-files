# `tracked-files`

This is a tool for listing all files that aren't `.gitignore`d that also exist.

## Motivation

`git ls-files` alone doesn't include new files, and having a way to access this
list can be helpful when determining what files to care about during token
analysis.


## Install

```sh
stack install
```

## Test

```sh
stack test
```

## License

Copyright 2020 Josh Clayton. See the [LICENSE](LICENSE).
