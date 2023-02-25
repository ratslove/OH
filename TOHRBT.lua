if game.PlaceId == 7227293156 then

    local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()

    local folder = Instance.new("Folder")

    folder.Name = "Storage"
    folder.Parent = game

    States = {}

    local win = lib:Window("Oasis Hub - Tower of Hell (RB Battles)",Color3.fromRGB(93, 143, 194), Enum.KeyCode)
        
    local maintab = win:Tab("Local Player")
    local utiltab = win:Tab("Utilities")
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

    local reg = getreg()
 
    for i, Function in next, reg do
        if type(Function) == 'function' then
            local info = getinfo(Function)
 
            if info.name == 'kick' then
                if (hookfunction(info.func, function(...)end)) then
                    print'succesfully hooked kick'
                else
                    print'failed to hook kick'
                end
            end
        end
    end
 
    local script1 = game.StarterPlayer.StarterPlayerScripts.LocalScript
    local script2 = game.StarterPlayer.StarterPlayerScripts.LocalScript2
 
    local script1signal = script1.Changed
    local script2signal = script2.Changed
 
    for i, connection in next, getconnections(script1signal) do
        connection:Disable()
    end
    for i, connection in next, getconnections(script2signal) do
        connection:Disable()
    end

    maintab:Slider('WalkSpeed', 0, 100, 16, function(value1)    
        
        game:GetService("ReplicatedStorage").globalSpeed.Value = value1
    
    end)
    
    maintab:Slider('JumpPower', 0, 200, 50, function(value2)
    
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value2
    
    end)
    
    maintab:Slider('Field of View', 0, 120, 70, function(amount)
        
        game:GetService'Workspace'.Camera.FieldOfView = amount
    
    end)

    maintab:Toggle('NoClip', false, function(value)
    
        getgenv().nokiz = value
        if getgenv().nokiz == true then

            _G.Noclips = true

            game:GetService("RunService").Stepped:Connect(function()
                if _G.Noclips then
                    pcall(function()
                        game.Players.LocalPlayer.Character:FindFirstChild("Head").CanCollide = false
                        game.Players.LocalPlayer.Character:FindFirstChild("Torso").CanCollide = false
                    end)
                end
            end)

        else if getgenv().nokiz == false then
            _G.Noclips = false
            
            end
        end
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
    
    maintab:Toggle('Fly', false, function(value, args)
    
        getgenv().flyerwow = value

        if getgenv().flyerwow == true then
            
            NOFLY()
            wait()
            sFLY()
            if args[1] and isNumber(args[1]) then
                iyflyspeed = args[1]
            end
            
            else if getgenv().flyerwow == false then
                NOFLY()
                
            end
        end
    
    end)
    
    maintab:Textbox('Fly Speed', false, function(value)

		iyflyspeed = value
    
    end)

    utiltab:Toggle('God Mode', false, function(value)
    
        godModeThing = value


        if godModeThing == true then


            _G.godMode1 = true
            while _G.godMode1 == true do
                wait()
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v.Name == "hitbox" then
                        v.Parent = game.Storage
                        wait()
                    end
                end
            end


        else if godModeThing == false then

            _G.godMode1 = false
            while _G.godMode1 == true do
                wait()
                for i,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                    if v.Name == "hitbox" then
                        v.Parent = game.Storage
                        wait()
                    end
                end
            end


            for i,v in pairs(game.Storage:GetChildren()) do
                if v.Name == "hitbox" then
                    v.Parent = game.Players.LocalPlayer.Character
                    wait()
                end
            end
        
        end
    end

    end)

    utiltab:Toggle("Anti Negative", false, function(value)
    
        antiNegative = value

        if antiNegative == true then

            local v1 = game:GetService("TweenService"):Create(game.Lighting.Negative, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
			Saturation = 0
                });
                v1.Completed:Connect(function()
                    game.Lighting.Negative.Enabled = false;
                end);
                v1:Play();


        else if antiNegative == false then

            warn("off lol")

        end
    end

    end)

    utiltab:Toggle("Anti Gravity", false, function(value)
    
        antiGravity = value

        if antiGravity == true then

            _G.antiGrav = true
            while _G.antiGrav == true do
                wait()
                game.Workspace.Gravity = 196.2
            end

        else if antiGravity == false then

            _G.antiGrav = false
            while _G.antiGrav == true do
                wait()
                game.Workspace.Gravity = 196.2
            end

            game.Workspace.Gravity = 196.2

        end
    end

    end)

    utiltab:Toggle("Anti Bunny", false, function(value)
    
        antiBunny = value

        if antiBunny == true then

            _G.antiBun = true
            while _G.antiBun == true do
                wait()
                game.ReplicatedStorage.bunnyJumping.Value = false
            end

        else if antiBunny == false then

            _G.antiBun = false
            while _G.antiBun == true do
                wait()
                game.ReplicatedStorage.bunnyJumping.Value = false
            end

            game.ReplicatedStorage.bunnyJumping.Value = false
            

        end
    end

    end)

    utiltab:Toggle("Anti Fog", false, function(value)
    
        antiFog = value

        if antiFog == true then

            _G.antiFogger = true
            while _G.antiFogger == true do
                wait()
                game.Lighting.FogEnd = 1200
            end

        else if antiFog == false then

            _G.antiFogger = false
            while _G.antiFogger == true do
                wait()
                game.Lighting.FogEnd = 1200
            end

            game.Lighting.FogEnd = 1200
            

        end
    end

    end)

    utiltab:Toggle("Anti Speed", false, function(value)
    
        antiSpeed = value

        if antiSpeed == true then

            _G.antiSpeeder = true
            while _G.antiSpeeder == true do
                wait()
                if game.ReplicatedStorage.globalSpeed.Value == 20 then

                    game.ReplicatedStorage.globalSpeed.Value = 16

                end
            end

        else if antiSpeed == false then

            _G.antiSpeeder = false
            while _G.antiSpeeder == true do
                wait()
                if game.ReplicatedStorage.globalSpeed.Value == 20 then

                    game.ReplicatedStorage.globalSpeed.Value = 16

                end
            end

            game:GetService("ReplicatedStorage").globalSpeed.Value = 16
            

        end
    end

    end)

    utiltab:Button("Grab Gear", function()
    
        for _,e in pairs(game.Players.LocalPlayer.Backpack:GetDescendants()) do
            if e:IsA("Tool") then
            e:Destroy()
            end
            end
            wait() 
            for _,v in pairs(game.ReplicatedStorage.Gear:GetDescendants()) do
            if v:IsA("Tool") then
            local CloneThings = v:Clone()
            wait()
            CloneThings.Parent = game.Players.LocalPlayer.Backpack
     
            end
            end    

    end)

    utiltab:Button("Teleport to Top", function()
    
        local endzone = game.Workspace.tower.sections.finish.FinishGlow.CFrame
 
        local player = game.Players.LocalPlayer.Character
        player.HumanoidRootPart.CFrame = endzone

    end)

    utiltab:Button('Rejoin Server', function()
    
        local ts = game:GetService("TeleportService")
    
        local p = game:GetService("Players").LocalPlayer
    
        ts:Teleport(game.PlaceId, p)
    
    end)

    utiltab:Button('Server Hop', function()
    
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for i,v in pairs(Servers.data) do
    		if v.playing ~= v.maxPlayers then
    			game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
    		end
    	end


    end)

    uitab:Colorpicker("Change UI Color",Color3.fromRGB(93, 143, 194), function(t)
        lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
    end)
    
    credstab:Label('Programmed by Ducky#3566')
        
    credstab:Button("Copy Discord Invite", function()
            
        setclipboard("https://discord.gg/t2wWA3hph3")
        lib:Notification("Success", "Copied Discord Invite to clipboard.", "Close")
        
    end)

end
