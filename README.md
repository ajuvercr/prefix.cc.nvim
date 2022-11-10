# Lookup prefix.cc

Simple nvim plugin that looks up the highlighted prefix.

When the last argument is truthy, the prefix is changed to `@prefix {short}: <{prefix}>.`. 


Usage:
```
:lua require"prefix-cc".lookup(true)
```


Note, executes curl as a subcommand, so curl is required.

