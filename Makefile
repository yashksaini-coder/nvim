# -----------------------------------------------------------------------------
# Neovim config Makefile  (put in ~/.config/nvim)
# -----------------------------------------------------------------------------
SHELL        := bash
ROOT         := $(CURDIR)
MASON_BIN    := $(HOME)/.local/share/nvim/mason/bin
LUA_FILES    := $(shell find $(ROOT)/lua $(ROOT)/plugin $(ROOT)/after -name '*.lua' 2>/dev/null)
STYLUA       := $(MASON_BIN)/stylua
LUACHECK     := luacheck
# Mason's bin dir is only on $PATH inside nvim. Put it on the shell's too, after
# the system path so a system luacheck still wins. Without this `make lint` fails
# with "luacheck: command not found"; install it with :MasonToolsInstall.
export PATH := $(PATH):$(MASON_BIN)

.PHONY: all fmt lint fmt-fix fix-whitespace help
all: fmt lint

# 1. Format -------------------------------------------------------------------
fmt:
	@echo "→  Format-checking Lua files …"
	@if $(STYLUA) --check . ; then \
	echo "All files are correctly formatted." ; \
else \
	echo "Some files need re-formatting. Auto-formatting..." ; \
	$(STYLUA) . ; \
	echo "Formatting complete." ; \
fi

# 2. Lint ---------------------------------------------------------------------
lint:
	@echo "→  Linting …"
	$(LUACHECK) $(LUA_FILES) \
	  --config .luacheckrc \
	  --codes --ranges --std luajit --max-line-length 100 \
	  --ignore 212/self  --ignore 631

# 3. One-shot “format in place” ----------------------------------------------
fmt-fix:
	$(STYLUA) .

# 4. Fix trailing whitespace --------------------------------------------------
fix-whitespace:
	@echo "→  Removing trailing whitespace from Lua files …"
	@find $(ROOT)/lua -name '*.lua' -type f -exec sed -i 's/[[:space:]]*$$//' {} +
	@echo "Whitespace cleanup complete."

# 6. Help / list --------------------------------------------------------------
help:
	@echo "Available targets:"
	@echo "  make              format-check + lint (default)"
	@echo "  make fmt          format-check only"
	@echo "  make lint         lint only"
	@echo "  make fmt-fix      auto-format files in place"
	@echo "  make fix-whitespace remove trailing whitespace"
	@echo "  make help         show this help"
