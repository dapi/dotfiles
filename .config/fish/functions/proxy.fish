function proxy --description 'Run command with proxy settings'
    env http_proxy="http://"(pass show proxy/current) \
        HTTPS_PROXY="http://"(pass show proxy/current) \
        $argv
end
