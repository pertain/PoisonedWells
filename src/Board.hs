module Board
    ( module System.Random
    , module Board
    ) where

import Data.List
import qualified Data.Vector as V
import qualified Data.Set as S
import Data.List (sort, groupBy)
import System.Random

data Glyph a = Mask
             | Flag
             | Poison
             | Safe a

instance (Num a, Eq a, Show a) => Show (Glyph a) where
    show Mask     = "\x2590\x2588\x258C"
    show Flag     = " \x2691 "
    show Poison   = " \x2620 "
    show (Safe 0) = "   "
    show (Safe n) = ' ' : show n ++ " "

data Well = Well
    { display   :: Glyph Int
    , poisoned  :: Bool
    , pollution :: Int
    } deriving (Show)

type Row' = V.Vector Well
type Board' = V.Vector Row'

showTile :: Well -> Glyph Int
showTile (Well g _ _) = g

maskedWell :: Bool -> Int -> Well
maskedWell = Well Mask

flaggedWell :: Bool -> Int -> Well
flaggedWell = Well Flag

poisonedWell :: Int -> Well
poisonedWell = Well Poison True

safeWell :: Int -> Well
safeWell n = Well (Safe n) False n

safeRow :: Int -> Row'
safeRow n = V.replicate n (safeWell 4)

safeBoard :: Int -> Board'
safeBoard n = V.replicate n (safeRow n)

updateRow' :: Row' -> [(Int,Well)] -> Row'
updateRow' r u = r V.// u

updateBoard' :: Board' -> [(Int,[(Int,Well)])]-> Board'
updateBoard' b ul = b V.// rowList'
    where
        rowList' = map (\(x,y) -> (x, updateRow' (b V.! x) y)) ul

---------------------------------------------

data Cell = Cell
    { exposed :: Bool
    , flagged :: Bool
    , poison :: Bool
    , proximity :: Int
    } deriving (Show)

type Row = V.Vector Cell
type Board  = V.Vector Row
type Point = (Int,Int)

emptyCell :: Cell
emptyCell = Cell
    { exposed   = False
    , flagged   = False
    , poison    = False
    , proximity = 0
    }

psnCell :: Cell
psnCell = Cell
    { exposed   = True
    , flagged   = False
    , poison    = True
    , proximity = 0
    }

{- TODO: make Glyph data type to replace unexposed, flag, tainted -}
-- Board display characters
unexposed :: String
unexposed = "\x2590\x2588\x258C"

-- Tile glyphs
flag :: String
flag = " \x2691 "

tainted :: String
tainted = " \x2620 "

emptyRow :: Int -> Row
emptyRow n = V.replicate n emptyCell

emptyBoard :: Int -> Board
emptyBoard n = V.replicate n (emptyRow n)

newBoard :: RandomGen gen => Int -> gen -> Board
newBoard n g = updateBoard (emptyBoard n) (genPsn n (0, n * n - 1) g)

-- This produces the desired output, but feels clunky -- Try to improve it
showBoard :: Board -> IO ()
showBoard b = mapM_ putStrLn theBoard
    where
        boardSize    = V.length b
        cellDashes   = replicate boardSize "\x2501\x2501\x2501"
        topBorder    = '\x250F' : (intercalate "\x2533" cellDashes) ++ "\x2513"
        bottomBorder = '\x2517' : (intercalate "\x253B" cellDashes) ++ "\x251B"
        innerBorder  = '\x2523' : (intercalate "\x254B" cellDashes) ++ "\x252B"
        theBoard     = topBorder : (intersperse innerBorder (V.toList $ V.map showRow b)) ++ [bottomBorder]

showCell :: Cell -> String
showCell (Cell ex _ ps _)
    | ex == True && ps == True  = tainted
    | ex == True && ps == False = "   "
    | otherwise  = unexposed

showRow :: Row -> String
showRow = V.foldr (\x acc -> ("\x2503" ++ (showCell x)) ++ acc) "\x2503"

updateRow :: Row -> [(Int,Cell)] -> Row
updateRow = (V.//)

updateBoard :: Board -> [(Int,[(Int,Cell)])]-> Board
updateBoard b ul = b V.// rowList
    where
        rowList = map (\(x,y) -> (x, (b V.! x) V.// y)) ul

-- A more efficient nub -- nub = O(n^2), nub' = O(nlogn)
-- (Works with both finite and infinite lists, but requires Set)
nub' :: Ord a => [a] -> [a]
nub' = strip S.empty
    where
        strip _ []          = []
        strip s (x:xs)
            | S.member x s  = strip s xs
            | otherwise     = x : strip (S.insert x s) xs

-- Random pairs, sorted and grouped (coordinates of poisoned cells)
genPsn :: RandomGen gen => Int -> Point -> gen -> [(Int,[(Int,Cell)])]
genPsn n rng g = map groomedRow groupedPairs
    where
        psnQty        = div (n^2) 5
        groomedRow ps = (maximum (map fst ps), zip (map snd ps) (repeat psnCell))
        groupedPairs  = groupBy (\a b -> fst a == fst b) sortedPairs
        sortedPairs   = sort $ take psnQty $ nub' pairs
        pairs         = [(div x n, mod x n) | x <- randomRs rng g]
