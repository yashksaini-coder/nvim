-- C# LSP (OmniSharp). Requires .NET SDK. Install via Mason: omnisharp
local mason_omnisharp = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll"

return {
  cmd = { "dotnet", mason_omnisharp },
  root_dir = function(fname)
    local dir = (fname and #fname > 0) and vim.fn.fnamemodify(fname, ":p:h") or vim.loop.cwd()
    while dir ~= "/" and dir ~= "" do
      if #vim.fn.glob(dir .. "/*.sln") > 0 or #vim.fn.glob(dir .. "/*.csproj") > 0 then
        return dir
      end
      local parent = vim.fn.fnamemodify(dir, ":h")
      if parent == dir then
        break
      end
      dir = parent
    end
    return vim.loop.cwd()
  end,
  settings = {
    omnisharp = {
      enable_import_completion = true,
      organize_imports_on_format = true,
      enable_roslyn_analyzers = true,
    },
  },
}
