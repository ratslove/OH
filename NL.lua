if game.PlaceId == 3956818381 then
        local lib = loadstring(game:HttpGet"https://raw.githubusercontent.com/bruvzz/ducklibrary/main/src.lua")()
    
    local win = lib:Window("Oasis Hub - Ninja Legends",Color3.fromRGB(233, 255, 107), Enum.KeyCode)
    
    local maintab = win:Tab('Islands')
    local maintab2 = win:Tab('Islands 2')
    local charactertab = win:Tab('Main')
    local areatab = win:Tab('Areas')
    local misctab = win:Tab('Misc')
    local elementtab = win:Tab('Elements')
    local uitab = win:Tab('UI')
    local credstab = win:Tab('Credits')
    
    maintab:Button('Enchanted Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(80, 766, -188)
    
    end)
    
    maintab:Button('Mythical Souls Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-128, 39439, 173)
    
    end)
    
    maintab:Button('Winter Wondlerland Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(183, 46010, 36)
    
    end)
    
    maintab:Button('Dragon Legend Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(188, 59594, 24)
    
    end)
    
    maintab:Button('Golden Master Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(166, 52607, 34)
    
    end)
    
    maintab:Button('Midnight Shadow Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(180, 33206, 28)
    
    end)
    
    maintab:Button('Astral Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(233, 2013, 331)
    
    end)
    
    maintab:Button('Mystical Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(165, 4047, 51)
    
    end)
    
    maintab:Button('Space Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(186, 5656, 76)
    
    end)
    
    maintab:Button('Tundra Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(189, 9284, 31)
    
    end)
    
    maintab2:Button('Sandstorm Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(135, 17686, 61)
    
    end)
    
    maintab2:Button('Ancient Inferno Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(171, 28255, 39)
    
    end)
    
    maintab2:Button('Eternal Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(139, 13680, 74)
    
    end)
    
    maintab2:Button('Thunderstorm Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(108, 24069, 84)
    
    end)
    
    maintab2:Button('Cybernetic Legends Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(226, 66669, 15)
    
    end)
    
    maintab2:Button('Skystorm Ultraus Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(197, 70270, 8)
    
    end)
    
    maintab2:Button('Chaos Legends Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(119, 74442, 52)
    
    end)
    
    charactertab:Toggle('Auto Belt', false, function(v)
    
        getgenv().buybelts = v
        while true do
            if not getgenv().buybelts then return end
            local A_1 = "buyAllBelts"
            local A_2 = "Inner Peace Island"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1, A_2)
            wait(0.5)
        end
    
    
    end)
    
    charactertab:Toggle('Auto Sword', false, function(v)
    
        getgenv().buyswords = v
        while true do
            if not getgenv().buyswords then return end
            local A_1 = "buyAllSwords"
            local A_2 = "Inner Peace Island"
            local Event = game:GetService("Players").LocalPlayer.ninjaEvent
            Event:FireServer(A_1, A_2)
            wait(0.5)
        end
    
    end)
    
    charactertab:Toggle('Auto Swing', false, function(v)
    
        getgenv().autoswing = v
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
    
    charactertab:Toggle('Auto Sell', false, function(v)
    
        getgenv().autosell = v
        while true do
            if getgenv().autoswing == false then return end
            game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            wait(0.1)
            game:GetService("Workspace").sellAreaCircles["sellAreaCircle16"].circleInner.CFrame = CFrame.new(0,0,0)
            wait(0.1)
        end
    
    end)
    
    charactertab:Button('Unlock All Islands', function()
    
        local oldcframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        for _,v in pairs(game:GetService("Workspace").islandUnlockParts:GetChildren()) do
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
            wait(0.3)
        end
        wait(0.3)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = oldcframe

        
    
    end)
    
    areatab:Button('Mystical Waters', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(344, 8824, 125)
    
    end)
    
    areatab:Button('Lava Pit', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-128, 12952, 274)
    
    end)
    
    areatab:Button('Tornado', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(320, 16872, -17)
    
    end)
    
    areatab:Button('Sword of Legends', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1831, 38, -140)
    
    end)
    
    areatab:Button('Sword of Ancients', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(613, 38, 2411)
    
    end)
    
    areatab:Button('Elemental Tornado', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(323, 30383, -10)
    
    end)
    
    areatab:Button('Fallen Infinity Blade', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1859, 38, -6788)
    
    end)
    
    areatab:Button('Zen Masters Blade', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5019, 38, 1614)
    
    end)
    
    misctab:Button('Infinity Stats Dojo', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-4109.91553, 122.94751, -5908.6845)
    
    end)
    
    misctab:Button('Altar of Elements', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(732.294434, 122.947517, -5908.3461)
    
    end)
    
    misctab:Button('Pet Cloning Altar', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4520.91943, 122.947517, 1401.6312)
    
    end)
    
    misctab:Button('King of the Hill', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(227.120529, 89.8075867, -285.06219)
    
    end)
    
    misctab:Button('Anti Kick', function()
    
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
        vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        wait(1)
        vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
        end)
    
    end)
    
    elementtab:Button('Frost Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Frost")
    
    end)
    
    elementtab:Button('Electral Chaos Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Electral Chaos")
    
    end)
    
    elementtab:Button('Lightning Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Lightning")
    
    end)
    
    elementtab:Button('Inferno Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Inferno")
    
    end)
    
    elementtab:Button('Masterful Wrath Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Masterful Wrath")
    
    end)
    
    elementtab:Button('Shadow Charge Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadow Charge")
    
    end)
    
    elementtab:Button('Shadowfire Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Shadowfire")
    
    end)
    
    elementtab:Button('Eternity Storm Element', function()
    
        game.ReplicatedStorage.rEvents.elementMasteryEvent:FireServer("Eternity Storm")
    
    end)
    
    elementtab:Button('Soul Fusion Island', function()
    
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(193, 79746, 18)
    
    end)
    
    uitab:Button('Rejoin Server', function()
    
        local ts = game:GetService("TeleportService")
    
        local p = game:GetService("Players").LocalPlayer
    
        ts:Teleport(game.PlaceId, p)
    
    end)
    
    uitab:Colorpicker("Change UI Color",Color3.fromRGB(233, 255, 107), function(t)
        lib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
    end)
    
    credstab:Label('Owner/Founder: Grant1ed#4919')
    credstab:Label('Lead Developer/Scripter: Ducky#3566')
    
    credstab:Button("Copy Discord Invite", function()
        
        setclipboard("https://discord.gg/t2wWA3hph3")
        lib:Notification("Success", "Copied Discord Invite to clipboard.", "Close")
    
    end)
    
end
