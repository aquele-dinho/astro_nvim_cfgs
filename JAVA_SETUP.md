# Neovim Java Development Setup

This document describes the Java development configuration for Neovim with AstroNvim.

## What's Configured

### 1. Language Server Protocol (LSP)
- **jdtls** (Eclipse JDT Language Server) - Provides:
  - Auto-completion
  - Code navigation (go to definition, find references)
  - Error/warning diagnostics
  - Code actions (refactoring, organize imports)
  - Signature help
  - Inlay hints (type information)

### 2. AI-Powered Completion
- **GitHub Copilot** - AI pair programmer
  - Context-aware code suggestions
  - Multi-line completions
  - Works with Java, Spring Boot, and all your tech stack
  
- **Supermaven** (optional) - Ultra-fast AI completion alternative
  - Currently disabled, can be enabled in `ai-completion.lua`

### 3. Code Quality Tools
- **google-java-format** - Code formatter
- **checkstyle** - Linter for code quality
- **java-debug-adapter** - Debugging support
- **java-test** - Test runner integration

### 4. Java Runtime Configuration
Configured for both Java 17 and Java 21:
- Java 21: `/opt/homebrew/Cellar/openjdk@21/21.0.8/libexec/openjdk.jdk/Contents/Home`
- Java 17: `/opt/homebrew/Cellar/openjdk@17/17.0.16/libexec/openjdk.jdk/Contents/Home`

## Installation Steps

### 1. Install/Update Plugins
Open Neovim and run:
```vim
:Lazy sync
```

This will:
- Install all configured plugins
- Install Mason tools (jdtls, formatters, linters)
- Set up the Java language pack from AstroCommunity

### 2. Setup GitHub Copilot
After plugins are installed, authenticate with GitHub Copilot:
```vim
:Copilot auth
```

Follow the browser authentication flow. You need an active Copilot subscription.

### 3. Verify Installation
Check that all Java tools are installed:
```vim
:Mason
```

Look for:
- ✓ jdtls
- ✓ google-java-format
- ✓ checkstyle
- ✓ java-debug-adapter
- ✓ java-test

### 4. Open a Java File
Open any Java file in your project:
```bash
nvim src/main/java/com/example/MyClass.java
```

The LSP should automatically attach. You'll see:
- Bottom status bar showing "jdtls" is active
- Auto-completion working as you type
- Error/warning squiggles for issues

## Key Bindings

### LSP Features (Normal Mode)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Find references
- `gi` - Go to implementation
- `gy` - Go to type definition
- `K` - Show hover documentation
- `<leader>la` - Code actions
- `<leader>lf` - Format code
- `<leader>lr` - Rename symbol
- `<leader>lh` - Toggle inlay hints

### Copilot Suggestions (Insert Mode)
- `<M-l>` or `<Option-l>` - Accept Copilot suggestion
- `<M-]>` or `<Option-]>` - Next suggestion
- `<M-[>` or `<Option-[>` - Previous suggestion
- `<C-]>` - Dismiss suggestion

### Copilot Panel
- `<M-CR>` or `<Option-Enter>` - Open Copilot panel (shows multiple suggestions)
- In panel:
  - `]]` - Next suggestion
  - `[[` - Previous suggestion
  - `<CR>` - Accept selected suggestion
  - `gr` - Refresh suggestions

### Completion Menu (Insert Mode)
- `<C-Space>` - Trigger completion manually
- `<C-n>` - Next completion item
- `<C-p>` - Previous completion item
- `<CR>` - Accept completion
- `<C-e>` - Close completion menu

## Spring Boot Specific Features

### Auto-completion
jdtls understands Spring Boot annotations and provides:
- Auto-completion for `@Autowired`, `@Service`, `@RestController`, etc.
- Property key completion in `@Value` annotations (if application.properties/yml is indexed)
- Bean dependency suggestions

### Code Actions
Right-click or use `<leader>la` to:
- Generate getters/setters
- Generate constructors
- Override methods
- Organize imports
- Remove unused imports

## Troubleshooting

### LSP Not Attaching
Check LSP status:
```vim
:LspInfo
```

If jdtls isn't listed, try:
```vim
:LspStart jdtls
```

### Copilot Not Working
Check Copilot status:
```vim
:Copilot status
```

If not authenticated:
```vim
:Copilot auth
```

### Slow Completion
The first time jdtls runs in a project, it needs to index:
- Your source code
- Dependencies (Maven/Gradle)
- JDK classes

This can take 1-5 minutes. Check progress in `:LspInfo`.

### Update Java Paths
If you update Java versions via Homebrew, update the paths in:
`~/.config/nvim/lua/plugins/astrolsp.lua`

Find your current Java homes:
```bash
/usr/libexec/java_home -V
```

## Alternative AI Completion: Supermaven

To use Supermaven instead of Copilot:

1. Edit `~/.config/nvim/lua/plugins/ai-completion.lua`
2. Change Copilot's `enabled = true` to `enabled = false`
3. Change Supermaven's `enabled = false` to `enabled = true`
4. Run `:Lazy sync`
5. Restart Neovim

Supermaven is free and very fast, but Copilot generally has better context understanding for complex Java projects.

## Tips for Java Development

1. **Project Import**: When opening a Maven/Gradle project for the first time, let jdtls finish indexing before coding
2. **Organize Imports**: Use `<leader>la` → "Organize imports" frequently
3. **Format on Save**: Enabled by default - your code auto-formats when you save
4. **Copilot Context**: Give Copilot context with comments, e.g.:
   ```java
   // Create a REST endpoint that returns all users from the database
   ```
   Then let Copilot suggest the implementation

5. **Inlay Hints**: Toggle with `<leader>lh` to see inferred types and parameter names

## Project-Specific Configuration

For Spring Boot projects, consider adding a `.jdtls` or `settings.gradle.kts` in your project root to:
- Set Java version explicitly
- Configure additional dependencies
- Set project-specific formatting rules

## Files Modified

- `~/.config/nvim/lua/plugins/astrolsp.lua` - LSP configuration
- `~/.config/nvim/lua/plugins/mason.lua` - Tool installer configuration
- `~/.config/nvim/lua/community.lua` - Java language pack import
- `~/.config/nvim/lua/plugins/ai-completion.lua` - AI completion setup (new file)

## Support

For issues:
- AstroNvim docs: https://docs.astronvim.com
- jdtls: https://github.com/eclipse/eclipse.jdt.ls
- Copilot: https://github.com/zbirenbaum/copilot.lua
