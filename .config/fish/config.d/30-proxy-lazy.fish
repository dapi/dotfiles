# Load BUGSNAG_HTTP_PROXY lazily from pass, once per shell.
function __load_bugsnag_proxy_once --description 'Load BUGSNAG_HTTP_PROXY from pass once per shell'
    if set -q __bugsnag_proxy_loaded
        return
    end
    set -g __bugsnag_proxy_loaded 1

    if test (uname) != "Linux"
        return
    end
    if not type -q pass
        return
    end

    set -l bugsnag_proxy (pass show proxy/current 2>/dev/null)
    if test -n "$bugsnag_proxy"
        set -gx BUGSNAG_HTTP_PROXY $bugsnag_proxy
    end
end
