---
description: Show current Chief Charlie account info via the MCP get_user_profile tool.
---

# /account

Call the MCP tool `chief-charlie__get_user_profile` (no arguments).

Display the response as:

> ## Chief Charlie Account
>
> - **Eingeloggt als:** {first_name} ({email})
> - **Plan:** {plan}
> - **Timezone:** {timezone}

If the tool returns an auth error (401 / "not authenticated"), tell the user:

> Cowork sollte beim ersten Pro-Tool-Aufruf automatisch den Browser für den Login öffnen. Falls nicht, geh in Cowork-Settings → MCP-Server-Verbindungen und deauthorisiere/reauthorisiere "chief-charlie".

**Do NOT call any local bash command or read any local file** — auth is handled entirely by Cowork's MCP client and the memphis OAuth server.
