function pi --description 'Run pi coding agent with ZAI provider'
    env ZAI_API_KEY=(pass show zai) \
        pi --provider zai --model glm-4.7-flash $argv
end
