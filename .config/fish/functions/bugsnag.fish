function bugsnag --wraps bugsnag --description 'Run bugsnag with lazy proxy loading'
    if functions -q __load_bugsnag_proxy_once
        __load_bugsnag_proxy_once
    else if not set -q BUGSNAG_HTTP_PROXY; and test (uname) = "Linux"; and type -q pass
        set -l bugsnag_proxy (pass show proxy/current 2>/dev/null)
        if test -n "$bugsnag_proxy"
            set -gx BUGSNAG_HTTP_PROXY $bugsnag_proxy
        end
    end

    if not command -q bugsnag
        echo "bugsnag: command not found" >&2
        return 127
    end

    command bugsnag $argv
end
