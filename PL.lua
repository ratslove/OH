if game.PlaceId == 155615604 then
    local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()
    
    local folder = Instance.new("Folder")
    folder.Name = "Storage"
    folder.Parent = Game
    
    local win = lib:Window("Oasis Hub - Prison Life",Color3.fromRGB(233, 125, 245), Enum.KeyCode)
    
    local maintab = win:Tab('Local Player')
    local charactertab = win:Tab('Combat')
    local gametab = win:Tab('Game')
    local teamtab = win:Tab('Teams')
    local misctab = win:Tab('Misc')
    local teletab = win:Tab('Teleports')
    local uitab = win:Tab('UI')
    local credstab = win:Tab('Credits')

    local plr = game.Players.LocalPlayer
    
    IYMouse = game.Players.LocalPlayer:GetMouse()

    function getRoot(char)
        local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
        return rootPart
    end
    
    function isNumber(str)
        if tonumber(str) ~= nil or str == 'inf' then
            return true
        end
    end
    
    function MoveTo(Pos,t)
		if typeof(Pos):lower() == "position" then
			Pos = CFrame.new(Pos)
		end
		for i =1,3 do
			plr.Character:FindFirstChild("HumanoidRootPart").CFrame = Pos
		end
	end

    function getpos()
    		return plr.Character:FindFirstChild("HumanoidRootPart").CFrame
    	end
    
    function refresh(Pos)
    		if not Pos then
    			Pos = getpos()
    		end
    		local Goto = Pos or getpos()
    		local Connections = {}
    		local Cam = workspace.CurrentCamera.CFrame
    		Connections[1] = plr.CharacterAdded:Connect(function(charnew)
    			pcall(function()
    				task.spawn(function()
    					workspace.CurrentCamera:GetPropertyChangedSignal("CFrame"):Wait()
    					for i =1,5 do
    						workspace.CurrentCamera.CFrame = Cam
    					end
    				end)
    				repeat task.wait() until charnew and charnew:FindFirstChild("HumanoidRootPart")
    				MoveTo(Goto)
    				task.spawn(function()
    					wait(.05)
    					MoveTo(Goto)
    				end)
    				Connections[1]:Disconnect()
    			end)
    		end)
    		Events.loadchar()
    		return
    end

    FLYING = false
    QEfly = true
    iyflyspeed = 3
    vehicleflyspeed = 3
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
    
    States = {
		autore = false,
		Killaura = false,
		Inf_Stam = true,
		Kill_Aura = false,
		Anti_Void = false,
		SuperPunch = false,
		Fast_Punch = false,
	}

    Events = {
    		TeamEvent = workspace.Remote.TeamEvent,
    		ShootEvent = game:GetService("ReplicatedStorage").ShootEvent,
    		loadchar = function()
    			if plr.Team == game.Teams.Inmates then
    				local ohString1 = "Bright orange"
    				workspace.Remote.TeamEvent:FireServer(ohString1)
    			else
    				local ohString1 = "Bright blue"
    				workspace.Remote.TeamEvent:FireServer(ohString1)
    			end
    		end,
    }
        
    maintab:Textbox('WalkSpeed', false, function(value1)    
        
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

        game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
        
            char:WaitForChild("Humanoid")
            char.Humanoid.Changed:Connect(function(prop)
                if prop == "WalkSpeed" and char.Humanoid.WalkSpeed ~= var.Player.WalkSpeed then
                    char.Humanoid.WalkSpeed = var.Player.WalkSpeed
                end
            end)

        end)
    
    end)
    
    maintab:Textbox('JumpPower', false, function(value2)
    
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
    
    maintab:Textbox('Field of View', false, function(amount)
        
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

    maintab:Toggle('Vehicle Fly', false, function(value, args)
    
        getgenv().flyerwow2 = value

        if getgenv().flyerwow2 == true then
            
            NOFLY()
            wait()
            sFLY(true)
            if args[1] and isNumber(args[1]) then
                vehiclespeed = args[1]
                end
            
            else if getgenv().flyerwow2 == false then
                NOFLY()
                
            end
        end
    
    end)

    maintab:Textbox('Vehicle Fly Speed', false, function(value)

		vehicleflyspeed = value
    
    end)

charactertab:Button('Gun Grabber', function()

    local saved = game:GetService("Players").LocalPlayer.Character:GetPrimaryPartCFrame()
		game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP.Position))
		for i =1,2 do
			local ohInstance1 = game:GetService("Workspace").Prison_ITEMS.giver.M9:GetChildren()[6]
			workspace.Remote.ItemHandler:InvokeServer(ohInstance1)
			task.spawn(function()
				for i =1,3 do
					workspace.Remote.ItemHandler:InvokeServer(ohInstance1)
				end		
			end)
			local ohInstance2 = workspace.Prison_ITEMS.giver["Remington 870"].ITEMPICKUP
			workspace.Remote.ItemHandler:InvokeServer(ohInstance2)
			task.spawn(function()
				for i =1,3 do
					workspace.Remote.ItemHandler:InvokeServer(ohInstance2)
				end		
			end)
			local ohInstance3 = game:GetService("Workspace").Prison_ITEMS.giver["AK-47"]:GetChildren()[51]
			wait()
			game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(game:GetService("Workspace").Prison_ITEMS.giver["AK-47"]:GetChildren()[51].Position+Vector3.new(0,4,0)))
			workspace.Remote.ItemHandler:InvokeServer(ohInstance3)
			task.spawn(function()
				for i =1,3 do
					workspace.Remote.ItemHandler:InvokeServer(ohInstance3)
				end		
			end)
		end
		game:GetService("Players").LocalPlayer.Character:SetPrimaryPartCFrame(saved)
    
