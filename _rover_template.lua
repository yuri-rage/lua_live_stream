local SCRIPT_NAME     = '_rover_template.lua'
local RUN_INTERVAL_MS = 200

-- https://mavlink.io/en/messages/common.html#MAV_SEVERITY
local MAV_SEVERITY_EMERGENCY = 0
local MAV_SEVERITY_ALERT     = 1
local MAV_SEVERITY_CRITICAL	 = 2
local MAV_SEVERITY_ERROR     = 3
local MAV_SEVERITY_WARNING   = 4
local MAV_SEVERITY_NOTICE    = 5
local MAV_SEVERITY_INFO      = 6
local MAV_SEVERITY_DEBUG     = 7

-- https://mavlink.io/en/messages/ardupilotmega.html#ROVER_MODE
local ROVER_MODE_MANUAL       =  0
local ROVER_MODE_ACRO         =  1
local ROVER_MODE_STEERING     =  3
local ROVER_MODE_HOLD         =  4
local ROVER_MODE_LOITER       =  5
local ROVER_MODE_FOLLOW       =  6
local ROVER_MODE_SIMPLE       =  7
local ROVER_MODE_AUTO         = 10
local ROVER_MODE_RTL          = 11
local ROVER_MODE_SMART_RTL    = 12
local ROVER_MODE_GUIDED       = 15
local ROVER_MODE_INITIALIZING = 16

-- wrapper for gcs:send_text()
local function gcs_msg(severity, txt)
    gcs:send_text(severity, string.format('%s: %s', SCRIPT_NAME, txt))
end

-- ! setup/initialization logic

function update()
    -- ! loop logic
    return update, RUN_INTERVAL_MS
end

gcs_msg(MAV_SEVERITY_INFO, 'Initialized.')

return update()
