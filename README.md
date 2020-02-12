# Honcho

A process manager for your `Procfile`(s).

## Installation

Install the Honcho archive into your Elixir:

```shell
mix archive.install hex honcho
```

Add a file `Procfile` to your project. Procfiles are defined in the following
format:

```procfile
<process name>: <command>
```

For example:

```procfile
postgres: postgres: postgres -D ./_build/data/postgres
phoenix: mix phx.server
```

## Usage

Honcho will add several mix tasks your your project, including:

  * `mix honcho.info` - prints information about your process definitions
  * `mix honcho.start` - will start your process
  
These tasks take the following optional arguments:

  * `-p, --procfile` - a path to a Procfile. This defaults to a file, `Procfile`,
    in the current working directory.

## Internal dependencies

On starting Honcho, it will attempt to write a bash wrapper script, which
helps to interface between Erlang and the shell. It will put its internal
helpers and config into `~/.honcho`. For this reason, in order for Honcho
to work, `$HOME` must be set, and writeable by the user under which Honcho is
started.