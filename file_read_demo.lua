-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=5465s

local SCRIPT_NAME     = 'file_read_demo.lua'
local RUN_INTERVAL_MS = 1000
local FILENAME        = 'scripts/batt.log'

local MAV_SEVERITY_INFO      = 6

-- wrapper for gcs:send_text()
local function gcs_msg(severity, txt)
    gcs:send_text(severity, string.format('%s: %s', SCRIPT_NAME, txt))
end

-- ! setup/initialization logic
local file = io.open(FILENAME, "r")  -- to read
local voltage = 12.6

function update()
    local s = file:read("l")

    -- slight change to YouTube demo - once file is read, terminate the script
    if s == nil then
        file:close()
        gcs_msg(MAV_SEVERITY_INFO, 'Terminated.')
        return
    end
    
    gcs_msg(MAV_SEVERITY_INFO, s)
    return update, RUN_INTERVAL_MS
end

gcs_msg(MAV_SEVERITY_INFO, 'Initialized.')

return update()
