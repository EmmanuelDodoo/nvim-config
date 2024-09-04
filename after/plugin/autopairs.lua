local auto = require("nvim-autopairs")
local rule = require("nvim-autopairs.rule")

-- Rule for OCaml commenting
auto.add_rules({
    rule("*", "*", "ocaml"),
    rule("<", ">", "rust")
})
