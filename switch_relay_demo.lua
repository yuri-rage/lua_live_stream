-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=2858s
-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=3359s

local SCRIPT_NAME     = 'switch_relay_demo.lua'
local RUN_INTERVAL_MS = 200
local RC_OPTION       = 300

local MAV_SEVERITY_INFO      = 6

-- wrapper for gcs:send_text()
local function gcs_msg(severity, txt)
    gcs:send_text(severity, string.format('%s: %s', SCRIPT_NAME, txt))
end

-- ! setup/initialization logic
local rc_chan = rc:find_channel_for_option(RC_OPTION)
local last_sw_pos = nil

function update()
    local sw_pos = rc_chan:get_aux_switch_pos()  -- returns 0, 1, or 2

    -- added this line to make things cleaner than YouTube demo script
    if sw_pos == last_sw_pos then return update, RUN_INTERVAL_MS end

    if sw_pos == 0 then
        relay:off(0)
        gcs_msg(MAV_SEVERITY_INFO, 'Relay off')
    else
        relay:on(0)
        gcs_msg(MAV_SEVERITY_INFO, 'Relay on')
    end

    last_sw_pos = sw_pos

    return update, RUN_INTERVAL_MS
end

gcs_msg(MAV_SEVERITY_INFO, 'Initialized.')

return update()
