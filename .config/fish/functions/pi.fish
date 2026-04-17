function pi --description 'Run pi coding agent with Kimi provider'
    set -lx KIMI_API_KEY (pass show kimi)
    set -lx ZAI_API_KEY (pass show zai)
    command pi --provider kimi-coding --model kimi-for-coding $argv
end
