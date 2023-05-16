# margin.nvim

Margin.nvim is a simple nvim extension that lights up the colorcolumn if the 
current line is getting too long. 


## Setup

The setup right now is pretty simple, since it's a function that takes in a 
table with a single argument. 

```lua
require("margin").setup({
    text_width = 80  -- The column where the last character is
})
```
