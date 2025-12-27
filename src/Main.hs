{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Data.Proxy
import Network.Wai.Handler.Warp
import Servant
import Servant.Server.StaticFiles (serveDirectoryFileServer)
import System.Environment (getArgs)
import System.Exit (die)
import Text.Read (readMaybe)

-- Serve static files from a directory
type API = Raw

api :: Proxy API
api = Proxy

server :: FilePath -> Server API
server staticDir = serveDirectoryFileServer staticDir

app :: FilePath -> Application
app staticDir = serve api (server staticDir)

main :: IO ()
main = do
  args <- getArgs
  (port, staticDir) <- case args of
    [portStr, dir] -> case readMaybe portStr of
      Just p -> return (p, dir)
      Nothing -> die $ "Invalid port: " ++ portStr
    _ -> die "Usage: haskell-html-server <port> <static-directory>"
  
  putStrLn $ "Starting server on port " ++ show port ++ "..."
  putStrLn $ "Serving files from: " ++ staticDir
  run port (app staticDir)
