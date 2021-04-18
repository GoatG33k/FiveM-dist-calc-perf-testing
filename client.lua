local constVec = vec3(0.0, 0.0, 0.0)
local GetEntityCoords = GetEntityCoords
local PlayerPedId = PlayerPedId
local Vdist = Vdist
local Vdist2 = Vdist2

local n = 10000000 -- 10 million

RegisterNetEvent("perf:test1", function(i)
    if i == nil then error() end
    local pos = GetEntityCoords(PlayerPedId())
    CreateThread(function()
        for i = 1, n do local D = #(pos - constVec) end
        TriggerServerEvent("perf:test1", i, n)
    end)
end)

RegisterNetEvent("perf:test2", function(i)
    if i == nil then error() end
    local pos = GetEntityCoords(PlayerPedId())
    CreateThread(function()
        for i = 1, n do
            local v = pos - constVec
            local D = v.x ^ 2 + v.y ^ 2 + v.z ^ 2
        end
        TriggerServerEvent("perf:test2", i, n)
    end)
end)

RegisterNetEvent("perf:test3", function(i)
    if i == nil then error() end
    local pos = GetEntityCoords(PlayerPedId())
    CreateThread(function()
        for i = 1, n do local D = Vdist(pos[1], pos[2], pos[3], constVec[1], constVec[2], constVec[3]) end
        TriggerServerEvent("perf:test3", i, n)
    end)
end)

RegisterNetEvent("perf:test4", function(i)
    if i == nil then error() end
    local pos = GetEntityCoords(PlayerPedId())
    CreateThread(function()
        for i = 1, n do local D = Vdist2(pos[1], pos[2], pos[3], constVec[1], constVec[2], constVec[3]) end
        TriggerServerEvent("perf:test4", i, n)
    end)
end)