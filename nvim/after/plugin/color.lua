require("catppuccin").setup({
    flavour = "macchiato", -- latte, frappe, macchiato, mocha
    transparent_background = true,
    show_end_of_buffer = false, -- show the '~' characters after the end of buffers
    term_colors = true, 
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    color_overrides = {},
    custom_highlights = {},
})

function Mytheme()

    local color = "catppuccin"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"} )
end

Mytheme()
