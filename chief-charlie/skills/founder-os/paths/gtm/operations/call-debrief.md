# Call / Conversation Debrief

After each sales call, discovery conversation, user interview, or feedback meeting.

## Step 1: Capture call details

```
Erzaehl mir vom Gespraech:

1. Mit wem hast du gesprochen? (Name, Rolle, Unternehmen)
2. Was fuer ein Gespraech war es? (Discovery / Demo / Feedback / Interview / Sonstiges)
3. Was ist passiert?
```

## Step 2: Structured debrief

```
## Call-Nachbereitung — {Name}, {Datum}

### ICP-Fit
{Passt die Person zum ICP? Warum / warum nicht?}

### Schmerzlevel
{1-5: Wie akut ist das Problem?}

### Dringlichkeit
{Sucht die Person aktiv nach einer Loesung?}

### Sprache des Kunden
> "{Woertliche Zitate die relevant sind}"

### Einwaende
{Welche Bedenken oder Einwaende kamen?}

### Kauf-/Nichtkauf-Signale
{Was deutet auf Kauf oder Nicht-Kauf hin?}

### Neue Hypothesen
{Was koennte sich daraus fuer ICP, Messaging, Offer ergeben?}

### Naechster Schritt
{Was passiert als naechstes mit diesem Kontakt?}
```

## Step 3: Update files

After confirmation:

1. Learning → append to `decisions_learnings.jsonl` (`type: "learning"`, with `category`, `source`, `insight`, `action`)
2. If new objection → append to `messaging_playbook.md` objections table
3. If strong customer language → extend `icp_playbook.md` customer-language section
4. If new task → add to `dashboard_data.json:path_state.tasks` (id = max + 1, `today: false`, `date: "this week"` if not today)
5. If hypothesis disproven → append to `decisions_learnings.jsonl` (`type: "hypothesis_discarded"`)
6. Update `dashboard_data.json:path_state.icp_signals` and `path_state.messaging_signals` counters as relevant

## Rules

- One question per message
- Always confirm before file changes
- Document customer-language verbatim — never paraphrase
