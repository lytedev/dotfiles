function NeatFoldText()
	-- TODO: finish this!
	-- local lines_count = vim.foldend - vim.foldstart + 1
	-- local foldchar = vim.fn.matchstr(vim.fillchars, 'fold:\\zs.')
	-- local foldtextstart = vim.fn.strpart('^' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
	-- let foldtextend = printf("%s %".(winwidth(0)-20)."dL", foldtextstart, getline(v:foldstart), lines_count)
	-- let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
	-- return printf("%s%d", substitute(getline(v:foldstart), "^.", ">"), lines_count)
end
-- set foldtext=NeatFoldText()

return {setup = function() end}
