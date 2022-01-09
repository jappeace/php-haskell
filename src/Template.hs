{-# OPTIONS_GHC -F -pgmF php #-}
module Template
  ( main
  )
where

main :: IO ()
main = putStrLn "hello, world ss"

nums :: Int
nums =
<?php

$res = "";
for($i = 0; $i < 10; $i++){
    $res .= " " . $i . " +";
}
echo substr($res, 0, strlen($res)-2);
?>
