# Honcho

A process manager for your `Procfile`(s).

## Installation

Add the following to your deps in `mix.env`

```shell
  {:honcho, "~> 0.2"},
```

Add a file `Procfile` to your project. Procfiles are defined in the following
format:

```procfile
<process name>: <command>
```

## Usage

Honcho will add several mix tasks your your project, including:

  * `mix honcho.info` - prints information about your process definitions
  * `mix honcho.start` - will start your process
  
These tasks take the following optional arguments:

  * `-p, --procfile` - a path to a Procfile. This defaults to a file, `Procfile`,
    in the current working directory.
