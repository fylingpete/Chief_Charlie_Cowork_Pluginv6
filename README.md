# GMT Builder Plugin — Chief Charlie for Claude Cowork

A Claude Cowork (and Claude Code) plugin that turns Claude into **Chief Charlie**, a Founder Operating System.

Chief Charlie guides a founder through the right phase of their company — **PMF**, **GTM**, or **Scale** — using a single source of truth (`dashboard_data.json`), structured cadences (weekly check-ins, monthly reviews, quarterly rebuilds), append-only decision logging, and curated knowledge from Skok, Hormozi, YC, and Wickman (EOS™).

## What's inside

This repository is a **marketplace** containing one plugin:

```
GMT_Builder_Plugin/
├── .claude-plugin/marketplace.json    # Lists the chief-charlie plugin
└── chief-charlie/                     # The plugin itself
    ├── .claude-plugin/plugin.json
    ├── .mcp.json                      # Add MCP servers here (start empty)
    ├── CLAUDE.md                      # Lean persona + security rules
    ├── commands/                      # /onboarding, /founder-os, /weekly-checkin, ...
    ├── skills/                        # founder-os (the OS), memory-search, decision-logging, kpi-tracking
    ├── agents/                        # research, market-report
    └── hooks/                         # SessionStart hook injects current dashboard state
```

## Install

### From Claude Cowork (Desktop App)

1. Open Claude Cowork → click **Customize** in the left sidebar
2. Click **Add plugin** → select **GitHub**
3. Enter: `fylingpete/GMT_Builder_Plugin`
4. Install the `chief-charlie` plugin

### From Claude Code (CLI)

```bash
/plugin marketplace add fylingpete/GMT_Builder_Plugin
/plugin install chief-charlie@gmt-builder
/reload-plugins
```

## First run

After installing, **create a dedicated folder for your Chief Charlie work** and open Claude Cowork / Claude Code in that folder:

```bash
mkdir -p ~/ChiefCharlie
cd ~/ChiefCharlie
# then open Claude Cowork in this folder (or `claude` from CLI)
```

Then run:

```
/onboarding
```

The onboarding command will:
1. Verify you're in a dedicated folder (and tell you how to create one if not)
2. Walk you through 8 founder identity questions (German by default)
3. Show your first roadmap after question 4 ("wow moment")
4. Initialize `.founder-os/dashboard_data.json` and supporting state files
5. Drop you into the right path (PMF / GTM / Scale) at the right phase

After onboarding, every session greets you with your current phase, bottleneck, and any overdue cadence — pulled live by the SessionStart hook.

## Daily use

- `/founder-os` — open the OS, see current phase + next actions
- `/weekly-checkin` — weekly KPI review + decision log
- `/monthly-review` — monthly path milestone review (GTM + Scale)
- `/quarterly-rebuild` — quarterly strategic rebuild
- `/log-decision` — append a decision to the log
- `/log-learning` — append a learning to the log

### Account (optional)

- `/login <jwt-token>` — connect a Chief Charlie account
- `/account` — show current account info
- `/logout` — disconnect

See "Connect to Chief Charlie account" below for how to get a token.

The `founder-os` skill auto-fires whenever you discuss founder work — you don't have to invoke it explicitly. The `decision-logging` skill watches every conversation for decisions/learnings and appends them automatically.

## Subagents

- `research` — focused research with web search + sources
- `market-report` — full market reports written to `research/`

## What this plugin does NOT do (yet)

Compared to the full Chief Charlie (desktop app + LangGraph backend), the plugin form factor has some honest limits:

| Feature | Status | Why |
|---|---|---|
| Vector / semantic memory search | ⚠️ Replaced with grep | Plugins can't run embedding pipelines |
| Multi-device sync | ❌ Not built in | Use git or iCloud/Dropbox on the folder |
| WhatsApp + Voice channels | ❌ Out of scope | Cowork is desktop only |
| Activity heatmap + usage dashboard | ❌ Dropped | No backend to count messages |
| Auto-managed reminders + cron | ⚠️ Use native | Claude Cowork has native scheduled tasks |

## Connect to Chief Charlie account

The plugin works fully standalone. Connecting to a Chief Charlie account unlocks server-side features (currently: identity injection in SessionStart; soon: mem0 sync, WhatsApp, Pro features).

### As an end user

If your admin gave you a JWT token, run:

```
/login eyJhbGc...
```

Verify it worked:

```
/account
```

### As an admin generating a test token

Chief Charlie uses Supabase JWTs (HS256, `audience: "authenticated"`). To generate a long-lived token for a specific user, you need:

1. The user's UUID from the `cc_users` table
2. The `PROD_JWT_SECRET` (or `DEV_JWT_SECRET`) from your Memphis `.env`

Then run this Python snippet (requires `pip install pyjwt`):

```python
import jwt
from datetime import datetime, timedelta, timezone

USER_ID = "e6f5156f-5f53-4a94-ace1-8d9a490bd430"  # the user's UUID
JWT_SECRET = "<your PROD_JWT_SECRET from .env>"
EXPIRES_DAYS = 365  # long-lived for plugin testing

now = datetime.now(timezone.utc)
token = jwt.encode(
    {
        "sub": USER_ID,
        "aud": "authenticated",
        "iat": now,
        "exp": now + timedelta(days=EXPIRES_DAYS),
    },
    JWT_SECRET,
    algorithm="HS256",
)
print(token)
```

Paste the printed token into `/login <token>` in Claude Cowork.

### Configuration

| Variable | Default | Purpose |
|---|---|---|
| `CHIEF_CHARLIE_API_URL` | `https://api.chiefcharlie.ai` | Memphis backend URL. Override for dev: `https://devapi.chiefcharlie.ai` |

Set it in your shell config (e.g., `~/.zshrc`) before starting Claude Cowork, or as a per-project env var.

Token is stored at `~/.chief-charlie/auth.json` with `chmod 600`. The SessionStart hook calls `GET /api/users/me` on every session start (with a 5s timeout — silent fallback if the backend is down).

## Add connectors (MCPs)

`chief-charlie/.mcp.json` starts empty. Add MCP servers there to give Charlie access to your tools (Notion, Linear, Slack, HubSpot, Gmail, ...). For Cowork-compatible MCPs, the server must be reachable over the public internet OR run locally on the user's machine.

Examples to add later:

```json
{
  "mcpServers": {
    "notion": { "url": "https://your-notion-mcp.example.com/sse" },
    "linear": { "url": "https://mcp.linear.app/sse" }
  }
}
```

## License

MIT — see `LICENSE`.

## Credits

Built on the Founder OS framework from the Chief Charlie LangGraph project. References Skok's SaaS metrics, Hormozi's offer mechanics, YC startup curricula, and Gino Wickman's *Traction™* (EOS™ tools attributed accordingly in the knowledge base).
