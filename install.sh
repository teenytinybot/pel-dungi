peldungi_install() {
  local URL="${PELDUNGI_URL:-https://github.com/teenytinybot/pel-dungi/releases/latest/download/PelDungi.zip}"
  local APP="Pel Dungi.app"
  local MAJOR
  MAJOR=$(sw_vers -productVersion | cut -d. -f1)
  if [ "$MAJOR" -lt 14 ]; then
    echo "Sorry, Pel Dungi needs macOS 14 (Sonoma) or newer. This Mac has $(sw_vers -productVersion)."
    return 1
  fi
  echo "Installing Pel Dungi..."
  local TMP
  TMP=$(mktemp -d) || return 1
  if ! curl -fsSL "$URL" -o "$TMP/PelDungi.zip"; then
    echo "Could not download Pel Dungi. Check your internet and try again."
    return 1
  fi
  pkill -x PelDungi 2>/dev/null
  sleep 1
  mkdir -p "$HOME/Applications"
  rm -rf "$HOME/Applications/$APP"
  ditto -x -k "$TMP/PelDungi.zip" "$HOME/Applications" || { echo "Could not unpack Pel Dungi."; return 1; }
  xattr -dr com.apple.quarantine "$HOME/Applications/$APP" 2>/dev/null
  rm -rf "${TMP:?}"
  open "$HOME/Applications/$APP"
  echo ""
  echo "Done! Look for Unnati's face in your top bar (near Wi-Fi)."
  echo "Click it and pick 'I need motivation', 'Mujhe daanto' or 'Meeting reminder'."
}
peldungi_install
