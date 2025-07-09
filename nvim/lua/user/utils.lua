local M = {}

function M.snacksCmd(cmd)
  return string.format(":lua Snacks.picker.%s()<CR>", cmd)
end

-- 배너 설정
local function get_all_files_in_dir(dir)
  local files = {}
  local scan = vim.fn.globpath(dir, "**/*.lua", true, true)
  for _, file in ipairs(scan) do
    table.insert(files, file)
  end
  return files
end

local prev_header_file = nil

function M.load_random_header()
  math.randomseed(os.time())
  local header_folder = vim.fn.stdpath("config") .. "/lua/user/banners/"
  local files = get_all_files_in_dir(header_folder)
  local dashboard = require("alpha.themes.dashboard")

  if #files == 0 then
    return nil
  end

  local candidate_files = {}
  for _, file in ipairs(files) do
    if file ~= prev_header_file then
      table.insert(candidate_files, file)
    end
  end

  -- 만약 후보가 없으면(파일이 1개뿐이면) 그냥 전체에서 뽑기
  if #candidate_files == 0 then
    candidate_files = files
  end

  local random_file = candidate_files[math.random(#candidate_files)]
  local relative_path = random_file:sub(#header_folder + 1)
  local module_name = "user.banners."
      .. relative_path:gsub("/", "."):gsub("\\", "."):gsub("%.lua$", "")

  package.loaded[module_name] = nil

  local ok, module = pcall(require, module_name)
  if ok and type(module) == "table" then
    dashboard.config.layout[2] = module
    prev_header_file = random_file
    return module
  else
    return nil
  end
end

function M.change_header()
  local new_header = M.load_random_header()
  if new_header then
    vim.cmd("AlphaRedraw")
  else
    print("no images inside banners folder.")
  end
end

return M