end)

charactertab:Dropdown("Gun Mods",{"M9", "Remington 870", "AK-47"}, function(v)
    
    local module = nil
    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(v) then
        module = require(game:GetService("Players").LocalPlayer.Backpack[v].GunStates)
    elseif game:GetService("Players").LocalPlayer.Character:FindFirstChild(v) then
        module = require(game:GetService("Players").LocalPlayer.Character[v].GunStates)
    end
    if module ~= nil then
        module["MaxAmmo"] = math.huge
        module["CurrentAmmo"] = math.huge
        module["FireRate"] = 0.01
        module["ReloadTime"] = 0.000001
        module["AutoFire"] = true
    end

end)

    charactertab:Toggle("Instant Respawn", false, function(value)
    
        if value == true then
        
        States.autore = true
        
        refresh()
        
        plr.CharacterAdded:Connect(function(char)
    	task.spawn(function()
    		--//Autorespawn
    		if States.autore == true then
    			repeat task.wait() until char and char:FindFirstChildOfClass("Humanoid")
    			char:FindFirstChildOfClass("Humanoid").BreakJointsOnDeath = false
    			char:FindFirstChildOfClass("Humanoid").Died:Connect(function()
    				refresh()
    			end)
    		end
    	end)
    end)
        
        else if value == false then
            
            States.autore = false
            
            refresh()
            
        end
    end
        
    end)
    
    charactertab:Toggle('Infinite Stamina', false, function(value)
    
        stamina_thing = value
    
        if stamina_thing == true then
				
	    States.Inf_Stam = true
            
            local plr = game:GetService("Players").LocalPlayer
            for i,v in next, getgc() do 
                if type(v) == "function" and getfenv(v).script and getfenv(v).script == plr.Character.ClientInputHandler then 
                    for i2,v2 in next, debug.getupvalues(v) do 
                        if type(v2) == "number" then 
                            debug.setupvalue(v, i2, 9999)
                        end
                    end
                end
            end
            
            
            else if stamina_thing == false then

                States.Inf_Stam = false
                
                local plr = game:GetService("Players").LocalPlayer
                for i,v in next, getgc() do 
                    if type(v) == "function" and getfenv(v).script and getfenv(v).script == plr.Character.ClientInputHandler then 
                        for i2,v2 in next, debug.getupvalues(v) do 
                            if type(v2) == "number" then 
                                debug.setupvalue(v, i2, 12)
                            end
                        end
                    end
                end
                
            end
        end

    end)

    coroutine.wrap(function()
        while wait() do
            if States.Inf_Stam == true then
                local plr = game:GetService("Players").LocalPlayer
                        for i,v in next, getgc() do 
                            if type(v) == "function" and getfenv(v).script and getfenv(v).script == plr.Character.ClientInputHandler then 
                                for i2,v2 in next, debug.getupvalues(v) do 
                                    if type(v2) == "number" then 
                                        debug.setupvalue(v, i2, 9999)
                                    end
                                end
                            end
                        end
            end
        end
    end)()

