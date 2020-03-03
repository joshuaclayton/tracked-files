module System.TrackedFilesSpec where

import System.TrackedFiles
import Test.Hspec

main :: IO ()
main = hspec spec

spec :: Spec
spec =
    describe "System.TrackedFiles" $
    it "tracks correct files" $ do
        files <- allFiles
        files `shouldSatisfy` elem ".gitignore"
        files `shouldSatisfy` elem "app/Main.hs"
        files `shouldSatisfy` elem "test/Spec.hs"
        files `shouldSatisfy` elem "test/System/TrackedFilesSpec.hs"
        files `shouldNotSatisfy` elem "tracked-files.cabal"
