local docs = require("utils.docs")

describe("utils.docs", function()
    it("exposes a docs URL", function()
        assert.is_string(docs.url)
        assert.is_true(docs.url:match("^https?://") ~= nil)
    end)

    it("has an open() function", function()
        assert.is_function(docs.open)
    end)

    it("default URL targets the VitePress site", function()
        assert.equals("https://yashksaini-coder.github.io/nvim/", docs.url)
    end)
end)
