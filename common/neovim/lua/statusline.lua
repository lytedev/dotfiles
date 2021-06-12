-- TODO: make override-able
vim.g.status_line_max_length = 5

-- TODO: only update this portion when needed instead of every render?

function StatusLineBufferByNum(bufnum)
	local bufinfo = vim.fn.getbufinfo(bufnum)
	local prefix = ' %#InactiveBuffer#'
	local suffix = '%* '

	if bufinfo.changed then
		prefix = '%#DirtyBuffer# '
		suffix = ' %*'
	end

	if bufinfo.hidden == 0 and vim.fn.index(bufinfo.windows, vim.g.statusline_winid) >= 0 then
		prefix = '%#ActiveBuffer# '
		suffix = ' %*'
		if bufinfo.changed then
			prefix = '%#ActiveBuffer# *'
			suffix = ' %*'
		end
	end

	return prefix..vim.fn.fnamemodify(vim.fn.bufname(bufnum), ':t')..suffix
end

function StatusLineBuffers()
	-- TODO: mark buffers with unsaved changes

	local active_index = -1
	local acc = {}
	for _,bufnum in ipairs(vim.api.nvim_list_bufs()) do
		local bufinfo = vim.fn.getbufinfo(bufnum)
		if bufinfo.listed ~= 0 then
			local entry = StatusLineBufferByNum(bufnum)
			table.insert(acc, entry)
			if vim.fn.matchstr(entry, '^%#ActiveBuffer#') then
				active_index = vim.fn.index(acc, entry)
			end
		end
	end
	if active_index >= 0 then
		-- TODO: instead implement this as a wraparound carousel?
		local offset = vim.g.status_line_max_length / 2
		local min_buf_num = math.max(0, (active_index - offset))
		local max_buf_num = math.min(#acc - 1, min_buf_num + vim.g.status_line_max_length - 1)
		min_buf_num = math.max(0, max_buf_num - vim.g.status_line_max_length + 1)
		local buflist = table.concat({unpack(acc, min_buf_num, max_buf_num)}, '')
		local prefix = ''
		local suffix = ''
		if min_buf_num > 0 then
			prefix = '< '
		end
		if max_buf_num < (#acc - 1) then
			suffix = ' >'
		end
		return prefix..buflist..suffix
	else
		return table.concat(acc, '')
	end
end

function StatusLine()
	return StatusLineBuffers()..'%*%=%c,%l/%L (%p%%)'
end

return {
	setup=function()
		vim.o.statusline = ''..StatusLine()
	end
}
