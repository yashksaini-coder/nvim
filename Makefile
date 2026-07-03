# -----------------------------------------------------------------------------
# Neovim config Makefile  (put in ~/.config/nvim)
# -----------------------------------------------------------------------------
SHELL        := bash
ROOT         := $(CURDIR)
MASON_BIN    := $(HOME)/.local/share/nvim/mason/bin
LUA_FILES    := $(shell find $(ROOT)/lua $(ROOT)/plugin $(ROOT)/after -name '*.lua' 2>/dev/null)
STYLUA_TOML  := $(ROOT)/stylua.toml
STYLUA       := $(MASON_BIN)/stylua
LUACHECK     := luacheck
JOBS         := $(shell nproc 2>/dev/null || echo 4)

.PHONY: all fmt lint check clean fmt-fix help
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

$(STYLUA_TOML):
	@echo "→  Creating minimal stylua.toml …"
	@echo 'column_width = 100' > $@
	@echo 'indent_type    = "Spaces"' >> $@
	@echo 'indent_width   = 2' >> $@

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

# 5. Clean artefacts ----------------------------------------------------------
clean:
	rm -f $(STYLUA_TOML)

# 6. Help / list --------------------------------------------------------------
help:
	@echo "Available targets:"
	@echo "  make              format-check + lint (default)"
	@echo "  make fmt          format-check only"
	@echo "  make lint         lint only"
	@echo "  make fmt-fix      auto-format files in place"
	@echo "  make fix-whitespace remove trailing whitespace"
	@echo "  make clean        remove generated files"
	@echo "  make help         show this help"
