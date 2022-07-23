local g = vim.g

---------> Gruvbox Flat <---------
g.gruvbox_flat_style = "medium"

---------> Airline Theme <-------
g.airline_theme = "gruvbox_material"
-- g.airline_theme = "gruvbox-flat"
-- g.airline_theme = "everforest"

-- Set current theme
vim.cmd [[
    colorscheme gruvbox-flat
"    colorscheme onedarkpro
]]
