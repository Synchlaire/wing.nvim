if vim.g.loaded_wing then
  return
end
vim.g.loaded_wing = true

vim.api.nvim_create_user_command("WingExport", function(opts)
  local export = require("wing.export")
  local args = vim.split(opts.args, "%s+", { trimempty = true })

  local dir = args[1] or vim.fn.expand("~/.config/wing")
  local target = args[2] -- nil = all

  if target then
    local variant = args[3] or (vim.o.background == "dark" and "dark" or "light")
    local path = export.write(target, variant, dir)
    vim.notify("Wing: exported " .. path, vim.log.levels.INFO)
  else
    local paths = export.export_all(dir)
    vim.notify("Wing: exported " .. #paths .. " files to " .. dir, vim.log.levels.INFO)
  end
end, {
  nargs = "*",
  complete = function(arglead, cmdline, curpos)
    local parts = vim.split(cmdline, "%s+", { trimempty = true })
    if #parts <= 2 then
      -- Complete directory (default behavior)
      return {}
    elseif #parts == 3 then
      -- Complete target
      local targets = vim.tbl_keys(require("wing.export").targets)
      table.sort(targets)
      return vim.tbl_filter(function(t)
        return t:find(arglead, 1, true) == 1
      end, targets)
    elseif #parts == 4 then
      return { "dark", "light" }
    end
    return {}
  end,
  desc = "Export Wing palette — :WingExport [dir] [target] [variant]",
})

vim.api.nvim_create_user_command("WingPalette", function()
  local wing = require("wing")
  local p = wing.get_palette()
  local lines = {}
  for k, v in pairs(p) do
    if type(v) == "string" and v:match("^#") then
      table.insert(lines, string.format("%-20s %s", k, v))
    end
  end
  table.sort(lines)
  vim.notify("Wing palette (" .. vim.o.background .. "):\n" .. table.concat(lines, "\n"), vim.log.levels.INFO)
end, {
  desc = "Show current Wing palette colors",
})
