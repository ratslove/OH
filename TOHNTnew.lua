if game.PlaceId == 1962086868 then

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
    
    local folder = Instance.new("Folder")
    
    folder.Name = "Storage"
    folder.Parent = game
    
    States = {}
    
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/UI-Libraries/main/Vynixius/Source.lua"))()
    
    local Window = Library:AddWindow({
    	title = {"Oasis Hub", "Tower of Hell [Noob Towers]"},
    	theme = {
    		Accent = Color3.fromRGB(93, 143, 194)
    	},
    	key = Enum.KeyCode.RightControl,
    	default = true
    })
    
    local Tab = Window:AddTab("Local Player", {default = false})
    local Tab2 = Window:AddTab("Utilities", {default = false})
    local Tab3 = Window:AddTab("Others", {default = false})
    
    local Section = Tab:AddSection("Local Player", {default = false})
    local Section2 = Tab2:AddSection("Utilities", {default = false})
    local Section3 = Tab3:AddSection("Other", {default = false})
    
    local Slider = Section:AddSlider("WalkSpeed", 16, 100, 16, {toggleable = true, default = false, flag = "Slider_Flag", fireontoggle = true, fireondrag = true, rounded = true}, function(val, bool)
    	
    	if bool == true then
    	    game:GetService("ReplicatedStorage").globalSpeed.Value = val
    	else if bool == false then
    	    game:GetService("ReplicatedStorage").globalSpeed.Value = 16
    	        
    	    end
    	end
    	
    end)
    
    local Slider2 = Section:AddSlider("JumpPower", 50, 200, 50, {toggleable = true, default = false, flag = "Slider_Flag", fireontoggle = true, fireondrag = true, rounded = true}, function(val, bool)
    	
    	if bool == true then
    	    game.Players.LocalPlayer.Character.Humanoid.JumpPower = val
    	else if bool == false then
    	    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    	        
    	    end
    	end
    	
    end)
    
    local Slider3 = Section:AddSlider("Field of View", 70, 120, 70, {toggleable = true, default = false, flag = "Slider_Flag", fireontoggle = true, fireondrag = true, rounded = true}, function(val, bool)
    	
    	if bool == true then
    	    game:GetService'Workspace'.Camera.FieldOfView = val
    	else if bool == false then
    	    game:GetService'Workspace'.Camera.FieldOfView = 70
    	        
    	    end
    	end
    	
    end)
    
    local Toggle = Section:AddToggle("NoClip", {flag = "Toggle_Flag", default = false}, function(bool)
    	
    	getgenv().nokiz = bool
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
    
    local Toggle2 = Section:AddToggle("Infinite Jump", {flag = "Toggle_Flag", default = false}, function(bool)
    	
    	getgenv().infjumper = bool
            
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
    
    local Toggle3 = Section:AddToggle("Fly", {flag = "Toggle_Flag", default = false}, function(bool)
    	
    	getgenv().flyerwow = bool
    
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
    
    local Box = Section:AddBox("Fly Speed", {fireonempty = true}, function(text)
    	
    	iyflyspeed = text
    	
    end)
    
    local Toggle4 = Section2:AddToggle("God Mode", {flag = "Toggle_Flag", default = false}, function(bool)
    	
    	godModeThing = bool
    
    
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
    
    local Toggle5 = Section2:AddToggle("Anti Negative", {flag = "Toggle_Flag", default = false}, function(bool)
    	
    	antiNegative = bool
    
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
    
    local Toggle6 = Section2:AddToggle("Anti Gravity", {flag = "Toggle_Flag", default = false}, function(bool)
    	
    	antiGravity = bool
    
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
    
    local Toggle7 = Section2:AddToggle("Anti Bunny", {flag = "Toggle_Flag", default = false}, function(bool)
    	
    	antiBunny = bool
    
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
    
    local Toggle8 = Section2:AddToggle("Anti Fog", {flag = "Toggle_Flag", default = false}, function(bool)
    	
    	antiFog = bool
    
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
    
    local Toggle9 = Section2:AddToggle("Anti Speed", {flag = "Toggle_Flag", default = false}, function(bool)
    	
    	antiSpeed = bool
    
            if antiSpeed == true then
    
                game:GetService("ReplicatedStorage").globalSpeed.Value = 16 
    
            else if antiSpeed == false then 
                
                game:GetService("ReplicatedStorage").globalSpeed.Value = 16 
    
            end
        end
    	
    end)
    
    local Button = Section2:AddButton("Teleport to Top", function()
    	
    	local endzone = game.Workspace.tower.sections.finish.FinishGlow.CFrame
     
            local player = game.Players.LocalPlayer.Character
            player.HumanoidRootPart.CFrame = endzone
    	
    end)
    
    local Button2 = Section2:AddButton("Grab Gear", function()
    	
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
    
    local Button3 = Section2:AddButton("Rejoin Server", function()
    	
    	local ts = game:GetService("TeleportService")
        
        local p = game:GetService("Players").LocalPlayer
        
        ts:Teleport(game.PlaceId, p)
    	
    end)
    
    local Button4 = Section2:AddButton("Server Hop", function()
    	
    	local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for i,v in pairs(Servers.data) do
        	if v.playing ~= v.maxPlayers then
        		game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
        	end
    	end
    	
    end)
    
    local Picker = Section3:AddPicker("Change UI Color", {color = Color3.fromRGB(93, 143, 194)}, function(color)
    	Window:SetAccent(color)
    end)
    
    local Label = Section3:AddLabel("Programmed by Ducky#3566")
    
    local Button5 = Section3:AddButton("Copy Discord Invitation", function()
    	
    	setclipboard("https://discord.gg/t2wWA3hph3")
    	Library:Notify({title = "Alert", text = "Copied Discord Invitation!", color = Color3.fromRGB(93, 143, 194)}, function(v)
    	    
    	end)
    	
    end)
    
    local Bind = Section3:AddBind("Toggle UI", Enum.KeyCode.RightControl, {toggleable = false, default = false, flag = "Bind_Flag"}, function(keycode)
    	Window:SetKey(keycode)
    end)
    
    Library:Notify({title = "Notification", text = "Loaded.", color = Color3.fromRGB(93, 143, 194)}, function(v)
    	    
    end)

end
