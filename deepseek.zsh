# DeepSeek Configuration
# Usage: deepseek
deepseek() {
    export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
    export ANTHROPIC_AUTH_TOKEN="${DEEPSEEK_API_KEY}"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-reasoner"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-chat"
    export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
    claude "$@"
}
