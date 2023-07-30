# The declaration of my systems

I grew tired of confusing flake based NixOS configuration frameworks, so here goes an attempt to have saner and more reliable system configuration repository.

## Goals

* Have all of my systems configured in one place in declarative, stateless and reproducable fashion,
* Have modular configuration that I can share between systems and that can be copied by others,
* Have a very stable core configuration, so that I don't have to worry that everything will break on flake update,
* Keep the codebase readable enough so that future me and other potential readers can find what they're looking for and understand how different parts of the codebase interact with each other.
