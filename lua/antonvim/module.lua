-- module represents a lua module for the plugin
local M = {}
local antovim_definitions = {
	{
		values = { "div", "span" },
		types = { "html", "ejs" },
	},
	{
		values = { "upper", "lower" },
		types = { "css", "less" },
	},
	{
		values = { "top", "bottom", "left", "right" },
		types = { "css", "less" },
	},
	{
		values = { "block", "inline-block", "inline", "none" },
		types = { "css", "less" },
	},
	{
		values = { "absolute", "fixed", "relative", "static" },
		types = { "css", "less" },
	},
	{
		values = { "px", "em", "rem", "%" },
		types = { "css", "less" },
	},
	{ values = { "acquire", "release" } },
	{ values = { "add", "remove" } },
	{ values = { "advance", "retreat" } },
	{ values = { "allocate", "deallocate" } },
	{ values = { "allow", "deny" } },
	{ values = { "assemble", "disassemble" } },
	{ values = { "assign", "deassign" } },
	{ values = { "associate", "dissociate" } },
	{ values = { "attach", "detach" } },
	{ values = { "begin", "end" } },
	{ values = { "bind", "unbind" } },
	{ values = { "commit", "rollback" } },
	{ values = { "compile", "decompile" } },
	{ values = { "compose", "parse" } },
	{ values = { "compress", "decompress" } },
	{ values = { "connect", "disconnect" } },
	{ values = { "construct", "destruct" } },
	{ values = { "create", "destroy" } },
	{ values = { "do", "undo" } },
	{ values = { "enable", "disable" } },
	{ values = { "encode", "decode" } },
	{ values = { "encrypt", "decrypt" } },
	{ values = { "enqueue", "dequeue" } },
	{ values = { "enter", "leave" } },
	{ values = { "expand", "collapse" } },
	{ values = { "first", "last" } },
	{ values = { "freeze", "unfreeze" } },
	{ values = { "front", "back" } },
	{ values = { "get", "set" } },
	{ values = { "grant", "revoke" } },
	{ values = { "head", "tail" } },
	{ values = { "high", "low" } },
	{ values = { "import", "export" } },
	{ values = { "include", "exclude" } },
	{ values = { "increase", "decrease" } },
	{ values = { "increment", "decrement" } },
	{ values = { "indent", "dedent" } },
	{ values = { "inflate", "deflate" } },
	{ values = { "inject", "eject" } },
	{ values = { "input", "output" } },
	{ values = { "insert", "delete" } },
	{ values = { "install", "uninstall" } },
	{ values = { "left", "right" } },
	{ values = { "Left", "Right" } },
	{ values = { "link", "unlink" } },
	{ values = { "load", "unload" } },
	{ values = { "lock", "unlock" } },
	{ values = { "maximum", "minimum" } },
	{ values = { "new", "old" } },
	{ values = { "next", "previous" } },
	{ values = { "open", "close" } },
	{ values = { "off", "on" } },
	{ values = { "paste", "cut" } },
	{ values = { "push", "pop" } },
	{ values = { "read", "write" } },
	{ values = { "reference", "dereference" } },
	{ values = { "register", "deregister" } },
	{ values = { "resume", "suspend" } },
	{ values = { "select", "deselect" } },
	{ values = { "send", "receive" } },
	{ values = { "serialize", "deserialize" } },
	{ values = { "set", "unset" } },
	{ values = { "set", "up tear down" } },
	{ values = { "show", "hide" } },
	{ values = { "start", "stop" } },
	{ values = { "true", "false" } },
	{ values = { "True", "False" } },
	{ values = { "TRUE", "FALSE" } },
	{ values = { "up", "down" } },
	{ values = { "Up", "Down" } },
}

	
-- table 中是否含有value,
-- table为nil      @return true
-- table含有value  @return ture
local function table_has_some_value(table, value)
	if type(table) == "table" then
		for _, v in ipairs(table) do
			if v == value then
				return true
			end
		end
		return false
	else
		return true
	end
end

-- 从数组中拿出value的下一个值,value为末尾那么就去开头找
local function take_value_next(array, value)
	for i, v in ipairs(array) do
		if v == value then
			-- 把index+1 赋值到当前的word
			local value_next = array[i + 1]
			if value_next == nil then
				value_next = array[1]
			end
			return value_next
		end
	end
	return nil
end

function M.antovim()
	-- 拿到当前光标位置的单词
	local world = vim.fn.expand("<cword>")
	local ft = vim.bo.filetype
	for _, item in ipairs(antovim_definitions) do
		local types = item.types
		local canChange = table_has_some_value(types, ft)
		if canChange then
			local replacement = take_value_next(item.values, world)
			if replacement ~= nil then
				-- 替换当前的单词, 有个问题是这地方会进入插入模式
				-- vim.api.nvim_feedkeys("ciw" .. new, "n", false)
				vim.cmd(string.format("normal! ciw%s", replacement))
			end
		end
	end
end

return M
