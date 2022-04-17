-- https://www.youtube.com/watch?v=UdXGXjigxAo&t=2493s

function ahrs_good()
    if not ahrs:healthy() then return do_transition, 1000 end
    gcs:send_text(6, 'Hello world!')
    return ahrs_good, 2000
end

function ahrs_bad()
    if ahrs:healthy() then return do_transition, 2000 end
    gcs:send_text(6, 'A little under the weather!')
    return ahrs_bad, 1000
end

function do_transition()
    if ahrs:healthy() then
        return ahrs_good, 2000
    end
    return ahrs_bad, 1000
end

return do_transition()
