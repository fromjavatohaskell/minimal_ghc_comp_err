{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module Main where

import Data.Data

type GenericQ r = forall a. Data a => a -> r

gzipWithQ :: GenericQ (GenericQ r) -> GenericQ (GenericQ [r])
gzipWithQ f x y = undefined

gcompare :: Data a => a -> a -> Ordering
gcompare = gcompare'
  where
    gcompare' :: (Data a, Data b) => a -> b -> Ordering
    gcompare' x y = mconcat (gzipWithQ gcompare' x y)

main :: IO ()
main = putStrLn "minimal variant of error compilation of syb under nightly 8.11.0.20200814"
