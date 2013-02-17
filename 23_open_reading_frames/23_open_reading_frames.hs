module Main where

import qualified Data.Map as Map
import Data.List.Split (chunksOf, endBy)
import Data.List (nub)

main :: IO()
main = do
  header <- getLine
  fwd    <- getLine
  let rev = map complement $ reverse fwd

  mapM_ putStrLn $ nub $ concatMap findOrfs
    $ [fwd, (drop 1 fwd), (drop 2 fwd), rev, (drop 1 rev), (drop 2 rev)]

--
findOrfs :: String -> [String]
findOrfs seq = nub $ filter (\x -> head x == 'M') aaStrings
  where aaStrings =   endBy "*"
                    $ dropWhile (/= 'M')
                    $ map translate
                    $ chunksOf 3 seq

complement :: Char -> Char
complement 'A' = 'T'
complement 'C' = 'G'
complement 'G' = 'C'
complement 'T' = 'A'
complement  _  = 'N'

translate :: String -> Char
translate key = Map.findWithDefault 'X' key codonMap
                where codonMap = Map.fromList [ ("TTT", 'F')
                                              , ("TTC", 'F')
                                              , ("TTA", 'L')
                                              , ("TTG", 'L')
                                              , ("CTT", 'L')
                                              , ("CTC", 'L')
                                              , ("CTA", 'L')
                                              , ("CTG", 'L')
                                              , ("ATT", 'I')
                                              , ("ATC", 'I') -- 10
                                              , ("ATA", 'I')
                                              , ("ATG", 'M')
                                              , ("GTT", 'V')
                                              , ("GTC", 'V')
                                              , ("GTA", 'V')
                                              , ("GTG", 'V')
                                              , ("TCT", 'S')
                                              , ("TCC", 'S')
                                              , ("TCA", 'S')
                                              , ("TCG", 'S') -- 20
                                              , ("CCT", 'P')
                                              , ("CCC", 'P')
                                              , ("CCA", 'P')
                                              , ("CCG", 'P')
                                              , ("ACT", 'T')
                                              , ("ACC", 'T')
                                              , ("ACA", 'T')
                                              , ("ACG", 'T')
                                              , ("GCT", 'A')
                                              , ("GCC", 'A') -- 30
                                              , ("GCA", 'A')
                                              , ("GCG", 'A')
                                              , ("TAT", 'Y')
                                              , ("TAC", 'Y')
                                              , ("TAA", '*')
                                              , ("TAG", '*')
                                              , ("CAT", 'H')
                                              , ("CAC", 'H')
                                              , ("CAA", 'Q')
                                              , ("CAG", 'Q') -- 40
                                              , ("AAT", 'N')
                                              , ("AAC", 'N')
                                              , ("AAA", 'K')
                                              , ("AAG", 'K')
                                              , ("GAT", 'D')
                                              , ("GAC", 'D')
                                              , ("GAA", 'E')
                                              , ("GAG", 'E')
                                              , ("TGT", 'C')
                                              , ("TGC", 'C') -- 50
                                              , ("TGA", '*')
                                              , ("TGG", 'W')
                                              , ("CGT", 'R')
                                              , ("CGC", 'R')
                                              , ("CGA", 'R')
                                              , ("CGG", 'R')
                                              , ("AGT", 'S')
                                              , ("AGC", 'S')
                                              , ("AGA", 'R')
                                              , ("AGG", 'R') -- 60
                                              , ("GGT", 'G')
                                              , ("GGC", 'G')
                                              , ("GGA", 'G')
                                              , ("GGG", 'G') ]