charactertab:Toggle('Kill Aura', false, function(value)

    getgenv().killauralol = value
    if getgenv().killauralol == true then

        States.Kill_Aura = true

        else if getgenv().killauralol == false then

        States.Kill_Aura = false

        end
    end

end)

coroutine.wrap(function()
	while wait() do
		if States.Kill_Aura == true then
			for i,v in pairs(game.Players:GetPlayers()) do
				pcall(function()
					if v ~= game.Players.LocalPlayer then
						local Distance = (v.Character:FindFirstChildOfClass("Part").Position - game.Players.LocalPlayer.Character:FindFirstChildOfClass("Part").Position).magnitude
						if Distance <= 10 then
							for i = 1,25 do
								game.ReplicatedStorage.meleeEvent:FireServer(v)
							end
						end
					end
				end)
			end
		end
	end
end)()

charactertab:Toggle('Anti Void', false, function(value)

    getgenv().antiviv = value
    if getgenv().antiviv == true then

        States.Anti_Void = true
		
		while wait() do
			if States.Anti_Void then
				pcall(function()
					if game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y < 1 then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(888, 100, 2388)
					end
				end)
			end
		end

    else if getgenv().antiviv == false then

        States.Anti_Void = false

        end
    end

end)

charactertab:Toggle('Super Punch', false, function(value)
    
    getgenv().superpuncher = value
    if getgenv().superpuncher == true then

        local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local MeleeEvent = ReplicatedStorage:FindFirstChild("meleeEvent")
		local Mouse = game.Players.LocalPlayer:GetMouse()
		local Punch = false
		local Cooldown = false
		States.SuperPunch = true

		local function Punch()
			if not States.Fast_Punch then
				Cooldown = true
				local Part = Instance.new("Part", game.Players.LocalPlayer.Character)
				Part.Transparency = 1
				Part.Size = Vector3.new(5, 2, 3)
				Part.CanCollide = false
				local Weld = Instance.new("Weld", Part)
				Weld.Part0 = game.Players.LocalPlayer.Character.Torso
				Weld.Part1 = Part
				Weld.C1 = CFrame.new(0, 0, 2)
				Part.Touched:connect(function(Touch)
					if game.Players:FindFirstChild(Touch.Parent.Name) then
						local plr = game.Players:FindFirstChild(Touch.Parent.Name) 
						if plr.Name ~= game.Players.LocalPlayer.Name then
							Part:Destroy()
							for i = 1,100 do
								MeleeEvent:FireServer(plr)
							end
						end
					end
				end)
				wait(0.9)
				Cooldown = false
				Part:Destroy()
			else
				Cooldown = true
				local Part = Instance.new("Part", game.Players.LocalPlayer.Character)
				Part.Transparency = 1
				Part.Size = Vector3.new(5, 2, 3)
				Part.CanCollide = false
				local Weld = Instance.new("Weld", Part)
				Weld.Part0 = game.Players.LocalPlayer.Character.Torso
				Weld.Part1 = Part
				Weld.C1 = CFrame.new(0, 0, 2)
				Part.Touched:connect(function(Touch)
					if game.Players:FindFirstChild(Touch.Parent.Name) then
						local plr = game.Players:FindFirstChild(Touch.Parent.Name) 
						if plr.Name ~= game.Players.LocalPlayer.Name then
							Part:Destroy()
							for i = 1,100 do
								MeleeEvent:FireServer(plr)
							end
						end
					end
				end)
				wait(0.1)
				Cooldown = false
				Part:Destroy()
			end
		end
		Mouse.KeyDown:connect(function(Key)
			if not Cooldown and States.SuperPunch then
				if Key:lower() == "f" then
					Punch()
				end				
			end
		end)

    
    else if getgenv().superpuncher == false then

        States.SuperPunch = false

    end
end

end)

