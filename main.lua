local lplr = game.Players.LocalPlayer
local http_request = syn and syn.request or request;
local unsupported_games = loadstring(game:HttpGet("https://raw.githubusercontent.com/3jm/demonware/main/unsupported"))()
local vercheck = loadstring(game:HttpGet("https://raw.githubusercontent.com/3jm/demonware/main/ver"))()
local gameId = game.PlaceId
local dwversion = "1.1"
print("Checking version...")
for q,v in pairs(vercheck) do
    if dwversion ~= v then
        print("New version found, loading...")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/3jm/demonware/main/main.lua"))()
    else
        print("Latest Version.".. dwversion)
        print("Checking game...")
        for _,e in pairs(unsupported_games) do
            if e == gameId then
                lplr:Kick("DËMONWARË is unsupported in this game.")
            else
                print("Supported, Loading...")
                local DarkraiX = loadstring(game:HttpGet("https://raw.githubusercontent.com/GamingScripter/Kavo-Ui/main/Darkrai%20Ui", true))()
            
                local Library = DarkraiX:Window("DËMONWARË   ","","",Enum.KeyCode.RightControl);
            
                local camera = game:GetService("Workspace").CurrentCamera
                local CurrentCamera = workspace.CurrentCamera
                local worldToViewportPoint = CurrentCamera.worldToViewportPoint
                local HeadOff = Vector3.new(0,0.5,0)
                local LegOff = Vector3.new(0,3,0)
                local ps = game:GetService("Players")
                local lp = ps.LocalPlayer
                local c = workspace.CurrentCamera
                local rs = game:GetService("RunService")
            
                Tab1 = Library:Tab("Visuals")
            
                Tab1:Seperator("DËMONWARË")
            
                local global_esp_settings = {
                    enabled = false,
                    teamcheck = false,
                    boxoutline = false,
                    distanceesp = false,
                    boxvisibility = false,
                    boxfilled = false,
                    tracers = false,
                    nameesps = false,
                    chams = false,
                    healthbar = false
                }
            
                Tab1:Toggle(
                    "Enabled",
                    false, 
                    function(espToggle)
                        if espToggle then
                            global_esp_settings.enabled = true
                        else
                            global_esp_settings.enabled = false
                        end
                    end)
                
                Tab1:Toggle(
                    "Team Check",
                    false,
                    function (teamchecktoggle)
                        if teamchecktoggle then
                            global_esp_settings.teamcheck = true
                        else
                            global_esp_settings.teamcheck = false
                        end
                    end
                )
            
                for i,v in pairs(game.Players:GetChildren()) do
                    local BoxOutline = Drawing.new("Square")
                    BoxOutline.Visible = global_esp_settings.boxoutline
                    BoxOutline.Color = Color3.fromRGB(0,0,255)
                    BoxOutline.Thickness = 3
                    BoxOutline.Transparency = 1
                    BoxOutline.Filled = false
                
                    local Box2 = Drawing.new("Square")
                    Box2.Visible = global_esp_settings.boxvisibility
                    Box2.Color = Color3.fromRGB(255,255,255)
                    Box2.Thickness = 2
                    Box2.Transparency = 0.6
                    Box2.Filled = false
                
                    local Box = Drawing.new("Square")
                    Box.Visible = global_esp_settings.boxvisibility
                    Box.Color = Color3.fromRGB(1,1,1)
                    Box.Thickness = 1
                    Box.Transparency = 0.4
                
                    local text = Drawing.new("Text")
                    text.Visible = false
                    text.Center = true
                    text.Outline = false
                    text.Font = 3
                    text.Color = Color3.fromRGB(255,255,255)
                    text.Size = 13
                
                    --local HealthBarOutline = Drawing.new("Square")
                    --HealthBarOutline.Thickness = 3
                    --HealthBarOutline.Filled = false
                    --HealthBarOutline.Visible = global_esp_settings.healthbar
                    --HealthBarOutline.Color = Color3.new(0,0,0)
                    --HealthBarOutline.Transparency = 1
                
                    --local HealthBar = Drawing.new("Square")
                    --HealthBar.Thickness = 1
                    --HealthBar.Filled = false
                    --HealthBar.Visible = global_esp_settings.healthbar
                    --HealthBar.Transparency = 1
                
                    function boxesp()
                        game:GetService("RunService").RenderStepped:Connect(function()
                            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lp and v.Character.Humanoid.Health > 0 then
                                local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
                            
                                local RootPart = v.Character.HumanoidRootPart
                                local Head = v.Character.Head
                                local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                                local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
                                local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)
                            
                                if onScreen and global_esp_settings.boxvisibility and global_esp_settings.enabled then
                                    BoxOutline.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                    BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                                    BoxOutline.Visible = global_esp_settings.boxoutline
                                
                                    Box2.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                    Box2.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                                    Box2.Visible = global_esp_settings.boxvisibility
                                
                                    Box.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                                    Box.Visible = global_esp_settings.boxvisibility
                                    Box.Filled = global_esp_settings.boxfilled
                                
                                    text.Text = v.Name
                                    text.Position = Vector2.new(Box.Position.X + Box.Size.X / 2, Box.Size.Y + Box.Position.Y - 17)
                                    text.Visible = global_esp_settings.nameesps
                                    
                                    -- HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
                                    -- HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)
                                    -- HealthBarOutline.Visible = global_esp_settings.healthbar
                                
                                    -- HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (game:GetService("Players")[v.Character.Name].Character.Health / math.clamp(game:GetService("Players")[v.Character.Name].Character.Health, 0, game:GetService("Players")[v.Character.Name].Character:WaitForChild("MaxHealth"))))
                                    -- HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1 / HealthBar.Size.Y))
                                    -- HealthBar.Color = Color3.fromRGB(255 - 255 / (game:GetService("Players")[v.Character.Name].Character.MaxHealth / game:GetService("Players")[v.Character.Name].Character.Health), 255 / (game:GetService("Players")[v.Character.Name].Character.MaxHealth / game:GetService("Players")[v.Character.Name].Character.Health), 0)
                                    -- HealthBar.Visible = global_esp_settings.healthbar
                                
                                    if global_esp_settings.teamcheck and v.TeamColor == lplr.TeamColor then
                                        --- Our Team
                                        --HealthBar.Visible = false
                                        --HealthBarOutline.Visible = false
                                        BoxOutline.Visible = false
                                        Box.Visible = false
                                        Box2.Visible = false
                                        text.Visible = false
                                    else
                                        ---Enemy Team
                                        --HealthBarOutline.Visible = true
                                        --HealthBar.Visible = true
                                        BoxOutline.Visible = true
                                        Box.Visible = true
                                        Box2.Visible = true
                                        text.Visible = global_esp_settings.nameesps
                                    end
                                else
                                    --HealthBar.Visible = false
                                    --HealthBarOutline.Visible = false
                                    BoxOutline.Visible = false
                                    Box.Visible = false
                                    Box2.Visible = false
                                    text.Visible = false
                                end
                            else
                                --HealthBar.Visible = false
                                --HealthBarOutline.Visible = false
                                BoxOutline.Visible = false
                                Box.Visible = false
                                Box2.Visible = false
                                text.Visible = false
                            end
                        end)
                    end
                    coroutine.wrap(boxesp)()
                end
                game.Players.PlayerAdded:Connect(function(v)
                    local BoxOutline = Drawing.new("Square")
                    BoxOutline.Visible = global_esp_settings.boxoutline
                    BoxOutline.Color = Color3.fromRGB(0,0,255)
                    BoxOutline.Thickness = 3
                    BoxOutline.Transparency = 1
                    BoxOutline.Filled = false
                
                    local Box2 = Drawing.new("Square")
                    Box2.Visible = global_esp_settings.boxvisibility
                    Box2.Color = Color3.fromRGB(255,255,255)
                    Box2.Thickness = 2
                    Box2.Transparency = 0.6
                    Box2.Filled = false
                
                    local Box = Drawing.new("Square")
                    Box.Visible = global_esp_settings.boxvisibility
                    Box.Color = Color3.fromRGB(1,1,1)
                    Box.Thickness = 1
                    Box.Transparency = 0.4
                
                    local text = Drawing.new("Text")
                    text.Visible = false
                    text.Center = true
                    text.Outline = false
                    text.Font = 3
                    text.Color = Color3.fromRGB(255,255,255)
                    text.Size = 13
                
                    --local HealthBarOutline = Drawing.new("Square")
                    --HealthBarOutline.Thickness = 3
                    --HealthBarOutline.Filled = false
                    --HealthBarOutline.Visible = global_esp_settings.healthbar
                    --HealthBarOutline.Color = Color3.new(0,0,0)
                    --HealthBarOutline.Transparency = 1
                
                    --local HealthBar = Drawing.new("Square")
                    --HealthBar.Thickness = 1
                    --HealthBar.Filled = false
                    --HealthBar.Visible = global_esp_settings.healthbar
                    --HealthBar.Transparency = 1
                
                    function boxesp()
                        game:GetService("RunService").RenderStepped:Connect(function()
                            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lp and v.Character.Humanoid.Health > 0 then
                                local Vector, onScreen = camera:worldToViewportPoint(v.Character.HumanoidRootPart.Position)
                            
                                local RootPart = v.Character.HumanoidRootPart
                                local Head = v.Character.Head
                                local RootPosition, RootVis = worldToViewportPoint(CurrentCamera, RootPart.Position)
                                local HeadPosition = worldToViewportPoint(CurrentCamera, Head.Position + HeadOff)
                                local LegPosition = worldToViewportPoint(CurrentCamera, RootPart.Position - LegOff)
                            
                                if onScreen and global_esp_settings.boxvisibility and global_esp_settings.enabled then
                                    BoxOutline.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                    BoxOutline.Position = Vector2.new(RootPosition.X - BoxOutline.Size.X / 2, RootPosition.Y - BoxOutline.Size.Y / 2)
                                    BoxOutline.Visible = global_esp_settings.boxoutline
                                
                                    Box2.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                    Box2.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                                    Box2.Visible = global_esp_settings.boxvisibility
                                
                                    Box.Size = Vector2.new(2500 / RootPosition.Z, HeadPosition.Y - LegPosition.Y)
                                    Box.Position = Vector2.new(RootPosition.X - Box.Size.X / 2, RootPosition.Y - Box.Size.Y / 2)
                                    Box.Visible = global_esp_settings.boxvisibility
                                    Box.Filled = global_esp_settings.boxfilled
                                
                                    text.Text = v.Name
                                    text.Position = Vector2.new(Box.Position.X + Box.Size.X / 2, Box.Size.Y + Box.Position.Y - 17)
                                    text.Visible = global_esp_settings.nameesps
                                    
                                    -- HealthBarOutline.Size = Vector2.new(2, HeadPosition.Y - LegPosition.Y)
                                    -- HealthBarOutline.Position = BoxOutline.Position - Vector2.new(6,0)
                                    -- HealthBarOutline.Visible = global_esp_settings.healthbar
                                
                                    -- HealthBar.Size = Vector2.new(2, (HeadPosition.Y - LegPosition.Y) / (game:GetService("Players")[v.Character.Name].Character.Health / math.clamp(game:GetService("Players")[v.Character.Name].Character.Health, 0, game:GetService("Players")[v.Character.Name].Character:WaitForChild("MaxHealth"))))
                                    -- HealthBar.Position = Vector2.new(Box.Position.X - 6, Box.Position.Y + (1 / HealthBar.Size.Y))
                                    -- HealthBar.Color = Color3.fromRGB(255 - 255 / (game:GetService("Players")[v.Character.Name].Character.MaxHealth / game:GetService("Players")[v.Character.Name].Character.Health), 255 / (game:GetService("Players")[v.Character.Name].Character.MaxHealth / game:GetService("Players")[v.Character.Name].Character.Health), 0)
                                    -- HealthBar.Visible = global_esp_settings.healthbar
                                
                                    if global_esp_settings.teamcheck and v.TeamColor == lplr.TeamColor then
                                        --- Our Team
                                        --HealthBar.Visible = false
                                        --HealthBarOutline.Visible = false
                                        BoxOutline.Visible = false
                                        Box.Visible = false
                                        Box2.Visible = false
                                        text.Visible = false
                                    else
                                        ---Enemy Team
                                        --HealthBarOutline.Visible = true
                                        --HealthBar.Visible = true
                                        BoxOutline.Visible = true
                                        Box.Visible = true
                                        Box2.Visible = true
                                        text.Visible = global_esp_settings.nameesps
                                    end
                                
                                else
                                    --HealthBar.Visible = false
                                    --HealthBarOutline.Visible = false
                                    BoxOutline.Visible = false
                                    Box.Visible = false
                                    Box2.Visible = false
                                    text.Visible = false
                                end
                            else
                                --HealthBar.Visible = false
                                --HealthBarOutline.Visible = false
                                BoxOutline.Visible = false
                                Box.Visible = false
                                Box2.Visible = false
                                text.Visible = false
                            end
                        end)
                    end
                    coroutine.wrap(boxesp)()
                end)
            
                Tab1:Toggle(
                    "Box",
                    true,
                    function (BoxToggle)
                        if BoxToggle then
                            global_esp_settings.boxvisibility = true
                        else
                            global_esp_settings.boxvisibility = false
                        end
                    end
                )
            
                -- Tab1:Toggle(
                --     "Health Bar",
                --     true,
                --     function(healthtoggle)
                --         if healthtoggle then
                --             global_esp_settings.healthbar = true
                --         else
                --             global_esp_settings.healthbar = false
                --         end
                --     end
                -- )
            
                Tab1:Toggle(
                    "Box Fill",
                    true,
                    function (toggleboxfill)
                        if toggleboxfill then
                            global_esp_settings.boxfilled = true
                        else
                            global_esp_settings.boxfilled = false
                        end
                    end
                )
            
                Tab1:Toggle(
                    "Names",
                    true,
                    function (togglenameesp)
                        if togglenameesp then
                            global_esp_settings.nameesps = true
                        else
                            global_esp_settings.nameesps = false
                        end
                    end
                )
            
                local tracerorigin = 1
                local tracertransparency = 0.75
                local tracertarget = "HumanoidRootPart"
            
                for i, v in pairs(game.Players:GetChildren()) do
                    local Tracer = Drawing.new("Line")
                    Tracer.Visible = false
                    Tracer.Thickness = 1
                    Tracer.Transparency = tracertransparency
                
                    function lineesp()
                        game:GetService("RunService").RenderStepped:Connect(function()
                            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                                local Vector, OnScreen = camera:worldToViewportPoint(v.Character[tracertarget].Position)
                                if OnScreen and global_esp_settings.tracers and global_esp_settings.enabled then
                                    Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / tracerorigin)
                                    Tracer.To = Vector2.new(Vector.X, Vector.Y)
                                    if global_esp_settings.teamcheck and v.TeamColor == lplr.TeamColor then
                                        -- Teammates Snapline
                                        Tracer.Color = Color3.fromRGB(255, 255, 255)
                                        Tracer.Visible = false
                                    else
                                        Tracer.Visible = true
                                        Tracer.Color = Color3.fromRGB(255, 255, 255)
                                        -- Enemy Snapline
                                    end
                                else
                                    Tracer.Visible = false
                                end
                            else
                                Tracer.Visible = false
                            end
                        end)
                    end
                    coroutine.wrap(lineesp)()
                end
            
                game.Players.PlayerAdded:Connect(function(v)
                    local Tracer = Drawing.new("Line")
                    Tracer.Visible = false
                    Tracer.Thickness = 1
                    Tracer.Transparency = tracertransparency
                
                    function lineesp()
                        game:GetService("RunService").RenderStepped:Connect(function()
                            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                                local Vector, OnScreen = camera:worldToViewportPoint(v.Character[tracertarget].Position)
                                if OnScreen and global_esp_settings.tracers and global_esp_settings.enabled then
                                    Tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / tracerorigin)
                                    Tracer.To = Vector2.new(Vector.X, Vector.Y)
                                    if global_esp_settings.teamcheck and v.TeamColor == lplr.TeamColor then
                                        -- Teammates Snapline
                                        Tracer.Color = Color3.fromRGB(255, 255, 255)
                                        Tracer.Visible = false
                                    else
                                        Tracer.Visible = true
                                        Tracer.Color = Color3.fromRGB(255, 255, 255)
                                        -- Enemy Snapline
                                    end
                                else
                                    Tracer.Visible = false
                                end
                            else
                                Tracer.Visible = false
                            end
                        end)
                    end
                    coroutine.wrap(lineesp)()
                end)
            
                Tab1:Toggle(
                    "Tracers",
                    false,
                    function (toggletracers)
                        if toggletracers then
                            global_esp_settings.tracers = true
                        else
                            global_esp_settings.tracers = false
                        end
                    end
                )
            
                Tab1:Dropdown(
                    "Tracer Target",
                    {"Head",
                    "Chest"},
                    function(target)
                        if target == "Head" then
                            tracertarget = "Head"
                        elseif target == "Chest" then
                            tracertarget = "HumanoidRootPart"
                        end
                    end
                )
            
                Tab1:Dropdown(
                    "Tracer Origin",
                    {"Top",
                    "Bottom"},
                    function(origin)
                        if origin == "Top" then
                            tracerorigin = 100
                        elseif origin == "Bottom" then
                            tracerorigin = 1
                        end
                    end
                )
            
                Tab2 = Library:Tab("Misc")
                Tab2:Seperator("DËMONWARË")
                Tab2:Button("Rejoin (may crash)", function()
                    game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
                end)
            
                Tab3 = Library:Tab("About")
                Tab3:Seperator("DËMONWARË")
                Tab3:Seperator("I Plan on adding a lot more to this script")
                Tab3:Seperator("in the future, for now its only visuals.")
                Tab3:Seperator("Follow the github progress below.")
                Tab3:Seperator("https://github.com/3jm/demonware")
                Tab3:Seperator("- Blind#6756 -")
            
                Tab1:Line()
                print("Loaded DËMONWARË !")
            end
        end
    end
end
