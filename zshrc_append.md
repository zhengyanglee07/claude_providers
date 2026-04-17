# Claude Code Multi-Provider Switcher
if [ -f ~/.secrets ]; then
    source ~/.secrets
fi
for f in ~/.claude_providers/*.zsh; do
    source "$f"
done
