local fn = vim.fn
local api = vim.api
local status_line_max_length = 5

-- TODO: only update this portion when needed instead of every render?
local status_line_buffer_by_num = function(bufnum)
	local is_active = false
	local bufinfo = fn.getbufinfo(bufnum)[1]
	local prefix = ' %#InactiveBuffer#'
	local suffix = '%* '

	if bufinfo.changed == 1 then
		prefix = '%#DirtyBuffer# '
		suffix = ' %*'
	end

	local windex = fn.index(bufinfo.windows, vim.g.statusline_winid)
	if bufinfo.hidden and windex >= 0 then
		is_active = true
		prefix = '%#ActiveBuffer# '
		suffix = ' %*'
		if bufinfo.changed == 1 then
			prefix = '%#ActiveDirtyBuffer# *'
			suffix = ' %*'
		end
	end

	return (prefix .. fn.fnamemodify(fn.bufname(bufnum), ':t') .. suffix), is_active
end

local status_line_buffers = function()
	-- TODO: mark buffers with unsaved changes

	local active_index = -1
	local acc = {}
	for _,bufnum in ipairs(api.nvim_list_bufs()) do
		local bufinfo = fn.getbufinfo(bufnum)[1]
		if bufinfo.listed ~= 0 then
			local entry, is_active = status_line_buffer_by_num(bufnum)
			table.insert(acc, entry)
			if is_active then
				active_index = #acc
			end
		end
	end
	if active_index >= 0 then
		-- TODO: instead implement this as a wraparound carousel?
		local offset = status_line_max_length / 2
		local min_buf_num = math.max(0, (active_index - offset))
		local max_buf_num = math.min(#acc - 1, min_buf_num + status_line_max_length - 1)
		min_buf_num = math.max(0, max_buf_num - status_line_max_length + 1)
		local buflist = table.concat({unpack(acc, min_buf_num+1, max_buf_num+1)}, '')
		local prefix = ''
		local suffix = ''
		if min_buf_num > 0 then
			prefix = '< '
		end
		if max_buf_num < (#acc - 1) then
			suffix = ' >'
		end
		return prefix .. buflist .. suffix
	else
		local suffix = ''
		if #acc - 1 >status_line_max_length then
			suffix = ' >'
		end
		local buflist = table.concat({unpack(acc, 1, math.min(#acc, status_line_max_length))}, '')
		return buflist .. suffix .. active_index
	end
end

local whitespace = function()
	local result = ""
	if vim.o.expandtab == true then
		result = result .. vim.o.shiftwidth .. "S"
	else
		result = result .. vim.o.tabstop .. "T"
	end
	return result
end

function StatusLine()
	return status_line_buffers() .. '%*%=%{&filetype} %l;%c (%p%%/%L) ' .. whitespace()
end

vim.o.statusline = '%!v:lua.StatusLine()'
