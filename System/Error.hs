-- | A family of functions to report errors on the standard error output.
module System.Error ( ExitStatus
                    , die
                    , dieWith
                    , warn
                    ) where

import System.Environment (getProgName)
import System.Exit (exitWith, ExitCode(..))
import System.IO (stderr, hPutStrLn)

-- | Exit status reported to the OS. Usually it should be between 1 and 255 on
-- Windows and POSIX-compliant systems.
type ExitStatus = Int

-- | Write program name and given error message to `System.IO.stderr` and
-- terminate with `System.Exit.exitFailure`.
die :: String -> IO a
die message = dieWith 1 message

-- | Write program name and given error message to `System.IO.stderr` and
-- terminate with `System.Exit.ExitFailure` constructed of `ExitStatus`.
dieWith :: ExitStatus -> String -> IO a
dieWith status message = warn message >> exitWith (ExitFailure status)

-- | Write program name and given error message to `System.IO.stderr`.
warn :: String -> IO ()
warn message = do
    progName <- getProgName
    hPutStrLn stderr (progName ++ ": " ++ message)
