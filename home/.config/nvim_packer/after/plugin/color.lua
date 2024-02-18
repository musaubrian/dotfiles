require("catppuccin").setup({
    flavour = "frappe",        -- latte, frappe, macchiato, mocha
    transparent_background = true,
    show_end_of_buffer = true, -- show the '~' characters after the end of buffers
    term_colors = true,
    no_italic = false,         -- Force no italic
    no_bold = false,           -- Force no bold
    color_overrides = {},
    styles = {
        conditionals = { "bold" },
        comments = { "italic" },
    },
    integrations = {
        native_lsp = {
            enabled = true,
            virtual_text = {
                hints = { "italic" },
                errors = { "italic" },
                warnings = { "italic" },
                information = { "italic" },
            },
        },
    },
})

function Mytheme()
    local color = "catppuccin"
    -- local color = "default"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

Mytheme()
