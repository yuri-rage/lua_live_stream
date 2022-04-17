-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=4343s
-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=4544s
-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=5095s

local SCRIPT_NAME     = 'batt_param_mode_demo.lua'
local RUN_INTERVAL_MS = 3000

local MAV_SEVERITY_INFO      = 6

local ROVER_MODE_HOLD         =  4
local ROVER_MODE_AUTO         = 10

-- wrapper for gcs:send_text()
local function gcs_msg(severity, txt)
    gcs:send_text(severity, string.format('%s: %s', SCRIPT_NAME, txt))
end

-- ! setup/initialization logic
local voltage = 12.6

function update()
    param:set('SIM_BATT_VOLTAGE', voltage)

    -- fixed this line to work properly (YouTube demo has a logic error)
    if vehicle:get_mode() ~= ROVER_MODE_AUTO then return update, RUN_INTERVAL_MS end

    if mission:state() == mission.MISSION_COMPLETE then return update, RUN_INTERVAL_MS end

    if battery:voltage(0) < 10.5 then
        vehicle:set_mode(ROVER_MODE_HOLD)
    end

    voltage = voltage - 0.3

    return update, RUN_INTERVAL_MS
end

gcs_msg(MAV_SEVERITY_INFO, 'Initialized.')

return update()