charactertab:Toggle('Fast Punch', false, function(value)

    getgenv().fastpunch = value
    if getgenv().fastpunch == true then

        States.Fast_Punch = true

    else if getgenv().fastpunch == false then
        States.Fast_Punch = false

    end
end

spawn(function()
	while wait() do
		if States.Fast_Punch == true then
			pcall(function()
				getsenv(game.Players.LocalPlayer.Character.ClientInputHandler).cs.isFighting = false
			end)
		end
	end
end)


end)

gametab:Toggle('Remove Prison Doors', false, function(value)
    
    getgenv().door = value
    if getgenv().door == true then 
        for i,v in pairs(Workspace:GetChildren()) do
            if v.Name == "Doors" then
                v.Parent = folder
            end
        end

    else if getgenv().door == false then
        for i,v in pairs(game.Storage:GetChildren()) do
            if v.Name == "Doors" then
                v.Parent = Workspace
            end
        end
    end
end

end)

gametab:Toggle('Remove Prison Cells', false, function(value)
    
    getgenv().cell = value
    if getgenv().cell == true then 
        for i,v in pairs(Workspace.Prison_Cellblock:GetChildren()) do
            if v.Name == "doors" then
                v.Parent = folder
            end
        end
    
    else if getgenv().cell == false then
        for i,v in pairs(game.Storage:GetChildren()) do
            if v.Name == "doors" then
                v.Parent = Workspace.Prison_Cellblock
            end
        end
    end
    end
    
end)

gametab:Toggle('Remove Prison Fences', false, function(value)
    
    getgenv().fence = value
    if getgenv().fence == true then 
        for i,v in pairs(Workspace:GetChildren()) do
            if v.Name == "Prison_Fences" then
                v.Parent = folder
            end
        end

    else if getgenv().fence == false then
        for i,v in pairs(game.Storage:GetChildren()) do
            if v.Name == "Prison_Fences" then
                v.Parent = Workspace
            end
        end
    end
end

end)
    
    teamtab:Button('Be Prisoner', function()
    
        Workspace.Remote.TeamEvent:FireServer("Bright orange")
    
        if game.Players.LocalPlayer.Neutral == true then
            game.Players.LocalPlayer.Neutral = false
        end

        lib:Notification("Success", "You are now on the 'Prisoners' team.", "Close") -- (header, text, closebutton) --
        
    end)
    
    teamtab:Button('Be Guard', function()
    
        Workspace.Remote.TeamEvent:FireServer("Bright blue")
    
        if game.Players.LocalPlayer.Neutral == true then
            game.Players.LocalPlayer.Neutral = false
        end

        lib:Notification("Success", "You are now on the 'Guards' team.", "Close") -- (header, text, closebutton) --
    
    end)
    
    teamtab:Button('Be Criminal', function()
    
        LCS = game.Workspace["Criminals Spawn"].SpawnLocation
    
        LCS.CanCollide = false
        LCS.Size = Vector3.new(51.05, 24.12, 54.76)
        LCS.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        LCS.Transparency = 1
        wait(0.5)
        LCS.CFrame = CFrame.new(-920.510803, 92.2271957, 2138.27002, 0, 0, -1, 0, 1, 0, 1, 0, 0)
        LCS.Size = Vector3.new(6, 0.2, 6)
        LCS.Transparency = 0
    
        if game.Players.LocalPlayer.Neutral == true then
            game.Players.LocalPlayer.Neutral = false
        end

        lib:Notification("Success", "You are now on the 'Criminal' team.", "Close") -- (header, text, closebutton) --
    
    end)
    
    misctab:Button('Reset Character', function()
        
        game.Players.LocalPlayer.Character:BreakJoints()

        lib:Notification("Notification", "Successfully died!", "Close") -- (header, text, closebutton) --
    end)

    misctab:Button('Rejoin Server', function()
    
        local ts = game:GetService("TeleportService")
    
        local p = game:GetService("Players").LocalPlayer
    
        ts:Teleport(game.PlaceId, p)
    
    end)

    misctab:Button('Server Hop', function()
    
        local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
        for i,v in pairs(Servers.data) do
    		if v.playing ~= v.maxPlayers then
    			game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
    		end
    	end


    end)

    misctab:Button('Builder Tools (BTools)', function()
    
        local tool1 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        local tool2 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        local tool3 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        local tool4 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        local tool5 = Instance.new("HopperBin",game.Players.LocalPlayer.Backpack)
        tool1.BinType = "Clone"
        tool2.BinType = "GameTool"
        tool3.BinType = "Hammer"
        tool4.BinType = "Script"
        tool5.BinType = "Grab"

        lib:Notification("Success", "Granted BTools!", "Close") -- (header, text, closebutton) --
    
    end)

