IYMouse = game.Players.LocalPlayer:GetMouse()

function getRoot(char)
	local rootPart = char:FindFirstChild("HumanoidRootPart")
		or char:FindFirstChild("Torso")
		or char:FindFirstChild("UpperTorso")
	return rootPart
end

FLYING = false
QEfly = true
iyflyspeed = 1
vehicleflyspeed = 1
function sFLY(vfly)
	repeat
		wait()
	until game.Players.LocalPlayer
		and game.Players.LocalPlayer.Character
		and getRoot(game.Players.LocalPlayer.Character)
		and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	repeat
		wait()
	until IYMouse
	if flyKeyDown or flyKeyUp then
		flyKeyDown:Disconnect()
		flyKeyUp:Disconnect()
	end

	local T = getRoot(game.Players.LocalPlayer.Character)
	local CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
	local lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
	local SPEED = 0

	local function FLY()
		FLYING = true
		local BG = Instance.new("BodyGyro")
		local BV = Instance.new("BodyVelocity")
		BG.P = 9e4
		BG.Parent = T
		BV.Parent = T
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = T.CFrame
		BV.velocity = Vector3.new(0, 0, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
		task.spawn(function()
			repeat
				wait()
				if not vfly and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
					game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = true
				end
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
					SPEED = 50
				elseif
					not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0)
					and SPEED ~= 0
				then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
					BV.velocity = (
						(workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B))
						+ (
							(
								workspace.CurrentCamera.CoordinateFrame
								* CFrame.new(
									CONTROL.L + CONTROL.R,
									(CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2,
									0
								).p
							) - workspace.CurrentCamera.CoordinateFrame.p
						)
					) * SPEED
					lCONTROL = { F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R }
				elseif
					(CONTROL.L + CONTROL.R) == 0
					and (CONTROL.F + CONTROL.B) == 0
					and (CONTROL.Q + CONTROL.E) == 0
					and SPEED ~= 0
				then
					BV.velocity = (
						(workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B))
						+ (
							(
								workspace.CurrentCamera.CoordinateFrame
								* CFrame.new(
									lCONTROL.L + lCONTROL.R,
									(lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2,
									0
								).p
							) - workspace.CurrentCamera.CoordinateFrame.p
						)
					) * SPEED
				else
					BV.velocity = Vector3.new(0, 0, 0)
				end
				BG.cframe = workspace.CurrentCamera.CoordinateFrame
			until not FLYING
			CONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
			lCONTROL = { F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0 }
			SPEED = 0
			BG:Destroy()
			BV:Destroy()
			if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
				game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
			end
		end)
	end
	flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
		if KEY:lower() == "w" then
			CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == "s" then
			CONTROL.B = -(vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == "a" then
			CONTROL.L = -(vfly and vehicleflyspeed or iyflyspeed)
		elseif KEY:lower() == "d" then
			CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
		elseif QEfly and KEY:lower() == "e" then
			CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed) * 2
		elseif QEfly and KEY:lower() == "q" then
			CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed) * 2
		end
		pcall(function()
			workspace.CurrentCamera.CameraType = Enum.CameraType.Track
		end)
	end)
	flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
		if KEY:lower() == "w" then
			CONTROL.F = 0
		elseif KEY:lower() == "s" then
			CONTROL.B = 0
		elseif KEY:lower() == "a" then
			CONTROL.L = 0
		elseif KEY:lower() == "d" then
			CONTROL.R = 0
		elseif KEY:lower() == "e" then
			CONTROL.Q = 0
		elseif KEY:lower() == "q" then
			CONTROL.E = 0
		end
	end)
	FLY()
end

function NOFLY()
	FLYING = false
	if flyKeyDown or flyKeyUp then
		flyKeyDown:Disconnect()
		flyKeyUp:Disconnect()
	end
	if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").PlatformStand = false
	end
	pcall(function()
		workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
	end)
end

local flags = {



}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/UI-Libraries/main/Vynixius/Source.lua"))()

-- Create Window
local Window = Library:AddWindow({
	title = { "Oasis Hub", "Server Simulator" },
	theme = {
		Accent = Color3.fromRGB(90, 179, 80),
	},
	key = Enum.KeyCode.RightControl,
	default = true,
})

-- Create Tab
local Tab = Window:AddTab("Local Player", { default = true })
local Tab2 = Window:AddTab("Utilities", { default = false })
local Tab3 = Window:AddTab("Other", { default = false })

-- Create Section
local Section = Tab:AddSection("Player", { default = false })
local Section2 = Tab2:AddSection("Utilities", { default = false })
local Section3 = Tab3:AddSection("Other", { default = false })

local var = {
    ['Player'] = {
        ['WalkSpeed'] = 16,
        ['JumpPower'] = 50
    }
}

local Slider = Section:AddSlider("WalkSpeed", 16, 200, 16, { toggleable = true, default = false, flag = "Slider_Flag1", fireontoggle = true, fireondrag = true, rounded = true }, function(val, bool)
		if bool == true then
			var.Player.WalkSpeed = val
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
		else
			if bool == false then
				var.Player.WalkSpeed = 16
                game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
			end
		end

        game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
            char:WaitForChild("Humanoid")
            char.Humanoid.WalkSpeed = var.Player.WalkSpeed
        end)
