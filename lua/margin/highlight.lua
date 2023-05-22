
local Highlight = {
    ns_id = vim.api.nvim_create_namespace("margin.nvim.highlight"),
}

function Highlight.Set(row)
    print(col)
    local id = vim.api.nvim_buf_set_extmark(0, Highlight.ns_id, row-1, 0, {
        hl_group = "MarginLineTooLong",
        hl_eol = true,
        end_row = row
    })
end


function Highlight.Clear()
    vim.api.nvim_buf_clear_namespace(
        0, 
        Highlight.ns_id,
        0,
        -1
    )
end

function Highlight.Init()
    vim.api.nvim_set_hl(
        0,
        "MarginLineTooLong",
        {
            underline = true,
            sp = "#FF0000",
            blend = 100,
        }
    )
end

return Highlight
