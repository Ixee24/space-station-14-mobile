#!/usr/bin/env bash
# Regenerates Content.Android/resources.zip from the pinned content submodule.
#
# The APK embeds this zip as its baked-in content pack. It must contain every
# prototype/texture the client touches during startup (engine init builds the
# game screen before any server content is downloaded). A stale zip = startup
# crash (e.g. UnknownPrototypeException for missing shaders).
#
# Run after any submodule bump, then commit the resulting zip.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$ROOT/space-station-14/Resources"
OUT="$ROOT/Content.Android/resources.zip"

[ -d "$SRC/Prototypes" ] || { echo "ERROR: content submodule not initialized (missing $SRC/Prototypes)"; exit 1; }
[ -f "$OUT" ] || { echo "ERROR: base zip not found at $OUT"; exit 1; }

STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

# Start from the current zip (engine fonts, stock shaders, fallback textures).
unzip -q -o "$OUT" -d "$STAGE"

# Overlay content dirs (merge, never delete: engine files share these trees).
for d in Prototypes Locale Fonts Changelog Credits IgnoredPrototypes ServerInfo ConfigPresets; do
    if [ -d "$SRC/$d" ]; then
        mkdir -p "$STAGE/$d"
        cp -r "$SRC/$d/." "$STAGE/$d/"
    fi
done

# Textures are huge (170MB+); take only what's needed before first connect:
# shader sources (referenced by shader prototypes) + interface icons.
mkdir -p "$STAGE/Textures"
for d in Shaders Interface; do
    if [ -d "$SRC/Textures/$d" ]; then
        mkdir -p "$STAGE/Textures/$d"
        cp -r "$SRC/Textures/$d/." "$STAGE/Textures/$d/"
    fi
done

# Startup touches audio all over (UI, voting, lobby, ...) and any missing
# file without a fallback is a fatal startup crash, so pack nearly all of
# Audio/. Only the giant music/ambience banks are skipped (they stream
# lazily during gameplay and come with server content on connect).
# OGGs barely compress; revisit with on-demand download if APK size bites.
if [ -d "$SRC/Audio" ]; then
    mkdir -p "$STAGE/Audio"
    cp -r "$SRC/Audio/." "$STAGE/Audio/"
    for d in Lobby MidiCustom Cosmic Ambience Jukebox; do
        rm -rf "$STAGE/Audio/$d"
    done
fi

# Small root-level metadata files (manifest, keybinds, attributions, ...).
for f in "$SRC"/*.yml "$SRC"/*.txt; do
    [ -f "$f" ] && cp "$f" "$STAGE/"
done

rm -f "$OUT"
(
    cd "$STAGE"
    if command -v zip >/dev/null; then
        zip -q -r "$OUT" .
    else
        python3 - "$OUT" <<'EOF'
import sys, os, zipfile
out = sys.argv[1]
with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED, compresslevel=9) as z:
    for root, _, files in os.walk("."):
        for f in files:
            p = os.path.join(root, f)
            z.write(p, os.path.relpath(p, "."))
EOF
    fi
)

echo "wrote $OUT"
ls -lh "$OUT"
# Sanity: the shader from the Oct 2026 startup-crash report must be present.
# NOTE: grep -c (not -q) so the whole listing is consumed; with `pipefail`,
# grep -q would close the pipe early and unzip would die of SIGPIPE.
found=$(unzip -l "$OUT" | grep -c "Prototypes/Shaders/cooldown.yml" || true)
if [ "$found" -ge 1 ]; then
    echo "OK: Prototypes/Shaders/cooldown.yml present"
else
    echo "ERROR: Prototypes/Shaders/cooldown.yml MISSING from $OUT" >&2
    exit 1
fi
