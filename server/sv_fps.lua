local render_distance_enabled = false
local render_distance = 5.0
local shadow_enabled = false
local shadow_shit = 5.0

local function startRenderThread()
    CreateThread(function()
        while render_distance_enabled do
            Wait(0)
            SetLightsCutoffDistanceTweak(render_distance)
            OverrideLodscaleThisFrame(render_distance)
        end
    end)
end

local function startShadowThread()
    CreateThread(function()
        while shadow_enabled do
            Wait(0)
            CascadeShadowsSetCascadeBoundsScale(shadow_shit)
        end
    end)
end

RegisterCommand('fps', function()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cc_core_fps', {
        title = 'FPS Boost',
        align = 'top-left',
        elements = {
            { label = 'Schatten', value = 'shadow' },
            { label = 'Render Distanz', value = 'render_distance' },
            { label = 'TimeCycle', value = 'timecycle' }
        }
    }, function(data, menu)
        if data.current.value == 'shadow' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cc_core_fps_shadow', {
                title = 'FPS Boost',
                align = 'top-left',
                elements = {
                    { label = "Remove", value = 0.0 },
                    { label = "Normal", value = 0.5 },
                    { label = "Complex", value = 1.0 },
                }
            }, function(data, menu)
                if data.current.value ~= 0.5 then
                    shadow_enabled = true
                    shadow_shit = data.current.value + 0.0
                    startShadowThread()
                else
                    shadow_enabled = false
                end
            end, function(data, menu)
                menu.close()
            end)
        elseif data.current.value == 'render_distance' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cc_core_fps_render_distance', {
                title = 'FPS Boost',
                align = 'top-left',
                elements = {
                    { label = 'Disable', value = false },
                    { label = "Close", value = 0.7 },
                    { label = "Normal", value = 1.0 },
                    { label = "Far", value = 3.0 },
                    { label = "Extra Far", value = 5.0 },
                }
            }, function(data, menu)
                if type(data.current.value) == 'number' then
                    render_distance_enabled = true
                    render_distance = data.current.value + 0.0
                    startRenderThread()
                else
                    render_distance_enabled = false
                end
            end, function(data, menu)
                menu.close()
            end)
        elseif data.current.value == 'timecycle' then
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cc_core_fps_timecycle', {
                title = 'FPS Boost',
                align = 'top-left',
                elements = {
                    { label = "Reset", value = "default" },
                    { label = "No Direct", value = "yell_tunnel_nodirect" },
                    { label = "Ultraboost", value = "gunclub" },
                }
            }, function(data, menu)
                SetTimecycleModifier(data.current.value)
            end, function(data, menu)
                menu.close()
            end)
        end
    end, function(data, menu)
        menu.close()
    end)
end)