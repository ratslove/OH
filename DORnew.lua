local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")

local flags = {
        
    speed = 15,
    draweraura = false,
    instapp= false,
    hintrush = false,
    noa90 = false
        
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/UI-Libraries/main/Vynixius/Source.lua"))()

-- Create Window
local Window = Library:AddWindow({
    title = {"Oasis Hub", "The Rooms"},
    theme = {
        Accent = Color3.fromRGB(185, 13, 1)
    },
    key = Enum.KeyCode.RightControl,
    default = true
})

-- Create Tab
local Tab = Window:AddTab("Local Player", {default = false})
local Tab2 = Window:AddTab("Utilities", {default = false})
local Tab3 = Window:AddTab("ESP", {default = false})
local Tab4 = Window:AddTab("Other", {default = false})


-- Create Section
local Section = Tab:AddSection("Player", {default = false})
local Section2 = Tab2:AddSection("Utilities", {default = false})
local Section3 = Tab2:AddSection("Bypasses", {default = false})
local Section4 = Tab3:AddSection("ESP", {default = false})
local Section5 = Tab4:AddSection("Other", {default = false})

local Slider = Section:AddSlider("WalkSpeed", 15, 22, 15, {toggleable = true, default = false, flag = "Slider_Flag1", fireontoggle = true, fireondrag = true, rounded = true}, function(val, bool)
                
    if bool == true then
        hum.WalkSpeed = val
        flags.speed = val
        else if bool == false then
            hum.WalkSpeed = 15
            flags.speed = 0
                    
        end
    end
    
end)

task.spawn(function()
    while true do
        if hum.WalkSpeed < flags.speed then
            hum.WalkSpeed = flags.speed
        end

        task.wait()
    end
end)

local fovThing;
local Slider2 = Section:AddSlider("Field of View", 70, 120, 70, {toggleable = true, default = false, flag = "Slider_Flag2", fireontoggle = true, fireondrag = true, rounded = true}, function(val, bool)
    
    if bool == true then

    fovThing = val

        else if bool == false then
            
            fovThing = 70     
                    
        end
    end

end)

game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        game:GetService("Workspace").CurrentCamera.FieldOfView = fovThing
    end)
end)

function randomString()
    local length = math.random(10,20)
    local array = {}
    for i = 1, length do
    array[i] = string.char(math.random(32, 126))
    end
    return table.concat(array)
end

local NoClipping = nil
floatName = randomString()

function NoclipLoop()
    if Clip == false and game.Players.LocalPlayer.Character ~= nil then
        for _, child in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
            if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= floatName then
                child.CanCollide = false
            end
        end
    end
end

local Toggle = Section:AddToggle("NoClip", {flag = "Toggle_Flag1", default = false}, function(bool)
    
    getgenv().nokiz = bool
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

local Toggle2 = Section2:AddToggle("Fix Lighting", {flag = "Toggle_Flag2", default = false}, function(bool)

    getgenv().autoLight = bool

    if getgenv().autoLight == true then
            
            _G.ToggleAmbient = true
            
            game.Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    
        else if getgenv().autoLight == false then
            
                _G.ToggleAmbient = false
                
                game.Lighting.Ambient = Color3.fromRGB(160, 160, 160)
        
        end
    end

end)

game.Lighting.LightingChanged:Connect(function()

    if _G.ToggleAmbient == true then
        
        game.Lighting.Ambient = Color3.fromRGB(255, 255, 255) 
        
        else if _G.ToggleAmbient == false then
            
            game.Lighting.Ambient = Color3.fromRGB(160, 160, 160) 
            
        end
    end
    
end)

local Toggle3 = Section2:AddToggle("Auto Loot", {flag = "Toggle_Flag3", default = false}, function(val)

    flags.draweraura = val
    
    if val then
        local function setup(room)
            local function check(v)
                if v:IsA("Model") then
                    if v.Name == "DrawerContainer" then
                        local knob = v:WaitForChild("Knobs")
                        
                        if knob then
                            local prompt = knob:WaitForChild("ActivateEventPrompt")
                            local interactions = prompt:GetAttribute("Interactions")
                            
                            if not interactions then
                                task.spawn(function()
                                    repeat task.wait(0.1)
                                        if plr:DistanceFromCharacter(knob.Position) <= 12 then
                                            fireproximityprompt(prompt)
                                        end
                                    until prompt:GetAttribute("Interactions") or not flags.draweraura
                                end)
                            end
                        end
                    elseif v.Name == "GoldPile" then
                        local prompt = v:WaitForChild("LootPrompt")
                        local interactions = prompt:GetAttribute("Interactions")
                            
                        if not interactions then
                            task.spawn(function()
                                repeat task.wait(0.1)
                                    if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
                                        fireproximityprompt(prompt) 
                                    end
                                until prompt:GetAttribute("Interactions") or not flags.draweraura
                            end)
                        end
                    elseif v.Name:sub(1,8) == "ChestBox" then
                        local prompt = v:WaitForChild("ActivateEventPrompt")
                        local interactions = prompt:GetAttribute("Interactions")
                        
                        if not interactions then
                            task.spawn(function()
                                repeat task.wait(0.1)
                                    if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
                                        fireproximityprompt(prompt)
                                    end
                                until prompt:GetAttribute("Interactions") or not flags.draweraura
                            end)
                        end
                    elseif v.Name == "RolltopContainer" then
                        local prompt = v:WaitForChild("ActivateEventPrompt")
                        local interactions = prompt:GetAttribute("Interactions")
                        
                        if not interactions then
                            task.spawn(function()
                                repeat task.wait(0.1)
                                    if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
                                        fireproximityprompt(prompt)
                                    end
                                until prompt:GetAttribute("Interactions") or not flags.draweraura
                            end)
                        end
                    end 
                end
            end
    
            local subaddcon
            subaddcon = room.DescendantAdded:Connect(function(v)
                check(v) 
            end)
            
            for i,v in pairs(room:GetDescendants()) do
                check(v)
            end
            
            task.spawn(function()
                repeat task.wait() until not flags.draweraura
                subaddcon:Disconnect() 
            end)
        end
        
        local addconnect
        addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
            setup(room)
        end)
        
        for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
            if room:FindFirstChild("Assets") then
                setup(room) 
            end
        end
        
        repeat task.wait() until not flags.draweraura
        addconnect:Disconnect()
    end


end)

