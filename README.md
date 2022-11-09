# Lookup prefix.cc

Simple nvim plugin that looks up the hightlighted prefix.

When the last argument is truthy, the prefix is changed to `@prefix {short}: <{prefix}>.`. 


Usage:
```
require"prefix-cc".lookup("foaf", true)
```

Or as nvim command:
```
:luado return require"prefix-cc".lookup(line, true)
```


Note, executes curl as a subcommand, so curl is required.

