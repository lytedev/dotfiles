#!/usr/bin/env moon

scheme_file = "donokai"
template_file = [
	"shell"
]

scheme = require(scheme_file)!

scheme.meta = scheme.meta || {}
scheme.meta.author = scheme.meta.author || "Unknown Author"
scheme.meta.name = scheme.meta.name || "Unnamed Color Scheme"

for f in template_files
	template_data = require(t)!

	colors = scheme.colors
	if "function" == type template_data.color_map
		colors = {template_data.color_map(k, v) for k, v in pairs(colors)}

