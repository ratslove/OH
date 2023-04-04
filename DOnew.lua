if game.PlaceId == 6839171747 then
    local floor = game:GetService("ReplicatedStorage").GameData.Floor.Value

    if floor == "Hotel" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ratslove/OH/main/DOmain.lua"))()

    elseif floor == "Rooms" then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/ratslove/OH/main/DORnew.lua"))()
    end
end
