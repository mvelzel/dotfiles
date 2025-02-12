local ts_ls = {
    name = "ts_ls"
}

function ts_ls.setup(config)
    local default_on_attach = config.on_attach

    config.on_attach = function(client, bufnr)
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false

        default_on_attach(client, bufnr)
    end

    return config
end

return ts_ls
