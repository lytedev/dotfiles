#!/usr/bin/env moon

archive_name = "#{string.gsub arg[1], "(.*/)(.*)", "%2"}.tar.zstd"
os.execute "tar --zstd -cvf '#{archive_name}' '#{table.concat arg, "' '"}'"
print "Archive created at: #{archive_name}"
