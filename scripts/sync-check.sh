#!/bin/bash

# CRYPTSK STAYSUITE - Git Sync Check Script
# Run this on every startup to ensure zero data loss

echo "═══════════════════════════════════════════════════════════"
echo "           CRYPTSK STAYSUITE - SYNC CHECK"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Get current directory
cd "$(dirname "$0")/.."

# Check git status
echo "📦 CURRENT BRANCH:"
echo "   $(git branch --show-current)"
echo ""

echo "🔗 REMOTE:"
git remote -v | head -1 | awk '{print "   " $2}'
echo ""

echo "📊 LOCAL STATUS:"
if git status --porcelain | grep -q .; then
    echo "   ⚠️  Uncommitted changes detected:"
    git status -s | head -10
    echo ""
    echo "   Run: git add -A && git commit -m 'Save changes'"
else
    echo "   ✅ Working tree clean"
fi
echo ""

# Fetch latest
echo "🔄 FETCHING REMOTE..."
git fetch origin 2>/dev/null

# Check if behind
BEHIND=$(git log HEAD..origin/main --oneline 2>/dev/null | wc -l)
AHEAD=$(git log origin/main..HEAD --oneline 2>/dev/null | wc -l)

if [ "$BEHIND" -gt 0 ]; then
    echo "   ⚠️  LOCAL IS BEHIND by $BEHIND commit(s):"
    git log HEAD..origin/main --oneline | head -5
    echo ""
    echo "   Run: git pull --rebase origin main"
else
    echo "   ✅ Local is up to date with remote"
fi
echo ""

if [ "$AHEAD" -gt 0 ]; then
    echo "   ⚠️  LOCAL IS AHEAD by $AHEAD commit(s):"
    git log origin/main..HEAD --oneline | head -5
    echo ""
    echo "   Run: git push origin main"
fi
echo ""

echo "📜 RECENT COMMITS:"
git log --oneline -5
echo ""

echo "═══════════════════════════════════════════════════════════"
echo "                    SYNC STATUS"
echo "═══════════════════════════════════════════════════════════"

if [ "$BEHIND" -gt 0 ] && [ "$AHEAD" -gt 0 ]; then
    echo "   🔴 DIVERGED - Local and remote have different commits"
    echo "   Action required: Resolve divergence"
elif [ "$BEHIND" -gt 0 ]; then
    echo "   🟡 BEHIND - Pull required"
    echo "   Run: git pull --rebase origin main"
elif [ "$AHEAD" -gt 0 ]; then
    echo "   🟡 AHEAD - Push required"
    echo "   Run: git push origin main"
else
    echo "   🟢 SYNCED - Local and remote are identical"
fi

echo "═══════════════════════════════════════════════════════════"
