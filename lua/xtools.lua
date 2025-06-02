local M = {}

------------------------------------------------------------------------------
-- neovim

function M.get_clip() return vim.fn.getreg "+" end
function M.set_clip(data) return vim.fn.setreg("+", data) end

function M.isdir(path) return vim.fn.isdirectory(path) == 1 end
function M.isfile(path) return vim.fn.filereadable(path) == 1 end

function M.cwd() return vim.fn.getcwd() end
function M.cd(path) vim.fn.chdir(path) end

function M.filename(path) return vim.fn.fnamemodify(path, ":t") end
function M.dirname(path) return vim.fn.fnamemodify(path, ":h") end

function M.get_buf_file_path()
  local buffer_number = vim.api.nvim_get_current_buf()
  local buffer_name = vim.api.nvim_buf_get_name(buffer_number)
  return buffer_name
end

function M.get_buf_file_relpath()
  local buf_path = vim.api.nvim_buf_get_name(0)
  local buf_relpath = vim.fn.fnamemodify(buf_path, ":.")
  return buf_relpath
end

function M.get_buf_file_name()
  local buffer_path = M.get_buf_file_path()
  local file_name = vim.fn.fnamemodify(buffer_path, ":t")
  return file_name
end

function M.get_buf_file_dir()
  local buffer_path = M.get_buf_file_path()
  local directory = vim.fn.fnamemodify(buffer_path, ":h")
  return directory
end

function M.get_cursor() return vim.api.nvim_win_get_cursor(0) end

function M.get_visual_range()
  local vpos = vim.fn.getpos "v"
  local cpos = vim.fn.getpos "."
  local visual_range = {
    vpos_lnum = vpos[2],
    vpos_col = vpos[3] - 1,
    cpos_lnum = cpos[2],
    cpos_col = cpos[3] - 1,
  }
  return visual_range
end

function M.get_buf_content(start_lnum, end_lnum)
  local lines = vim.api.nvim_buf_get_lines(
    0,
    start_lnum and (start_lnum - 1) or 0,
    end_lnum == "$" and -1 or (end_lnum and end_lnum or -1),
    false
  )
  return table.concat(lines, "\n")
end

function M.get_vbuf_content()
  return table.concat(vim.fn.getregion(vim.fn.getpos "v", vim.fn.getpos ".", { type = vim.fn.mode() }), "\n")
end

function M.sort_qf()
  local items = vim.fn.getqflist()
  table.sort(items, function(a, b) return (a.lnum or 0) < (b.lnum or 0) end)
  vim.fn.setqflist({}, "r", { items = items })
end

function M.filter_qflist(filter_fn)
  local qflist = vim.fn.getqflist()
  local new_qflist = {}
  for _, entry in ipairs(qflist) do
    if filter_fn(entry) then table.insert(new_qflist, entry) end
  end
  vim.fn.setqflist(new_qflist)
  M.sort_qf()
end

function M.filter_qflist_visual()
  local visual_range = {
    bufnr = vim.api.nvim_get_current_buf(),
    start_lnum = vim.fn.getpos("v")[2],
    end_lnum = vim.fn.getpos(".")[2],
  }

  M.filter_qflist(function(entry)
    if entry.bufnr ~= visual_range.bufnr then return false end
    return entry.lnum >= visual_range.start_lnum and entry.lnum <= visual_range.end_lnum
  end)
end

function M.filter_qflist_current_buffer()
  M.filter_qflist(function(entry) return entry.bufnr == vim.api.nvim_get_current_buf() end)
end

function M.goto_nearest_qf_item()
  local qflist = vim.fn.getqflist()
  if #qflist == 0 then return end

  local current_buf = vim.api.nvim_get_current_buf()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local min_dist, nearest_idx = math.huge, nil

  for idx, item in ipairs(qflist) do
    if item.valid and item.bufnr == current_buf then
      local dist = math.abs(item.lnum - current_line)
      if dist < min_dist then
        min_dist, nearest_idx = dist, idx
      end
    end
  end

  if nearest_idx then vim.fn.setqflist({}, "r", { idx = nearest_idx }) end
end

function M.run(cmd, input) return vim.fn.system(cmd, input) end

------------------------------------------------------------------------------
-- win

function M.winb(text)
  return require("snacks").win {
    text = text,
    position = "bottom",
    height = 0.4,
    width = 0.4,
    wo = {
      number = true,
    },
  }
end

function M.winf(text)
  return require("snacks").win {
    text = text,
    position = "float",
    height = 0.4,
    width = 0.4,
    wo = {
      number = true,
    },
  }
end

function M.winv(text)
  return require("snacks").win {
    text = text,
    position = "right",
    height = 0.4,
    width = 0.4,
    wo = {
      number = true,
    },
  }
end

------------------------------------------------------------------------------
-- toggleterm

function M.new_term_cmd_vertical(opts)
  local term = require("toggleterm.terminal").Terminal:new(opts)
  term:toggle(80, "vertical")
end

function M.new_term_cmd_float(opts)
  local term = require("toggleterm.terminal").Terminal:new(opts)
  term:toggle(80, "float")
end

------------------------------------------------------------------------------
-- xtools

function M.adjust_path_from_clip() return M.run "xt -b c2V0X2NsaXAoZmwwKGdldF9jbGlwKCkpKQ==" end

function M.xtools_exec_float(code)
  M.set_clip(code)
  M.new_term_cmd_float { cmd = "xt -c -d", display_name = "xtools_exec", close_on_exit = false }
end

function M.xtools_exec_vertical(code)
  M.set_clip(code)
  M.new_term_cmd_vertical { cmd = "xt -c -d", display_name = "xtools_exec", close_on_exit = false }
end

function M.xtools_eval(code)
  M.set_clip(code)
  vim.fn.system "xt -c -e clip -d"
  vim.wait(100)
  M.winf(M.get_clip())
end

------------------------------------------------------------------------------

return M
