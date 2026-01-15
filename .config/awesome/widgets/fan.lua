-------------------------------------------------
-- fan speed arc widget for Awesome Window Manager
-- requires - thinkpad_acpi kernel module
-- author @s3mer
-------------------------------------------------

local awful     = require("awful")
local beautiful = require("beautiful")
local wibox     = require("wibox")
local watch     = require("awful.widget.watch")
local naughty   = require("naughty")

local fan_widget = {}

local function worker()

    local timeout = 1
    local arc_thickness = 2
    local size = 22
    local arc_color = '#6A1B9A'
    local bg_color = '#ffffff11'
    local path_to_icon = '/usr/share/icons/Papirus/24x24/panel/indicator-sensors-fan.svg'
    local current_level = 0
    local get_fan_speed_cmd = "awk '/speed:/ { print $2 }' /proc/acpi/ibm/fan"
    local fan_status = "head -3 /proc/acpi/ibm/fan"
    local notification_position = 'top_right' -- see naughty.notify position argument
    local show_notification_mode = 'on_hover' -- on_hover / on_click

    fan_widget = wibox.widget {
        {
            {
                image = path_to_icon,
                resize = true,
                widget = wibox.widget.imagebox,
            },
            valign = 'center',
            layout = wibox.container.place
        },
        min_value = 0,
        max_value = 3428, -- max rpm for my T470p
        thickness = arc_thickness,
        start_angle = 4.71238898, -- 2pi*3/4
        forced_height = size,
        forced_width = size,
        paddings = 2,
        colors = { arc_color },
        bg = bg_color,
        widget = wibox.container.arcchart,
        set_value = function(self, level)
            self:set_value(level)
        end
    }

    local update_widget = function(widget, stdout, _, _, _)
        local fan_level = tonumber(stdout:match("%d+"))
        current_level = fan_level
        widget:set_value(fan_level)
    end

    watch(get_fan_speed_cmd, timeout, update_widget, fan_widget)

    -- Popup with fan info
    local notification
    local function show_fan_status()
        awful.spawn.easy_async(fan_status,
                function(stdout, _, _, _)
                    naughty.destroy(notification)
                    notification = naughty.notify {
                        text = stdout,
                        title = "Fan status",
                        timeout = 5,
                        width = 250,
                        position = notification_position,
                    }
                end)
    end

    if show_notification_mode == 'on_hover' then
        fan_widget:connect_signal("mouse::enter", function() show_fan_status() end)
        fan_widget:connect_signal("mouse::leave", function() naughty.destroy(notification) end)
    elseif show_notification_mode == 'on_click' then
        fan_widget:connect_signal('button::press', function(_, _, _, button)
            if (button == 1) then show_fan_status() end
        end)
    end

    return fan_widget
end

return setmetatable(fan_widget, { __call = function(_, ...)
    return worker(...)
end })