end)

local Slider2 = Section:AddSlider("JumpPower", 50, 400, 50, { toggleable = true, default = false, flag = "Slider_Flag2", fireontoggle = true, fireondrag = true, rounded = true }, function(val, bool)
		if bool == true then
			var.Player.JumpPower = val
            game.Players.LocalPlayer.Character.Humanoid.JumpPower = val
		else
			if bool == false then
				var.Player.JumpPower = 50
                game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
			end
		end

        game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
            char:WaitForChild("Humanoid")
            char.Humanoid.JumpPower = var.Player.JumpPower
        end)
end)

local Slider3 = Section:AddSlider("Field of View", 70, 120, 70, { toggleable = true, default = false, flag = "Slider_Flag3", fireontoggle = true, fireondrag = true, rounded = true }, function(val, bool)
		if bool == true then
			game:GetService("Workspace").Camera.FieldOfView = val
		else
			if bool == false then
				game:GetService("Workspace").Camera.FieldOfView = 70
			end
		end
end)

local Toggle2 = Section:AddToggle("Infinite Jump", { flag = "Toggle_Flag2", default = false }, function(bool)
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
	else
		if getgenv().infjumper == false then
			_G.infinjump = false
		end
	end
end)

local Toggle3 = Section:AddToggle("Fly", { flag = "Toggle_Flag3", default = false }, function(bool)
	getgenv().flyerwow = bool

	if getgenv().flyerwow == true then
		NOFLY()
		wait()
		sFLY()
		if args[1] and isNumber(args[1]) then
			iyflyspeed = args[1]
		end
	else
		if getgenv().flyerwow == false then
			NOFLY()
		end
	end
end)

local Box = Section:AddBox("Fly Speed", { fireonempty = true }, function(text)
	iyflyspeed = text
end)

local Toggle4 = Section2:AddToggle("2X Money Gamepass", { flag = "Toggle_Flag4", default = false }, function(bool)
	if bool == true then
        game:GetService("Players").LocalPlayer.Gamepasses.X2Cash.Value = true
        else if bool == false then
            game:GetService("Players").LocalPlayer.Gamepasses.X2Cash.Value = false
        end
    end
end)

local Toggle5 = Section2:AddToggle("2X Gold Gamepass", { flag = "Toggle_Flag5", default = false }, function(bool)
	if bool == true then
        game:GetService("Players").LocalPlayer.Gamepasses.X2Gold.Value = true
        else if bool == false then
            game:GetService("Players").LocalPlayer.Gamepasses.X2Gold.Value = false
        end
    end
end)

local Toggle6 = Section2:AddToggle("Auto Button Clicker", { flag = "Toggle_Flag6", default = false }, function(bool)
	if bool == true then
        _G.buttonClick = true
            while _G.buttonClick == true do
                local ClickDetector = game:GetService("Workspace").TakenPlots.bqndl.Button.Hit.Use 
	            fireclickdetector(ClickDetector, 50, "LeftMouseClick")
                wait()
            end
        else if bool == false then
            _G.buttonClick = false
            while _G.buttonClick == true do
                local ClickDetector = game:GetService("Workspace").TakenPlots.bqndl.Button.Hit.Use 
	            fireclickdetector(ClickDetector, 50, "LeftMouseClick")
                wait()
            end
        end
    end
end)

local Toggle7 = Section2:AddToggle("Anti AFK", { flag = "Toggle_Flag7", default = false }, function(bool)
            
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
            
end)

local Button = Section2:AddButton("Rejoin Server", function()
    	
    local ts = game:GetService("TeleportService")
        
    local p = game:GetService("Players").LocalPlayer
        
    ts:Teleport(game.PlaceId, p)
    	
end)
    
local Button2 = Section2:AddButton("Server Hop", function()
    	
    local Servers = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for i,v in pairs(Servers.data) do
        if v.playing ~= v.maxPlayers then
        	game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, v.id)
        end
    end
    	
end)

local Picker = Section3:AddPicker("Change UI Color", { color = Color3.fromRGB(90, 179, 80) }, function(color)
    Window:SetAccent(color)
end)
    
local Label = Section3:AddLabel("Programmed by Ducky#3566")
    
local Button3 = Section3:AddButton("Copy Discord Invitation", function()
    	
    setclipboard("https://discord.gg/t2wWA3hph3")
    Library:Notify({title = "Alert", text = "Copied Discord Invitation!", color = Color3.fromRGB(90, 179, 80)}, function(v)
    	    
    end)
    	
end)
    
local Bind = Section3:AddBind("Toggle UI", Enum.KeyCode.RightControl, {toggleable = false, default = false, flag = "Bind_Flag1"}, function(keycode)
    Window:SetKey(keycode)
end)
    
Library:Notify({title = "Notification", text = "Loaded.", color = Color3.fromRGB(90, 179, 80)}, function(v)
    	    
end)
