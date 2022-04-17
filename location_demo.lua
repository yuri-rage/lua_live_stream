-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=3668s

local SCRIPT_NAME     = 'location_demo.lua'
local RUN_INTERVAL_MS = 1000

local MAV_SEVERITY_INFO      = 6

-- wrapper for gcs:send_text()
local function gcs_msg(severity, txt)
    gcs:send_text(severity, string.format('%s: %s', SCRIPT_NAME, txt))
end

-- ! setup/initialization logic
local last_posit = nil

function update()
    if not ahrs:healthy() then return update, RUN_INTERVAL_MS end

    local current_posit = ahrs:get_location()
    if last_posit == nil then
        last_posit = current_posit
        return update, RUN_INTERVAL_MS
    end

    if current_posit:get_distance(last_posit) > 1 then
        gcs_msg(MAV_SEVERITY_INFO, 'Moved more than 1m!')
    end
    last_posit = current_posit
    return update, RUN_INTERVAL_MS
end

gcs_msg(MAV_SEVERITY_INFO, 'Initialized.')

return update()
