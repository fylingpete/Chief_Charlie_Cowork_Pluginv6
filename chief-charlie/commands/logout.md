---
description: Log out of Chief Charlie. Deletes the locally stored token. Workspace files are kept.
---

# /logout — Disconnect from Chief Charlie

1. **Check if a token exists:**

   ```bash
   ls ~/.chief-charlie/auth.json 2>/dev/null
   ```

2. **If file exists** — delete it:

   ```bash
   rm ~/.chief-charlie/auth.json
   ```

   Then tell the user:

   > ✓ Ausgeloggt. Dein lokaler Workspace (`.founder-os/`) ist unverändert.
   >
   > Zum erneuten Einloggen: `/login <token>`

3. **If file doesn't exist** — tell the user:

   > Du warst nicht eingeloggt — nichts zu tun.

4. **Do NOT touch** the user's workspace files in `.founder-os/`. Only the auth token gets removed.
