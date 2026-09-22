# Security checklist (quasar 2.33.1)

Source: `dist/mcp/security/dos-and-donts.md` shipped with the package.

## HTML-rendering props are the XSS surface

Opt-in Boolean props that force HTML rendering; when enabled, YOU sanitize:

- `QSelect`: `options-html`, `display-value-html` (ignored when using the
  `option`/`selected` slots — sanitize there yourself).
- `QChatMessage`: `text-html`, `name-html`, `label-html`, `stamp-html` (also
  beware emoji/UTF-8 device-crash exploits on older mobile OSes).
- `Notify`, `Dialog` plugins: `html: true` (title/message).
- `Loading` plugin: `html` option ("Force render the message as HTML; This can
  lead to XSS attacks so make sure that you sanitize the content",
  `dist/api/Loading.json`).
- `QEditor`: users CREATE HTML; there is no sanitize option
  (`dist/mcp/security/dos-and-donts.md:67`). Strip `<script></script>` and
  `<iframe></iframe>` server-side before storing and re-serving to other users.
- Any `v-html` usage: only with trusted content (Vue's own warning); use
  `v-pre` for extra precaution.

## Environment exposure (Quasar CLI)

- Dotenv files: add `.env*` to `.gitignore`; never commit secrets.
- Quasar CLI filters what reaches client code by prefix: only env variables
  matching `QCLI_` (configurable via `build.env.clientPrefix`,
  `dist/mcp/security/dos-and-donts.md:80`, `:102`) are exposed to the browser
  bundle. Keep secrets out of that prefix.
- CSP: set a `<meta http-equiv="Content-Security-Policy">` in `index.html`
  (recommended baseline: `default-src 'self'; script-src 'self'; style-src
  'self' 'unsafe-inline'`), or enforce via HTTP headers in production
  (`dist/mcp/security/dos-and-donts.md:140`).

## Mode-specific

- Electron: never disable `websecurity`, never enable remote code execution;
  XSS in Electron means full device compromise.
- Cordova/Capacitor: no iframes; sign builds; encrypt data at rest.
- SSR: harden the Express server headers selectively before production.

## Files

- Validate uploads by magic numbers, not file extension; consider ClamAV.
- If you can refuse archive uploads, do.
