local Margin = {
    text_width = 80
}

function Margin.Enable()
    vim.api.nvim_win_set_option(0, "colorcolumn", tostring(Margin.text_width))
end

function Margin.Disable()
    vim.api.nvim_win_set_option(0, "colorcolumn", "0")
end

-- Checks if the line is long enough to warrant the margin to be enabled
function Margin.EnableIfRequired(line)
    if #line > Margin.text_width then
        print("enabled")
        Margin.Enable()
    else
        Margin.Disable()
    end
end

function Margin.CheckCurrentLine() 
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local row_nr = cursor_pos[1]
    local row = vim.api.nvim_buf_get_lines(0, row_nr-1, row_nr, true)[1]
    Margin.EnableIfRequired(row)
end

function Margin.setup(options)

    if options.text_width ~= nil then
        Margin.text_width = options.text_width
    end

    vim.api.nvim_create_autocmd(
        {"TextChangedI", "TextChanged"},
        {
            callback = function() 
                Margin.CheckCurrentLine()
            end
        }
    )
end


return Margin
