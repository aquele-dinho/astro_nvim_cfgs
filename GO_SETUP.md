# Neovim Go Development Setup

This document describes the Go development configuration for Neovim with AstroNvim.

## What's Configured

### 1. Language Server Protocol (LSP)
- **gopls** (Official Go Language Server) - Provides:
  - Auto-completion
  - Code navigation (go to definition, find references)
  - Error/warning diagnostics
  - Code actions (refactoring, extract variable/function)
  - Signature help
  - Inlay hints (variable types, parameter names)

### 2. Code Quality Tools
- **gofumpt** - Stricter Go formatter (superset of gofmt)
- **goimports** - Auto-organizes imports
- **golangci-lint** - Comprehensive linter (runs 50+ linters)
- **staticcheck** - Advanced static analysis
- **delve** - Go debugger

### 3. Gopls Configuration
Advanced features enabled:
- **Inlay Hints**: Shows inferred types, parameter names, constant values
- **Code Lenses**: Inline actions for tests, go.mod tidy, vulnerability checks
- **Analyses**: Field alignment, nil checks, unused parameters
- **Auto-import**: Automatically imports packages as you type

## Installation Steps

### 1. Install/Update Plugins
Open Neovim and run:
```vim
:Lazy sync
```

This will:
- Install all configured plugins
- Install Mason tools (gopls, formatters, linters)
- Set up the Go language pack from AstroCommunity

### 2. Verify Installation
Check that all Go tools are installed:
```vim
:Mason
```

Look for:
- ✓ gopls
- ✓ gofumpt
- ✓ goimports
- ✓ golangci-lint
- ✓ staticcheck
- ✓ delve

### 3. Install Go Tools (Optional but Recommended)
Some features work better with tools installed via `go install`:
```bash
go install golang.org/x/tools/gopls@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
```

### 4. Open a Go File
Open any Go file in your project:
```bash
nvim main.go
```

The LSP should automatically attach. You'll see:
- Bottom status bar showing "gopls" is active
- Auto-completion working as you type
- Error/warning squiggles for issues
- Inlay hints showing types

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
- `<leader>lG` - Workspace diagnostics

### Completion Menu (Insert Mode)
- `<C-Space>` - Trigger completion manually
- `<C-n>` - Next completion item
- `<C-p>` - Previous completion item
- `<CR>` - Accept completion
- `<C-e>` - Close completion menu

### Code Lenses (shown above functions/tests)
- `<leader>lL` - Run code lens action
  - Run test
  - Run benchmarks
  - go mod tidy
  - Check for vulnerabilities
  - Upgrade dependencies

## Go-Specific Features

### Auto-Import
As you type struct/function names from unimported packages, gopls will:
1. Show completions from unimported packages
2. Automatically add the import when you accept the completion

Example:
```go
func main() {
    // Type "json.Mar" and accept completion
    // gopls automatically adds: import "encoding/json"
    json.Marshal(data)
}
```

### Inlay Hints
Shows helpful type information inline:
```go
// With inlay hints enabled, you'll see:
func process(data []byte) {
    result := parseData(data)  // <- result: *Result
    //                            (type shown inline)
}
```

Toggle with `<leader>lh`

### Code Lenses
Appear above test functions and go.mod:
```go
// run | debug
func TestMyFunction(t *testing.T) {
    // Click "run" or "debug" in the virtual text
}
```

### Struct Tag Generation
Use code actions to generate JSON/YAML/XML tags:
```go
type User struct {
    Name string
    Email string
}

// Place cursor on struct, press <leader>la
// Select "Add tags" -> "json" to get:

type User struct {
    Name  string `json:"name"`
    Email string `json:"email"`
}
```

### Format on Save
Enabled by default - uses gofumpt:
- Formats code
- Organizes imports
- Removes unused imports

### Error Detection
gopls shows errors in real-time:
- Syntax errors
- Type mismatches
- Unused variables/imports
- Nil pointer risks
- Race conditions (in some cases)

## Common Code Actions

Access with `<leader>la` or right-click:

1. **Extract to variable** - Extract expression to a new variable
2. **Extract to function** - Extract code block to new function
3. **Inline variable** - Replace variable with its value
4. **Add struct tags** - Generate JSON/YAML/etc tags
5. **Fill struct** - Auto-fill struct fields
6. **Remove unused parameter** - Clean up function signature
7. **Organize imports** - Sort and group imports

## Troubleshooting

### LSP Not Attaching
Check LSP status:
```vim
:LspInfo
```

If gopls isn't listed, try:
```vim
:LspStart gopls
```

Check gopls logs:
```vim
:LspLog
```

### Slow Completion
First time gopls runs in a project, it needs to:
- Index your source code
- Download and index dependencies
- Build a cache

