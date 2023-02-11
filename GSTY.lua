if game.PlaceId == 4842364293 then

        local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()
    
game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50

States = {}

local win = lib:Window("Oasis Hub - Guesty",Color3.fromRGB(247, 84, 84), Enum.KeyCode)
        
local maintab = win:Tab("Local Player")
local gametab = win:Tab("Game")
local esptab = win:Tab("ESP")
local uitab = win:Tab("User-Interface")
local credstab = win:Tab("Credits")

function randomString()
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end

IYMouse = game.Players.LocalPlayer:GetMouse()

    function getRoot(char)
        local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
        return rootPart
    end

    FLYING = false
    QEfly = true
    iyflyspeed = 1
    vehicleflyspeed = 1
    function sFLY(vfly)
        repeat wait() until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and getRoot(game.Players.LocalPlayer.Character) and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        repeat wait() until IYMouse
        if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

        local T = getRoot(game.Players.LocalPlayer.Character)
        local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
        local SPEED = 0

        local function FLY()
            FLYING = true
            local BG = Instance.new('BodyGyro')
            local BV = Instance.new('BodyVelocity')
            BG.P = 9e4
            BG.Parent = T
            BV.Parent = T
            BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
            BG.cframe = T.CFrame
            BV.velocity = Vector3.new(0, 0, 0)
            BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
            task.spawn(function()
                repeat wait()
                    if not vfly and game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                        game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
                    end
                    if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
                        SPEED = 50
                    elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
                        SPEED = 0
                    end
                    if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                        lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
                    elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
                        BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
                    else
                        BV.velocity = Vector3.new(0, 0, 0)
                    end
                    BG.cframe = workspace.CurrentCamera.CoordinateFrame
                until not FLYING
                CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
                SPEED = 0
                BG:Destroy()
                BV:Destroy()
                if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
                end
            end)
        end
        flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 's' then
                CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 'a' then
                CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
            elseif KEY:lower() == 'd' then 
                CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
            elseif QEfly and KEY:lower() == 'e' then
                CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
            elseif QEfly and KEY:lower() == 'q' then
                CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
            end
            pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
        end)
        flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
            if KEY:lower() == 'w' then
                CONTROL.F = 0
            elseif KEY:lower() == 's' then
                CONTROL.B = 0
            elseif KEY:lower() == 'a' then
                CONTROL.L = 0
            elseif KEY:lower() == 'd' then
                CONTROL.R = 0
            elseif KEY:lower() == 'e' then
                CONTROL.Q = 0
            elseif KEY:lower() == 'q' then
                CONTROL.E = 0
            end
        end)
        FLY()
    end

    function NOFLY()
        FLYING = false
        if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
        if game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
            game.Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
        end
        pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
    end

local var = {
    ['Player'] = {
        ['WalkSpeed'] = 16,
        ['JumpPower'] = 50
    }
}

maintab:Slider('WalkSpeed', 16, 50, 16, function(value1)    
        
    var.Player.WalkSpeed = value1
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value1

    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid")
        char.Humanoid.WalkSpeed = var.Player.WalkSpeed
    end)

    game.Players.LocalPlayer.Character.Humanoid.Changed:Connect(function(prop)
        if prop == "WalkSpeed" and game.Players.LocalPlayer.Character.Humanoid.WalkSpeed ~= var.Player.WalkSpeed then
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = var.Player.WalkSpeed
        end
    end)

end)

maintab:Slider('JumpPower', 50, 150, 50, function(value2)
    
    var.Player.JumpPower = value2
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = value2

    game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        char:WaitForChild("Humanoid")
        char.Humanoid.JumpPower = var.Player.JumpPower
    end)

    game.Players.LocalPlayer.Character.Humanoid.Changed:Connect(function(prop)
        if prop == "JumpPower" and game.Players.LocalPlayer.Character.Humanoid.JumpPower ~= var.Player.JumpPower then
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = var.Player.JumpPower
        end
    end)

end)

maintab:Slider('Field of View', 70, 120, 70, function(amount)
        
    game:GetService'Workspace'.Camera.FieldOfView = amount

end)

maintab:Toggle('Infinite Jump', false, function(value)

    getgenv().infjumper = value
    
    if getgenv().infjumper == true then
        
        _G.infinjump = true
        
        local Player = game:GetService("Players").LocalPlayer
        local Mouse = Player:GetMouse()
        Mouse.KeyDown:connect(function(k)
            if _G.infinjump then
                if k:byte() == 32 then
                    Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    Humanoid:ChangeState("Jumping")
                end
            end
        end)

        else if getgenv().infjumper == false then
                
            _G.infinjump = false
            
        end
    end

end)

local NoClipping = nil
floatName = randomString()

