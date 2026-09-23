#!/usr/bin/env osascript

tell application "iTerm"
    activate
    set newWindow to (create window with default profile)
    
    tell current session of newWindow
        write text "ff"
    end tell

    tell newWindow
        set rightPane to (split vertically with default profile)
        tell rightPane
            write text "cd ~/Documents/Github"
        end tell
    end tell
end tell

