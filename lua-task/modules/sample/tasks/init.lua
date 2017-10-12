#!/usr/bin/lua

msg = function() local message = os.getenv('PT_message'); return message end

print(msg())
