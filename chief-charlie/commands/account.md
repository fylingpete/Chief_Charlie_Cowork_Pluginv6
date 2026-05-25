---
description: Show current Chief Charlie account info (name, email, plan, timezone) by calling the backend.
---

# /account — Show current account

Display the current Chief Charlie account status by calling Memphis.

## Steps

1. **Check if logged in:**

   ```bash
   if [ ! -f ~/.chief-charlie/auth.json ]; then
     echo "not_logged_in"
   fi
   ```

   If not logged in, tell the user:

   > Du bist nicht eingeloggt. Tippe `/login <token>` um dich zu verbinden.
   > (Wenn du noch keinen Account hast: chiefcharlie.ai)

   Then stop.

2. **Read the token and call Memphis:**

   ```bash
   TOKEN=$(jq -r .token ~/.chief-charlie/auth.json)
   API_URL="${CHIEF_CHARLIE_API_URL:-https://api.chiefcharlie.ai}"
   RESPONSE=$(curl -s -w "\n%{http_code}" -H "Authorization: Bearer ${TOKEN}" "${API_URL}/api/users/me")
   STATUS=$(echo "$RESPONSE" | tail -n1)
   BODY=$(echo "$RESPONSE" | sed '$d')
   ```

3. **Handle the response:**

   - **`200`** → display:

     ```
     ## Chief Charlie Account

     **Eingeloggt als:** {first_name} {last_name}
     **Email:** {email}
     **Plan:** Free
     **Timezone:** {timezone}
     **Language:** {language}
     **Daily dashboard:** {show_daily_dashboard ? "an" : "aus"}

     Token gespeichert in: ~/.chief-charlie/auth.json
     Backend: {API_URL}
     ```

   - **`401`** → Token abgelaufen oder ungültig:

     > Token nicht mehr gültig. Bitte neu einloggen: `/login <neuer-token>`

     Frage NICHT von selbst nach Löschen der Datei — der User entscheidet.

   - **Andere Fehler** → zeige Status-Code und Body. Sage dass das Backend nicht erreichbar ist.

4. **Never echo the token value** — nur User-Identity.
