 # Neovim Comprehensive Keybind Guide

This guide is split into two parts:
1.  **Custom Configuration**: Mappings specific to your personal setup.
2.  **Neovim Defaults**: A comprehensive reference of standard Vim/Neovim commands.

**Leader Key:** `<Space>`

---

## 🛠️ Part 1: Your Custom Configuration

### 🌐 Global & General
| Key | Mode | Action | Description |
| :--- | :--- | :--- | :--- |
| `<Space>w` | Normal | Save | Save current buffer |
| `<Space>q` | Normal | Quit | Quit (confirms if unsaved) |
| `<Esc>` | Normal | Clear Highlights | Clear search highlights |
| `<S-h>` (Shift+H) | Normal | Prev Buffer | Go to previous buffer |
| `<S-l>` (Shift+L) | Normal | Next Buffer | Go to next buffer |
| `<` | Visual | Indent Left | Indent selection left (stays in visual mode) |
| `>` | Visual | Indent Right | Indent selection right (stays in visual mode) |

### 🤖 OpenCode AI
| Key | Mode | Action | Description |
| :--- | :--- | :--- | :--- |
| `<C-a>` (Ctrl+a) | Normal/Visual | Ask AI | Ask OpenCode about the current context |
| `<C-x>` (Ctrl+x) | Normal/Visual | AI Actions | Execute OpenCode actions |
| `<C-.>` (Ctrl+.) | Normal | Toggle Chat | Toggle OpenCode chat window |

### ⚡ Navigation & Files
| Key | Mode | Action | Description |
| :--- | :--- | :--- | :--- |
| `-` | Normal | Open Parent | Open parent directory (Oil.nvim) |
| `<Space>fm` | Normal | Mini Files | Open Mini Files explorer |
| `s` | Normal/Visual | Flash Jump | Jump to any character on screen |
| `<Space>ff` | Normal | Find Files | Fuzzy find files (FzfLua) |
| `<Space>fg` | Normal | Grep | Live grep text in project (FzfLua) |
| `<Space>fb` | Normal | Buffers | Search open buffers (FzfLua) |

### 🧠 LSP (Language Server Protocol)
*Active when a language server is attached.*

| Key | Mode | Action | Description |
| :--- | :--- | :--- | :--- |
| `gd` | Normal | Definition | Go to definition |
| `gr` | Normal | References | Find references (FzfLua) |
| `K` | Normal | Hover | Show documentation/hover info |
| `<Space>rn` | Normal | Rename | Rename symbol |
| `<Space>ca` | Normal | Code Action | Open code actions menu |
| `[d` | Normal | Prev Diagnostic | Go to previous error/warning |
| `]d` | Normal | Next Diagnostic | Go to next error/warning |
| `<Space>e` | Normal | Show Error | Show diagnostic error in float |
| `<Space>gl` | Normal | Diagnostic List | Open diagnostics in quickfix list |

### 📝 Typst
| Key | Mode | Action | Description |
| :--- | :--- | :--- | :--- |
| `<Space>tp` | Normal | Preview Start | Start Typst live preview |
| `<Space>ts` | Normal | Preview Stop | Stop Typst live preview |

### 🍿 Snacks.nvim (Utilities)
| Key | Mode | Action | Description |
| :--- | :--- | :--- | :--- |
| `<Space>z` | Normal | Zen Mode | Toggle Zen Mode |
| `<Space>.` | Normal | Scratch | Open Scratch Buffer |
| `<Space>n` | Normal | Notifications | Show Notification History |
| `<Space>bd` | Normal | Delete Buffer | Delete current buffer |
| `<C-/>` (Ctrl+/) | Normal | Terminal | Toggle integrated terminal |
| `<Space>gb` | Normal | Git Blame | Show Git blame for line |
| `<Space>gB` | Normal | Git Browse | Browse file in GitHub/GitLab |

---

## 📚 Part 2: Neovim Default Keybindings

This section covers the essential built-in commands that make Vim/Neovim powerful.

