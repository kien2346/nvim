local on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]h", function()
        if vim.wo.diff then return "]h" end
        vim.schedule(function() gs.next_hunk() end)
        return "<Ignore>"
    end, { expr = true })

    map("n", "[h", function()
        if vim.wo.diff then return "[h" end
        vim.schedule(function() gs.prev_hunk() end)
        return "<Ignore>"
    end, { expr = true })

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk)
    map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
    map("n", "<leader>hS", gs.stage_buffer)
    map("n", "<leader>hx", gs.reset_hunk)
    map("v", "<leader>hx", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end)
    map("n", "<leader>hX", gs.reset_buffer)

    map("n", "<leader>hu", gs.undo_stage_hunk)
    map("n", "<leader>hp", gs.preview_hunk)
    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end)
    map("n", "<leader>hd", gs.diffthis)
    map("n", "<leader>hD", function() gs.diffthis("~") end)
    -- map("n", "<leader>tb", gs.toggle_current_line_blame)
    -- map("n", "<leader>td", gs.toggle_deleted)

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
end

return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
            follow_files = true,
        },
        on_attach = on_attach,
    },
}
