# Security Notes

## Shared credentials

DuoFY offers two shared conveniences to signed-in users: fallback Gemini API
keys (so new users can generate content before adding their own key) and the
Backblaze B2 credentials behind the community Document Store.

These are **not compiled into the app**. They live in the Firestore document
`secrets/apikeys` and are fetched at runtime by `lib/services/secrets_service.dart`,
cached in memory only, and dropped on sign-out.

Document shape (edit in the Firebase console, project `duofy-database`):

```
secrets/apikeys
  GENAI:      ["<gemini-key-1>", "<gemini-key-2>"]   # list or comma string
  B2_KEY_ID:  "<backblaze keyID>"
  B2_APP_KEY: "<backblaze applicationKey>"
  B2_BUCKET:  "duofyug"
  B2_REGION:  "eu-central-003"
```

Access is restricted by `firestore.rules` (repo root): the document is
readable **only by authenticated users** and never writable from clients.
Deploy rules with:

```
firebase deploy --only firestore:rules
```

## Threat model — be honest about it

Any **signed-in** user can read the shared keys (that is what makes them
shared). Auth-gating removes them from the public web bundle, from the git
history going forward, and enables central rotation — it does not make them
secret from a motivated signed-in user. Mitigations:

- **Rotate on a schedule** and immediately after any suspected abuse — edit
  `secrets/apikeys` in the console; every client picks the change up on its
  next fetch, no app update needed.
- **Cap the blast radius**: set per-key quotas in Google AI Studio; use a
  B2 application key scoped to only the `duofyug` bucket with the minimum
  capabilities (read/write files, no key management).
- A server-side proxy (Cloud Functions) is the next hardening step if abuse
  appears. Firebase App Check is deliberately deferred: the Linux/Windows
  desktop builds authenticate via firedart, which cannot produce App Check
  attestations, so enforcing it would break desktop.

## ⚠ One-time action required after this change landed

The previously hardcoded credentials remain visible in **git history**:

- The Backblaze key `00384db7dd2f3390000000001` / `K003EUC…` (was in
  `lib/services/b2_service.dart`) — **rotate it in the Backblaze console**,
  then put the new values into `secrets/apikeys`.
- If any Gemini key ever lived in source, rotate it in Google AI Studio too.
- Add the `B2_*` fields to `secrets/apikeys` (the `GENAI` field already
  exists) — until then the Document Store shows "not configured" for
  everyone, and generation falls back to user-supplied keys.

## Signed-out / guest users

Guests never receive shared keys. Generation prompts them to add their own
Gemini key in Settings; the Document Store shows its "not configured" state.
Signing in unlocks the shared keys — onboarding explains this.
