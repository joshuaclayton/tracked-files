module Main where

import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified System.TrackedFiles as TrackedFiles

main :: MonadIO m => m ()
main = liftIO . putStr . unlines =<< TrackedFiles.trackedFiles
