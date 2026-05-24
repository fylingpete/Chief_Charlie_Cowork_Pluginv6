# Chief Charlie — Founder OS Plugin

The Chief Charlie plugin turns Claude into a Founder Operating System. See the [repo README](../README.md) for install instructions and overview.

## Plugin contents

| Type | What |
|---|---|
| Commands | `/onboarding`, `/founder-os`, `/weekly-checkin`, `/monthly-review`, `/quarterly-rebuild`, `/log-decision`, `/log-learning` |
| Skills | `founder-os` (master), `memory-search`, `decision-logging`, `kpi-tracking` |
| Agents | `research`, `market-report` |
| Hooks | `SessionStart` — injects current dashboard snapshot |
| MCP | empty by default — add your own connectors in `.mcp.json` |

## How it works

1. **CLAUDE.md** sets the persona and security rules (always loaded when the plugin is active in a workspace).
2. **SessionStart hook** reads `.founder-os/dashboard_data.json` from the workspace and injects a current snapshot (path, phase, bottleneck, overdue cadences) into the system context — so Claude doesn't have to re-read the file on every turn.
3. **`founder-os` skill** is the master operating system: 3 paths × 14 steps × deliverable templates × knowledge library, all checked into `skills/founder-os/`.
4. **Slash commands** are thin entry points that load the relevant skill content and execute path-specific workflows.
5. **Helper skills** (`memory-search`, `decision-logging`, `kpi-tracking`) auto-trigger when relevant — no explicit invocation needed.

## State files in the user's workspace

After `/onboarding`:

```
~/ChiefCharlie/
├── .founder-os/
│   ├── dashboard_data.json        # primary state (single source of truth)
│   ├── roadmap_data.json          # per-step rich content (lazy-loaded)
│   ├── decisions_learnings.jsonl  # append-only log
│   └── templates/                 # deliverable stubs
├── deliverables/                  # ICP doc, sales playbook, etc.
├── research/                      # market reports, customer research
├── decisions/                     # narrative decision docs
├── kpis/                          # KPI tracking sheets
├── roadmaps/                      # phase-specific roadmaps
└── knowledge/                     # curated knowledge notes
```

## Customizing

- **Edit the persona:** modify `CLAUDE.md`
- **Change Founder OS rules:** edit `skills/founder-os/SKILL.md` and path files under `skills/founder-os/paths/`
- **Add connectors:** add MCP servers to `.mcp.json`
- **Add commands:** drop new `.md` files in `commands/` with the standard frontmatter

## License

MIT.
