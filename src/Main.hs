
import Types
import Network (PortID(UnixSocket), connectTo)

main :: IO ()
main = do
  cmd <- getCommand
  putStrLn $ "Whats that? " ++ show cmd


socketPath :: FilePath
socketPath = "/Users/rjhala/tmp/.lhi.sock"


-- This is how the *client* runs
-- serverCommand :: FilePath -> Command -> CommandExtra -> IO ()
