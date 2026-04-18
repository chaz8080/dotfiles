# Firefox Setup

Automated via `set_css.sh` (runs during `./install`).

## What's automated

- **userChrome.css** — hides the native tab bar and sidebar header (Tree Style Tab replaces them)
- **user.js** — sets `toolkit.legacyUserProfileCustomizations.stylesheets = true` in `about:config`

## Manual steps (one-time after fresh install)

### 1. Install extensions

| Extension | Install link |
|-----------|-------------|
| [Tree Style Tab](https://addons.mozilla.org/en-US/firefox/addon/tree-style-tab/) | Sidebar-based tree tabs |
| [Vimium](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/) | Vim-style keyboard navigation |
| [Bitwarden](https://addons.mozilla.org/en-US/firefox/addon/bitwarden-password-manager/) | Password manager |
| [Dark Reader](https://addons.mozilla.org/en-US/firefox/addon/darkreader/) | Dark mode for websites |

### 2. Apply Tree Style Tab custom CSS

1. Open Tree Style Tab preferences (click TST icon → gear ⚙)
2. Go to **Advanced** → **Extra style rules for sidebar contents**
3. Paste the contents of [`treestyletab.css`](./treestyletab.css)

This hides the `+` new-tab button at the bottom of the TST sidebar.

### 3. Pin TST to sidebar

Right-click the Tree Style Tab toolbar icon → **Pin to Sidebar** so it opens automatically.
