# Getting Started Guide

Steps you can follow after cloning this template:

- Be sure to read the [den documentation](https://vic.github.io/den)

- Update den input.

```console
nix flake update den
```

- Edit [modules/hosts.nix](modules/hosts.nix)

- Run the VM

We recommend to use a VM develop cycle so you can play with the system before applying to your hardware.

See [modules/vm.nix](modules/vm.nix)

```console
nix run .#vm
```

# Self-docs
## What makes an app vs a tool?
- **App**: a user-facing GUI or CLI that a user calls. User-facing, and can appear the an app launcher. Never a default configuration option.
- **Tool**: a system, daemon, config, or admin low-level utility and its backends. This includes wireguard services, hardware configuration, and system services. These are permitted to be a default configuration option.
### Heuristics
- If both a daemon and GUI frontend exist, daemon -> *tool*, frontend -> *tool*, and the frontend depends on the daemon module.
- If it's a "glue" module between different modules, then it's a *tool*
- If it's an app that only admins interact with, it's a *tool*
