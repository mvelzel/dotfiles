local elixirls = {
    name = "elixirls"
}

function elixirls.setup(config)
    config.cmd = { "/home/mvelzel/.local/share/nvim/mason/bin/elixir-ls" }

    return config
end

return elixirls
