# 🧙‍♂️ Tio da TI's AstroNvim Setup

**Because life's too short for bad tooling**

> *"A good editor is like a good coffee maker — once you've got it dialed in, you never want to go back to the instant stuff."* — Your friendly neighborhood IT Uncle

Welcome to my Neovim config! After 25+ years of writing code in everything from Notepad (yes, really) to IntelliJ, I finally found my happy place with AstroNvim. This setup is optimized for late-night coding sessions, fintech projects that need to actually work, and maintaining my sanity.

## 🚀 Quick Start

```bash
# Clone this config
git clone https://github.com/aquele-dinho/astro_nvim_cfgs.git ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim

# Sync all plugins
:Lazy sync

# Authenticate GitHub Copilot (required)
:Copilot auth
```

That's it. You're ready to code.

## 🏗️ What's Inside

### The Essentials
- **AstroNvim v5** - Because reinventing the wheel is overrated
- **Catppuccin Mocha** - Dark theme that doesn't hurt your eyes at 2 AM
- **GitHub Copilot** - My AI pair programmer (Supermaven available if you prefer)
- **LSP for Java & Go** - My daily drivers (see [JAVA_SETUP.md](JAVA_SETUP.md) and [GO_SETUP.md](GO_SETUP.md))
- **Format on save** - Because arguing about tabs vs spaces is so 2010

### Languages Configured
- ☕ **Java** (primary) - Spring Boot, jPOS, all the enterprise jazz
- 🐹 **Go** (secondary) - For when Java feels too verbose
- 🌐 **Web stuff** - JS/TS because someone has to deal with frontends
- 📝 **Markdown** - You're reading it right now!
- And more via AstroCommunity packs

## ⚡ Why You'll Like It

- **Zero-config LSP**: Open a file, start coding. That's it.
- **AI suggestions**: Copilot shows up as you type. Accept with `Option+L` or ignore it.
- **Sensible keybindings**: If you know Vim motions, you're 90% there.
- **Fast startup**: ~50-80ms. I timed it so you don't have to.
- **Looks good**: Transparent background, clean UI, no visual noise.

## ⌨️ Key Shortcuts (The "Uncle's" Favorites)

Leader key is `<Space>` (because who actually uses spacebar in normal mode?)

| Shortcut | What It Does |
| --- | --- |
| `<leader>e` | Toggle file explorer |
| `<leader>ff` | Find files (Telescope) |
| `<leader>fg` | Grep/search in files |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Show docs (hover) |
| `<leader>la` | Code actions (the good stuff) |
| `<leader>mp` | Preview Markdown |
| `<M-l>` | Accept Copilot suggestion (Option+L on Mac) |

Press `<leader>` in normal mode and wait a sec — which-key will show you everything else.

## 📁 How It's Organized

```
~/.config/nvim/
├── init.lua              # The starting point
├── lua/plugins/          # All the plugin configs
│   ├── astrolsp.lua      # LSP setup (Java, Go, etc.)
│   ├── ai-completion.lua # Copilot/Supermaven
│   ├── astrocore.lua     # Keybindings & settings
│   └── ...               # Other plugin configs
├── JAVA_SETUP.md         # Java deep dive
└── GO_SETUP.md           # Go deep dive
```

If you want to change something, poke around in `lua/plugins/`. It's all pretty readable.

## 🛠️ Making It Yours

Want to change stuff? Go for it!

- **Change theme**: Edit the `flavour` in `init.lua` (mocha/macchiato/frappe/latte)
- **Add a language**: Check [AstroCommunity](https://github.com/AstroNvim/astrocommunity), add to `lua/community.lua`, run `:Lazy sync`
- **Tweak keybindings**: Edit `lua/plugins/astrocore.lua`
- **Add plugins**: Create a file in `lua/plugins/`, run `:Lazy sync`

It's all pretty straightforward. If you can read Lua (and honestly, it's not hard), you can customize anything.

## 🔧 When Things Go Wrong

**LSP not working?**
- `:LspInfo` to check status
- `:LspRestart` to give it a kick

**Copilot acting up?**
- `:Copilot auth` to re-authenticate
- `:Copilot status` to see what's up

**Something else broke?**
- `:Lazy sync` usually fixes plugin issues
- `:checkhealth` for a full diagnostic

If Java LSP seems slow the first time, it's indexing. Grab a coffee, it'll be done in a few minutes.

## 💡 Uncle's Pro Tips

1. **Give Copilot good comments** - It's like explaining to a junior dev. The better your comment, the better the suggestion.
2. **Learn `gd` and `gr`** - Go to definition and find references. You'll use these 100 times a day.
3. **Use code actions** - `<leader>la` has all the refactoring goodies (extract method, generate constructors, etc.)
4. **Telescope is your friend** - `<leader>ff` to find files, `<leader>fg` to grep. Faster than you think.
5. **Format on save is on** - Your code stays pretty automatically. One less thing to worry about.

## 📦 What You Need

- Neovim 0.10+
- Git, Node.js
- Java 17+ (if doing Java)
- Go 1.21+ (if doing Go)
- A Nerd Font (for pretty icons)

macOS:
```bash
brew install neovim node git go openjdk@21
```

## 🤝 Need Help?

Found a bug? Something not working? Open an issue! Just remember: this is my personal config, tuned for my workflow. But if something's broken, I want to know.

Feel free to fork it and make it your own. That's what it's here for.

---

## 👨‍💻 About Your IT Uncle

**Gandhi Mesquita** (a.k.a. Tio da TI)  
Senior Specialist @ Deloitte  
25+ years building stuff that actually works

**Current gig**: Microservices, event-driven systems, fintech platforms  
**Stack**: Java, Spring Boot, Go, PostgreSQL, Kafka, AWS, GCP  
**Location**: Inhumas, Goiás, Brazil 🇧🇷

I've been coding since Notepad was considered a legitimate IDE. Now I use Neovim and feel like I finally made it.

---

*"A well-configured editor is like a well-organized toolbox — it makes the work feel like play."* — Me, probably after too much coffee

---

**License**: MIT (do whatever you want)  
**Status**: Actively maintained (I use this daily)
