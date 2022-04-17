-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=5465s

local SCRIPT_NAME     = 'file_write_demo.lua'
local RUN_INTERVAL_MS = 3000
local FILENAME        = 'scripts/batt.log'

local MAV_SEVERITY_INFO      = 6

local ROVER_MODE_HOLD         =  4
local ROVER_MODE_AUTO         = 10

-- wrapper for gcs:send_text()
local function gcs_msg(severity, txt)
    gcs:send_text(severity, string.format('%s: %s', SCRIPT_NAME, txt))
end

-- ! setup/initialization logic
local file = io.open(FILENAME, "a")  -- to append
local voltage = 12.6

function update()
    -- fixed this line to work properly (YouTube demo has a logic error)
    if vehicle:get_mode() ~= ROVER_MODE_AUTO then return update, RUN_INTERVAL_MS end

    param:set('SIM_BATT_VOLTAGE', voltage)

    file:write(string.format('BATT: %f\n', voltage))

    if battery:voltage(0) < 10.5 then
        vehicle:set_mode(ROVER_MODE_HOLD)
    end

    voltage = voltage - 0.3

    return update, RUN_INTERVAL_MS
end

gcs_msg(MAV_SEVERITY_INFO, 'Initialized.')

return update()
