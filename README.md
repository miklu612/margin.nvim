# margin.nvim

Margin.nvim is a simple nvim extension that lights up the colorcolumn if the 
current line is getting too long. 


## Setup

The setup right now is pretty simple, since it's a function that takes in a 
table with a couple of arguments that are relatively simple. 

```lua
require("margin").setup({

    -- The column where the last character is
    text_width = 80,  

    -- Should the plugin check every line or only the current line
    global_margin = true, 
})
```
