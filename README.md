# README

`lhi` is a persistent LiquidHaskell server (cf. `hdevtools`) that will enable

1. Incremental Checking
2. Interactive Queries
3. Interactive Proofs & Synthesis

## Incremental Checking

## Interactive Queries

## Interactive Proofs (and Synthesis)

## Framework

To create your own server, simply provide implementations of the above, and:

_Types_

+ `Types.Command`
+ `Types.Response`
+ `Types.State`

_Code_

+ `Handler.init`
+ `Handler.handler`


```
$ lhi get --key=cat
Daemon started on port 7856
Just (Failed "not found")
$ lhi put --key=cat --val=garfield
Just (Value "Ok!")
$ lhi get --key=cat
Just (Value "garfield")
$ lhi get --key=dog
Just (Failed "not found")
$ lhi put --key=dog --val=fido
Just (Value "Ok!")
$ lhi get --key=cat
Just (Value "garfield")
$ lhi get --key=dog
Just (Value "fido")
```