This can take 1-5 minutes for large projects. Check progress:
```vim
:LspInfo
```

### Module Not Found Errors
Make sure you're in a proper Go module:
```bash
go mod init github.com/yourusername/projectname
```

Gopls requires `go.mod` to understand your project structure.

### Imports Not Working
Try manually tidying your module:
```bash
go mod tidy
```

Then restart gopls:
```vim
:LspRestart
```

### Format Not Working
Check that gofumpt is installed:
```bash
which gofumpt
```

If not in Mason, install manually:
```bash
go install mvdan.cc/gofumpt@latest
```

## Performance Tips

### Large Projects
For large projects, configure gopls to be less aggressive:

Add to your project root `.vscode/settings.json` (gopls reads it):
```json
{
  "gopls": {
    "analyses": {
      "unusedparams": false,
      "shadow": false
    },
    "staticcheck": false
  }
}
```

### Exclude Vendor/Generated Code
Gopls is configured to ignore:
- `.git/`
- `vendor/`
- `node_modules/`
- `.vscode/`
- `.idea/`

Add more in `astrolsp.lua` under `directoryFilters`.

## Testing

### Run Tests in Neovim
Use code lenses above test functions:
- Click virtual text "run" or "debug"
- Or use `<leader>lL` on the test function line

### Run All Tests in File
```bash
:!go test -v %
```

### Run Specific Test
With cursor on test function:
```vim
:!go test -v -run ^TestFunctionName$ %:p:h
```

## Debugging with Delve

### Setup
Delve (dlv) is installed via Mason and ready to use.

### Debug Current File
```vim
:!dlv debug %
```

### Debug with Arguments
```bash
dlv debug . -- arg1 arg2
```

### Attach to Running Process
```bash
dlv attach <pid>
```

## Go Module Management

### Initialize Module
```bash
go mod init github.com/yourusername/project
```

### Add Dependencies
Just import and use - gopls will suggest adding to go.mod:
```go
import "github.com/gin-gonic/gin"
```

Then run:
```bash
go mod tidy
```

Or use code lens "tidy" above go.mod file.

### Update Dependencies
Use code lens "upgrade dependency" above specific dependency in go.mod.

## Working with Different Go Versions

### Check Go Version
```bash
go version
```

### Switch Go Versions (with Homebrew)
```bash
brew install go@1.21
brew link go@1.21
```

### Per-Project Go Version
Use `go.mod`:
```
go 1.21
```

Gopls respects this version specification.

## Tips for Learning Go

1. **Use Inlay Hints**: Toggle on (`<leader>lh`) to see types everywhere - great for learning
2. **Read Hover Docs**: Press `K` on any symbol to see documentation
3. **Explore Standard Library**: Type `fmt.` and see all available functions with docs
4. **Check Examples**: Hover docs often include usage examples
5. **Code Actions for Learning**: Use `<leader>la` to see what refactorings are possible

## Common Go Patterns

### Error Handling
gopls auto-completes error checks:
```go
result, err := someFunction()
// Type "if err" and accept completion to get:
if err != nil {
    return err
}
```

### Interface Implementation
gopls shows which interfaces a type implements:
```go
type MyWriter struct{}

// Hover over MyWriter to see: "implements io.Writer"
```

### Implementing Interface Methods
Use code action "Implement interface":
```go
type MyHandler struct{}

// Cursor on MyHandler, <leader>la -> "Implement http.Handler"
// Auto-generates ServeHTTP method
```

## Project Structure Best Practices

Gopls works best with standard Go project structure:
```
myproject/
├── go.mod
├── go.sum
├── main.go
├── cmd/
│   └── myapp/
│       └── main.go
├── internal/
│   ├── handlers/
│   └── models/
└── pkg/
    └── utils/
```

## Files Modified

- `~/.config/nvim/lua/plugins/astrolsp.lua` - LSP configuration with gopls settings
- `~/.config/nvim/lua/plugins/mason.lua` - Tool installer with Go tools
- `~/.config/nvim/lua/community.lua` - Go language pack import
- `~/.config/nvim/lua/plugins/ai-completion.lua` - Enhanced completion for Go

## Resources

- Go documentation: https://go.dev/doc/
- Gopls settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
- AstroNvim docs: https://docs.astronvim.com
- Effective Go: https://go.dev/doc/effective_go

## Quick Reference Card

| Action | Command |
|--------|---------|
| Go to definition | `gd` |
| Find references | `gr` |
| Hover docs | `K` |
| Code actions | `<leader>la` |
| Format | `<leader>lf` |
| Rename | `<leader>lr` |
| Toggle hints | `<leader>lh` |
| Run test (lens) | `<leader>lL` |
| Restart LSP | `:LspRestart` |
| Check LSP status | `:LspInfo` |
