
import Types

main :: IO ()
main = do
  cmd <- getCommand
  putStrLn $ "Whats that? " ++ show cmd
