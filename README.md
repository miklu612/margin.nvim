# margin.nvim

Margin.nvim is a simple nvim extension that lights up the colorcolumn if the 
current line is getting too long, and optionally shows a custom highlight group 
on the offending line.


## Setup

The setup right now is pretty simple, since it's a function that takes in a 
table with a couple of arguments that are relatively simple. 

```lua
require("margin").setup({

    -- The column where the last character is
    text_width = 80,  

    -- Should the plugin check every line or only the current line
    global_margin = true, 

    -- Should the highlighted line be underlined if it is over the text_width
    enable_highlight = false,

    -- Override the default highlight group that is used on the lines that are 
    -- breaking the margin rule.
    highlight_definition = {
        underline = true,
        sp = "#FF0000",
    }
})
```
