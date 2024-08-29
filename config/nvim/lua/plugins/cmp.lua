return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
    },
    opts = function()
      local cmp = require("cmp")

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "buffer" },
        }),
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        window = {
          documentation = {
            max_width = 1,
            max_height = 1,
          },
        },
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      return {
        -- performance = {
        --   fetching_timeout = 50,
        -- },
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body)
          end,
        },
        formatting = {
          format = function(_, vim_item)
            vim_item.abbr = string.sub(vim_item.abbr, 1, 32)
            vim_item.menu = nil
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<c-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
          ["<c-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
          ["<c-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
          ["<c-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
          ["<c-c>"] = cmp.mapping(cmp.mapping.close(), { "i", "c" }),
          ["<cr>"] = cmp.mapping.confirm({ select = false }),
          ["<tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end),
          ["<s-tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            else
              fallback()
            end
          end),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "buffer" },
        }, {
          { name = "path" },
        }),
      }
    end,
  },
}
