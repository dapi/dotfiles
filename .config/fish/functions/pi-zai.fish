function pi-zai --description 'Run pi coding agent with ZAI provider'
    set -lx KIMI_API_KEY (pass show kimi)
    set -lx ZAI_API_KEY (pass show zai)
    command pi --provider zai --model glm-5.1 $argv
end
