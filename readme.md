# No-Slop 101

Shared agent skills for coding and communication:

- [general](.agents/skills/general/SKILL.md): language style, how to talk, and other interaction rules.
- [coding](.agents/skills/coding/SKILL.md): simple implementations, code reuse, style, and conventions.

## Installation

### Claude Code
Install:
```bash
claude plugin marketplace add SteveImmanuel/no-slop-101
claude plugin install no-slop-101@steveimm-no-slop
```
Update:
```bash
claude plugin marketplace update steveimm-no-slop
claude plugin update no-slop-101@steveimm-no-slop
```

### Codex
Install:
```bash
codex plugin marketplace add SteveImmanuel/no-slop-101
codex plugin add no-slop-101@steveimm-no-slop
```
Update:
```bash
codex plugin marketplace upgrade steveimm-no-slop
codex plugin add no-slop-101@steveimm-no-slop
```

### Pi
Install:
```bash
pi install git:github.com/SteveImmanuel/no-slop-101
```

Update:
```sh
pi update git:github.com/SteveImmanuel/no-slop-101
```

## Package maintenance

All three harnesses load the files under [`.agents/skills/`](.agents/skills/). Packaging is defined in:
- Claude Code: [plugin manifest](.claude-plugin/plugin.json) and [marketplace](.claude-plugin/marketplace.json).
- Codex: [plugin manifest](.codex-plugin/plugin.json) and [marketplace](.agents/plugins/marketplace.json).
- Pi: [`package.json`](package.json).

For each release, bump the version in both plugin manifests and `package.json`, then publish the changes to GitHub.
