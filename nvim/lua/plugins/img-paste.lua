return {
  dir = vim.fn.stdpath("config"),
  name = "img-paste",
  keys = {
    {
      "<leader>p",
      function()
        local slug = vim.fn.expand("%:t:r")
        local fs_dir = vim.fn.getcwd() .. "/public/assets/posts/" .. slug
        local web_dir = "/assets/posts/" .. slug

        vim.fn.mkdir(fs_dir, "p")

        -- 소스 파일 목록 수집
        local sources = {}
        local line = vim.fn.getline("."):match("^%s*(.-)%s*$")
        if line ~= "" and vim.fn.filereadable(line) == 1 then
          sources = { line }
          vim.api.nvim_del_current_line()
        else
          -- Finder Cmd+C: NSPasteboard로 전체 파일 목록 추출 (단일/복수 모두 처리)
          local script = [[
use framework "Foundation"
use scripting additions
set pb to current application's NSPasteboard's generalPasteboard()
set names to pb's propertyListForType:"NSFilenamesPboardType"
if names is missing value then return ""
set paths to {}
repeat with n in names
  set end of paths to n as text
end repeat
set AppleScript's text item delimiters to "\n"
return paths as text
]]
          local sf = io.open("/tmp/_nvim_img_urls.applescript", "w")
          if sf then sf:write(script); sf:close() end
          local raw = vim.fn.system({ "osascript", "/tmp/_nvim_img_urls.applescript" })
          for path in raw:gmatch("[^\n]+") do
            if vim.fn.filereadable(path) == 1 then
              table.insert(sources, path)
            end
          end
          -- 파일 URL 없으면 pngpaste (스크린샷 등)
          if #sources == 0 then
            local tmp = "/tmp/_nvim_img_paste.png"
            vim.fn.system("pngpaste " .. tmp)
            if vim.v.shell_error == 0 then sources = { tmp } end
          end
        end

        if #sources == 0 then
          vim.notify("이미지 소스 없음", vim.log.levels.WARN)
          return
        end


        local base = #vim.fn.glob(fs_dir .. "/*", false, true)
        local links = {}
        for i, src in ipairs(sources) do
          local name = string.format("%02d", base + i)
          local out = fs_dir .. "/" .. name .. ".webp"
          vim.fn.system({ "/opt/homebrew/bin/magick", src, "-quality", "80", "webp:" .. out })
          if vim.v.shell_error ~= 0 then
            vim.notify(name .. " 변환 실패", vim.log.levels.ERROR)
          else
            table.insert(links, "![" .. name .. "](" .. web_dir .. "/" .. name .. ".webp)")
          end
        end

        if #links > 0 then
          vim.api.nvim_put(links, "l", true, true)
          vim.notify(#links .. "개 저장됨")
        end
      end,
      desc = "Paste image(s) to MDX",
    },
    {
      "<leader>pd",
      function()
        local line = vim.fn.getline(".")
        local img_path = line:match("!%[.-%]%((/assets/posts/[^)]+)%)")
        if not img_path then
          vim.notify("이미지 링크 없음", vim.log.levels.WARN)
          return
        end
        local fs_path = vim.fn.getcwd() .. "/public" .. img_path
        if vim.fn.filereadable(fs_path) == 0 then
          vim.notify("파일 없음: " .. fs_path, vim.log.levels.WARN)
          return
        end
        vim.ui.input({ prompt = "삭제? " .. img_path .. " [y/N] " }, function(input)
          if input ~= "y" then return end
          vim.fn.delete(fs_path)
          vim.api.nvim_del_current_line()
          vim.notify("삭제됨: " .. img_path)
        end)
      end,
      desc = "Delete image file and line",
    },
  },
}
