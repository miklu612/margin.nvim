
local Highlight = require("margin.highlight")

local Margin = {

    -- At what column should the margin be activated. This is inclusive, so the 
    -- actual limit is text_width+1
    text_width = 80,

    -- Should we check every line, or only the current line
    -- true : check every
    -- false : check only the current
    global_margin = false,

    -- Should the rule breaking line be highlighted, or not. Note: This
    -- current only works with the global margin
    -- true : highlight the lines that are over the text_width
    -- false : Don't highlight the lines that are over the text_width
    enable_highlight = false
}

-- Enables the margin
function Margin.Enable()
    vim.api.nvim_win_set_option(0, "colorcolumn", tostring(Margin.text_width))
end

-- Disables the margin
function Margin.Disable()
    vim.api.nvim_win_set_option(0, "colorcolumn", "0")
end

-- Checks if the line is long enough to warrant the margin to be enabled
function Margin.EnableIfRequired(line)
    if #line > Margin.text_width then
        Margin.Enable()
    else
        Margin.Disable()
    end
end

function Margin.CheckGlobalMargin()

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, true)

    Margin.Disable()

    if Margin.enable_highlight then
        Highlight.Clear()
    end

    for index, line in pairs(lines) do
        if #line > Margin.text_width then
            Margin.Enable()

            if Margin.enable_highlight then
                Highlight.Set(index)
            else 
                -- If the margin highlighting is not enabled we don't have to 
                -- check more lines.
                break
            end
        end
    end


end

-- Gets the current line, and runs `Margin.EnableIfRequired` which checks should
-- the margin be enabled
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

    if options.global_margin ~= nil then
        Margin.global_margin = options.global_margin
    end

    if options.enable_highlight ~= nil then
        Margin.enable_highlight = options.enable_highlight
    end

    vim.api.nvim_create_autocmd(
        {"TextChangedI", "TextChanged"},
        {
            callback = function() 
                if Margin.global_margin == false then
                    Margin.CheckCurrentLine()
                else
                    Margin.CheckGlobalMargin()
                end
            end
        }
    )

    Highlight.Init()

end


return Margin
