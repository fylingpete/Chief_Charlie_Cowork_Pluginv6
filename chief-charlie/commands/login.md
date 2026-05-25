---
description: Log in to your Chief Charlie account by pasting your JWT token. Usage: /login <token>
argument-hint: <jwt-token>
---

# /login — Connect to Chief Charlie

You are connecting the user to their Chief Charlie account by storing a JWT token locally and verifying it against the backend.

## Steps

1. **Read the token from `$ARGUMENTS`**. If empty, tell the user:

   > Bitte den Token mitgeben: `/login eyJhbGc...`
   >
   > Wenn du noch keinen Token hast, siehe README → "Connect to Chief Charlie account".

   Then stop.

2. **Basic format check.** A JWT has three dot-separated segments. If `$ARGUMENTS` does not match `*.*.*`, tell the user the token doesn't look like a valid JWT and stop.

3. **Create the auth directory and write the file** with strict permissions:

   ```bash
   mkdir -p ~/.chief-charlie
   chmod 700 ~/.chief-charlie
   cat > ~/.chief-charlie/auth.json <<EOF
   {
     "token": "$ARGUMENTS",
     "saved_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
   }
   EOF
   chmod 600 ~/.chief-charlie/auth.json
   ```

4. **Verify the token** by calling Memphis. Default URL is `https://api.chiefcharlie.ai` — override via `CHIEF_CHARLIE_API_URL` env var.

   ```bash
   API_URL="${CHIEF_CHARLIE_API_URL:-https://api.chiefcharlie.ai}"
   RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer $ARGUMENTS" "${API_URL}/api/users/me")
   STATUS=$(echo "$RESPONSE" | tail -n1)
   BODY=$(echo "$RESPONSE" | sed '$d')
   ```

5. **Handle the response:**

   - **`200`** → Parse body with jq (if available) and greet the user:

     > ✓ Eingeloggt als **{first_name} {last_name}** ({email})
     > Plan: Free (Pro coming soon)
     > Timezone: {timezone}
     >
     > Tippe `/founder-os` für den Einstieg, oder `/onboarding` falls du noch nicht eingerichtet bist.

   - **`401`** → Token ist ungültig oder abgelaufen. Lösche die gerade geschriebene Datei (`rm ~/.chief-charlie/auth.json`) und sage:

     > Token ungültig oder abgelaufen. Generiere einen neuen Token (siehe README) und versuche es erneut.

   - **Andere Fehler / Netzwerk down** → Datei BEHALTEN (Token könnte später valid sein), aber warnen:

     > Token gespeichert, aber Memphis ist gerade nicht erreichbar ({status}). Nächste Session sollte funktionieren wenn Backend wieder da ist.

6. **Wichtig:** Never log or echo the token value itself. Only echo the user's identity (name, email).
