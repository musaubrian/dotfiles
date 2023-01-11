require("tokyonight").setup({
    transparent = true, -- Enable this to disable setting the background color
    styles = {
        comments = { italic = true },
        keywords = { italic = false },
        functions = {},
        variables = { italic = true },
        floats = "transparent", -- style for floating windows
    },
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
})

function Mytheme(color)

    color = color or "tokyonight-storm"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end

Mytheme()