function NoclipLoop()
    if Clip == false and speaker.Character ~= nil then
        for _, child in pairs(speaker.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                child.CanCollide = false
            end
        end
    end
end

maintab:Toggle('NoClip', false, function(value)

    getgenv().nokiz = value
        if getgenv().nokiz == true then

            Clip = false
            wait(0.1)
            local function NoclipLoop()
                if Clip == false and game.Players.LocalPlayer.Character ~= nil then
                    for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                            child.CanCollide = false
                        end
                    end
                end
            end
            Noclipping = game:GetService("RunService").Stepped:Connect(NoclipLoop)

        else if getgenv().nokiz == false then

            if Noclipping then
                Noclipping:Disconnect()
            end
            Clip = true
        
        end
    end 

end)

maintab:Toggle('Fly', false, function(value)
    
    getgenv().flyerwow = value

    if getgenv().flyerwow == true then
        
        NOFLY()
        wait()
        sFLY()
        
        else if getgenv().flyerwow == false then
            NOFLY()
            
        end
    end

end)

gametab:Toggle('Fix Lighting', false, function(value)
    
    getgenv().autoLight = value

    if getgenv().autoLight == true then

        _G.fixLight = true
        while _G.fixLight == true do
            game.Lighting.FogEnd = 100000
            wait()
        end


    else if getgenv().autoLight == false then

        _G.fixLight = false
        while _G.fixLight == true do
            game.Lighting.FogEnd = 100000
            wait()
        end

        game.Lighting.FogEnd = 85
        
        end
    end

end)

gametab:Toggle('Auto Skip Scene', false, function(value)

    getgenv().autoSkip = value
    
    if getgenv().autoSkip == true then

        _G.autoSkiper = true
        while _G.autoSkiper == true do 
            game:GetService("ReplicatedStorage").Events.SkipScene:FireServer()
            wait()
        end


    else if getgenv().autoSkip == false then

        _G.autoSkiper = false
        while _G.autoSkiper == true do
            game:GetService("ReplicatedStorage").Events.SkipScene:FireServer()
            wait()
        end

        end
    end

end)

gametab:Button('Grab Coins', function()  

    getgenv().autoCoin = true

    spawn(function()
    
        local HR = game.Players.LocalPlayer.Character.HumanoidRootPart -- Players Head
            while wait() do
                if not getgenv().autoCoin then break end
                
                for i, v in pairs(game:GetService("Workspace").Coins:GetDescendants()) do
                    if v.Name == "TouchInterest" and v.Parent then
                        -- Fire the FireTouchInterest below.
                        firetouchinterest(HR, v.Parent, 0)
                    end
                end
            end

            for i, v in pairs(game.Workspace.Coins:DescendantAdded()) do
                if v.Name == "TouchInterest" and v.Parent then
                    -- Fire the thing again.
                    firetouchinterest(HR, v.Parent, 0)
                end
            end
        
    end)

end)

gametab:Button('Rejoin Server', function()
    
    local ts = game:GetService("TeleportService")

    local p = game:GetService("Players").LocalPlayer

    ts:Teleport(game.PlaceId, p)

end)

gametab:Button('Server Hop', function()
    
    local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for i,v in pairs(Servers.data) do
        if v.playing ~= v.maxPlayers then
            game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
        end
    end


end)

getgenv().cham = false
getgenv().nameESP = false
getgenv().boxESP = false


getgenv().esp_loaded = false
getgenv().Visibility = false

esptab:Toggle('Toggle ESP', false, function(value)

    if getgenv().esp_loaded == false and value == true then
        getgenv().esp_loaded = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
    end
    getgenv().Visibility = value   

end)

esptab:Toggle('Name ESP', false, function(value)

    if getgenv().esp_loaded == false and value == true then
        getgenv().esp_loaded = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
    end
    getgenv().nameESP = value   

end)

esptab:Toggle('Box ESP', false, function(value)

    if getgenv().esp_loaded == false and value == true then
        getgenv().esp_loaded = true
        loadstring(game:HttpGet("https://raw.githubusercontent.com/skatbr/Roblox-Releases/main/A_simple_esp.lua", true))()
    end
    getgenv().boxESP = value   

end)

uitab:Colorpicker("Change UI Color",Color3.fromRGB(247, 84, 84), function(t)
    lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)

credstab:Label('Owner/Founder: Grant1ed#4919')
    credstab:Label('Lead Developer/Scripter: Ducky#3566')
    
credstab:Button("Copy Discord Invite", function()
        
    setclipboard("https://discord.gg/t2wWA3hph3")
    lib:Notification("Success", "Copied Discord Invite to clipboard.", "Close")
    
end)
  
end