teletab:Dropdown('Teleports', {"Cell Room", "Cafeteria", "Guard Spawn", "Prison Courtyard", "Prison Garage", "Prison Gate", "Criminal Base", "City"}, function(v)

    nigerian = v
    
    if nigerian == "Cell Room" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(916, 99.9899673, 2448, 1, -1.70197954e-08, -3.39260277e-14, 1.70197954e-08, 1, 7.21635587e-08, 3.26978197e-14, -7.21635587e-08, 1)

    else if nigerian == "Cafeteria" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(932.999695, 99.9899368, 2288.99463, 0.999998569, 1.30449251e-08, -0.00168087881, -1.29614106e-08, 1, 4.96959665e-08, 0.00168087881, -4.96741102e-08, 0.999998569)
    
    else if nigerian == "Guard Spawn" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(834, 98.5170059, 2316.00708, 0.999998569, -1.23378059e-05, 0.00167511462, 1.98490895e-07, 0.999973774, 0.00724552013, -0.00167516002, -0.00724550989, 0.999972343)

    else if nigerian == "Prison Courtyard" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(778.999939, 97.9999237, 2472.00391, 0.999999762, -1.46142091e-11, 0.000683857477, -1.34698882e-12, 1, 2.33399469e-08, -0.000683857477, -2.33399415e-08, 0.999999762)
    
    else if nigerian == "Prison Garage" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(582.738281, 98.039917, 2482.43945, 1, 0, 0, 0, 1, 0, 0, 0, 1)
    
    else if nigerian == "Prison Gate" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(468, 98.1899872, 2252.00122, 1, -9.38789758e-12, 0.000121457255, 4.76451864e-12, 1, 3.80658918e-08, -0.000121457255, -3.80658918e-08, 1)
    
    else if nigerian == "Criminal Base" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-921, 92.5015793, 2190.9978, 0.999999285, -2.92056484e-06, -0.00126135349, -8.70204531e-08, 0.999997139, -0.00238165935, 0.00126135349, 0.00238165748, 0.999996424)
    
    else if nigerian == "City" then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-361, 54.5028076, 1733.99707, 0.999998748, -4.78906168e-06, -0.00160547963, 1.38837322e-07, 0.999995828, -0.00289654895, 0.00160548685, 0.00289654522, 0.999994576)
    
    
    
    end
    end
    end
    end
    end
    end
    end
    end

end)
    
    uitab:Colorpicker("Change UI Color",Color3.fromRGB(233, 125, 245), function(t)
        lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
    end)
    
    credstab:Label('Owner/Founder: Grant1ed#4919')
    credstab:Label('Lead Developer/Scripter: Ducky#3566')
    
    credstab:Button("Copy Discord Invite", function()
        
        setclipboard("https://discord.gg/t2wWA3hph3")
        lib:Notification("Success", "Copied Discord Invite to clipboard.", "Close")
    
    end)

    _G.fixFrame = true
    while _G.fixFrame == true do
        game.Players.LocalPlayer.PlayerGui.Home.fadeFrame.BackgroundTransparency = 1.000
        wait()
    end
    
   end
