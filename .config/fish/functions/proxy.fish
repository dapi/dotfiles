function proxy --description 'Run command with proxy settings'
    if functions -q __load_bugsnag_proxy_once
        __load_bugsnag_proxy_once
    end

    set -l proxy_current $BUGSNAG_HTTP_PROXY
    if test -z "$proxy_current"; and type -q pass
        set proxy_current (pass show proxy/current 2>/dev/null)
    end

    if test -n "$proxy_current"
        set -l proxy_url $proxy_current
        if not string match -rq '^[a-zA-Z][a-zA-Z0-9+.-]*://' -- $proxy_url
            set proxy_url "http://$proxy_url"
        end

        env http_proxy="$proxy_url" \
            HTTPS_PROXY="$proxy_url" \
            $argv
    else
        $argv
    end
end
