# λdvent of Code 2018

![https://git.irvinlim.com/irvin/advent-of-code-2018/pipelines](https://git.irvinlim.com/irvin/advent-of-code-2018/badges/master/build.svg)

My attempt at Advent of Code 2018, completely in Haskell with automatic input fetching, running and submission. As a Haskell beginner, this serves as a platform for me to learn more about using some real world Haskell packages, as well as certain advanced Haskell concepts such as existentialisation.

This is very much inspired by [mstksg/advent-of-code-2018](https://github.com/mstksg/advent-of-code-2018)!

## Usage

Submit answers with the `SubmitAnswer` executable:

```sh
stack run SubmitAnswer
```

Run all unit tests:

```sh
stack test
```

## Features

### `Challenge` record type

We can standardise the declaration of all challenge solutions in a single record type, where we can declare how to parse an input, solve the problem with the given input, and show the result. This separation of concerns allows us to test the `sSolve` function without involving the parse and show methods.

```hs
data Challenge where
  Challenge
    :: { day :: Int
       , level :: Int
       , sParse :: T.Text -> a
       , sSolve :: a -> b
       , sShow :: b -> String}
    -> Challenge
```

By making `Challenge` [existential](https://wiki.haskell.org/Existential_types), we can still create a homogenous `[Challenge]` list by hiding the inner `a` and `b` types. If on the other hand we had parameterised the `Challenge` ADT as such, our list is no longer [homogenous](https://wiki.haskell.org/Heterogenous_collections).

```hs
data Challenge' a b = Challenge'
  { day :: Int
  , level :: Int
  , sParse :: T.Text -> a
  , sSolve :: a -> b
  , sShow :: b -> String
  }

challenges = [challengeA :: Challenge' String Int, challengeB :: Challenge' Int Int]
-- <interactive>:16:52: error:
--     • Couldn't match type ‘Int’ with ‘[Char]’
--       Expected type: Challenge' String Int
--         Actual type: Challenge' Int Int
```
