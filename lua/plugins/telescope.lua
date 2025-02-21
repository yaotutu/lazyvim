return {
    'nvim-telescope/telescope.nvim',
    opts = function(_, opts)
        opts.defaults = opts.defaults or {}
        opts.defaults.mappings = opts.defaults.mappings or {}
        opts.defaults.mappings.i = {
            -- 上下移动
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            -- 历史记录
            -- ["<C-n>"] = "cycle_history_next",
            -- ["<C-p>"] = "cycle_history_prev",
            -- 关闭窗口
            ["<Esc>"] = "close",
            -- 预览窗口上下滚动
            ["<C-u>"] = "preview_scrolling_up",
            ["<C-d>"] = "preview_scrolling_down",
        }
    end,
}
