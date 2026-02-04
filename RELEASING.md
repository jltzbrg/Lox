# 🚀 Releasing Lox

This document describes the release process for Lox maintainers.

## 📋 Release Workflow

### 1. Prepare Release

```bash
# 1. Switch to develop branch and update
git checkout develop
git pull origin develop

# 2. Create release branch
git checkout -b release/1.0.0

# 3. Update version in all files
# - Package.swift (if version is stored there)
# - README.md (badge versions)
# - CHANGELOG.md (set release date)

# 4. Run tests
swift test

# 5. Verify build
swift build

# 6. Create commit
git add .
git commit -m "chore(release): prepare for v1.0.0"
```

### 2. Merge into main

```bash
# 1. Create PR: release/1.0.0 → main
# 2. Perform code review
# 3. Merge into main
git checkout main
git merge --no-ff release/1.0.0

# 4. Create tag
git tag -a 1.0.0 -m "Release v1.0.0"

# 5. Push
git push origin main
git push origin 1.0.0
```

### 3. Merge back into develop

```bash
# 1. Switch to develop
git checkout develop

# 2. Merge release branch
git merge --no-ff release/1.0.0

# 3. Optional: Set version for next development phase
# (e.g., 1.1.0-alpha in README/badges)

# 4. Push
git push origin develop

# 5. Delete release branch
git branch -d release/1.0.0
git push origin --delete release/1.0.0
```

### 4. Create GitHub Release

1. On GitHub → Releases → "Draft a new release"
2. Tag: `1.0.0` (already pushed)
3. Title: `Lox v1.0.0`
4. Description: Copy changelog entries
5. "Publish release"

### 5. Swift Package Index

The package is automatically indexed by [Swift Package Index](https://swiftpackageindex.com) once:
- The tag is pushed
- The package is public

## 📊 Versioning Scheme

### Semantic Versioning (SemVer)

```
MAJOR.MINOR.PATCH
  1    0    0
```

| Component | When to increment? | Example |
|-----------|-------------------|---------|
| **MAJOR** | Breaking changes | API changes that break existing code |
| **MINOR** | New features | Backwards compatible additions |
| **PATCH** | Bugfixes | Backwards compatible fixes |

### Pre-Releases

```
1.0.0-alpha.1   # First Alpha
1.0.0-beta.1    # First Beta
1.0.0-rc.1      # Release Candidate 1
```

## 🔄 Hotfix Process

For critical bugfixes on production:

```bash
# 1. Create hotfix branch from main
git checkout main
git checkout -b hotfix/1.0.1

# 2. Implement bugfix
git commit -m "fix: resolve critical bug XYZ"

# 3. Update changelog
git commit -m "docs: update changelog for v1.0.1"

# 4. Merge into main
git checkout main
git merge --no-ff hotfix/1.0.1
git tag -a 1.0.1 -m "Release v1.0.1"
git push origin main
git push origin 1.0.1

# 5. Also merge into develop!
git checkout develop
git merge --no-ff hotfix/1.0.1
git push origin develop
```

## 📝 Pre-Release Checklist

- [ ] All tests pass (`swift test`)
- [ ] Build successful (`swift build`)
- [ ] Changelog updated
- [ ] README version badges updated
- [ ] Version updated in code (if present)
- [ ] No TODOs/comments for next version
- [ ] Documentation up to date

## 🏷️ Tag Format

```bash
# Standard release
git tag -a 1.0.0 -m "Release v1.0.0"

# Pre-release
git tag -a 1.1.0-beta.1 -m "Beta release v1.1.0-beta.1"

# Push tag
git push origin 1.0.0
```

## 📦 Swift Package Manager Integration

Users can integrate the package as follows:

```swift
// For stable releases
.package(url: "https://github.com/USER/Lox.git", from: "1.0.0")

// For specific version
.package(url: "https://github.com/USER/Lox.git", exact: "1.0.0")

// For latest features (develop branch)
.package(url: "https://github.com/USER/Lox.git", branch: "develop")
```

---

**Note:** This workflow is based on [Git Flow](https://nvie.com/posts/a-successful-git-branching-model/) and [Semantic Versioning](https://semver.org/).
