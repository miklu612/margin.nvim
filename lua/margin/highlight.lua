
local Highlight = {
    ns_id = vim.api.nvim_create_namespace("margin.nvim.highlight"),
}

-- Enables the highlighting for the given row number
function Highlight.Set(row)
    local id = vim.api.nvim_buf_set_extmark(0, Highlight.ns_id, row-1, 0, {
        hl_group = "MarginLineTooLong",
        hl_eol = true,
        end_row = row
    })
end


-- Clears all of the highlighting that is currently in use
function Highlight.Clear()
    vim.api.nvim_buf_clear_namespace(
        0, 
        Highlight.ns_id,
        0,
        -1
    )
end

-- Just creates the highlighting group that is used to underline the offending 
-- lines
function Highlight.Init(hl_definition)
    vim.api.nvim_set_hl(
        0,
        "MarginLineTooLong",
        hl_definition
    )
end

return Highlight
