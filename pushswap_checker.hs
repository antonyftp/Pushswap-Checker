import Data.Char ( Char, isDigit )
import Prelude
import System.Environment ( getArgs )
import System.Exit

-- Pushswap functions --

swap :: Int -> Int -> [Int]
swap a b = [b] ++ [a]

swapList :: [Int] -> [Int]
swapList x | length x < 2 = x
        | otherwise = (swap (x !! 0) (x !! 1)) ++ (drop 2 x)

putList :: [Int] -> [Int] -> ([Int], [Int])
putList a b | null b = (a, b)
          | otherwise = (([b !! 0] ++ a), (drop 1 b))

rotateList :: [Int] -> [Int]
rotateList x | length x < 2 = x
        | otherwise = drop 1 (x ++ [(x !! 0)])

rrList :: [Int] -> [Int]
rrList x | length x < 2 = x
         | otherwise = take (length x) ([last x] ++ x)

toTuppling :: a -> b -> (a, b)
toTuppling a b = (a,b)

swapTuple :: ([Int], [Int]) -> ([Int], [Int])
swapTuple (a, b) = (b, a)

-- Pushswap utils --

myFst :: (a, b) -> a
myFst (a, b) = a

mySnd :: (a, b) -> b
mySnd (a, b) = b

link :: String -> [Int] -> [Int] -> ([Int],[Int])
link "sa" a b = toTuppling (swapList a) b
link "sb" a b = toTuppling a (swapList b)
link "sc" a b = toTuppling (swapList a) (swapList b)
link "pa" a b = putList a b
link "pb" a b = swapTuple (putList b a)
link "ra" a b = toTuppling (rotateList a) b
link "rb" a b = toTuppling a (rotateList b)
link "rr" a b = toTuppling (rotateList a) (rotateList b)
link "rra" a b = toTuppling (rrList a) b
link "rrb" a b = toTuppling a (rrList b)
link "rrr" a b = toTuppling (rrList a) (rrList b)
link _ a b = ([84], [])

chaincall :: [String] -> ([Int], [Int]) -> ([Int], [Int])
chaincall (x:xs) t
    | t == ([84], []) = ([84], [])
    | null xs = t
    | otherwise = chaincall xs (link x (myFst t) (mySnd t))

toInt :: String -> Int
toInt = read 

sortCheck :: (Ord a) => [a] -> Bool
sortCheck xs = all (\(x, y) -> x <= y) $ zip xs (tail xs)

sortCheckMain :: ([Int], [Int]) -> Bool
sortCheckMain (a, b)
    | not (null b) = False
    | otherwise = sortCheck a

readIntCheck :: [String] -> Bool
readIntCheck [] = True
readIntCheck (x:xs) | all isDigit x = readIntCheck xs
                    | otherwise = False

-- Pushswap main -- 

main :: IO Int
main = do
    args <- getArgs
    if not (readIntCheck args)
        then exitWith (ExitFailure 84)
    else do
    let a_ = map toInt args
    line <- getLine
    let commands = words line
    let tuple = chaincall (commands ++ [""]) (a_,[])
    if tuple == ([84], [])
        then exitWith (ExitFailure 84)
    else do
    if sortCheckMain tuple
        then print "OK"
    else print "KO"
    return 0