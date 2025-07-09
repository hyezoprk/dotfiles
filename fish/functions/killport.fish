function killport
    set -l port $argv[1]
    if test -z "$port"
        echo "Usage: killport <port>"
        return 1
    end
    set -l pid (lsof -ti :$port)
    if test -z "$pid"
        echo "No process found on port $port"
        return 1
    end
    kill -9 $pid
    echo "Killed process $pid on port $port"
end
