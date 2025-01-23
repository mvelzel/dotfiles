local terraformls = {
    name = "terraformls"
}

function terraformls.setup(config)
    config.filetypes = { 'terraform', 'terraform-vars', 'hcl' }

    return config
end

return terraformls
