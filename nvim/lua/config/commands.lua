-- No buffer when entering a directory
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        if vim.fn.isdirectory(vim.fn.expand("%")) == 1 then
            vim.cmd("bwipeout!")
        end
    end,
})

-- Enable dashboard on enter
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local stats = vim.loop.fs_stat(vim.fn.argv(0))
        if stats and stats.type == "directory" then
            vim.cmd("cd " .. vim.fn.argv(0))
            require("snacks").dashboard()
        end
    end,
})

-- Run conform on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function(args)
        require("conform").format({ bufnr = args.buf })
    end,
})

-- Disable conceal for markdown files (indentline sets conceallevel)
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown" },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        vim.cmd([[%s/\s\+$//e]])
        vim.api.nvim_win_set_cursor(0, pos)
    end,
})

-- Open all modified and untracked git files in buffers
vim.api.nvim_create_user_command("GitOpenModified", function()
    local files = {}
    local seen = {}

    -- Get modified files
    local handle = io.popen("git diff --name-only 2>/dev/null")
    if handle then
        local result = handle:read("*a")
        handle:close()
        for file in result:gmatch("[^\r\n]+") do
            if vim.fn.filereadable(file) == 1 and not seen[file] then
                table.insert(files, file)
                seen[file] = true
            end
        end
    end

    -- Get untracked files
    handle = io.popen("git ls-files --others --exclude-standard 2>/dev/null")
    if handle then
        local result = handle:read("*a")
        handle:close()
        for file in result:gmatch("[^\r\n]+") do
            if vim.fn.filereadable(file) == 1 and not seen[file] then
                table.insert(files, file)
                seen[file] = true
            end
        end
    end

    if #files == 0 then
        vim.notify("No modified or untracked git files found", vim.log.levels.INFO)
        return
    end

    for _, file in ipairs(files) do
        vim.cmd("edit " .. vim.fn.fnameescape(file))
    end
    vim.notify("Opened " .. #files .. " modified/untracked file(s)", vim.log.levels.INFO)
end, {})
