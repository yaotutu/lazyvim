local gstatus = { ahead = 0, behind = 0 }
local function update_gstatus()
    local Job = require("plenary.job")
    Job:new({
        command = "git",
        args = { "rev-list", "--left-right", "--count", "HEAD...@{upstream}" },
        on_exit = function(job, _)
            local res = job:result()[1]
            if type(res) ~= "string" then
                gstatus = { ahead = 0, behind = 0 }
                return
            end
            local ok, ahead, behind = pcall(string.match, res, "(%d+)%s*(%d+)")
            if not ok then
                ahead, behind = 0, 0
            end
            gstatus = { ahead = ahead, behind = behind }
        end,
    }):start()
end

if _G.Gstatus_timer == nil then
    _G.Gstatus_timer = vim.loop.new_timer()
else
    _G.Gstatus_timer:stop()
end
_G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        { "dokwork/lualine-ex" },
        { "nvim-lua/plenary.nvim" },
        { "kyazdani42/nvim-web-devicons" },
        "meuter/lualine-so-fancy.nvim",
    },
    event = "VeryLazy",
    opts = function(_, opts)
        opts.sections.lualine_b = {
            "ex.git.branch",
            {
                function()
                    return gstatus.ahead .. " " .. gstatus.behind .. ""
                end,
            },
            "diff",
            "diagnostics",
            "fancy_macro",
        }
    end,
}
