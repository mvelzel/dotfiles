local csharp_ls = {
    name = "csharp_ls"
}

function csharp_ls.setup(config)
    config.handlers = {
        ["textDocument/definition"] = require('csharpls_extended').handler,
    }

    return config
end

return csharp_ls
