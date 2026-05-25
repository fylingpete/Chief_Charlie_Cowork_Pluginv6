---
description: Disconnect Chief Charlie account from Cowork.
---

# /logout

Tell the user:

> Zum Ausloggen geh in Cowork-Settings → MCP-Servers → "chief-charlie" → Disconnect / Revoke authorization.
>
> Cowork wird dann den Token bei chiefcharlie.ai widerrufen. Deine lokalen Workspace-Files (`.founder-os/`) bleiben unverändert.

**Note:** in v0.3+ wird der OAuth-Token von Cowork intern verwaltet, nicht mehr in `~/.chief-charlie/auth.json`. Diese Datei wird vom Plugin nicht mehr gelesen oder geschrieben — du kannst sie sicher löschen falls sie noch existiert: `rm -f ~/.chief-charlie/auth.json`.

Do NOT actually delete the file from this command — only tell the user it's safe to delete manually.
