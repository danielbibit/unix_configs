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

return utils
