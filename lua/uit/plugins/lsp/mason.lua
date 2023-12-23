return {
    'williamboman/mason.nvim',
    lazy = true,
    opts = {
        ui = {
            border = 'double',
            size = {
                width = 0.8,
                height = 0.8,
            },
            icons = {
                package_installed = '✓',
                package_pending = '➜',
                package_uninstalled = '✗',
            },
        },
    },
}
