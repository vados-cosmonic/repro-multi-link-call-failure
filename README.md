# Multi-link call reproduction

This repository is a reproduction of [Issue #3285 in wasmcloud/wasmcloud][issue].

A "temporary" fix (i.e. removing one of the links) is on the `temp-fix` branch of this repository,
which shows that the HTTP calls *will* work properly when that the second link is removed.

## Reproduction steps

### Start the environment

To run the code in here/replicate the bug, ensure you have [`just`][just] installed and run the following:

```console
just setup
```

> [!NOTE]
> To see all available build targets, simply run `just`

### Attempt to curl the HTTP server provider

```console
curl localhost:8082
```

### Teardown the environment

```console
just teardown
```

[issue]: https://github.com/wasmCloud/wasmCloud/issues/3285
[just]: https://github.com/casey/just
