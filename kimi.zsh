# Kimi (Moonshot AI) Configuration
# Usage: kimi
kimi() {
    export ANTHROPIC_BASE_URL="https://api.moonshot.ai/anthropic"
    export ANTHROPIC_AUTH_TOKEN="${KIMI_API_KEY}"
    claude "$@"
}
