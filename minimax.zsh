# MiniMax Configuration
# Usage: MiniMax
minimax() {
    export ANTHROPIC_BASE_URL="https://api.minimax.io/anthropic"
    export ANTHROPIC_AUTH_TOKEN="${MINIMAX_API_KEY}"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="MiniMax-M2.7"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="MiniMax-M2.7"
    export ANTHROPIC_DEFAULT_HAIKU_MODEL="MiniMax-M2.7"
    export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
    export API_TIMEOUT_MS="10000000"
    export ANTHROPIC_MODEL="MiniMax-M2.7"
    export ANTHROPIC_SMALL_FAST_MODEL="MiniMax-M2.7"
    claude "$@"
}
