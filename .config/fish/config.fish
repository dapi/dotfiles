# Non-interactive sessions: keep startup minimal.
if not status --is-interactive
    set -g fish_greeting
    exit 0
end

# User snippets are loaded by fish from conf.d/.

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.fish.inc' ]; . '/home/danil/google-cloud-sdk/path.fish.inc'; end
