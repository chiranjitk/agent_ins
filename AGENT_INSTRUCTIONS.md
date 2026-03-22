# CRYPTSK STAYSUITE - Agent Instructions

## 🚨 CRITICAL: READ THIS FIRST ON EVERY STARTUP

**This file MUST be read immediately when any new session starts.**

If you're reading this as an AI agent and your memory was reset, follow these steps:

### ⚡ IMMEDIATE STARTUP SEQUENCE (MANDATORY)

```
STEP 1: Read this entire file first
STEP 2: Run git sync (see below)
STEP 3: Check for any discrepancies
STEP 4: Continue with work
```

---

## 📋 Git Configuration

```bash
git config user.name "chiranjitk"
git config user.email "chiranjitk@outlook.com"
```

---

## 📁 Repository Information

| Property | Value |
|----------|-------|
| Repository | https://github.com/chiranjitk/cryptsk_staysuiteV2026 |
| Branch | main (NOT master) |
| Author | chiranjitk <chiranjitk@outlook.com> |
| Token | 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 |

---

## 🔄 ZERO DATA LOSS PROTOCOL

### 🟢 STARTUP SYNC (Run EVERY time on new session)

```bash
# 1. Check current status
git status

# 2. Fetch remote changes
git fetch origin

# 3. Check if local is behind remote
git log HEAD..origin/main --oneline

# 4. If behind, pull with rebase (preserves local changes)
git pull --rebase origin main

# 5. Check for any local uncommitted changes
git status --porcelain

# 6. Verify branch
git branch --show-current
```

### 🔴 IF LOCAL HAS CHANGES NOT IN REMOTE

```bash
# 1. Stash any uncommitted work
git stash push -m "WIP backup $(date +%Y%m%d_%H%M%S)"

# 2. Pull latest
git pull origin main

# 3. Pop stash back
git stash pop

# 4. Commit and push immediately
git add -A && git commit -m "Restore local changes" && git push origin main
```

### 🟡 IF REMOTE HAS COMMITS NOT IN LOCAL

```bash
# Just pull - local is behind
git pull origin main
```

### 🟣 IF DIVERGED (both have different commits)

```bash
# 1. Create backup branch of local
git branch backup-local-$(date +%Y%m%d_%H%M%S)

# 2. Rebase local on top of remote
git pull --rebase origin main

# 3. If conflicts, resolve and continue
git rebase --continue

# 4. Force push if needed (with caution)
git push origin main --force-with-lease
```

---

## 📝 MANDATORY WORKFLOW

### BEFORE Starting ANY Task:

```bash
# Always sync first!
git fetch origin
git status
git log HEAD..origin/main --oneline  # Check if behind
```

### DURING Work (Every 10-15 minutes):

```bash
# Frequent commits prevent data loss
git add -A
git commit -m "WIP: [task description]"
git push origin main
```

### AFTER Completing ANY Task:

```bash
git add -A
git commit -m "[Descriptive message]"
git push origin main

# VERIFY on GitHub
curl -s "https://api.github.com/repos/chiranjitk/cryptsk_staysuiteV2026/commits/main" | grep '"sha"'
```

---

## 🛡️ ANTI-DATA-LOSS FEATURES

### 1. Worklog System
- Location: `/home/z/my-project/worklog.md`
- Purpose: Track all work done
- Every task MUST append to worklog

### 2. Frequent Push Strategy
- Push after EVERY task
- Push WIP (Work In Progress) every 10-15 mins
- Never keep uncommitted code for long

### 3. Branch Protection
- Main branch is source of truth
- Create backup branches before risky operations

### 4. Sync Script (run automatically)
```bash
# File: scripts/sync-check.sh
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
```

---

#
## 🔄 Session Recovery Checklist

When starting a NEW session (memory reset):

- [ ] 1. Read `AGENT_INSTRUCTIONS.md` completely
- [ ] 2. Run `git fetch origin`
- [ ] 3. Run `git status`
- [ ] 4. Check if behind: `git log HEAD..origin/main --oneline`
- [ ] 5. Pull if needed: `git pull --rebase origin main`
- [ ] 6. Read `worklog.md` to understand previous work
- [ ] 7. Verify database: `bun run db:push`
- [ ] 8. Start working

---

## 📞 How to Read Instructions on Startup

### Option 1: First Command
```
Read the file: /home/z/my-project/AGENT_INSTRUCTIONS.md
```

### Option 2: Automated Check
```bash
cat AGENT_INSTRUCTIONS.md | head -50
```

### Option 3: Include in Prompt
```
"Read AGENT_INSTRUCTIONS.md and follow ALL rules strictly"
```

---

## ✅ Task Completion Checklist

Before saying "done":

- [ ] Code written and tested
- [ ] `bun run lint` passes
- [ ] `git status` checked (clean)
- [ ] Committed with descriptive message
- [ ] Pushed to `origin/main`
- [ ] Verified on GitHub (check commits page)
- [ ] Updated `worklog.md`

---

## 🆘 Emergency Recovery

### If Code is Lost:

```bash
# 1. Check reflog for lost commits
git reflog

# 2. Find your commit and reset
git reset --hard HEAD@{n}

# 3. Force push if needed
git push origin main --force
```

### If Remote is Ahead:

```bash
# Just pull
git pull origin main
```

### If Everything is Broken:

```bash
# Nuclear option - reset to remote
git fetch origin
git reset --hard origin/main
git push origin main --force
```

---

## 🔐 Environment Variables

```env
# Development (SQLite)
DATABASE_URL="file:./db/custom.db"

# Production (PostgreSQL)
DATABASE_URL="postgresql://user:password@host:5432/staysuite?schema=public"
```

---

## 📌 Important Notes

1. **Multi-tenant**: All data scoped by `tenant_id`
2. **View-based Navigation**: Uses Zustand, not Next.js routing
3. **Soft Deletes**: Use `deleted_at` field
4. **Demo Data**: Run `bun run db:seed` after fresh setup
5. **PostgreSQL Ready**: Use `prisma/schema.postgres.prisma` for production

---

## 🎯 Ultimate Goal: ZERO DATA LOSS

**Remember:**
1. READ this file on EVERY startup
2. SYNC with remote FIRST
3. COMMIT and PUSH after EVERY task
4. VERIFY on GitHub before saying "done"
5. UPDATE worklog.md for every task

**When in doubt, PUSH to remote!**

---

**Last Updated:** 2026-03-22
**Version:** 2.0 - Zero Data Loss Edition
