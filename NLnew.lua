if game.PlaceId == 3956818381 then
    
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
    
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/UI-Libraries/main/Vynixius/Source.lua"))()
        
    local Window = Library:AddWindow({
        title = {"Oasis Hub", "Ninja Legends"},
        theme = {
        	Accent = Color3.fromRGB(233, 255, 107)
        },
        key = Enum.KeyCode.RightControl,
        default = true
    })
        
    local Tab = Window:AddTab("Local Player", {default = false})
    local Tab2 = Window:AddTab("Utilities", {default = false})
    local Tab3 = Window:AddTab("Teleportation", {default = false})
    local Tab4 = Window:AddTab("Others", {default = false})
        
    local Section = Tab:AddSection("Local Player", {default = false})
    local Section2 = Tab2:AddSection("Utilities", {default = false})
    local Section3 = Tab3:AddSection("Teleportation", {default = false})
    local Section4 = Tab4:AddSection("Others", {default = false})
    local Section5 = Tab4:AddSection("User-Interface", {default = false})
    
    local Slider = Section:AddSlider("WalkSpeed", 16, 300, 16, {toggleable = true, default = false, flag = "Slider_Flag", fireontoggle = true, fireondrag = true, rounded = true}, function(val, bool)
        	
            if bool == true then
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
            else if bool == false then
            	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
            	        
            end
        end
        	
    end)
    
    local Slider2 = Section:AddSlider("JumpPower", 50, 500, 50, {toggleable = true, default = false, flag = "Slider_Flag", fireontoggle = true, fireondrag = true, rounded = true}, function(val, bool)
        	
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
    
    local Toggle = Section:AddToggle("Infinite Jump", {flag = "Toggle_Flag", default = false}, function(bool)
        	
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
    
    local Toggle2 = Section:AddToggle("Fly", {flag = "Toggle_Flag", default = false}, function(bool)
        	
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
    
    local Toggle3 = Section2:AddToggle("Auto Swing", {flag = "Toggle_Flag", default = false}, function(bool)
        	
        	getgenv().autoswing = bool
            while true do 
                if not getgenv().autoswing then return end
                for _,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                    if v:FindFirstChild("ninjitsuGain") then 
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
                        break
                    end
                end
                local A_1 = "swingKatana"
                local Event = game:GetService("Players").LocalPlayer.ninjaEvent
                Event:FireServer(A_1)
                wait(0.1)
            end
        	
    end)
    
    local Toggle4 = Section2:AddToggle("Auto Buy Swords", {flag = "Toggle_Flag", default = false}, function(bool)
        	
        	getgenv().buyswords = bool
            while true do
                if not getgenv().buyswords then return end
                local A_1 = "buyAllSwords"
                local A_2 = "Inner Peace Island"
                local Event = game:GetService("Players").LocalPlayer.ninjaEvent
                Event:FireServer(A_1, A_2)
                wait(0.5)
            end
        	
    end)
    
    local Toggle5 = Section2:AddToggle("Auto Buy Belts", {flag = "Toggle_Flag", default = false}, function(bool)
        	
        	getgenv().buybelts = bool
            while true do
                if not getgenv().buybelts then return end
                local A_1 = "buyAllBelts"
                local A_2 = "Inner Peace Island"
                local Event = game:GetService("Players").LocalPlayer.ninjaEvent
                Event:FireServer(A_1, A_2)
                wait(0.5)
            end
        	
    end)
    
    local Toggle6 = Section2:AddToggle("Auto Sell", {flag = "Toggle_Flag", default = false}, function(bool)
        	
        	getgenv().autosell = bool
            while true do
                if getgenv().autoswing == false then return end
                game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
                wait(0.1)
                game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = CFrame.new(0,0,0)
                wait(0.1)
            end
        	
    end)
    
    local Dropdown = Section3:AddDropdown("Islands", {"Enchanted Island", "Mythical Souls Island", "Winter Wonderland Island", "Dragon Legend Island", "Golden Master Island", "Midnight Shadow Island", "Astral Island", "Mystical Island", "Space Island", "Tundra Island", "Sandstorm Island", "Ancient Inferno Island", "Eternal Island", "Thunderstorm Island", "Cybernetic Legends Island", "Skystorm Ultraus Island", "Chaos Legends Island"}, {default = ""}, function(selected)
	    
	    if selected == "Enchanted Island" then
	        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80, 766, -188)
	        
        else if selected == "Mythical Souls Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-128, 39439, 173)
        
        else if selected == "Winter Wonderland Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(183, 46010, 36)
        
        else if selected == "Dragon Legend Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(188, 59594, 24)
        
        else if selected == "Golden Master Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(166, 52607, 34)
            
        else if selected == "Midnight Shadow Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(180, 33206, 28)
            
        else if selected == "Astral Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(233, 2013, 331)
            
        else if selected == "Mystical Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(165, 4047, 51)
        
        else if selected == "Space Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(186, 5656, 76)
            
        else if selected == "Tundra Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(189, 9284, 31)
        
        else if selected == "Sandstorm Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135, 17686, 61)
           
        else if selected == "Ancient Inferno Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171, 28255, 39)
            
        else if selected == "Eternal Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139, 13680, 74)
        
        else if selected == "Thunderstorm Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(108, 24069, 84)
        
        else if selected == "Cybernetic Legends Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226, 66669, 15)
            
        else if selected == "Skystorm Ultraus Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(197, 70270, 8)
        
        else if selected == "Chaos Legends Island" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(119, 74442, 52)
        
        end    
        end    
        end
        end
        end    
        end
        end
        end
        end
        end
        end    
        end
        end
        end
        end
        end
        end
	    
	end)

    local Dropdown2 = Section3:AddDropdown("Areas", {"Mystical Waters", "Lava Pit", "Tornado", "Sword of Legends", "Sword of Ancients", "Elemental Tornado", "Fallen Infinity Blade", "Zen Masters Blade", "Infinity Stats Dojo", "Altar of Elements", "Pet Cloning Altar", "King of the Hill"}, {default = ""}, function(selected)
    
        if selected == "Mystical Waters" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(344, 8824, 125)
        
        else if selected == "Lava Pit" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-128, 12952, 274)
        
        else if selected == "Tornado" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(320, 16872, -17)
            
        else if selected == "Sword of Legends" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1831, 38, -140)
        
        else if selected == "Sword of Ancients" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(613, 38, 2411)
        
        else if selected == "Elemental Tornado" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(323, 30383, -10)
        
        else if selected == "Fallen Infinity Blade" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1859, 38, -6788)
        
        else if selected == "Zen Masters Blade" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5019, 38, 1614)
        
        else if selected == "Infinity Stats Dojo" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4109.91553, 122.94751, -5908.6845)
        
        else if selected == "Altar of Elements" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(732.294434, 122.947517, -5908.3461)
        
        else if selected == "Pet Cloning Altar" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4520.91943, 122.947517, 1401.6312)
        
        else if selected == "King of the Hill" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(227.120529, 89.8075867, -285.06219)
        
        
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
    
    end)
    
    local Button = Section3:AddButton("Unlock All Islands", function()
    
        local oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        for _,v in pairs(game:GetService("Workspace").islandUnlockParts:GetChildren()) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            wait(0.3)
        end
        wait(0.3)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcframe
    
    end)
    
    local Dropdown3 = Section4:AddDropdown("Elements", {"Frost Element", "Electral Chaos Element", "Lightning Element", "Inferno Element", "Masterful Wrath Element", "Shadow Charge Element", "Shadowfire Element", "Eternity Storm Element"}, {default = ""}, function(selected)
	
	    if selected == 'Frost Element' then
	        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Frost")
	    
	    else if selected == 'Electral Chaos Element' then
	        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Electral Chaos")
	        
	    else if selected == 'Lightning Element' then
	        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Lightning")
	    
	    else if selected == 'Inferno Element' then
	        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Inferno")
	    
	    else if selected == 'Masterful Wrath Element' then
	        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Masterful Wrath")
	    
	    else if selected == 'Shadow Charge Element' then
	        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadow Charge")
	    
	    else if selected == 'Shadowfire Element' then
	        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadowfire")
	    
	    else if selected == 'Eternity Storm Element' then
	        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Eternity Storm")
	    
	    end
	    end
	    end
	    end
	    end
	    end
	    end
	    end
	
    end)
    
    local Button2 = Section4:AddButton("Unlock All Elements", function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Frost")
        wait(0.1)
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Electral Chaos")
        wait(0.1)
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Lightning")
        wait(0.1)
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Inferno")
        wait(0.1)
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Masterful Wrath")
        wait(0.1)
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadow Charge")
        wait(0.1)
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadowfire")
        wait(0.1)
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Eternity Storm")
        wait(0.1)
        
    
    end)
    
    local Button3 = Section4:AddButton("Rejoin Server", function()
    
        local ts = game:GetService("TeleportService")

        local p = game:GetService("Players").LocalPlayer
    
        ts:Teleport(game.PlaceId, p)
    
    end)
    
    local Button4 = Section4:AddButton("Server Hop", function()
    
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
            for i,v in pairs(Servers.data) do
            	if v.playing ~= v.maxPlayers then
            		game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
            	end
        	end
    
    end)
    
    local Toggle7 = Section4:AddToggle("Anti AFK", {flag = "Toggle_Flag", default = false}, function(bool)
        	
        	local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
            end)
        	
    end)
    
    local Picker = Section5:AddPicker("Change UI Color", {color = Color3.fromRGB(233, 255, 107)}, function(color)
        	Window:SetAccent(color)
    end)
        
    local Label = Section5:AddLabel("Programmed by Ducky#3566")
    
    local Button4 = Section5:AddButton("Copy Discord Invitation", function()
        	
        	setclipboard("https://discord.gg/t2wWA3hph3")
        	Library:Notify({title = "Alert", text = "Copied Discord Invitation!", color = Color3.fromRGB(233, 255, 107)}, function(v)
        	    
        	end)
        	
    end)
    
    local Bind = Section5:AddBind("Toggle UI", Enum.KeyCode.RightControl, {toggleable = false, default = false, flag = "Bind_Flag"}, function(keycode)
        	Window:SetKey(keycode)
        end)
        
    Library:Notify({title = "Notification", text = "Loaded.", color = Color3.fromRGB(233, 255, 107)}, function(v)
        	    
    end)
    
end
