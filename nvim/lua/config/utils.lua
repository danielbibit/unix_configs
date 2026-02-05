_G.utils = {}
utils.plugins = {}

utils.plugins.telescope_open_single_or_multi = function(prompt_bufnr)
    local action_state = require("telescope.actions.state")
    local actions = require("telescope.actions")

    local picker = action_state.get_current_picker(prompt_bufnr)
    local multi_selection = picker:get_multi_selection()

    if #multi_selection > 1 then
        -- 1. Close the Telescope window first to avoid focus issues
        actions.close(prompt_bufnr)

        -- 2. Loop through each selected item and open it in a buffer
        for _, selection in ipairs(multi_selection) do
            -- File pickers usually store the path in .path or .filename
            local file_path = selection.path or selection.filename or selection[1]
            if file_path then
                vim.cmd("edit " .. vim.fn.fnameescape(file_path))
            end
        end
    else
        -- 3. If only one (or zero) files are selected, use standard open
        actions.select_default(prompt_bufnr)
    end
end

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

return utils
