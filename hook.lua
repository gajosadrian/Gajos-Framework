local ga = gajosframework
ga.core_hook = {}
ga.hooks = {}

_addhook = addhook
function addhook(name, func, priority)
    if type(func) == 'string' then
        print(ga.COLOR.RED .. 'Impossible to add hook. Do NOT use string in function argument.')
        return
    end

    ga.hooks[name] = ga.hooks[name] or {}
    local hook = ga.hooks[name]

    table.insert(hook, {
        func = func,
        priority = priority or false,
    })
end

local function callHook(name, ...)
    local hook = ga.hooks[name]
    local result = false

    if hook then
        for _, v in pairs(hook) do
            local temp = v.func(...)
            result = temp or result
        end
    end

    return result
end

-- hiding hooks
parse('debuglua 0')

local hooks = {
    Server = {
        'always', 'break', 'endround', 'hitzone', 'log', 'mapchange', 'minute', 'ms100', 'objectdamage', 'objectkill', 'objectupgrade',
        'parse', 'projectile', 'rcon', 'second', 'shutdown', 'startround', 'startround_prespawn', 'trigger', 'triggerentity',
    },
    Player = {
        'always', 'attack', 'attack2', 'bombdefuse', 'bombexplode', 'bombplant', 'build', 'buildattempt', 'buy', 'clientdata', 'collect', 'die', 'dominate',
        'drop', 'flagcapture', 'flagtake', 'flashlight', 'hit', 'hostagerescue', 'join', 'kill', 'leave', 'menu', 'move', 'movetile', 'name', 'radio',
        'reload', 'say', 'sayteam', 'select', 'serveraction', 'shieldhit', 'spawn', 'specswitch', 'spray', 'suicide', 'team', 'use', 'usebutton',
        'vipescape', 'vote', 'walkover', 'key',
    },
}

for category, v in pairs(hooks) do
    for k, hook_name in pairs(v) do
        ga.core_hook[hook_name] = function(...)
            local func = _G['on' .. category .. hook_name:gsub('^%l', string.upper)]
            local arg = {...}

            if hook_name == 'join' then
                newPlayer(arg[1])
            elseif hook_name == 'leave' then
                destructPlayer(arg[1])
            elseif hook_name == 'team' then
                local user = getPlayerInstance(arg[1])

                if not user.joined then
                    user.joined = true
                    _G['onPlayerJoined'](user)
                end
            end

            if func then
                if category == 'Player' then
                    local new_arg = table.shallowCopy(arg)
                    table.remove(new_arg, 1)

                    func(getPlayerInstance(arg[1]), unpack(new_arg))
                else
                    func(unpack(arg))
                end
            end

            return callHook(hook_name, ...)
        end

        _addhook(hook_name, 'gajosframework.core_hook.' .. hook_name)
    end
end

-- unhiding hooks
parse('debuglua 1')
