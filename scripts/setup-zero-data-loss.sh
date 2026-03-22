#!/bin/bash

# ============================================================
# ZERO DATA LOSS SETUP SCRIPT
# Run this when starting a NEW project
# Usage: ./setup-zero-data-loss.sh <REPO_NAME>
# ============================================================

REPO_NAME=$1

if [ -z "$REPO_NAME" ]; then
    echo "❌ Error: Repository name required"
    echo "Usage: ./setup-zero-data-loss.sh <REPO_NAME>"
    echo "Example: ./setup-zero-data-loss.sh my_awesome_project"
    exit 1
fi

echo "🚀 Setting up Zero Data Loss for: $REPO_NAME"
echo ""

# 1. Configure Git
echo "📋 Configuring Git..."
git config user.name "chiranjitk"
git config user.email "chiranjitk@outlook.com"
echo "✅ Git configured"

# 2. Create worklog.md
echo ""
echo "📝 Creating worklog.md..."
cat > worklog.md << EOF
# $REPO_NAME - Worklog

---
## Task ID: 1
### Date: $(date +%Y-%m-%d)
### Task: Project initialized with Zero Data Loss setup
### Status: Complete

### Work Summary:
- Project initialized
- Zero Data Loss system configured
- Ready for development
EOF
echo "✅ worklog.md created"

# 3. Create scripts directory and sync script
echo ""
echo "📜 Creating sync script..."
mkdir -p scripts
cat > scripts/sync-check.sh << 'SCRIPT'
#!/bin/bash
echo "=== GIT SYNC CHECK ==="
echo "Current Branch: $(git branch --show-current)"
echo "Remote: $(git remote -v | head -1)"
echo ""
echo "=== LOCAL STATUS ==="
git status -s
echo ""
echo "=== COMMITS BEHIND REMOTE ==="
git log HEAD..origin/main --oneline 2>/dev/null || echo "Up to date or ahead"
echo ""
echo "=== COMMITS AHEAD OF REMOTE ==="
git log origin/main..HEAD --oneline 2>/dev/null || echo "Up to date or behind"
echo ""
echo "=== LAST 5 COMMITS ==="
git log --oneline -5
SCRIPT
chmod +x scripts/sync-check.sh
echo "✅ scripts/sync-check.sh created"

# 4. Add package.json scripts if package.json exists
if [ -f "package.json" ]; then
    echo ""
    echo "📦 Adding npm scripts to package.json..."
    # Check if jq is available
    if command -v jq &> /dev/null; then
        jq '.scripts.sync = "git fetch origin && git status && echo '"'"'=== SYNC STATUS ==='"'"' && git log HEAD..origin/main --oneline" |
           .scripts.backup = "git add -A && git commit -m '"'"'Auto backup'"'"' && git push origin main" |
           .scripts.recover = "git fetch origin && git reset --hard origin/main"' package.json > package.json.tmp && mv package.json.tmp package.json
        echo "✅ package.json scripts added"
    else
        echo "⚠️  jq not installed - add these scripts manually to package.json:"
        echo '    "sync": "git fetch origin && git status && echo '"'"'=== SYNC STATUS ==='"'"' && git log HEAD..origin/main --oneline",'
        echo '    "backup": "git add -A && git commit -m '"'"'Auto backup'"'"' && git push origin main",'
        echo '    "recover": "git fetch origin && git reset --hard origin/main"'
    fi
fi

echo ""
echo "=========================================="
echo "✅ ZERO DATA LOSS SETUP COMPLETE!"
echo "=========================================="
echo ""
echo "📝 Next Steps:"
echo "   1. Create AGENT_INSTRUCTIONS.md with repo name: $REPO_NAME"
echo "   2. Run: git init (if not already)"
echo "   3. Run: git remote add origin https://github.com/chiranjitk/$REPO_NAME.git"
echo "   4. Run: git add -A && git commit -m 'Initial commit' && git push -u origin main"
echo ""
echo "🔐 Credentials:"
echo "   User: chiranjitk"
echo "   Email: chiranjitk@outlook.com"
echo "   Token: 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"
echo ""
