# README

`lhi` is a persistent LiquidHaskell server (cf. `hdevtools`) that will enable

1. Incremental Checking
2. Interactive Queries
3. Interactive Proofs & Synthesis

## Incremental Checking

## Interactive Queries

## Interactive Proofs (and Synthesis)


## TODO

We must learn to crawl.

`lhi` sets up a server that takes two commands, which `get` and `set`
the value of a given `String` key:

```
$ lhi get --key=cat
$ lhi set --key=cat --val=10
```


**HEREHEREHEREHERE**

1. figure out how hdevtools uses a socket to do the comms.

   hardwire socket at "/Users/rjhala/tmp/.lhi.sock"

2. then what?
     if server exists then query it ...
                      else create server
                           query it ...
