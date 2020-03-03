module System.TrackedFiles
    ( allFiles
    , trackedFiles
    , untrackedFiles
    ) where

import qualified Control.Monad as M
import Control.Monad.IO.Class (MonadIO, liftIO)
import qualified Data.List as L
import qualified System.Directory as D
import qualified System.Process as Process

-- Relevant files, either due to being tracked and not deleted, or untracked
-- that aren't omitted via .gitignore
allFiles :: MonadIO m => m [FilePath]
allFiles = L.sort <$> filesThatExist files
  where
    filesThatExist = liftIO . (M.filterM D.doesFileExist =<<)
    files = (<>) <$> trackedFiles <*> untrackedFiles

-- All tracked files, including ones that have been deleted from the filesystem
trackedFiles :: MonadIO m => m [FilePath]
trackedFiles = liftIO $ lines <$> Process.readProcess "git" ["ls-files"] []

-- All untracked files that aren't omitted via .gitignore
untrackedFiles :: MonadIO m => m [FilePath]
untrackedFiles =
    liftIO $
    lines <$>
    Process.readProcess "git" ["ls-files", "--others", "--exclude-standard"] []