### 🏃 Basic Movement
| Key | Description |
| :--- | :--- |
| `h` | Move left |
| `j` | Move down |
| `k` | Move up |
| `l` | Move right |
| `w` | Jump forward to the start of the next word |
| `W` | Jump forward to the start of the next WORD (ignores punctuation) |
| `e` | Jump forward to the end of a word |
| `E` | Jump forward to the end of a WORD |
| `b` | Jump backward to the start of a word |
| `B` | Jump backward to the start of a WORD |
| `0` | Jump to the start of the line |
| `^` | Jump to the first non-blank character of the line |
| `$` | Jump to the end of the line |
| `gg` | Go to the first line of the file |
| `G` | Go to the last line of the file |
| `:n` | Go to line number `n` (e.g., `:10` goes to line 10) |

### 🔍 Search & Scrolling
| Key | Description |
| :--- | :--- |
| `/pattern` | Search forward for `pattern` |
| `?pattern` | Search backward for `pattern` |
| `n` | Repeat search in the same direction |
| `N` | Repeat search in the opposite direction |
| `*` | Search forward for the word under the cursor |
| `#` | Search backward for the word under the cursor |
| `<C-u>` | Scroll up half a screen |
| `<C-d>` | Scroll down half a screen |
| `<C-b>` | Scroll up full screen |
| `<C-f>` | Scroll down full screen |
| `zz` | Center the cursor line on the screen |
| `zt` | Move the cursor line to the top of the screen |
| `zb` | Move the cursor line to the bottom of the screen |

### ✏️ Editing (Insert Mode)
| Key | Description |
| :--- | :--- |
| `i` | Insert before the cursor |
| `I` | Insert at the beginning of the line |
| `a` | Insert after the cursor |
| `A` | Insert at the end of the line |
| `o` | Open a new line below and enter Insert mode |
| `O` | Open a new line above and enter Insert mode |
| `s` | Delete character and enter Insert mode |
| `S` | Delete line and enter Insert mode (same as `cc`) |
| `C` | Change (delete and insert) to end of line |

### ✂️ Editing (Normal Mode)
| Key | Description |
| :--- | :--- |
| `x` | Delete character under cursor |
| `X` | Delete character before cursor |
| `dd` | Delete (cut) current line |
| `dw` | Delete word |
| `D` | Delete to end of line |
| `yy` | Yank (copy) current line |
| `yw` | Yank word |
| `p` | Paste after cursor |
| `P` | Paste before cursor |
| `u` | Undo |
| `<C-r>` | Redo |
| `.` | Repeat last change command |
| `r` | Replace single character under cursor |
| `~` | Switch case of character under cursor |
| `J` | Join current line with the next one |

### 👁️ Visual Mode
| Key | Description |
| :--- | :--- |
| `v` | Enter Visual mode (select characters) |
| `V` | Enter Visual Line mode (select lines) |
| `<C-v>` | Enter Visual Block mode (select rectangular blocks) |
| `o` | Move to other end of marked area |
| `y` | Yank selection |
| `d` | Delete selection |
| `c` | Change selection |
| `=` | Auto-indent selection |

### 📑 Windows & Tabs
| Key | Description |
| :--- | :--- |
| `<C-w>s` | Split window horizontally |
| `<C-w>v` | Split window vertically |
| `<C-w>h/j/k/l` | Move focus to window left/down/up/right |
| `<C-w>c` | Close current window |
| `<C-w>o` | Close all other windows |
| `:tabnew` | Open new tab |
| `gt` | Go to next tab |
| `gT` | Go to previous tab |

### 📍 Marks & Macros
| Key | Description |
| :--- | :--- |
| `m{char}` | Set mark `{char}` at cursor position |
| `'{char}` | Jump to position of mark `{char}` |
| `q{char}` | Record macro into register `{char}` |
| `q` | Stop recording macro |
| `@{char}` | Execute macro `{char}` |
| `@@` | Repeat last executed macro |

### 📋 Registers
| Key | Description |
| :--- | :--- |
| `"{reg}y` | Yank into register `{reg}` (e.g., `"ayw` copies word to reg `a`) |
| `"{reg}p` | Paste from register `{reg}` |
| `"+y` | Yank to system clipboard |
| `"+p` | Paste from system clipboard |
