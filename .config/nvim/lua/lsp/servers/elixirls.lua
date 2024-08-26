local elixirls = {
    name = "elixirls",
    disable = true
}

function elixirls.setup(config)
    config.cmd = { "/home/mvelzel/.local/share/nvim/mason/bin/elixir-ls" }
    config.settings = {
        elixirLS = {
            dialyzerEnabled = false,
            enableTestLenses = true
        }
    }

    return config
end

return elixirls
