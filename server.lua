local Wait = Wait
local clock = os.clock

RegisterCommand("perftest", function()
    local idx = 0
    local test = function(name)
        idx = idx + 1
        local eventName = "perf:test" .. idx
        local results = {}
        local start
        RegisterNetEvent(eventName, function(i, total)
            if i == nil then error() end
            local totalTime = math.round((clock() - start) * 1000)
            local ops = math.round(total / totalTime)
            table.insert(results, { totalTime, ops })
            print("^0[^1" .. name .. "^0] ^4run:^5" .. i .. "^0 [^3" .. totalTime .. "ms ^0::^3 " .. ops .. " ops/sec^0]")
            start = nil
        end)
        for i = 1, 5 do
            start = clock()
            TriggerClientEvent(eventName, -1, i)
            while start ~= nil do Wait(100) end
        end
        local meanTime = 0
        local meanOps = 0
        for i = 1, #results do
            meanTime = meanTime + results[i][1]
            meanOps = meanOps + results[i][2]
        end
        meanTime = meanTime / #results
        meanOps = meanOps / #results
        print("^0[^1" .. name .. "^0] :: ^4mean time ^2" .. meanTime .. "ms^0 ::^4 mean ops/sec: ^2" .. meanOps)
    end

    test("#(vec1 - vec2)")
    test("v.x ^ 2 + v.y ^ 2 + v.z ^ 2")
    test("Vdist")
    test("Vdist2")
    test("GetDistanceBetweenCoords(..., false)")
    test("GetDistanceBetweenCoords(..., true)")
end)