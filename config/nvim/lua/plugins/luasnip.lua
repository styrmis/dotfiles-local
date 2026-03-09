return {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  config = function()
    local ls = require("luasnip")
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local fmt = require("luasnip.extras.fmt").fmt

    -- Load friendly-snippets
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Custom Ruby snippets
    ls.add_snippets("ruby", {
      -- RSpec snippets
      s("desc", fmt("describe '{}' do\n  {}\nend", { i(1, "description"), i(0) })),
      s("cont", fmt("context '{}' do\n  {}\nend", { i(1, "context"), i(0) })),
      s("it", fmt("it '{}' do\n  {}\nend", { i(1, "does something"), i(0) })),
      s("bef", fmt("before do\n  {}\nend", { i(0) })),
      s("aft", fmt("after do\n  {}\nend", { i(0) })),
      s("let", fmt("let(:{}) {{ {} }}", { i(1, "name"), i(2) })),
      s("subj", fmt("subject {{ {} }}", { i(0) })),
      
      -- Rails snippets
      s("bt", t("belongs_to :")),
      s("ho", t("has_one :")),
      s("hm", t("has_many :")),
      s("vp", t("validates_presence_of :")),
      
      -- General Ruby snippets
      s("defi", fmt("def initialize({})\n  {}\nend", { i(1), i(0) })),
      s("defs", fmt("def self.{}({})\n  {}\nend", { i(1, "method_name"), i(2), i(0) })),
      s("mod", fmt("module {}\n  {}\nend", { i(1, "ModuleName"), i(0) })),
      s("cla", fmt("class {}\n  {}\nend", { i(1, "ClassName"), i(0) })),
      s("attr", fmt("attr_{} :{}", { i(1, "reader"), i(2, "name") })),
      s("req", fmt("require '{}'", { i(1, "library") })),
      s("reqr", fmt("require_relative '{}'", { i(1, "file") })),
    })

    -- Configure LuaSnip
    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })

    -- Key mappings for snippet navigation
    vim.keymap.set({"i", "s"}, "<C-k>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, {silent = true})

    vim.keymap.set({"i", "s"}, "<C-j>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, {silent = true})
  end
}