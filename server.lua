local Wait = Wait
local clock = os.clock

RegisterCommand("perftest", function()
    local idx = 0
    local test = function()
        idx = idx + 1
        local eventName = "perf:test" .. idx
        local results = {}
        local start
        RegisterNetEvent(eventName, function(i, total)
            if i == nil then error() end
            local totalTime = math.round((clock() - start) * 1000)
            local ops = math.round(total / totalTime)
            table.insert(results, { totalTime, ops })
            print("Completed test #" .. idx .. " (run " .. i .. ")! (took " .. totalTime .. "ms) (" .. ops .. " ops/sec)")
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
        print("Test #" .. idx .. " - Mean time: " .. meanTime .. "ms | Mean ops/sec: " .. meanOps)
    end

    for _ = 1, 4 do test() end
end)