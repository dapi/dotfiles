set -gx LESS -eiRMX
set -gx ENABLE_CLAUDEAI_MCP_SERVERS false
set -gx PGOPTIONS '--client-min-messages=warning'
set -gx EDITOR nvim

# Playwright CLI: артефакты (snapshots, console logs) в /tmp вместо корня проекта
set -gx PLAYWRIGHT_MCP_OUTPUT_DIR /tmp/playwright-cli

# nvimpager не умеет переходить в редактор по v как это делает less
#
#if [ `uname` = "Darwin" ]; then
    #set -x PAGER=/opt/homebrew/bin/nvimpager
    #set -x MANPAGER=/opt/homebrew/bin/nvimpager
#end
