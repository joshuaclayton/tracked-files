module System.TrackedFiles
    ( trackedFiles
    ) where

import qualified Control.Monad as M
import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified Data.List as L
import qualified System.Directory as D
import qualified System.Process as Process

trackedFiles :: MonadIO m => m [FilePath]
trackedFiles = L.sort <$> existingFiles allFiles
  where
    existingFiles = liftIO . (M.filterM D.doesFileExist =<<)

allFiles :: MonadIO m => m [FilePath]
allFiles = (<>) <$> findTrackedFiles <*> findUntrackedFiles

findTrackedFiles :: MonadIO m => m [FilePath]
findTrackedFiles = liftIO $ lines <$> Process.readProcess "git" ["ls-files"] []

findUntrackedFiles :: MonadIO m => m [FilePath]
findUntrackedFiles =
    liftIO $
    lines <$>
    Process.readProcess "git" ["ls-files", "--others", "--exclude-standard"] []
