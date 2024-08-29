return {
  {
    "nvim-lualine/lualine.nvim",
    event = "BufEnter",
    opts = function()
      local function get_lsp_name()
        local bufnr = vim.api.nvim_get_current_buf()
        local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })

        if next(buf_clients) == nil then
          return "  No servers"
        end

        local buf_client_names = {}

        local disallowed_clients = {
          ["null-ls"] = true,
          ["trim"] = true,
          ["whitespace"] = true,
          ["trim_whitespace"] = true,
        }

        local copilot = ""

        for _, client in pairs(buf_clients) do
          if not disallowed_clients[client.name] then
            if client.name == "copilot" then
              copilot = " "
            else
              table.insert(buf_client_names, client.name)
            end
          end
        end

        local ok, conform = pcall(require, "conform")
        local formatters = table.concat(conform.list_formatters_for_buffer(), " ")
        if ok then
          for formatter in formatters:gmatch("%w+") do
            if formatter and not disallowed_clients[formatter] then
              table.insert(buf_client_names, formatter)
            end
          end
        end

        local hash = {}
        local unique_client_names = {}

        for _, v in ipairs(buf_client_names) do
          if not hash[v] then
            unique_client_names[#unique_client_names + 1] = v
            hash[v] = true
          end
        end

        local language_servers = table.concat(unique_client_names, ", ")

        local space = ""
        if copilot ~= "" and language_servers ~= "" then
          space = " "
        end

        return copilot .. space .. language_servers
      end

      return {
        options = {
          section_separators = { "", "" },
          component_separators = { "", "" },
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = {
            "branch",
          },
          lualine_c = {
            {
              "filename",
              path = 1,
            },
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " "
              },
            },
          },
          lualine_x = {
            {
              "diff",
              symbols = {
                added = " ",
                modified = " ",
                removed = " "
              },
            },
            "progress",
          },
          lualine_y = {
            "location",
          },
          lualine_z = {
            get_lsp_name,
          },
        },
        inactive_sections = {
          lualine_c = {
            {
              "filename",
              path = 1,
            }
          },
          lualine_x = { "location" },
        },
        extensions = {
          "fugitive",
          "lazy",
          "man",
          "mason",
          "nvim-tree",
          "quickfix",
          "trouble",
        },
      }
    end,
  },
}
