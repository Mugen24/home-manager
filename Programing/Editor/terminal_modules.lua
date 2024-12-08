local window_h = vim.fn.winheight("0") / 3

vim.cmd(string.format("rightb %ssplit term://zsh", window_h))
local buff_name = vim.fn.bufname(2)
vim.cmd.close()


vim.keymap.set("t", "\\", vim.cmd.close)
vim.keymap.set("n", "\\",
    function ()
        vim.cmd(string.format("rightb %ssplit %s", window_h, buff_name))
        vim.cmd.startinsert()
    end,
    {
        desc = "Invoke terminal"
    }
)
