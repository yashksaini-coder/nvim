# 🐛 Debugging C Code in Neovim with nvim-dap

## Your Code Analysis

Looking at your C program (`Untitled-1`):

```c
#include <stdio.h>

#define LOW 1                            //Symbolic constant defined at start of file
#define HIGH 50

int main(void)
{
    for (int i = LOW; i <= HIGH; ++i)
        printf("%d\n", i);

    return 0;
}
```

**What this code does:**
- Defines symbolic constants `LOW = 1` and `HIGH = 50`
- Loops from 1 to 50 (inclusive)
- Prints each number on a new line
- Returns 0 (success)

## Step-by-Step Debugging Guide

### 1. **Save and Compile Your Code**

First, save your file (e.g., as `count.c`) and compile it with debug symbols:

```bash
gcc -g -o count count.c
```

The `-g` flag adds debug information that the debugger needs.

### 2. **Set Breakpoints**

In Neovim, navigate to the line where you want to pause execution:

- **Line 9** (the for loop) - Good place to see the loop variable
- **Line 10** (printf) - Good place to see what's being printed

Press `<leader>db` (Space + d + b) to toggle a breakpoint. You'll see a 🔴 red circle appear.

**Breakpoint Keymaps:**
- `<leader>db` - Toggle breakpoint at current line
- `<leader>dB` - Set conditional breakpoint (e.g., `i == 25` to stop when i equals 25)

### 3. **Start Debugging**

Press `<F5>` or `<leader>dc` to start debugging. You'll be prompted to:
1. Select a debug configuration (choose "Debug C/C++ (Auto)")
2. If the executable doesn't exist, it will auto-compile

The DAP UI will automatically open showing:
- **Left panel**: Scopes (variables), Breakpoints, Call Stack, Watches
- **Bottom panel**: REPL (interactive console) and Console output

### 4. **Control Execution**

Once debugging starts, you'll see a ▶️ arrow at the current line:

| Key | Action | Description |
|-----|--------|-------------|
| `<F5>` or `<leader>dc` | Continue | Resume execution until next breakpoint |
| `<F10>` or `<leader>do` | Step Over | Execute current line, don't go into functions |
| `<F11>` or `<leader>di` | Step Into | Step into function calls |
| `<F12>` or `<leader>dO` | Step Out | Step out of current function |
| `<leader>dp` | Pause | Pause execution |
| `<leader>dt` | Terminate | Stop debugging |

### 5. **Inspect Variables**

While paused at a breakpoint:

**In the DAP UI (left panel):**
- **Scopes**: See all variables in current scope
  - `i` - loop variable (starts at 1, increments to 50)
  - `LOW` - constant (1)
  - `HIGH` - constant (50)

**In the REPL (bottom panel):**
- Type variable names to see their values: `i`, `LOW`, `HIGH`
- Evaluate expressions: `i * 2`, `i < 25`

**Watch Expressions:**
- Add variables to watch list to monitor their values as you step through

### 6. **Understanding Your Code Flow**

When debugging your loop:

1. **Initial state**: `i = 1` (from `LOW`)
2. **Loop condition**: `i <= HIGH` (1 <= 50) → true
3. **Execute body**: Print `i` (prints "1")
4. **Increment**: `++i` → `i = 2`
5. **Repeat**: Check condition again (2 <= 50) → true
6. **Continue** until `i = 51`, then condition fails, loop exits

### 7. **Common Debugging Scenarios**

**Watch the loop variable change:**
1. Set breakpoint at line 9 or 10
2. Start debugging (`<F5>`)
3. Use Step Over (`<F10>`) repeatedly to see `i` increment
4. Check the Scopes panel to see `i` change: 1, 2, 3, 4...

**Stop at a specific iteration:**
1. Set conditional breakpoint: `<leader>dB`
2. Enter condition: `i == 25`
3. Start debugging
4. Execution will pause when `i` equals 25

**Inspect what's being printed:**
1. Set breakpoint at line 10 (printf line)
2. Step through and watch the Console panel to see output accumulate

### 8. **DAP UI Panels Explained**

**Left Panel:**
- **Scopes**: Current variables and their values
- **Breakpoints**: List of all breakpoints
- **Stacks**: Call stack (shows function hierarchy)
- **Watches**: Custom expressions to monitor

**Bottom Panel:**
- **REPL**: Interactive debugger console (evaluate expressions)
- **Console**: Program output (stdout/stderr)

### 9. **Useful Commands**

| Command | Keymap | Purpose |
|---------|--------|---------|
| Toggle DAP UI | `<leader>du` | Show/hide debug UI |
| Open REPL | `<leader>dr` | Open debugger console |
| Run Last | `<leader>dl` | Re-run last debug session |

## Quick Reference: All Debug Keymaps

### Main Controls
- `<F5>` / `<leader>dc` - Continue/Start debugging
- `<F10>` / `<leader>do` - Step Over
- `<F11>` / `<leader>di` - Step Into
- `<F12>` / `<leader>dO` - Step Out
- `<leader>dp` - Pause
- `<leader>dt` - Terminate

### Breakpoints
- `<leader>db` - Toggle breakpoint
- `<leader>dB` - Conditional breakpoint

### UI & Tools
- `<leader>du` - Toggle DAP UI
- `<leader>dr` - Open REPL
- `<leader>dl` - Run last debug session

## Example Debugging Session

1. **Open your C file** in Neovim
2. **Set breakpoint** at line 10: Move cursor to line 10, press `<leader>db`
3. **Start debugging**: Press `<F5>`, select "Debug C/C++ (Auto)"
4. **If not compiled**: The debugger will auto-compile with `gcc -g`
5. **Execution pauses** at line 10
6. **Inspect variables**: Check Scopes panel - you'll see `i = 1`
7. **Step through**: Press `<F10>` (Step Over) repeatedly
   - Watch `i` increment: 1 → 2 → 3 → 4...
   - Watch Console output: "1", "2", "3", "4"...
8. **Continue**: Press `<F5>` to run to completion or next breakpoint

## Troubleshooting

**"codelldb not found"**
- Run `:Mason` and install `codelldb` if not already installed

**"Executable not found"**
- The auto-compile feature should handle this, or manually compile:
  ```bash
  gcc -g -o your_program your_program.c
  ```

**Breakpoints not working**
- Make sure you compiled with `-g` flag (debug symbols)
- Check that the executable path is correct

**DAP UI not showing**
- Press `<leader>du` to toggle the UI
- It should auto-open when debugging starts

## Tips

1. **Use conditional breakpoints** to stop at specific iterations
2. **Watch expressions** to monitor complex conditions
3. **REPL is powerful** - evaluate any C expression while debugging
4. **Step Over vs Step Into**: Use Step Over for library functions like `printf`
5. **Multiple breakpoints**: Set breakpoints at different lines to trace execution flow

Happy debugging! 🎉
