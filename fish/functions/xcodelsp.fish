function xcodelsp
    set -l scheme $argv[1]
    set -l mode $argv[2]

    if test -z "$scheme"
        echo "Usage: xcodelsp <scheme> [-w]"
        echo "  -w : use workspace (default is project)"
        return 1
    end

    if test "$mode" = "-w"
        xcode-build-server config -scheme $scheme -workspace *.xcworkspace
    else
        xcode-build-server config -scheme $scheme -project *.xcodeproj
    end
end
