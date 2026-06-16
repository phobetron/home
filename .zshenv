export PNPM_HOME="$HOME/Library/pnpm"
export NVM_DIR="$HOME/.nvm"

case ":$PATH:" in
  *":$NVM_DIR/current/bin:"*) ;;
  *) export PATH="$NVM_DIR/current/bin:$PATH" ;;
esac

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

. "$HOME/.cargo/env"
