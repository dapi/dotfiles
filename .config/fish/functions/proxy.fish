function proxy --description 'Run command with proxy settings'
    set -gx http_proxy "http://"(pass show proxy/current)
    set -gx HTTPS_PROXY "http://"(pass show proxy/current)
    $argv
end
