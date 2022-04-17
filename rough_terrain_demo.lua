-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=7155s

local SCRIPT_NAME     = 'rough_terrain.lua'
local RUN_INTERVAL_MS = 1000  -- this sampling rate works well SITL wave simulation
local GZ_THRESHOLD    = 0.03  -- this threshold works well with SITL wave simulation

local MAV_SEVERITY_INFO      = 6

-- wrapper for gcs:send_text()
local function gcs_msg(severity, txt)
    gcs:send_text(severity, string.format('%s: %s', SCRIPT_NAME, txt))
end

-- ! setup/initialization logic
local last_z = nil

function update()
    local acc = ahrs:get_accel()
    local z = acc:z()
    if last_z == nil then
        last_z = z
        return update, RUN_INTERVAL_MS
    end
    if math.abs(z - last_z) > GZ_THRESHOLD then
        gcs_msg(MAV_SEVERITY_INFO, 'Impact detected!')
    end
    last_z = z
    gcs:send_named_float('Gz_Lua', z)
    return update, RUN_INTERVAL_MS
end

gcs_msg(MAV_SEVERITY_INFO, 'Initialized.')

return update()
