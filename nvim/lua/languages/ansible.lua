local M = {}

local function get_venv_info()
    local venv_names = { ".venv", "venv" }
    local current_file = vim.api.nvim_buf_get_name(0)
    local venv_root = vim.fs.find(venv_names, { upward = true, path = current_file })[1]

    if venv_root then
        return {
            root = vim.fn.fnamemodify(venv_root, ":p:h:h"), -- Project root
            bin = venv_root .. "/bin",
            python = venv_root .. "/bin/python3"
        }
    end
    return nil
end

function M.setup()
    local venv = get_venv_info()
    if not venv then return end

    vim.filetype.add({
      pattern = {
        [".*/playbooks/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/tasks/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/handlers/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/defaults/.*%.ya?ml"] = "yaml.ansible",
        [".*/roles/.*/vars/.*%.ya?ml"] = "yaml.ansible",
        [".*/inventories/.*%.ya?ml"] = "yaml.ansible",
      },
    })

    vim.lsp.config['ansiblels'] = {
        cmd = { "ansible-language-server", "--stdio" },

        cmd_env = {
            PATH = venv.bin .. ":" .. vim.env.PATH,
            VIRTUAL_ENV = venv.root,
            PYTHONPATH = venv.bin,
        },

        filetypes = { 'yaml.ansible' },
        root_markers = { 'ansible.cfg', '.ansible-lint', '.git', 'inventory', 'uv.lock' },

        settings = {
            ansible = {
                python = {
                    interpreterPath = venv.python
                },
                validation = {
                    enabled = true,
                    lint = {
                        enabled = true,
                        path = venv.bin .. "/ansible-lint"
                    }
                },
            },
        },
    }

    vim.diagnostic.config({
        underline = true,
        virtual_text = true,
        signs = true,
        severity_sort = true,
    })

    vim.lsp.enable('ansiblels')
end

return M
