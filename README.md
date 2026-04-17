# Claude Code Multi-Provider Setup Guide

## Overview

Claude Code is a powerful command-line interface that allows developers to interact with Anthropic's Claude AI models for coding assistance. This guide provides two battle-tested methods to configure Claude Code to work with multiple LLM providers beyond just Anthropic, including models from DeepSeek, z.ai (GLM), Kimi, and OpenRouter.

This empowers you to switch between the best model for any given task without ever leaving your terminal.
Two Approaches to Flexibility

- Shell Functions: A simple, lightweight, and robust method for switching providers before starting a session. Perfect for most use cases.

- Python Proxy: A more advanced but incredibly flexible solution that allows for switching models within an active session using a simple /model command.

This guide also covers setting up y-router, a local translation service that enables OpenAI-compatible services like OpenRouter to work seamlessly with Claude Code's Anthropic-native API format.

##  Method 1: Shell Functions (Quick & Easy)

Use simple bash functions to quickly switch between different LLM providers using memorable commands like deepseek, glm, kimi, and openrouter.

### Step 1: Add Functions to Your Shell Config

Open your ~/.bashrc (for Bash) or ~/.zshrc (for Zsh) and add the following functions:

```bash
# === CLAUDE CODE MULTI-PROVIDER SWITCHER ===
# Assumes 'claude' is in your PATH (e.g., installed via `npm install -g @anthropic-ai/claude-code`)

# --- DeepSeek Configuration ---
# Usage: deepseek
deepseek() {
    export ANTHROPIC_BASE_URL="https://api.deepseek.com/anthropic"
    export ANTHROPIC_AUTH_TOKEN="${DEEPSEEK_API_KEY}"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="deepseek-reasoner"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="deepseek-chat"
    export CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC=1
    claude "$@"
}

# --- z.ai (GLM) Configuration ---
# Usage: glm
glm() {
    export ANTHROPIC_BASE_URL="https://api.z.ai/api/anthropic"
    export ANTHROPIC_AUTH_TOKEN="${Z_AI_API_KEY}"
    export ANTHROPIC_DEFAULT_HAIKU_MODEL="glm-4.5-air"
    export ANTHROPIC_DEFAULT_SONNET_MODEL="glm-4.6"
    export ANTHROPIC_DEFAULT_OPUS_MODEL="glm-4.6"
    claude "$@"
}

# --- Kimi (Moonshot AI) Configuration ---
# Usage: kimi
kimi() {
    export ANTHROPIC_BASE_URL="https://api.moonshot.ai/anthropic"
    export ANTHROPIC_AUTH_TOKEN="${KIMI_API_KEY}"
    claude "$@"
}

# --- OpenRouter Configuration (Requires local y-router) ---
# Usage: openrouter
openrouter() {
    export ANTHROPIC_BASE_URL="http://localhost:8787"
    export ANTHROPIC_API_KEY="${OPENROUTER_API_KEY}"
    # y-router uses a custom header for the key
    export ANTHROPIC_CUSTOM_HEADERS="x-api-key: $ANTHROPIC_API_KEY"
    claude "$@"
}

# --- Reset to Default (Local Anthropic) ---
# Usage: claude_reset
claude_reset() {
    unset ANTHROPIC_BASE_URL ANTHROPIC_AUTH_TOKEN ANTHROPIC_API_KEY
    unset ANTHROPIC_CUSTOM_HEADERS ANTHROPIC_MODEL ANTHROPIC_SMALL_FAST_MODEL
    echo "Claude environment has been reset to default."
}
```

### Step 2: Secure Your API Keys

Create a ~/.secrets file to store your API keys securely.
Create and open the file

```
nano ~/.secrets
```

Add your keys

```
export DEEPSEEK_API_KEY="your_deepseek_api_key_here"
export Z_AI_API_KEY="your_z_ai_api_key_here"
export KIMI_API_KEY="your_kimi_api_key_here"
export OPENROUTER_API_KEY="your_openrouter_api_key_here"
```

Set strict permissions so only you can read it

```
chmod 600 ~/.secrets
```

Now, add the following line to the top of your ~/.bashrc or ~/.zshrc to load these keys automatically:

```
if [ -f ~/.secrets ]; then
    source ~/.secrets
fi
```

### Step 3: Set Up y-router for OpenRouter (Optional)

To use OpenRouter, you need to run the y-router translation service locally using Docker.

1. Clone the y-router repository

```
git clone https://github.com/luohy15/y-router
cd y-router
```

2. Start the service using Docker Compose

```
docker-compose up -d
```

The service will now be running at http://localhost:8787, which the openrouter() function is configured to use.

### Step 4: Usage

Reload your shell configuration:

```
source ~/.bashrc
# or source ~/.zshrc
```

Launch Claude Code with your chosen provider:

```
deepseek  # Starts Claude Code using the DeepSeek API
glm       # Starts Claude Code using the z.ai GLM API
kimi      # Starts Claude Code using the Kimi API
openrouter  # Starts Claude Code using OpenRouter (make sure Docker is running!)
```

All arguments are passed through, so you can use flags as normal: deepseek -m "deepseek-coder"

## Method 2: Python Proxy (In-Session Switching)

This advanced method runs a local proxy that lets you switch models inside a Claude Code session with a /model <provider>/<model_name> command.

### Step 1: Create the Proxy Script

Save the Python code in the next file (simple-proxy.py) on your system.

### Step 2: Install Dependencies

You'll need fastapi, uvicorn, httpx, and pydantic.

```
pip install fastapi "uvicorn[standard]" httpx pydantic
```

### Step 3: Run the Proxy and Claude Code

Run y-router (if using OpenRouter):

```
cd y-router && docker-compose up -d
```

Start the proxy server:
```
python /path/to/your/simple-proxy.py
```
Open a new terminal and configure Claude Code to use the proxy:
```
export ANTHROPIC_BASE_URL="http://localhost:8787"
export ANTHROPIC_API_KEY="dummy" # The proxy handles auth, so this can be anything
claude
```

### Step 4: Switch Models In-Session

Now, within the running Claude Code session, you can switch models on the fly by typing a message like:

```
/model deepseek/deepseek-chat
/model openrouter/x-ai/grok-code-fast-1
```

The proxy will route your next request to the specified provider and model.
