# OpenRouter Configuration (Requires local y-router)
# Usage: openrouter
openrouter() {
    export ANTHROPIC_BASE_URL="http://localhost:8787"
    export ANTHROPIC_API_KEY="${OPENROUTER_API_KEY}"
    # y-router uses a custom header for the key
    export ANTHROPIC_CUSTOM_HEADERS="x-api-key: $ANTHROPIC_API_KEY"
    claude "$@"
}
