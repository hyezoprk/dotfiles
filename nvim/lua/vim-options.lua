vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

vim.opt.relativenumber = true
vim.opt.wrap = true
vim.opt.conceallevel = 1
vim.opt.linebreak = true
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmode = false
vim.opt.guicursor = {
  "n-v-c:block",
  "i-ci-ve:ver25",
  "r-cr:hor20",
  "o:hor50",
}

vim.g.mapleader = " "
-- vim.keymap.set({ "n", "v", "o" }, "s", "<nop>", { noremap = true, silent = true, desc = "기본 s 효력 중지" })
vim.keymap.set({ "n", "v", "o" }, "f", "<nop>", { noremap = true, silent = true, desc = "기본 f 효력 중지" })
vim.keymap.set("n", "j", "gj", { noremap = true, silent = true })
vim.keymap.set("n", "k", "gk", { noremap = true, silent = true })
vim.keymap.set("n", "<c-f>", "<c-d>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-g>", "<c-u>", { noremap = true, silent = true })
vim.keymap.set("n", "<c-h>", "<c-w>h", { noremap = true })
vim.keymap.set("t", "<c-q>", "<c-\\><c-n>", { noremap = true })
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
vim.keymap.set({ "n", "v" }, "<s-enter>", vim.lsp.buf.format, { desc = "Format code" })
vim.keymap.set({ "n", "v" }, "<c-enter>", vim.lsp.buf.code_action, { desc = "Code Action" })
vim.keymap.set({ "n", "v" }, "<a-enter>", "<CMD>w<CR>", { desc = "Save.. to linter" })
vim.keymap.set({ "i", "o", "t" }, "<a-bs>", "<c-w>", { desc = "Delete word" })

-- NOTE: 노말모드 리맵
vim.keymap.set("n", "<C-e>", "<CMD>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<C-q>", "<CMD>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<bs>", "'", { desc = "마크이동 트리거 설정" })
vim.keymap.set("n", "<esc>", "<CMD>nohlsearch<CR>", { desc = "색인 빠져나오기" })
vim.keymap.set("n", "\\", ";", { desc = "반복키를 \\으로 설정" })
vim.keymap.set({ "n", "v" }, "x", '"_x', { desc = "복사 없는 삭제" })
vim.keymap.set("n", "dd", '"_dd', { desc = "복사 없는 삭제" })
vim.keymap.set("v", "p", "P", { desc = "붙여넣기 후 원래 텍스트 복사안함" })
vim.keymap.set({ "n", "v", "o" }, "$", "^", { noremap = true, silent = true })
vim.keymap.set({ "n", "v", "o" }, "^", "$", { noremap = true, silent = true })
vim.keymap.set("n", "<c-m>", "<CMD>delm! | delm A-Z0-9<CR>", { noremap = true, silent = true })

-- NOTE: Snacks 키맵
vim.keymap.set("n", "<tab>", function()
  Snacks.words.jump(1)
end, { desc = "Next Reference" })
vim.keymap.set("n", "<s-tab>", function()
  Snacks.words.jump(-1)
end, { desc = "Previous Reference" })
vim.keymap.set({ "n", "t" }, "<C-t>", function()
  Snacks.terminal.toggle(nil, {
    win = {
      style = "float",
      width = 0.7,
      height = 0.7,
      border = "rounded",
      title = "🛋️🚀🔥💻⚡",
      enter = true,
    },
    start_insert = true,
  })
end, { desc = "플로팅 터미널 토글" })
