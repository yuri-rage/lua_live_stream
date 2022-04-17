-- this is not a complete script - just some code snippets

-- ! start Mission Planner SITL at a specific location
--        lat        lon        alt hdg
-- --home=-35.363261,149.165230,584,353

-- ! RC pwm
local RC_CHAN = 8
local rc_pwm = rc:get_pwm(RC_CHAN)

-- ! 2 or 3 position switch
local RC_OPTION = 300
local rc_chan = rc:find_channel_for_option(RC_OPTION)
local sw_pos = rc_chan:get_aux_switch_pos()  -- returns 0, 1, or 2

-- ! relay control
local RELAY_NUM = 1
relay:on(RELAY_NUM)
relay:off(RELAY_NUM)

-- ! servo pwm
local SERVO_FN = 94
local srv_pwm = SRV_Channels:get_output_pwm(SERVO_FN)
SRV_Channels:set_output_pwm(SERVO_FN, srv_pwm)

-- ! parameter get/set
local mode_channel = param:get("MODE_CH")
param:set("MODE_CH", mode_channel)  -- does not persist after reboot
param:set_and_save("MODE_CH", mode_channel)  -- persists after reboot

-- ! a few ahrs bindings
local ahrs_state = ahrs:healthy()  -- boolean
local current_posit = ahrs:get_location()  -- Location object
local accel = ahrs:get_accel()  -- Vector3f
local x_acc = accel:x()
local y_acc = accel:y()
local z_acc = accel:z()
local gyro = ahrs:get_gyro()  -- Vector3f
local roll_rate = gyro.x()
local pitch_rate = gyro.y()
local yaw_rate = gyro.z()

-- ! basic file I/O
local FILENAME = 'demo_file.txt'
local file = io.open(FILENAME, "r")
local line = file:read("l")  -- read line, returns nil if EOF
file:close()
file = io.open(FILENAME, "a")
file:write(line ..'\n')
file:close()
