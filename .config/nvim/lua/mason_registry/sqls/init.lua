local Pkg = require("mason-core.package")
local go = require("mason-core.managers.go")

return Pkg.new {
    name = "sqls",
    desc = [[Custom fork of SQL language server written in Go.]],
    homepage = "https://github.com/mvelzel/sqls",
    languages = { Pkg.Lang.SQL },
    categories = { Pkg.Cat.LSP },
    install = go.packages { "github.com/mvelzel/sqls", bin = { "sqls" } },
}
