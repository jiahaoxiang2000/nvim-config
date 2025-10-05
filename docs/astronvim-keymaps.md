# AstroNvim Keymaps Reference

> Reference: https://docs.astronvim.com/mappings

## Leader Keys

| Key | Description |
|-----|-------------|
| `<Space>` | Leader key |
| `,` | Local Leader key |

## General Mappings

| Key | Mode | Description |
|-----|------|-------------|
| `Ctrl + {h,j,k,l}` | Normal | Navigate between windows |
| `Ctrl + {Arrow Keys}` | Normal | Resize windows |
| `Ctrl + s` | Normal | Force write |
| `Ctrl + q` | Normal | Force quit |
| `<Leader> + n` | Normal | New file |
| `<Leader> + R` | Normal | Rename current file |
| `<Leader> + c` | Normal | Close buffer |
| `\` | Normal | Horizontal split |
| `\|` | Normal | Vertical split |

## Buffer Navigation

| Key | Description |
|-----|-------------|
| `]b` | Next buffer |
| `[b` | Previous buffer |
| `>b` | Move buffer right |
| `<b` | Move buffer left |
| `<Leader> + bb` | Navigate buffer tabs |
| `<Leader> + bc` | Close all buffers except current |
| `<Leader> + bC` | Close all buffers |

## Tab Navigation

| Key | Description |
|-----|-------------|
| `]t` | Next tab |
| `[t` | Previous tab |

## Commenting

| Key | Mode | Description |
|-----|------|-------------|
| `<Leader> + /` | Normal/Visual | Toggle comment |
| `gco` | Normal | Insert comment below |
| `gcO` | Normal | Insert comment above |

## Completion

| Key | Mode | Description |
|-----|------|-------------|
| `Ctrl + Space` | Insert | Open completion menu |
| `Enter` | Insert | Select completion |
| `Tab` | Insert | Navigate to next snippet location |
| `Shift + Tab` | Insert | Navigate to previous snippet location |
| `Ctrl + e` | Insert | Cancel completion |

## LSP (Language Server Protocol)

| Key | Description |
|-----|-------------|
| `K` | Hover document |
| `<Leader> + lf` | Format document |
| `gra` / `<Leader> + la` | Code actions |
| `grn` / `<Leader> + lr` | Rename symbol |
| `gd` | Go to definition |
| `]d` | Next diagnostic |
| `[d` | Previous diagnostic |

## Debugger (DAP)

| Key | Description |
|-----|-------------|
| `<Leader> + dc` / `<F5>` | Start/Continue debugger |
| `<Leader> + db` / `<F9>` | Toggle breakpoint |
| `<Leader> + do` / `<F10>` | Step over |

## Picker/Telescope

| Key | Description |
|-----|-------------|
| `<Leader> + ff` | Find files |
| `<Leader> + fw` | Live grep (search in files) |
| `<Leader> + fb` | Find buffers |

## Terminal

| Key | Description |
|-----|-------------|
| `<Leader> + tf` | Open floating terminal |
| `<Leader> + th` | Open horizontal terminal |
| `<F7>` | Toggle current terminal |

## Notes

- Most mappings use `<Space>` as the leader key
- Window navigation uses Vim-style `hjkl` keys with `Ctrl`
- LSP mappings follow the `gr` (go to reference) prefix pattern
- Debugger mappings use both leader key combinations and function keys for convenience