local Toggle4 = Section2:AddToggle("No E Wait", {flag = "Toggle_Flag4", default = false}, function(val)

    flags.instapp = val
    
    local holdconnect
    holdconnect = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
        fireproximityprompt(p)
    end)
    
    repeat task.wait() until not flags.instapp
    holdconnect:Disconnect()

end)

local entityinfo = game.ReplicatedStorage:WaitForChild("EntityInfo")
function message(text)
    local msg = Instance.new("Message",workspace)
    msg.Text = tostring(text)
    task.wait(5)
    msg:Destroy()
    
    --firesignal(entityinfo.Caption.OnClientEvent,tostring(text)) 
end

local a90remote = game.ReplicatedStorage:WaitForChild("EntityInfo"):WaitForChild("A90")
--
local Toggle5 = Section3:AddToggle("Bypass A90", {flag = "Toggle_Flag5", default = false}, function(bool)

    flags.noa90 = bool
        
        if bool then
            local jumpscare = plr.PlayerGui:WaitForChild("MainUI"):WaitForChild("Jumpscare"):FindFirstChild("Jumpscare_A90")
           
            if jumpscare then
                jumpscare.Parent = nil
                
                a90remote.Parent = nil
                repeat task.wait()
                    game.SoundService.Main.Volume = 1 
                until not flags.noa90
                jumpscare.Parent = plr.PlayerGui.MainUI.Jumpscare
                a90remote.Parent = entityinfo 
            end
        end


end)

local Label = Section4:AddLabel("Coming Soon!")

local Picker = Section5:AddPicker("Change UI Color", {color = Color3.fromRGB(185, 13, 1)}, function(color)
    Window:SetAccent(color)
end)

local Toggle6 = Section5:AddToggle("Anti AFK", {flag = "Toggle_Flag6", default = false}, function(bool)
                
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)
                
end)

local entityNames = {"RushMoving","AmbushMoving","Snare","A60","A120"}
    
local Toggle7 = Section5:AddToggle("Notify for Entities", {flag = "Toggle_Flag7", default = false}, function(val)
                
    flags.hintrush = val
        
    if val then
        local addconnect
        addconnect = workspace.ChildAdded:Connect(function(v)
            if table.find(entityNames,v.Name) then
                repeat task.wait() until plr:DistanceFromCharacter(v:GetPivot().Position) < 1000 or not v:IsDescendantOf(workspace)
                    
                if v:IsDescendantOf(workspace) then
                    Library:Notify({title = "Alert", text = v.Name:gsub("Moving","").." has spawned. Hide quickly!", color = Color3.fromRGB(185, 13, 1)}, function(v)
                    
                    end)
                end
            end
        end) 
            
        repeat task.wait() until not flags.hintrush
        addconnect:Disconnect()
    end
                
end)
            
local Label = Section5:AddLabel("Programmed by Ducky#3566")
        
local Button5 = Section5:AddButton("Copy Discord Invitation", function()
                
    setclipboard("https://discord.gg/t2wWA3hph3")
    Library:Notify({title = "Alert", text = "Copied Discord Invitation!", color = Color3.fromRGB(185, 13, 1)}, function(v)
                    
    end)
                
end)
        
local Bind = Section5:AddBind("Toggle UI", Enum.KeyCode.RightControl, {toggleable = false, default = false, flag = "Bind_Flag"}, function(keycode)
    Window:SetKey(keycode)
end)
            
Library:Notify({title = "Notification", text = "Loaded.", color = Color3.fromRGB(185, 13, 1)}, function(v)
                    
end)
