local SCRIPT_NAME     = '_plane_template.lua'
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

-- https://mavlink.io/en/messages/ardupilotmega.html#PLANE_MODE
local PLANE_MODE_MANUAL        =  0
local PLANE_MODE_CIRCLE        =  1
local PLANE_MODE_STABILIZE     =  2
local PLANE_MODE_TRAINING      =  3
local PLANE_MODE_ACRO          =  4
local PLANE_MODE_FLY_BY_WIRE_A =  5
local PLANE_MODE_FLY_BY_WIRE_B =  6
local PLANE_MODE_CRUISE        =  7
local PLANE_MODE_AUTOTUNE      =  8
local PLANE_MODE_AUTO          = 10
local PLANE_MODE_RTL           = 11
local PLANE_MODE_LOITER        = 12
local PLANE_MODE_TAKEOFF       = 13
local PLANE_MODE_AVOID_ADSB    = 14
local PLANE_MODE_GUIDED        = 15
local PLANE_MODE_INITIALIZING  = 16
local PLANE_MODE_QSTABILIZE    = 17
local PLANE_MODE_QHOVER        = 18
local PLANE_MODE_QLOITER       = 19
local PLANE_MODE_QLAND         = 20
local PLANE_MODE_QRTL          = 21
local PLANE_MODE_QAUTOTUNE     = 22
local PLANE_MODE_QACRO         = 23
local PLANE_MODE_THERMAL       = 24

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
