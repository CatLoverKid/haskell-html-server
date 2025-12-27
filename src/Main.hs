{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Main where

import Data.Proxy
import Network.Wai.Handler.Warp
import Servant
import Servant.HTML.Blaze (HTML)
import Text.Blaze.Html5 ((!))
import qualified Text.Blaze.Html5 as H
import qualified Text.Blaze.Html5.Attributes as A

type API = Get '[HTML] H.Html

api :: Proxy API
api = Proxy

homePage :: H.Html
homePage = H.docTypeHtml $ do
  H.head $ do
    H.title "Anthony Keba"
    H.meta ! A.charset "utf-8"
  H.body $ do
    H.h1 "Welcome to my web page"
    H.p "This is a simple Haskell web server running on NixOS! ❄️  "


server :: Server API
server = return homepage

app :: Application
app = serve api server

main :: IO ()
main = do
  putStrLn "starting server on port 443..."
  run 443 app
