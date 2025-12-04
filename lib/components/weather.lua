local utils = require("utils")
local core = require("components.core")
local weather = {}

-- Clean simple weather - current conditions only
lcc.tpl.weather = [[
${font}${texeci 300 curl -s 'wttr.in/{%= location %}?format=%l' 2>/dev/null | tr -d '\n'}
${texeci 300 curl -s 'wttr.in/{%= location %}?format=%C' 2>/dev/null | tr -d '\n'}
${color2}${lua font h2 TEMP}${font}${color} ${texeci 300 curl -s 'wttr.in/{%= location %}?format=%t' 2>/dev/null | tr -d '\n'} / ${texeci 300 curl -s 'wttr.in/{%= location %}?u&format=%t' 2>/dev/null | tr -d '\n'}
${color2}${lua font h2 FEELS}${font}${color} ${texeci 300 curl -s 'wttr.in/{%= location %}?format=%f' 2>/dev/null | tr -d '\n'} / ${texeci 300 curl -s 'wttr.in/{%= location %}?u&format=%f' 2>/dev/null | tr -d '\n'}
${color2}${lua font h2 HUMIDITY}${font}${color}${alignr}${texeci 300 curl -s 'wttr.in/{%= location %}?format=%h' 2>/dev/null | tr -d '\n'}
${color2}${lua font h2 WIND}${font}${color}${alignr}${texeci 300 curl -s 'wttr.in/{%= location %}?format=%w' 2>/dev/null | sed 's/[^0-9.]//g'}km/h
${color2}${lua font h2 PRESSURE}${font}${color}${alignr}${texeci 300 curl -s 'wttr.in/{%= location %}?format=%p' 2>/dev/null | tr -d '\n'}]]

function weather.default(args)
    local location = utils.table.get(args, 'location', '')
    local loc = location:gsub(" ", "%%20")
    return core.section("WEATHER", "") .. "\n" .. lcc.tpl.weather { location = loc }
end

return weather
