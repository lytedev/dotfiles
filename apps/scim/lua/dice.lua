local os = require "os"
local math = require "math"

math.randomseed(os.clock())

function table.tostring(self, indent, done)
	local result = ""
	done = done or {}
	indent = indent or 0
	if type(self) == "table" then
		for key, value in pairs(self) do
			result = result .. string.rep(" ", indent)
			if type(value) == "table" and not done[value] then
				done[value] = true
				result = result ..
					string.format(
						"[%s] => table\n",
						tostring(key)
					) ..
					"{\n" ..
					table.tostring(value, indent + 2, done) ..
					"}\n"
			else
				result = result ..
					string.format("[%s] => %s\n",
						tostring(key),
						tostring(value)
					)
			end
		end
	else
		result = result .. self .. "\n"
	end
	return result
end

function log(s)
	s = "[timestamp: " .. tostring(os.time()) .. "]\n" .. s
	local out = s:gsub("\n", "\n  ")
	local file = io.open("/tmp/sc-im-dice.log", "a+")
	file:write("\n")
	file:write(out)
	io.close(file)
end

local dstr_matcher = "(%d*)d(%d+)"

function dstr(n, s, fl)
	n = tonumber(n) or 1
	local sum = 0
	for di = 1, n do
		sum = sum + math.random(1, tonumber(s))
	end
	return sum
end

function rolls(s)
	local pieces = {}
	for nd, ds in s:gmatch(dstr_matcher) do
		local sum = dstr(tonumber(nd), tonumber(ds))
		pieces[#pieces+1] = {
			tostring(nd) .. "d" .. tostring(ds),
			tostring(sum)
		}
	end
	return pieces
end

function replacerolls(s, rolls)
	local result = s
	for k, n in ipairs(rolls) do
		result = result:gsub(n[1], n[2], 1)
	end
	return result
end

function evalreturn(s)
	local f = loadstring("return " .. s)
	return f()
end

function sc_parserollstr(s)
	local r = rolls(s)
	log(table.tostring(r))
	return evalreturn(replacerolls(s, r))
end

function sc_rollres(c, r)
	local os = require "os"
	local seed = (os.time() + os.clock()) * 10000000
	math.randomseed(seed)
	log("Setting Seed: " .. tostring(seed))
	local sum = sc_parserollstr(sc.lgetstr(c, r))
	sc.lsetnum(c + 1, r, sum)
end
