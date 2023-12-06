local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Nexus Hub", HidePremium = false, IntroText = "Con Cu Bu", SaveConfig = true, ConfigFolder = "nexus.nexus/BloxFruit/Main/"})

nexus = {
  Point = {},
  MasteryWeapon = "Blox Fruit",
  MasterySkills = {
    Z = {},
    X = {},
    C = {},
    V = {},
    F = {}
    }
  }
  
SCRIPT_CFG = {

    Workspace = ".nexus/BloxFruit/main",

    Config_Define = game.Players.LocalPlayer.Name,
    Config_Type = ".json"
  }
  
function noti(a, b, c)

  pcall(function () 
  OrionLib:MakeNotification({
	Name = a or "Nexus Notify",
	Content = b or "Con Me May Bel",
	Image = "rbxassetid://4483345998",
	Time = c or 5
})end)
end
function deploy() 
  if not isfolder(SCRIPT_CFG.Workspace) then
    makefolder(SCRIPT_CFG.Workspace)
  end
  if not isfile(SCRIPT_CFG.Workspace.."/"..SCRIPT_CFG.Config_Define..SCRIPT_CFG.Config_Type) then 
    writefile(SCRIPT_CFG.Workspace.."/"..SCRIPT_CFG.Config_Define..SCRIPT_CFG.Config_Type, game:GetService"HttpService":JSONEncode(nexus))
    else
    nexus = game:GetService"HttpService":JSONDecode(readfile(SCRIPT_CFG.Workspace.."/"..SCRIPT_CFG.Config_Define..SCRIPT_CFG.Config_Type))
  end
end
deploy()

function save() 
  if not nexus then 
    return noti(nil, "Wtf???")
  end 
 spawn(function ()
  writefile(SCRIPT_CFG.Workspace.."/"..SCRIPT_CFG.Config_Define..SCRIPT_CFG.Config_Type, game:GetService"HttpService":JSONEncode(nexus))
  end)
end
save()
--Values
nexus.cybograce = true
nexus.minkrace = true
nexus.auto = true 
nexus.AutoAgility = true
nexus.Random_Auto = true
nexus.Melee = true
nexus.Defense = true
nexus.Sword = true
nexus.Gun = true
nexus.Fruit = true
nexus.AutoFarm = true
nexus.SelectStateHaki = true
nexus.InfnityAgility = true
nexus.autobuso = true
nexus.StartTweenIsland = true
nexus.Select_Island = true

--Functions
Gui_Version = "1.0.0";

--Variables
local camera = workspace.CurrentCamera;
local CoreGui = game:GetService("CoreGui");
local uis = game:GetService("UserInputService");
local run = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

local plyr = game.Players.LocalPlayer;
local mouse = plyr:GetMouse();
local char = plyr.Character or plyr.CharacterAdded:Wait();
local hrp = char:WaitForChild("HumanoidRootPart", math.huge);
local hum = char:WaitForChild("Humanoid", math.huge);

--Functions
plyr.CharacterAdded:Connect(function(New_Char)
    char = New_Char;
    hrp = New_Char:WaitForChild("HumanoidRootPart", math.huge);
    hum = New_Char:WaitForChild("Humanoid", math.huge);
end)

function FireAll_ClickDetectors()
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("ClickDetector") then
            fireclickdetector(v);
        end
    end
end

function FireAll_TouchInterests()
    local root = hrp or char:FindFirstChildOfClass("BasePart");
    local function TI_Touch(x)
        x = x:FindFirstAncestorWhichIsA("Part");
        if x and root then
            task.spawn(function()
                firetouchinterest(x, root, 1)
                task.wait();
                firetouchinterest(x, root, 0)
            end)
        end
    end
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("TouchTransmitter") then
            TI_Touch(v);
        end
    end
end


function bM(ab)
  if not ab then return end 
  return ( game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy"..tostring(ab)) == 1 ) or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", ab, "1") == 1
end


--//Aimbot
local aimbot_conn_1 = nil;
local aimbot_conn_2 = nil;
local aimbot_conn_3 = nil;

local aimbot_team_check = false;
local aimbot_radius = 80;
local aimbot_target_part = "Head";
local aimbot_strict_team_check = false;

function Aimbot_GetClosestVisiblePlayer()
    local t = nil;
    local OnScreen = {};
    local MaxDistance = math.huge;
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p.UserId ~= plyr.UserId then
            local function aimbot_getplayer_check()
                local c = p.Character;
                if c then
                    local r = nil;
                    if aimbot_target_part == "Head" then
                        r = c:FindFirstChild("Head");
                    elseif aimbot_target_part == "Torso" then
                        r = c:FindFirstChild("UpperTorso") or c:FindFirstChild("HumanoidRootPart") or c:FindFirstChild("Torso");
                    end
                    if r then
                        pcall(function()
                            local Visible = camera:WorldToScreenPoint(r.Position);
                            if Visible then
                                local v1 = Vector2.new(uis:GetMouseLocation().X, uis:GetMouseLocation().Y);
                                local v2 = Vector2.new(Visible.X, Visible.Y);
                                local VectorDistace = (v1-v2).Magnitude;
                                if VectorDistace < aimbot_radius then
                                    table.insert(OnScreen, r);
                                end
                            end
                        end)
                    end
                end
            end
            if aimbot_team_check == true then
                if p.TeamColor ~= plyr.TeamColor then
                    if aimbot_strict_team_check then
                        if p.Team ~= plyr.Team then
                            aimbot_getplayer_check();
                        end
                    else
                        aimbot_getplayer_check();
                    end
                end
            else
                aimbot_getplayer_check();
            end
        end
    end
    for _, root in pairs(OnScreen) do
        if hrp and root then
            local Distance = (hrp.Position - root.Position).Magnitude;
            if Distance < MaxDistance then
                MaxDistance = Distance;
                t = root;
            end
        end
    end
    return t;
end

function ToggleAimbot(E)
    if E then
        local function Aimbot_Activate(e)
            if e then
                aimbot_conn_1 = run.Heartbeat:Connect(function()
                    task.spawn(function()
                        local ClosestVisiblePart = Aimbot_GetClosestVisiblePlayer();
                        if ClosestVisiblePart then
                            pcall(function()
                                camera.CFrame = CFrame.new(camera.CFrame.Position, ClosestVisiblePart.Position);
                            end)
                        end
                    end)
                end)
            else
                pcall(function()
                    aimbot_conn_1:Disconnect();
                end)
                aimbot_conn_1 = nil;
            end
        end
        aimbot_conn_2 = mouse.Button2Down:Connect(function()
            Aimbot_Activate(true);
        end)
        aimbot_conn_3 = mouse.Button2Up:Connect(function()
            Aimbot_Activate(false);
        end)
    else
        pcall(function()
            aimbot_conn_1:Disconnect();
        end)
        aimbot_conn_1 = nil;
        pcall(function()
            aimbot_conn_2:Disconnect();
        end)
        aimbot_conn_2 = nil;
        pcall(function()
            aimbot_conn_3:Disconnect();
        end)
        aimbot_conn_3 = nil;
    end
end
--//

--//Esp
local esp_conn_1 = nil;
local esp_conn_2 = nil;
local esp_conn_3 = nil;

local esp_transparency = 0.5;
local esp_blacklist_team = false;
local esp_enabled = false;
local esp_strict_team_blacklist = false;

function esp_update_esp_t()
    for _, v in pairs(CoreGui:GetChildren()) do
        if string.find(v.Name, "_ESP") and v:IsA("Folder") then
            for _, v in pairs(v:GetChildren()) do
                if v:IsA("BoxHandleAdornment") then
                    v.Transparency = esp_transparency;
                end
            end
        end
    end
end

function esp_update_esp_b(toggle_main)
    for _, v in pairs(game.Players:GetPlayers()) do
        if v ~= plyr then
            local function esp_update_start(toggle)
                local folder = CoreGui:FindFirstChild(v.Name.."_ESP");
                if toggle then
                    if folder then
                        for _, t in pairs(folder:GetChildren()) do
                            if t:IsA("BoxHandleAdornment") then
                                t:Destroy();
                            end
                        end
                    end
                else
                    if not folder then
                        folder = Instance.new("Folder", CoreGui);
                        folder.Name = v.Name.."_ESP";
                    end
                    if folder and #folder:GetChildren() <= 0 then
                        if esp_enabled then
                            local v_char = v.Character;
                            if v_char then
                                for _, t in pairs(v_char:GetChildren()) do
                                    if t:IsA("BasePart") then
                                        local bha = Instance.new("BoxHandleAdornment", folder);
                                        bha.Adornee = t;
                                        bha.Size = t.Size;
                                        bha.ZIndex = 10;
                                        bha.Transparency = esp_transparency;
                                        bha.AlwaysOnTop = true;
                                        bha.Color = v.TeamColor;
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if toggle_main then
                if (v.TeamColor ~= plyr.TeamColor) then
                    if (esp_strict_team_blacklist == true) then
                        if (v.Team ~= plyr.Team) then
                            esp_update_start(false);
                        else
                            esp_update_start(true);
                        end
                    else
                        esp_update_start(false);
                    end
                else
                    esp_update_start(true);
                end
            else
                esp_update_start(false);
            end
        end
    end
end

function ToggleEsp(toggle)
    if toggle then
        local function Esp_PlayerFound(p)
            local esp_char_conn1 = nil;
            local esp_char_conn2 = nil;
            local esp_plyr_conn1 = nil;
            local folder = CoreGui:FindFirstChild(p.Name.."_ESP");
            if not folder then
                folder = Instance.new("Folder", CoreGui);
                folder.Name = p.Name.."_ESP";
            end
            if p ~= plyr then
                local function esp_disconnect_functions()
                    pcall(function()
                        esp_char_conn1:Disconnect();
                        esp_char_conn2:Disconnect();
                        esp_plyr_conn1:Disconnect();
                    end)
                    esp_char_conn1 = nil;
                    esp_char_conn2 = nil;
                    esp_plyr_conn1 = nil;
                end
                local function Esp_CharFound(c)
                    if not toggle then
                        esp_disconnect_functions();
                        return;
                    end
                    if esp_blacklist_team == true then
                        if (p.TeamColor == plyr.TeamColor) then
                            if esp_strict_team_blacklist == true then
                                if (p.Team == plyr.Team) then
                                    return;
                                end
                            else
                                return;
                            end
                        end
                    end
                    task.spawn(function()
                        task.wait();
                        for _, v in pairs(c:GetChildren()) do
                            if v:IsA("BasePart") then
                                local bha = Instance.new("BoxHandleAdornment", folder);
                                bha.Adornee = v;
                                bha.Size = v.Size;
                                bha.ZIndex = 10;
                                bha.Transparency = esp_transparency;
                                bha.AlwaysOnTop = true;
                                bha.Color = p.TeamColor;
                            end
                        end
                    end)
                    esp_char_conn2 = c.ChildAdded:Connect(function(child)
                        if child:IsA("BasePart") then
                            if folder then
                                local bha = Instance.new("BoxHandleAdornment", folder);
                                bha.Adornee = child;
                                bha.Size = child.Size;
                                bha.ZIndex = 10;
                                bha.Transparency = esp_transparency;
                                bha.AlwaysOnTop = true;
                                bha.Color = p.TeamColor;
                            end
                        end
                    end)
                end
                if p.Character then
                    Esp_CharFound(p.Character);
                end
                esp_char_conn1 = p.CharacterAdded:Connect(Esp_CharFound);
                esp_plyr_conn1 = p.Changed:Connect(function(property)
                    if property == "TeamColor" then
                        if folder then
                            for _, v in pairs(folder:GetChildren()) do
                                if v:IsA("BoxHandleAdornment") then
                                    v.Color = p.TeamColor;
                                end
                            end
                        end
                    end
                    if property == "Team" then
                        if folder then
                            for _, v in pairs(folder:GetChildren()) do
                                if v:IsA("BoxHandleAdornment") then
                                    v.Color = p.TeamColor;
                                end
                            end
                        end
                        esp_update_esp_b(esp_blacklist_team);
                    end
                end)
            end
        end
        for _, v in pairs(game.Players:GetPlayers()) do
            Esp_PlayerFound(v);
        end
        esp_conn_1 = game.Players.PlayerAdded:Connect(function(plyr)
            Esp_PlayerFound(plyr);
        end)
        esp_conn_2 = game.Players.PlayerRemoving:Connect(function(p)
            local gui_found = CoreGui:FindFirstChild(p.Name.."_ESP");
            if gui_found then
                gui_found:Destroy();
            end
        end)
        esp_conn_3 = plyr.Changed:Connect(function(property)
            if property == "Team" or property == "TeamColor" then
                ToggleEsp(false);
                task.wait();
                if esp_enabled == true then
                    ToggleEsp(true);
                end
            end
        end)
    else
        pcall(function()
            esp_conn_1:Disconnect();
        end)
        esp_conn_1 = nil;
        pcall(function()
            esp_conn_2:Disconnect();
        end)
        esp_conn_2 = nil;
        pcall(function()
            esp_conn_3:Disconnect();
        end)
        esp_conn_3 = nil;
        for _, v in pairs(CoreGui:GetChildren()) do
            if string.find(v.Name, "_ESP") and v:IsA("Folder") then
                v:Destroy();
            end
        end
    end
end
--//

--//Inf Jump
local inf_jump_conn1 = nil;
local inf_jump_conn2 = nil;

local inf_jump_can_jump = true;

function ToggleInfJump(toggle)
    if toggle then
        inf_jump_conn1 = uis.JumpRequest:Connect(function()
            if (hum) and (hum.Health > 0) and (inf_jump_can_jump == true) then
                hum:ChangeState(Enum.HumanoidStateType.Jumping);
                inf_jump_can_jump = false;
            end
        end)
        inf_jump_conn2 = uis.InputEnded:Connect(function(input, _)
            if input.KeyCode == Enum.KeyCode.Space then
                inf_jump_can_jump = true;
            end
        end)
    else
        pcall(function()
            inf_jump_conn1:Disconnect();
        end)
        inf_jump_conn1 = nil;
        pcall(function()
            inf_jump_conn2:Disconnect();
        end)
        inf_jump_conn2 = nil;
    end
end

function cybograce()
	while nexus.cybograce == true do
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,300,0)
		wait(.01)
	 end
	end

function minkrace()
	while nexus.minkrace == true do
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0,10,0)
		wait(.01)
	 end
	end

function auto()
	while nexus.auto do wait()
		for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
    		if v.ClassName == "Model" then
        		v.Humanoid.Health = die
		 wait(.1)
		end
		end
     end 
     end

function AutoAgility()
	while nexus.AutoAgility == true do
		game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
		wait(.01)
	 end
	end

function Random_Auto()
	while nexus.Random_Auto == true do
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
		wait(.01)
	 end
	end


	local function ToTarget(a)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a
		end
		ToTarget(CFrame.new(-1884.7747802734375, 19.327526092529297, -11666.8974609375))
	getgenv().Totarget = function(a)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = a
		end
 	getgenv().Totarget (CFrame.new(0,0,0))

--Tabs

function update(label, list, text) 
        text2 = ""
          for i, v in pairs(list) do 
            print(i, v)
            if v then 
           print(text2)
              text2 = text2..i.." "
            end
            
          end
          label:Set(text, text2)
end

            function CheckSea(e) 
              if sussea then 
              if sussea == e then return true end
              else
               if game.PlaceId == 2753915549 then
                  if e == 1 then 
                    sussea = 1
                     return true
                  end
               elseif  game.PlaceId == 4442272183 then
                  if e == 2 then
                    sussea = 2
                     return true
                  end
               elseif  game.PlaceId == 7449423635 then
                  if e == 3 then
                    sussea = 3
                     return true
                  end
               end
               return false
            end
end 

local Q = require(game.ReplicatedStorage.Quests)

         local R = {"BartiloQuest", "Trainees", "MarineQuest", "CitizenQuest"}

         function checkq()
            local T = game.Players.LocalPlayer.Data.Level.Value
            local min = 0
            if T >= 1450 and game.PlaceId == 4442272183 then
               Mob1 = "Water Fighter"
               Mob2 = "ForgottenQuest"
               Mob3 = 2
            elseif  T >= 700 and game.PlaceId == 2753915549 then
               Mob1 = "Galley Captain"
               Mob2 = "FountainQuest"
               Mob3 = 2
            
            
               else
                  for r, v in pairs(Q) do
                     for M, N in pairs(v) do
                        local U = N.LevelReq
                        for O, P in pairs(N.Task) do
                           if T >= U and U >= min and N.Task[O] > 1 and not table.find(R, tostring(r)) then
                              min = U
                              Mob1 = tostring(O)
                              Mob2 = r
                              Mob3 = M
                           end
                        end
                     end
                  end
               end
         end
          
            function CFrameQuest()
               QuestPoses = {}
               for r, v in pairs(getnilinstances()) do
                  if
                  v:IsA("Model") and v:FindFirstChild("Head") and v.Head:FindFirstChild("QuestBBG") and
                  v.Head.QuestBBG.Title.Text == "QUEST" and v.Name ~= "Villager"
                  then
                     QuestPoses[v.Name] = v:WaitForChild"HumanoidRootPart".CFrame * CFrame.new(0, -2, 2)
                  end
               end
               for r, v in pairs(game.Workspace.NPCs:GetDescendants()) do
                  if v.Name == "QuestBBG" and v.Title.Text == "QUEST" and v.Parent.Parent.Name ~= "Villager" then
                     QuestPoses[v.Parent.Parent.Name] = v.Parent.Parent.HumanoidRootPart.CFrame * CFrame.new(0, -2, 2)
                  end
               end
               DialoguesList = {}
               for r, v in pairs(require(game.ReplicatedStorage.DialoguesList)) do
                  DialoguesList[v] = r
               end
               local V = getscriptclosure(game:GetService("Players").LocalPlayer.PlayerScripts.NPC)
               local W = {}
               for k, v in pairs(debug.getprotos(V)) do
                  if #debug.getconstants(v) == 1 then
                     table.insert(W, debug.getconstant(v, 1))
                  end
               end
               local X = false
               local Y = {}
               for k, v in pairs(debug.getconstants(V)) do
                  if type(v) == "string" then
                     if v == "Players" then
                        X = false
                     end
                     if not X then
                        if v == "Blox Fruit Dealer" then
                           X = true
                        end
                     else
                     end
                     if X then
                        table.insert(Y, v)
                     end
                  end
               end
               local Z = {}
               QuestPoint = {}
               for k, v in pairs(Y) do
                  if QuestPoses[v] then
                     Z[W[k]] = Y[k]
                  end
               end
               for r, v in next, Z do
                  QuestPoint[r] = QuestPoses[v]
               end
               QuestPoint["SkyExp1Quest"] =
               CFrame.new(
               -7857.28516,
               5544.34033,
               -382.321503,
               -0.422592998,
               0,
               0.906319618,
               0,
               1,
               0,
               -0.906319618,
               0,
               -0.422592998
               )
            end


            function GrayWibi(a)
               if  a and  a.Parent and a:FindFirstChild("Humanoid") and a:FindFirstChild("HumanoidRootPart") and a.Humanoid.Health >= 0 and (a.HumanoidRootPart or a.Character.HumanoidRootPart).CFrame
                then
                  return true
               else
                  return false
               end
            end 
            
 
function vcl(a, b) 
  if a: FindFirstChild"Level" then 
    return a.Level.Value 
   else 
     return b or 0 
  end 
end 
 
         function checkitem(sw)
            local a = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(sw)
            local b =  game.Players.LocalPlayer.Character:FindFirstChild(sw)
            if ( a and a.Name == sw)  then 
              
              return {Mastery = vcl(a , 0)} 
            end 
            
            if ( b and b.Name == sw)  then
              return {Mastery = vcl(b , 0)} 
            end 
            
            for k, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do
               if v.Name == sw then
                  return v
               end
            end
            return false
         end

function CheckBoss(bg) 
  if GrayWibi(game:GetService("ReplicatedStorage"):FindFirstChild(bg) ) then 
    return game:GetService("ReplicatedStorage"):FindFirstChild(bg)  
    end 
  if GrayWibi(game.workspace.Enemies:FindFirstChild(bg) ) then 
    return game.workspace.Enemies:FindFirstChild(bg)  
    end 
end
               

         function CheckDoubleQuest()

            local a = {}
            for r, v in pairs(Q) do
               for M, N in pairs(v) do
                  local U = N.LevelReq
                  for O, P in pairs(N.Task) do
                     if O == Mob1 then
                        for _, a0 in next, v do
                           if a0.LevelReq <= game.Players.LocalPlayer.Data.Level.Value and a0.Name ~= "Town Raid" then
                              for a1, a2 in next, a0.Task do
                                 if a2 > 1 then
                                    table.insert(a, a1)
                                 end
                              end
                           end
                        end
                     end
                  end
               end
            end
            return a 
         end
         local a3 = require(game.ReplicatedStorage:WaitForChild("GuideModule"))
         function CheckQuestData()
            for r, v in next, a3.Data do
               if r == "QuestData" then
                  return true
               end
            end
            return false
         end

         function CheckNameDoubleQuest()
            local a
            if CheckQuestData() then
               for r, v in next, a3.Data.QuestData.Task do
                  a = r
               end
            end
            return a
         end
         function CheckNameDoubleQuest2()
            local a
            local a4 = {}
            if CheckQuestData() then
               for r, v in next, a3.Data.QuestData.Task do
                  a = r
                  table.insert(a4, r)
               end
            end
            return a4
         end

         function CheckDoubleQuest2()
            checkq()
            local a5 = {}
            if
            game.Players.LocalPlayer.Data.Level.Value >= 10 and CheckQuestData() and
            CheckNameDoubleQuest() == Mob1 and
            #CheckNameDoubleQuest() > 2 and nexus.DoubleQuest
            then
               for r, v in pairs(Q) do
                  for M, N in pairs(v) do
                     for O, P in pairs(N.Task) do
                        if tostring(O) == Mob1 then
                           for a6, a7 in next, v do
                              for a8, a9 in next, a7.Task do
                                 if a8 ~= Mob1 and a9 > 1 then
                                    if a7.LevelReq <= game.Players.LocalPlayer.Data.Level.Value then
                                       a5["Name"] = tostring(a8)
                                       a5["NameQuest"] = r
                                       a5["ID"] = a6
                                    else
                                       a5["Name"] = Mob1
                                       a5["NameQuest"] = Mob2
                                       a5["ID"] = Mob3
                                    end
                                    return a5
                                 end
                              end
                           end
                        end
                     end
                  end
               end
            else
               a5["Name"] = Mob1
               a5["NameQuest"] = Mob2
               a5["ID"] = Mob3
               return a5
            end
            a5["Name"] = Mob1
            a5["NameQuest"] = Mob2
            a5["ID"] = Mob3
            return a5
         end
         CFrameQuest() 
         EnemySpawn = {}
         function SpawnPoint() 
           -- if not workspace:FindFirstChild".NEXUS_ENEMYSPAWM" then 
--              main_folder = Instance.new("Folder", workspace)
--              main_folder.Name = ".NEXUS_ENEMYSPAWM"
--            end
--            
          -- mobname = mobname:gsub(" %pLv. %d+%p", ""):gsub(" ", "")
           for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
         if GrayWibi(v) then 
             if not table.find(EnemySpawn, v.Name:gsub(" %pLv. %d+%p", "")) then 
               EnemySpawn[v.Name:gsub(" %pLv. %d+%p", "")] = v.HumanoidRootPart.CFrame
             end 
           end
         end 
         for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do 
           if v.Name and not table.find(EnemySpawn, v.Name) then 
             EnemySpawn[v.Name] = v.CFrame 
           end 
         end 
         for i, v in pairs(getnilinstances()) do 
           pcall (function ()
           if v and v.Name and not EnemySpawn[(v.Name:gsub(" %pLv. %d+%p", ""))] then 
             if math.random(10, 70) == 25 then 
               task.wait() 
             end 
             
         --Tabs    print("Scanning Mob: "..v.Name.." ("..i.." Items Scanned")
             local cach = gqgqj(v)
             if  cach then 
             
               EnemySpawn[v.Name:gsub(" %pLv. %d+%p", "")] = cach
             end 
           end 
           end)
         end 
         end 
       
         
         function GetQuest()
            if game.Players.LocalPlayer.PlayerGui.Main:FindFirstChild("Quest").Visible then
               return
            end
            if not QuestPoint[tostring(CheckDoubleQuest2().NameQuest)] then
               CFrameQuest()
               return
            end
            if
            (QuestPoint[CheckDoubleQuest2().NameQuest].Position -
            game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 8
            then 
              vc = CheckDoubleQuest2()
               CacheMon = vc.Name  
               game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("StartQuest", tostring(vc.NameQuest), vc.ID)
            

            else
               QuestCFrame = QuestPoint[CheckDoubleQuest2().NameQuest]
               to(QuestCFrame) 
               
            end
            
         
         end 
         
local specialitems = {"Special Microchip", "God's Chalice", "Sweet Chalice", "Relic", "Key", "Torch", "Flower 1", "Flower 2", "Flower 3", "Hallow Essence", "Fire Essence", "Holy Torch", "Library Key", "Hidden Key", "Water Key"}
rarity = {
  [0] = "🟤",
  [1] = "🔵",
  [2] = "🟢",
  [3] = "🟡",
  [4] = "🔴",
  [5] = "wtf"
}
function resetable() 
  for i, v in pairs(specialitems) do
  local a1, a2 = game:GetService("Players").LocalPlayer.Backpack: FindFirstChild(v), game:GetService("Players").LocalPlayer.Character: FindFirstChild(v)
    if a1 or a2 then 
      return false 
    end 
  end 
  for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
    if v:FindFirstChild"EatRemote" then return false end 
    end
  for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 
    if v:FindFirstChild"EatRemote" then return false end 
    end
  return true 
end 

 function gqgqj(a) 
   if a: FindFirstChild"HumanoidRootPart" then
     return a.HumanoidRootPart.CFrame 
   end 
   return a.CFrame 
   end
function getSpawn(wtf)
   local a, b = nil, math.huge
   for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(game.Players.LocalPlayer.Team)):GetChildren()) do
      if (v:GetModelCFrame().Position-wtf.Position).Magnitude < b then
         a = v:GetModelCFrame()
         b = (v:GetModelCFrame().Position-wtf.Position).Magnitude
      end
   end
   return a
end
function request(check1)
   game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack({"requestEntrance", check1}))
end

function disnoy(I, II) 
  return (Vector3.new(I.X, 0, I.Z)-Vector3.new(II.X, 0, II.Z)).Magnitude 
end 

function check11()
  return game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible and game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Text and (string.find(string.lower(game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Text),"risk"))
end
function getPortal(check2)
   local check3 = check2.Position
   local w = game.PlaceId
   if w == 2753915549 then
      gQ = {
         Vector3.new(-7894.6201171875, 5545.49169921875, -380.246346191406),
         Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
         Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
         Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
      }
   elseif w == 4442272183 then
      gQ = {
         Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
         Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
         Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
         Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
      }
   elseif w == 7449423635 then
      gQ = {
         Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125),
         Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
         Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
         Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
         Vector3.new(-11993.580078125, 334.7812805175781, -8844.1826171875),
         Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
      }
   end
   local aM, aN = Vector3.new(0,0,0), math.huge

   for _, aL in pairs(gQ) do
      if (aL-check3).Magnitude < aN and (aL-check3).Magnitude < (game.Players.LocalPlayer:DistanceFromCharacter(aL) + 300) and aM ~= aL then
         aM, aN = aL,  (aL-check3).Magnitude
      end
   end
   return aM
end

function cancel()
  pcall(function
    ()
    
    
    sexroblox:Cancel()
    end)
   
end

elite = {"Deandre [Lv. 1750]", "Urban [Lv. 1750]", "Diablo [Lv. 1750]"}

            function getElite()
               for v746, v9471 in pairs(getsortedmon()) do
                  if GrayWibi(v9471) and table.find(elite, v9471.Name) then
                     return v9471
                  end
               end
               for v746, v9471 in pairs(game.ReplicatedStorage:GetChildren()) do
                  if GrayWibi(v9471) and table.find(elite, v9471.Name) then
                     return v9471
                  end
               end
            end
function grgrgrgrg(aE)
pcall(function()
   game.Players.LocalPlayer.Character.Humanoid.Health = 0
   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = aE
   wait(1)
   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = aE
   game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint") 
   end)
end

function giunhabatman()
  pcall(function()
   for a, b in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
      if b:IsA"BasePart" then
         b.CanCollide = false
      end
   end
   if not game.Players.LocalPlayer.Character.Head:FindFirstChild"eltrul" then
       ngu = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.Head)
      ngu.Name = "eltrul"
      ngu.MaxForce = Vector3.new(0,math.huge,0)
      ngu.Velocity = Vector3.new(0,0,0)
   end
end)
end

function check11()
  return game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible and game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Text and (string.find(string.lower(game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Text),"risk"))
end 

function to(position)
    pcall(function()
   game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, position.Y, (game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z))
  end)
   if not game.Players.LocalPlayer.Character:FindFirstChild"Head" then
      repeat task.wait()
      until game.Players.LocalPlayer.Character:FindFirstChild"Head"
   end
    for a, b in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
      if b:IsA"BasePart" then
         b.CanCollide = false
      end
   end
   if not game.Players.LocalPlayer.Character.Head:FindFirstChild"eltrul" then
      local ngu = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.Head)
      ngu.Name = "eltrul"
      ngu.MaxForce = Vector3.new(0,math.huge,0)
      ngu.Velocity = Vector3.new(0,0,0)
   end
   local aaaaaaa = game.Players.LocalPlayer:DistanceFromCharacter(position.Position)
   if aaaaaaa < 150 then
      pcall(function () sexroblox:Cancel() end)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = position
      
   end
   
  -- local aH, aI = getSpawn(position), getPortal(position)

   local aH, aI = getSpawn(position), getPortal(position)
   if nexus.BypassTp and not check11() and disnoy(aI, aH.Position) > 850 and disnoy(position.Position, aH.Position) < disnoy(game.Players.LocalPlayer.Character:GetPrimaryPartCFrame().p,position.Position) and disnoy(game.Players.LocalPlayer.Character:GetPrimaryPartCFrame().p, aH.Position) > 3500 and disnoy(game.Players.LocalPlayer.Character:GetPrimaryPartCFrame().p,aI) > 1500 and game.Players.LocalPlayer:DistanceFromCharacter(position.Position) > 1200 and resetable() then
        cancel()
         grgrgrgrg(aH)
     
      --game.Players.LocalPlayer.Character:FindFirstChild"Head" 

   elseif nexus.requestEntrance and  disnoy(position.Position, aI) < disnoy(game.Players.LocalPlayer.Character:GetPrimaryPartCFrame().p,position.Position) and disnoy(game.Players.LocalPlayer.Character:GetPrimaryPartCFrame().p,aI) > 450 then 
     cancel()
      request(aI) 
    
      end
   
   local bbbbbbbbb = aaaaaaa/nexus.Tspeed
   
  sexroblox = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(bbbbbbbbb, Enum.EasingStyle.Linear),{CFrame = position})

   sexroblox:Play()
   
   return sexroblox
end

             function SizePart(v)
                if not v:FindFirstChild("HumanoidRootPart") then
                   return nil
                end
                v.HumanoidRootPart.CanCollide = false
                v.Humanoid:ChangeState(11)
                if not v.HumanoidRootPart:FindFirstChild"Hold" then
                   local Hold = Instance.new("BodyVelocity", v.HumanoidRootPart)
                   Hold.Name = "Hold"
                   Hold.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                   Hold.Velocity = Vector3.new(0, 0, 0)
                end
             end
            function GetNearestPlayer(as)

               ner = math.huge
               for r, v in pairs(game.Players:GetChildren()) do
                  if v and GrayWibi(v.Character) and (v.Character.HumanoidRootPart.Position - as).Magnitude < ner then
                     ner = (v.Character.HumanoidRootPart.Position - as).Magnitude
                  end
               end
               for r, v in pairs(game.Players:GetChildren()) do
                  if v and GrayWibi(v.Character) and (v.Character.HumanoidRootPart.Position - as).Magnitude <= ner then
                     ner2 = v.Name
                  end
               end
               if game.Players.LocalPlayer.Name == ner2 then
                  return true
               end
            end
   
   network = isnetworkowner or InMyNetWork or newcclosure(function () 
     return true
     end)
   function createcheckthread(data) 
     spawn (function ()
     if not data then return end  
     
     if GrayWibi(data[1]) then 
       data[5] = data[1].Humanoid 
       data[6] = data[5].Health 
       data[7] = os.time()-data[2] 
       data[10] = data[1].HumanoidRootPart.CFrame
       while GrayWibi(data[1]) and wait() do
       if data[1].Humanoid.Health >= data[6] and data[7] > 3 then 
        
         data[1].HumanoidRootPart.CFrame = data[10]
         data[1].Humanoid.Health = 0  
       end
       end 
     end
     end) 
   end 
   
function gnc() 
  
    iroajjrod, kvbahifj = nil, math.huge
    for kejrkaoufha, othabfooahf in pairs(game.Workspace:GetChildren()) do
        if
            string.find(othabfooahf.Name, "Chest")
         then 
          
            if game.Players.LocalPlayer:DistanceFromCharacter(othabfooahf.Position) < kvbahifj then
              
                iroajjrod = othabfooahf
                kvbahifj = game.Players.LocalPlayer:DistanceFromCharacter(othabfooahf.Position)
            end
        end
    end
    return iroajjrod
end

ajaxjaxjaxjax = {}
function BringMob(Mob)
  pcall(function ()
  for i, v in pairs(workspace.Enemies: GetChildren ()) do
   if v.Name == Mob.Name then
                            if (v.HumanoidRootPart.Position-Mob.HumanoidRootPart.Position).Magnitude <= 480 and (v.HumanoidRootPart.Position-Mob.HumanoidRootPart.Position).Magnitude > 10 and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and network(v.HumanoidRootPart)  then 
                              
							createcheckthread({
							  v,
							  os.time()
							})
						--	to(v.HumanoidRootPart.CFrame+getKillVector3())
                                							v.HumanoidRootPart.CFrame = Mob.HumanoidRootPart.CFrame
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							if not nexus.FastAttack then 
							  v.HumanoidRootPart.Size = Vector3.new(80,80,80)
							end
				     v.HumanoidRootPart.CanCollide = false
							
							sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
							v.Humanoid:ChangeState(14)
							v.Humanoid:ChangeState(11) 
              SizePart(v)
                            end 
   end 
  end 
                        end)
                        
end 

            function down(use) -- Send key to client
               game:service("VirtualInputManager"):SendKeyEvent(true, use, false, game)
               task.wait()
               game:service("VirtualInputManager"):SendKeyEvent(false, use, false, game)
            end

            function equip(tooltip)
               local player = game.Players.LocalPlayer
               local character = player.Character or player.CharacterAdded:Wait()
               for _, item in pairs(player.Backpack:GetChildren()) do
                  if item:IsA("Tool") and item.ToolTip == tooltip then
                     local humanoid = character:FindFirstChildOfClass("Humanoid")
                     if humanoid and not humanoid:IsDescendantOf(item) then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(item)
                        return item
                     end
                  end
               end

               return false
            end
            -- 
            
     
function getKillVector3(pos)
    nexus.Kangle = nexus.Kangle + nexus.Kspeed
    return pos + Vector3.new(math.sin(math.rad(nexus.Kangle)) * nexus.Kradius, nexus.Ky, math.cos(math.rad(nexus.Kangle)) * nexus.Kradius)
end

function MonStuff(mon) 
  BringMob(mon) 
 if nexus.Buso then 
       Buso() 
       end
      to(getKillVector3(mon.HumanoidRootPart.CFrame))
  spawn(function ()
  if vailoz then return end 
  vailoz = true
  if nexus.StartMasteryFarm and ((mon.Humanoid.Health/mon.Humanoid.MaxHealth)*100) < nexus.HealthToSendSkills then
    equip(nexus.MasteryWeapon)
    for lq, ql in pairs(nexus.MasterySkills) do 
      if ql[1] then 
      to(getKillVector3(mon.HumanoidRootPart.CFrame))
        down(lq, ql[2]) 
      end 
    end 
    else
  equip(nexus.Weapon) 
  end
  vailoz = false
 end)
 end

function getsortedmon()
    local beo = game.Players.LocalPlayer
    local memay = beo.Character:WaitForChild"HumanoidRootPart"
    local chim = workspace.Enemies: GetChildren ()
    local bamaysuccac = {} 
    for i, v in pairs(chim) do 
      if v.Name ~= "PirateBasic" and v.Name ~= "PirateBrigade" and v:FindFirstChild"HumanoidRootPart" then 
        table.insert(bamaysuccac, v) 
       end
      end
    table.sort(bamaysuccac, function(aL, aM)
      
        return beo: DistanceFromCharacter(aL.HumanoidRootPart.Position) < beo: DistanceFromCharacter (aM.HumanoidRootPart.Position) 
    end)
   
   return bamaysuccac

-- return bamaysuccac or game.Workspace.Enemies:GetChildren()
end

function cac1(a) 
  return a:gsub(" %pLv. %d+%p", "") 
end 



local adupi = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework")))[2]
local aP = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local aQ = getupvalues(aP)[2]
local aR = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local aS = getupvalues(aR)[2]
local aT = require(game.ReplicatedStorage.CombatFramework.RigLib)
local aU = tick()
function CameraShaker()
	task.spawn(
		function()
			local b9 = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.CameraShaker)
			while wait() do
				pcall(
					function()
						b9.CameraShakeInstance.CameraShakeState.Inactive = 0
					end
				)
			end
		end
	)
end

function CurrentWeapon()
	local ac = aQ.activeController
	local aW = ac.blades[1]
	if not aW then
		return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
	end
	pcall(
		function()
			while aW.Parent ~= game.Players.LocalPlayer.Character do
				aW = aW.Parent
			end
		end
	)
	if not aW then
		return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
	end
	return aW
end
function getAllBladeHitsPlayers(aX)
	Hits = {}
	local aY = game.Players.LocalPlayer
	local aZ = game:GetService("Workspace").Characters:GetChildren()
	for r = 1, #aZ do
		local v = aZ[r]
		Human = v:FindFirstChildOfClass("Humanoid")
		if
			v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and
				aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5
		 then
			table.insert(Hits, Human.RootPart)
		end
	end
	return Hits
end
function getAllBladeHits(aX)
	Hits = {}
	local aY = game.Players.LocalPlayer
	local a_ = game:GetService("Workspace").Enemies:GetChildren()
	for r = 1, #a_ do
		local v = a_[r]
		Human = v:FindFirstChildOfClass("Humanoid")
		if
			Human and Human.RootPart and Human.Health > 0 and
				aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5
		 then
			table.insert(Hits, Human.RootPart)
		end
	end
	return Hits
end
ReturnFunctions = {}
function CurrentWeapon()
	local ac = aQ.activeController
	local aW = ac.blades[1]
	if not aW then
		return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
	end
	pcall(
		function()
			while aW.Parent ~= game.Players.LocalPlayer.Character do
				aW = aW.Parent
			end
		end
	)
	if not aW then
		return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name
	end
	return aW
end
function getAllBladeHitsPlayers(aX)
	Hits = {}
	local aY = game.Players.LocalPlayer
	local aZ = game:GetService("Workspace").Characters:GetChildren()
	for r = 1, #aZ do
		local v = aZ[r]
		Human = v:FindFirstChildOfClass("Humanoid")
		if
			v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and
				aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5
		 then
			table.insert(Hits, Human.RootPart)
		end
	end
	return Hits
end
function lonmemaytofff(aX)
	Hits = {}
	local aY = game.Players.LocalPlayer
	local a_ = game:GetService("Workspace").Enemies:GetChildren()
	for r = 1, #a_ do
		local v = a_[r]
		Human = v:FindFirstChildOfClass("Humanoid")
		if
			Human and Human.RootPart and Human.Health > 0 and Human.Health ~= Human.MaxHealth and
				aY:DistanceFromCharacter(Human.RootPart.Position) < aX + 5
		 then
			table.insert(Hits, Human.RootPart)
		end
	end
	return Hits
end 


function click2()
	pcall(
		function()
			if game.Players.LocalPlayer.Character.Stun.Value ~= 0 then
				return nil
			end
			local ac = aQ.activeController
			ac.hitboxMagnitude = 55
			if ac and ac.equipped then
				for b0 = 1, 1 do
					local b2 =
						require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
						game.Players.LocalPlayer.Character,
						{game.Players.LocalPlayer.Character.HumanoidRootPart},
						60
					)
					if #b2 > 0 then
						local b3 = debug.getupvalue(ac.attack, 5)
						local b4 = debug.getupvalue(ac.attack, 6)
						local b5 = debug.getupvalue(ac.attack, 4)
						local b6 = debug.getupvalue(ac.attack, 7)
						local b7 = (b3 * 798405 + b5 * 727595) % b4
						local b8 = b5 * 798405
						(function()
							b7 = (b7 * b4 + b8) % 1099511627776
							b3 = math.floor(b7 / b4)
							b5 = b7 - b3 * b4
						end)()
						b6 = b6 + 1
						debug.setupvalue(ac.attack, 5, b3)
						debug.setupvalue(ac.attack, 6, b4)
						debug.setupvalue(ac.attack, 4, b5)
						debug.setupvalue(ac.attack, 7, b6)
						for k, v in pairs(ac.animator.anims.basic) do
							v:Play()
						end 
						
						if
							game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and
								ac.blades[1]
						 then
							game:GetService("ReplicatedStorage").RigControllerEvent:FireServer(
								"weaponChange",
								tostring(CurrentWeapon())
							)
							game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(b7 / 1099511627776 * 16777215), b6+1)
							game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", b2, 2, "")
							
						end
					end
				end
			end
		end
	)
end
spawn(function () 
  while task.wait(nexus.FastAttackDelay or 0.075) do 
    spawn(function ()
      for _, lol in pairs (workspace.Enemies:GetChildren()) do 
        if lol.Humanoid.Health <1 then
          lol:Destroy() 
        end 
      end 
      
    if click then
      if nexus.FastAttack then
      click2() 
      else 
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(1000,1000))
        end
    end
    end)
  end 
end) 
function checkenemy(en) 
  for i, v in pairs(workspace.Enemies:GetChildren()) do
    if cac1(v.Name) == cac1(en) then
      return true 
    end 
  end 
end 

SpawnPoint()
for i, v in pairs (EnemySpawn) do
  print(i, v) 
end 
function whatcheck(sv, l)
  return nexus.FarmMode == sv and nexus.StartFarm and(l or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible)
end
function whatcheck2(sv, l, arg3) 
  arg3 = arg3 or true
  return sv and (l or game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible) and arg3
end

function Buso()
               if (not (game.Players.LocalPlayer.Character:FindFirstChild("HasBuso"))) then
                  local rel = game.ReplicatedStorage

                  rel.Remotes.CommF_:InvokeServer("Buso")
               end
end

function getNextZone() 
 zone = workspace._WorldOrigin.EnemyRegions:GetChildren() 
 index = index or 1 
 index = index + 1 
 if index >= #zone then 
   print(index, #zone)
   index = 1 
 end 
 print(index)
 if zone[index] then 
   return zone[index] 
 end 
 
end 

function yama() 
       local args = {
    [1] = "LoadItem",
    [2] = "Yama"
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
equip("Sword") 
wait(4)
end
function tus() 
       local args = {
    [1] = "LoadItem",
    [2] = "Tushita"
}

game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
equip("Sword") 
wait(4)
end

function cdk() 
  if (checkitem("Yama").Mastery) >= 350  or (checkitem("Tushita").Mastery) >= 350 then
    if not CheckSea(3) then 
      if nexus.FullyMode then 
         MethodFDrop:Set("Bone")
          StartF:Set(true) 
          else 
            noti("Auto Cursed Dual Katana", "Toggle Canceled [Sea 3 Requirements]")
            autocdk:Set(false) 
      end 
          return
    end 
    if checkitem("Cursed Dual Katana") then
      autocdk:Set(false) 
      return noti("Auto Cursed Dual Katana", "Ok") 
    end 
    
    oldCa = Ca
    Ca = {
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","Progress")
      } 
    if not Ca[1].Opened then Ca = oldCa return end
    
      
    
    if Ca[1]["Opened"] then
      
      if Ca[1].Evil == 0 then
        noti("Pain and Suffering")
        yama()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil") 
        
        repeat wait() 
          if not workspace.Enemies: FindFirstChild("Mythological Pirate [Lv. 1850]") then 
            to(CFrame.new(-13159.4531, 541.480896, -7722.20264, 0.727798998, 0.109392084, 0.677009583, -0.0310000461, 0.991434634, -0.126871645, -0.685089469, 0.0713497475, 0.724956274)) 
          else 
            to(workspace.Enemies:FindFirstChild"Mythological Pirate [Lv. 1850]".HumanoidRootPart.CFrame)
          end 
        until game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","Progress").Evil == 1
      elseif Ca[1].Good == 0 then
        noti("Dock Legend")
        tus()
         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Good")
        repeat wait()
        for i, v in pairs(getnilinstances()) do 
          if v.Name == "Luxury Boat Dealer" then 
            repeat wait()
            to(v.HumanoidRootPart.CFrame)
            until game.Players.LocalPlayer: DistanceFromCharacter(v.HumanoidRootPart.Position) < 2
            if game.Players.LocalPlayer: DistanceFromCharacter(v.HumanoidRootPart.Position) < 10 then 
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","BoatQuest",v)
            end 
          end
        end
        until game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","Progress").Good == 1
      elseif Ca[1].Evil== 1 then
        noti("Haze Of Misery")
        yama()
        wait(1)
         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","StartTrial","Evil")
        repeat wait()
       
        nameggggg = getNextZone()
        repeat wait() 
          to(nameggggg.CFrame)
        until game.Players.LocalPlayer:DistanceFromCharacter(nameggggg.Position) <= 10
        wait(5)
        for _, m in pairs(getsortedmon()) do
          
          if m:FindFirstChild("HazeESP") then 
            repeat task.wait() 
              pcall(function ()
              click = true 
              MonStuff(m)
              end)
            until not m:FindFirstChild"HazeESP" or not GrayWibi(m)
            click = false
          end 
        end
        until game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CDKQuest","Progress").Evil == 2
      elseif Ca[1].Good == 10 then 
        pcall(function () 
          AutoPirateRaid:Set(true) 
        end) 
        return false 
      elseif Ca[1].Evil == 2 then
        if not CheckBoss("Soul Reaper [Lv. 2100] [Raid Boss]") then
        if nexus.FullyMode then
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1) 
          if checkitem"Hallow Essence" then 
            to(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
          end 
          WeaponDrop:Set("Sword")
        if not nexus.StartFarm or nexus.FarmMode == nil or nexus.FarmMode ~= "Bone" then 
          MethodFDrop:Set("Bone")
          StartF:Set(true) 
        end
        else return false end
        end
        
          else
            repeat wait()
            to(CheckBoss("Soul Reaper [Lv. 2100] [Raid Boss]").HumanoidRootPart.CFrame)
            until game:GetService("Workspace").Map:FindFirstChild("HellDimension") 
            wait(3) 
            for i3,v3 in pairs(game:GetService("Workspace").Map.HellDimension:GetChildren()) do 
              if string.find(v3.Name, 'Torch') and v3:FindFirstChild("ProximityPrompt") then
                if v3.ProximityPrompt.Enabled == true then 
                  repeat wait() 
                    if game.Players.LocalPlayer:DistanceFromCharacter(v3.Position) <= 5 then 
                        fireproximityprompt(v3.ProximityPrompt)
                      else 
                        to(v3.CFrame)
                      end 
                  until v3.ProximityPrompt.Enabled == false 
                end 
              end 
            end 
            repeat wait() 
             for i, v in pairs(getsortedmon()) do 
               pcall(function()
                  if string.find(v.Name, "Cursed Skeleton") or string.find(v.Name, "Hell") then 
                      v.HumanoidRootPart.CanCollide = false
                      sethiddenproperty(
                      game:GetService("Players").LocalPlayer,
                       "SimulationRadius",
                        math.huge)
                      v.Humanoid.Health = 0
                      v:BreakJoints()
                           end
               end ) 
             end 
               
            until not game.Workspace.Enemies:FindFirstChild"Hell's Messenger [Lv. 2200] [Boss]"
             wait(2)
             to(game:GetService("Workspace").Map.HellDimension.Exit.CFrame)
            
            
           
          end
          
      end

  else
    if checkitem("Yama").Mastery < 350 then 
      if nexus.FullyMode then yama() else noti("Yama Mastery Error") end
        end
    if checkitem("Tushita").Mastery < 350 then 
      if nexus.FullyMode then tushita() else noti("Yama Mastery Error") end
    end 
      
      if nexus.FullyMode then 
        WeaponDrop:Set("Sword")
        if not nexus.StartFarm or nexus.FarmMode == nil or string.find(tostring(nexus.FarmMode), "(") then 
          MethodFDrop:Set("Bone")
          StartF:Set(true) 
        end
      end 
  return false
  
end
end


spawn(function()
    while wait() and game.Players.LocalPlayer.Team == nil do
        if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
            repeat
                wait()
                if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
                    if nexus["Team"] == nil or nexus["Team"] == "Pirates" then
                        for i, v in pairs(
                            getconnections(
                                game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated
                            )
                        ) do
                            v.Function()
                        end
                    elseif nexus["Team"] == "Marines" then
                        for i, v in pairs(
                            getconnections(
                                game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Activated
                            )
                        ) do
                            v.Function()
                        end
                    else
                        for i, v in pairs(
                            getconnections(
                                game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated
                            )
                        ) do
                            v.Function()
                        end
                    end
                end
            until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
        end 
    end
end)
repeat wait() until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded() 

          wait(6) 
          
spawn(function ()
  while task.wait(nexus.SaveConfigDelay or 10) do 
    
    SpawnPoint() 
    save() 
  end end) 
  function getAllBoss() 
    gR = {}
    for _, l in pairs(workspace.Enemies:GetChildren()) do 
      if string.find(l.Name, "Boss") then 
        table.insert(gR, l.Name) 
      end
    end 
    for _, l in pairs(game.ReplicatedStorage:GetChildren()) do 
      if string.find(l.Name, "Boss") then 
        table.insert(gR, l.Name) 
      end
    end 
    return gR
    
  end 
  
         function GetInfoBossQuest(cy)
            returnrnrnr = {}
            for r, v in next, require(game:GetService("ReplicatedStorage").Quests) do
               for M, N in next, v do
                  if N.LevelReq <= game.Players.LocalPlayer.Data.Level.Value and N.Name == cy then
                    
returnrnrnr["QuestName"] = r
                     returnrnrnr["QuestId"] = M
                     return returnrnrnr
                     else
                       getqgetq:Set(false)
                  end
               end
            end
         end
         
         function CheckQuestBoss(bg)

            local c5 = bg

            local a
            local ab
            if string.find(c5, " %pRaid Boss%p") then
               a = string.gsub(c5, "%pLv. %d+%p", "")
               ab = string.gsub(a, "  %pRaid Boss%p", "")
            else
               a = string.gsub(c5, "%pLv. %d+%p", "")
               ab = string.gsub(a, "  %pBoss%p", "")
            end
            for r, v in next, require(game:GetService("ReplicatedStorage").Quests) do
               for M, N in next, v do
                  for O, P in next, N.Task do
                     if O == ab then
                        return ab
                     end
                  end
               end
            end
         end
function getQuestBoss(boss) 
  if not GrayWibi(boss) then return end 
  if not string.find(boss.Name, string.gsub(string.gsub(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat ", ""), " %p(0/1)%p", "")) then 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
    noti("Auto Boss", "Abandon Quest [Boss]")
  end 
  local br = GetInfoBossQuest(CheckQuestBoss(boss.Name)) 
  
  game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("StartQuest", tostring(br.QuestName), br.QuestId) 
end 



            function CheckSea(e) 
              if sussea then 
              if sussea == e then return true end
              else
               if game.PlaceId == 2753915549 then
                  if e == 1 then 
                    sussea = 1
                     return true
                  end
               elseif  game.PlaceId == 4442272183 then
                  if e == 2 then
                    sussea = 2
                     return true
                  end
               elseif  game.PlaceId == 7449423635 then
                  if e == 3 then
                    sussea = 3
                     return true
                  end
               end
               return false
            end
end 

            function TeleportSea(e)
               if e == 1 then
                  if not CheckSea(e) then
                     local args = {[1] = "TravelMain"}
                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                     wait()
                  end
               elseif  e == 2 then
                  if not CheckSea(e) then
                     local args = {[1] = "TravelDressrosa"}
                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                  end
               elseif  e == 3 then
                  if not CheckSea(e) then
                     local args = {[1] = "TravelZou"}
                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                  end
               end
            end
            
            function EquipWeaponName(m)
               if not m then
                  return
               end
               NoClip = true
               ToolSe = m
               if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
                  local bi = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
                  wait(.4)
                  game.Players.LocalPlayer.Character.Humanoid:EquipTool(bi)
                  return true
               end
               if game.Players.LocalPlayer.Character:FindFirstChild(m) then
                  return game.Players.LocalPlayer.Character:FindFirstChild(m)
               end
            end

         local bM = {}

         local HttpService = game:GetService("HttpService")
         local bN = "ServerCache"
         function SaveSettings2()
            local HttpService = game:GetService("HttpService")
            if not isfolder(".nexus/Cache/") then
               makefolder(".nexus/Cache/")
            end
            writefile(".nexus/Cache/" .. bN, HttpService:JSONEncode(bM))
         end
         function ReadSetting2()
            local s, o =
            pcall(
            function()
               local HttpService = game:GetService("HttpService")
               Hub = game:GetService("HttpService")
               if not isfolder(".nexus/Cache/") then
                  makefolder(".nexus/Cache/")
               end
               return HttpService:JSONDecode(readfile(".nexus/Cache/" .. bN))
            end
            )
            if s then
               return o
            else
               SaveSettings2()
               return ReadSetting2()
            end
         end
         bM = ReadSetting2()

         function HopServer(bO)
            if not bO then
               bO = 10
            end
            ticklon = tick()
            repeat
               task.wait()
            until tick() - ticklon >= 2
            local function Hop()
               noti("Server Hop", 5)
               for r = 1, 100 do
                  if ChooseRegion == nil or ChooseRegion == "" then
                     ChooseRegion = "Singapore"
                  else
                     game:GetService("Players").LocalPlayer.PlayerGui.ServerBrowser.Frame.Filters.SearchRegion.TextBox.Text =
                     ChooseRegion
                  end
                  local bP = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(r)
                  for k, v in pairs(bP) do
                     if k ~= game.JobId and v["Count"] < bO then
                        if not bM[k] or tick() - bM[k].Time > 60 * 10 then
                           bM[k] = {Time = tick()}
                           SaveSettings2()
                           if game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible then
                              noti("Wait For End InCombat", 15)
                              repeat
                                 wait()

                              until not game:GetService("Players").LocalPlayer or
                              not game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible
                              
                           else
                             
                           end
                           game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", k)
                           return true
                        elseif  tick() - bM[k].Time > 60 * 60 then
                           bM[k] = nil
                        end
                     end
                  end
               end
               return false
            end
            if not getgenv().Loaded then
               local function bQ(v)
                  if v.Name == "ErrorPrompt" then
                     if v.Visible then
                        if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                           HopServer()
                           v.Visible = false
                        end
                     end
                     v:GetPropertyChangedSignal("Visible"):Connect(
                     function()
                        if v.Visible then
                           if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                              HopServer()
                              v.Visible = false
                           end
                        end
                     end
                     )
                  end
               end
               for k, v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren()) do
                  bQ(v)
               end
               game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(bQ)
               getgenv().Loaded = true
            end
            while not Hop() do
               wait()
            end
            SaveSettings2()
         end 
          
         
function saber() 
  if game.Players.LocalPlayer.Data.Level.Value >= 200 then
    if checkitem("Saber") then
      noti("Auto Saber", "Ok")
      autosaber:Set(false) 
      return
    end 
    
    if not CheckSea(1) then
      if nexus.FullyMode then
        TeleportSea(1) 
        noti("Auto Saber", "Teleport To Sea 1") 
        return
        else 
        noti("Auto Saber", "Require Sea 1") 
      end 
    end 
    
    
    if game:GetService("Workspace").Map.Jungle.QuestPlates.Door.CanCollide  then
                  
                     for r, v in next, game:GetService("Workspace").Map.Jungle.QuestPlates:GetChildren() do

                        if v:IsA("Model")  then

                           if v.Button:FindFirstChild("TouchInterest") then
                              pcall(function ()
                                wait(1)
                              game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Button.CFrame
                              end)
                           end
                        end
                     end


                  elseif   game:GetService("Workspace").Map.Desert.Burn.Part.Transparency == 0  then
                     --set("Doing Saber Quest 2: Firing Door On Desert")
                     if not checkitem("Torch")  then
                        to(game:GetService("Workspace").Map.Jungle.Torch.CFrame)
                     else
                       repeat wait()
                        EquipWeaponName("Torch")
                        to(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))
                        until not checkitem"Torch"
                     end


                  elseif  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0  then
                     --set("Doing Saber Quest 3: Killing Mob Leader [Boss]")
                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","GetCup")
                     EquipWeaponName("Cup")
                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","FillCup",game:GetService("Players").LocalPlayer.Character.Cup)
                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan")


                  elseif   game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == nil  then
                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")


                  elseif  game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 and not checkitem"Relic"  then
                     repeat task.wait()
                        local v68 = CheckBoss("Mob Leader [Lv. 120] [Boss]")
                        click= true
                        MonStuff(v68)
                     until game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 or checkitem"Relic"
                     click = false
                  elseif   game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 and game:GetService("Workspace").Map.Jungle.Final.Part.CanCollide   then
                    -- set("Doing Saber Final Quest: Using Relic")
                     game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon")
                     EquipWeaponName("Relic")
                   repeat wait()
                     to(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09, 0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, 0.876514494))
                      until not game:GetService("Workspace").Map.Jungle.Final.Part.CanCollide or not checkitem"Relic"
                  end
                  else 
                    if nexus.FullyMode then 
      MethodFDrop:Set("Level")
      StartF:Set(true) 
      return
      else 
        noti("Auto Saber", "200 Level Requirements")
        autosaber:Set(false)
        return
    end
  end
  if not game:GetService("Workspace").Map.Jungle.Final.Part.CanCollide then
  wboss = CheckBoss("Saber Expert [Lv. 200] [Boss]") 
  if wboss then 
    repeat task.wait()
      click = true 
      MonStuff(wboss)
    until checkitem("Saber") 
    else 
      HopServer() 
  end 
  end
end

function iyama() 
  
     if checkitem("Yama") then 
       autoyama:Set(false) 
       noti("Auto Rengoku", "Found Yama, Turn Off")
       return
     end
     if not CheckSea(3) then 
       if nexus.FullyMode then
         noti("Auto Yama", "Teleport Sea 3")
         TeleportSea(3)
         return
       else 
          autorengoku:Set(false) 
          noti("Auto Yama", "Only 3rd Sea, Turn Off") 
          return
       end 
       autoelite:Set(true) 
       if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter","Progress") >= 30 then
         repeat wait()
           fireclickdetector(game:GetService("Workspace").Map.Waterfall.SealedKatana.Handle.ClickDetector)
         until checkitem"Yama"
        end
     end 
     end
function rengoku() 
  
     if checkitem("Rengoku") then 
       autorengoku:Set(false) 
       noti("Auto Rengoku", "Found Rengoku, Turn Off")
     end
     if not CheckSea(2) then 
       if nexus.FullyMode then
         noti("Auto Rengoku", "Teleport Sea 2")
         TeleportSea(2)
       else 
          autorengoku:Set(false) 
          noti("Auto Rengoku", "Only 2nd Sea, Turn Off") 
       end 
     end 
     if CheckBoss("Awakened Ice Admiral [Lv. 1400] [Boss]") then 
       graygray:Refresh(getAllBoss(), true)
        killsb:Set(true) 
        graygray:Set("Awakened Ice Admiral [Lv. 1400] [Boss]") 
     end 
     if checkitem("Hidden Key") then 
       to(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
                  EquipWeaponName"Hidden Key" 
     end 
end 
              
function mobdrop() 
  print("called", #nexus.ItemDrop)
  if count(nexus.ItemDrop) > 0 then 
    thieunangsucvat = true
    print(1)
    for i, v in pairs(nexus.ItemDrop) do 
      print(2)
      if not checkitem(v) then 
        print(3)
        thieunangsucvat = false 
        local data = droplist[v]
        if data then 
          print(4)
          if CheckSea(data.Sea) then
            print(5)
            local mob = CheckBoss(data.Name) 
            if mob then
              print(6)
              repeat task.wait()
                click = true 
                MonStuff(mob)
              until not GrayWibi(mob) or not nexus.ItemDropEnable 
            elseif nexus.ItemMethod == "Hop If No Requirements" then
              HopServer()
            end 
          elseif nexus.FullyMode then
            print(7)
            TeleportSea(data.Sea) 
          else 
            automobdrop:Set(false)
            noti("Auto Mob Drop", "Only Sea 2")
          end 
        end 
      end 
    end 
    if thieunangsucvat == true then
      TeleportSea(tonumber(nexus.DSea)) 
      end
  end 
end

spawn(function() 
  while task.wait() do 
    x, z = pcall(function()
     
      if nexus.ICursedDualKatana and cdk() then 
      
        
      elseif nexus.AutoElite and getElite() then
        if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible  then 
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
        end
        if not string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, cac1(getElite().Name)) then 
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest") 
          noti("Auto Elite", "Abandon Quest [Elite]")
        end 
        eliteo = getElite() 
        repeat task.wait() 
          click = true
          MonStuff(eliteo) 
        until not GrayWibi(eliteo) or not whatcheck2(nexus.Elite, game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible)
        elseif  nexus.ItemDropEnable and mobdrop() then
      elseif nexus.KillSelectedBoss and SelectBoss and GrayWibi(SelectBoss) then 
        if nexus.GetBossQuest then
          getQuestBoss(SelectBoss) 
        end 
        
        repeat wait() 
          MonStuff(SelectBoss)
          click = true
        until not GrayWibi(SelectBoss) or not whatcheck2(nexus.KillSelectedBoss, (game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible or not nexus.GetBossQuest))
        print ("exit")
        click = false
      elseif nexus.KillAllBoss and #getAllBoss() > 0 then 
        for i, v in pairs(getAllBoss()) do 
          graygray:Refresh(getAllBoss(), true)
          killsb:Set(true) 
          graygray:Set(v)
        end 
        elseif nexus.IRengoku and rengoku() then 
      elseif nexus.IYama and iyama() then 
      elseif nexus.ISaber and saber() then 
      elseif nexus.StartFarm then 
        if nexus.FarmMode == "Level" then
          if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
            GetQuest() 
            return
          end
          if string.gsub(string.gsub(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat . ", ""), "s %p(./.)%p", "") ~= CacheMon then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest") 
            noti("Auto Farm", "Abandon Quest [Level Farm] ["..CacheMon.."]".." ["..string.gsub(string.gsub(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat . .", ""), "s %p(./.)%p", "").."]")
            return 
            end
          lonof = {
             [1] = CacheMon
          } 
          for i, v in pairs(game.Workspace.Enemies:GetChildren()) do 
            if GrayWibi(v) and cac1(v.Name) == lonof[1] then 
              lonof[2] = true 
            end 
          end 
          if not lonof[2] then 
            
            return to(EnemySpawn[lonof[1]]) 
          end 
          for _, gq in pairs(getsortedmon()) do 
            if GrayWibi(gq) and cac1(gq.Name) == lonof[1] then 
              lonof[3] = os.time()
              lonof[4] = gq.Humanoid.Health
               repeat task.wait() 
                  click= true 
                  MonStuff(gq) 
               until not GrayWibi(gq) or ((os.time()-lonof[3] > 15 and gq.Humanoid.Health >= (lonof[4] - 30))) or not whatcheck("Level") or not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible
               click = false
            end 
          end
        elseif nexus.FarmMode == "Bone" then
          lonof = {
            [1] = {
            "Reborn Skeleton [Lv. 1975]",
            "Living Zombie [Lv. 2000]",
            "Demonic Soul [Lv. 2025]",
            "Posessed Mummy [Lv. 2050]"
              }
          }
          if not checkenemy(cac1(lonof[1][math.random(1, #lonof[1])])) then
          to(EnemySpawn[cac1(lonof[1][math.random(1, #lonof[1])])]+Vector3.new(0, 30, 0))
          end
          for _, gq in pairs(getsortedmon()) do 
            if table.find(lonof[1], gq.Name) then 
              lonof[3] = os.time()

              lonof[4] = gq.Humanoid.Health
              repeat task.wait() 
                click= true 
                MonStuff(gq)
              until not GrayWibi(gq) or ((os.time()-lonof[3] > 15 and gq.Humanoid.Health >= (lonof[4] - 30))) or not whatcheck("Bone", true)
              click = false
        end
          end 
        elseif nexus.FarmMode == "Katakuri" then 
        lonof = {
          [1] = {
            "Dough King [Lv. 2300] [Raid Boss]",
            "Cake Prince [Lv. 2300] [Raid Boss]"
         },
         [2] = {
            "Cookie Crafter [Lv. 2200]",
            "Cake Guard [Lv. 2225]",
            "Baking Staff [Lv. 2250]",
            "Head Baker [Lv. 2275]"
         }
        }
        for _, q in pairs(lonof[1]) do
          q = CheckBoss(q)
          if q then 
            repeat task.wait() 
              click= true 
              MonStuff(q) 
            until not GrayWibi(q) 
            click = false
          end
        end
         to(EnemySpawn[cac1(lonof[2][math.random(1, #lonof[1])])]+Vector3.new(0, 30, 0)) 
         for _, gq in pairs(getsortedmon()) do 
            if table.find(lonof[2], gq.Name) then 
              lonof[3] = os.time()

              lonof[4] = gq.Humanoid.Health
              repeat task.wait() 
                click= true 
                MonStuff(gq)
              until not GrayWibi(gq) or ((os.time()-lonof[3] > 15 and gq.Humanoid.Health >= (lonof[4] - 30))) or not whatcheck("Katakuri", true)
                click= false
              
        end
         end 
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner") 
        elseif nexus.FarmMode == "Ectoplasm" then 
          lonof = {
            [1] = {"Ship Deckhand [Lv. 1250]", "Ship Engineer [Lv. 1275]", "Ship Steward [Lv. 1300]"}
          } 
          to(EnemySpawn[cac1(lonof[1][math.random(1, #lonof[1])])]+Vector3.new(0, 30, 0))
          for _, gq in pairs(getsortedmon()) do 
            if table.find(lonof[1], gq.Name) then 
              lonof[3] = os.time()

              lonof[4] = gq.Humanoid.Health
              repeat task.wait() 
                click= true 
                MonStuff(gq)
              until not GrayWibi(gq) or ((os.time()-lonof[3] > 15 and gq.Humanoid.Health >= (lonof[4] - 30))) or not whatcheck("Ectoplasm", true)
              click= false
        end
          end 
    end
      end
    end)
    if not x then warn(z) end
end
end) 

  

  

function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

function grcheck() 
  return game.Players.LocalPlayer.Character:FindFirstChild"Busy" and game.Players.LocalPlayer.Character:FindFirstChild"Busy".Value and nexus.EnableAimbot
end 

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
 
    if self == workspace and not checkcaller() then
        if Method == "FindPartOnRayWithIgnoreList" and target   then
          if nexus and nexus.EnableAimbot then
            
          Origin = Arguments[2].Origin
          Direction = getDirection(Origin, (target.Character.HumanoidRootPart.CFrame*CFrame.new(0,-8,1)).Position)
          Arguments[2] = Ray.new(Origin, Direction) 
          
          end
        end 
    end 
   return oldNamecall(unpack(Arguments)) 
end))

angle= 0
function strafepoint(pos)
    angle = angle + nexus.StrafeSpeed
    return pos + Vector3.new(math.sin(math.rad(angle)) * nexus.StrafeDistance, nexus.StrafeY, math.cos(math.rad(angle)) * nexus.StrafeDistance)
end
function count(gr) 
  q = 0 
  for i, v in pairs(gr) do 
    if v then 
      q = q + 1
    end 
  end 
  return q 
  end 
  function strafe() 


      if game.Players.LocalPlayer.Character.Busy.Value then
        to(target.Character.Head.CFrame)
        else
      to(getKillVector3(target.Character.Head.CFrame)) 
      end
    
    end 
      
spawn(function() 
  while task.wait() do 
    y, s = pcall(function () 
      
      if nexus.TargetFetchMethod == "Nearest" then 
        local qw; lw = nil, math.huge
        for q, w in pairs(game.Players:GetPlayers()) do 
          if game.Players.LocalPlayer:DistanceFromCharacter(w.Character.Head.Position) then
            if w.Name ~= game.Players.LocalPlayer.Name and not nexus.TeamCheck or ( tostring(game.Players.LocalPlayer.Team) == "Pirates" or tostring(game.Players.LocalPlayer.Team) ~= tostring(b.Team)) then 
            qw = w 
            w = game.Players.LocalPlayer:DistanceFromCharacter(w.Character.Head.Position) 
            end
          end 
        end
        target = qw
      end 
    
        
      
    end)
    if not y then warn(s) end
  end 
end)

function GetNearestPlayerFrom(pos) 
  for a, b in pairs(game.Players:GetPlayers()) do 
    if target ~= b and not nexus.TeamCheck or ( tostring(game.Players.LocalPlayer.Team) == "Pirates" or tostring(game.Players.LocalPlayer.Team) ~= tostring(b.Team)) then 
      if b:DistanceFromCharacter(pos) < nexus.HitRange and b.Name ~= game.Players.LocalPlayer.Name then
         target = b 
         noti("Nexus PvP", "Target Champed: "..b.Name)
         break; 
        end 
        end
      end
end 

local function onTouch(input)
    local touchPosition = input.Position
    local clickPosition = workspace.CurrentCamera:ScreenPointToRay(touchPosition.X, touchPosition.Y).Origin
    print(clickPosition)
    GetNearestPlayerFrom(clickPosition)
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
  if nexus.TargetFetchMethod == "Tap" then 
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mouse = game.Players.LocalPlayer:GetMouse()
        local clickPosition = mouse.Hit.p -- Lấy tọa độ 3D của điểm click
        GetNearestPlayerFrom(clickPosition)
    end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
   if nexus.TargetFetchMethod == "Tap" then 
    if not gameProcessedEvent and input.UserInputType == Enum.UserInputType.Touch then
        onTouch(input)
        end
    end
end)


local StatsTab = Window:MakeTab({
 Name = "Con Cac",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

StatsTab:AddParagraph("Work Nào Mấy Em", "Todo: Auto Fully Melee");


local Main = Window:MakeTab({
 Name = "Main",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

Mirage = Main:AddLabel(" [❌] Mirage") 
Moon = Main:AddLabel(" [🌑] Moon")
Elite = Main:AddLabel(" [❌] Elite")
--Dough = Main:AddLabel(" [❌] %s / %s left")
Server = Main:AddLabel(" [🟡] Connecting...")
local wtfwtfwtf = tick() 

local moonTextures = {
    ["http://www.roblox.com/asset/?id=9709149431"] = " [🌕] Full Moon",
    ["http://www.roblox.com/asset/?id=9709149052"] = "[🌔] 75",
    ["http://www.roblox.com/asset/?id=9709143733"] = "[🌗] 50",
    ["http://www.roblox.com/asset/?id=9709150401"] = "[🌒] 25",
    ["http://www.roblox.com/asset/?id=9709149680"] = "[🌑] 0"
}


function isMirageSpawn() 
  return game:GetService("Workspace").Map:FindFirstChild("MysticIsland") 
end 
       

function to_base64(data)
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    return ((data:gsub('.', function(x) 
        local r,b='',x:byte()
        for i=8,1,-1 do r=r..(b%2^i-b%2^(i-1)>0 and '1' or '0') end
        return r;
    end)..'0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
        if (#x < 6) then return '' end
        local c=0
        for i=1,6 do c=c+(x:sub(i,i)=='1' and 2^(6-i) or 0) end
        return b:sub(c+1,c+1)
    end)..({ '', '==', '=' })[#data%3+1])
end 

function caesarCipher(text, key)
    local result = ""

    for i = 1, #text do
        local char = text:sub(i, i)
        if char >= "A" and char <= "Z" then
            local shift = key % 26
            local base = (char:byte() - ("A"):byte() + shift) % 26
            result = result .. string.char(base + ("A"):byte())
        elseif char >= "a" and char <= "z" then
            local shift = key % 26
            local base = (char:byte() - ("a"):byte() + shift) % 26
            result = result .. string.char(base + ("a"):byte())
        else
            result = result .. char
        end
    end

    return result
end



function hash(data) 
  data = tostring(data) 
  data = to_base64(data) 
  a0 = os.date("*t").min
  data = caesarCipher(data, (a0+757462*a0/2)*a0)
  return data
end 
 
 api = ""
 
 function post(name, typeh) 
   warn(game:HttpGet('cringeman.gggggjdksksk.repl.co/discord/post/'..typeh..'?data='..hash({Name=name, ServerId=game.JobId})))
 end 
 
 
posted = {}

spawn(function () 
    local connection = game:HttpGet"https://cringeman.gggggjdksksk.repl.co/api/v1/getInfo" 
    Server:Set(" [❌] Failed To Connect")
    if string.find(connection, "success") then 
      Server:Set(" [🟢] Connected To Server (took "..math.floor((tick()-wtfwtfwtf)*60).."ms)")
    end
    while wait(2) do 
      spawn(function () 
       
        if moonTextures[game:GetService("Lighting").Sky.MoonTextureId] == " [🌕] Full Moon" then 
          if not posted.Moon then
            post("Full Moon", "Moon")
            posted.Moon = true 
          end 
        end 
        
        end)
      spawn(function () 
        Mirage:Set(" [❌] Mirage") 
        if isMirageSpawn() then 
          Mirage:Set(" [🟢] Mirage Spawned") 
        end
        Moon:Set(" [🌑] Moon")  
        
        pcall(function () 
          Moon:Set(moonTextures[game:GetService("Lighting").Sky.MoonTextureId])
        end) 
        Elite:Set(" [❌] Elite [Not Spawn]" )
        if getElite() then 
          Elite:Set(" [🟢] Elite: "..getElite().Name)
        end 
       
      end)
    end 
end)


local Farm = Window:MakeTab({
 Name = "Farm",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})
gG = {
  "Level",
}

if CheckSea(2) then
  table.insert(gG, "Ectoplasm")
  else
  table.insert(gG, "Ectoplasm (2nd Sea)")
  end
if CheckSea(3) then
  table.insert(gG, "Katakuri")
  table.insert(gG, "Bone")
  else
  table.insert(gG, "Katakuri (3rd Sea)")
  table.insert(gG, "Bone (3rd Sea)")
  end

WeaponDrop = Farm:AddDropdown({
  Name = "Weapon",
  Default = nexus.Weapon or "Melee",
  Options = {"Melee", "Sword"},
  Callback = function(v)
    nexus.Weapon = v 
    end
})

MethodFDrop = Farm:AddDropdown({
  Name = "Farm Method",
  Default = nexus.FarmMode,
  Options = gG,
  Callback = function(v)
    nexus.FarmMode = v 
    end
})

StartF = Farm:AddToggle({
  Name = "Start",
  Default = nexus.StartFarm or false,
  Callback = function(v)
    nexus.StartFarm = v 
  end 
})
Farm:AddToggle({
  Name = "Double Quest",
  Default = nexus.DoubleQuest,
  Callback = function(v)
    nexus.DoubleQuest = v 
  end 
})


graygray = Farm:AddDropdown({
  Name = "Select Boss", 
  Options = getAllBoss(),
  Callback = function (v) 
    SelectBoss = CheckBoss(v)
  end
}) 

Farm:AddButton({
  Name = "Refresh Boss",
  Callback = function () 
    graygray:Refresh(getAllBoss(), true)
    end
})

getqgetq = Farm:AddToggle({
  Name = "Get Quest",
  Default = nexus.GetBossQuest or false,
  Callback = function(l) 
    nexus.GetBossQuest = l
    end
})

killsb = Farm:AddToggle({
  Name = "Kill Selected Boss",
  Default = nexus.KillSelectedBoss or false,
  Callback = function(l) 
    nexus.KillSelectedBoss = l
    end
})
Farm:AddToggle({
  Name = "Kill All Boss",
  Default = nexus.KillAllBoss or false,
  Callback = function(l) 
    nexus.KillAllBoss = l
    end
})

Farm:AddDropdown({
  Name = "Select Weapon Mastery",
  Default = nexus.MasteryWeapon,
  Options = {"Blox Fruit", "Gun"},
  Callback = function(v)
    nexus.MasteryWeapon = v 
    end
})


Farm:AddToggle({

  Name = "With Mastery Farm",
  Default = nexus.StartMasteryFarm,
  Callback = function(v)
    nexus.StartMasteryFarm = v 
  end 
})


pt_1 = Farm:AddParagraph("Selected Point Add", "Wait A Little Bit")
 update(pt_1, nexus.Point, "Selected Point Add")
Farm:AddDropdown({
  Name = "Select Point Add",
  Options = {"Melee", "Defense", "Sword", "Gun", "Blox Fruit"},
  Callback = function(l)
   
    if nexus.Point[l] then 
    nexus.Point[l] = false
    noti("Turn Off "..l.." Point")
    else
    noti("Turn On "..l.." Point")
    nexus.Point[l] = true 
    spawn(function()
      repeat task.wait(1)
       local args = {

			[1] = "AddPoint",

			[2] = l,
			[3] = nexus.PointLimit or 1
		}
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
      until not nexus.Point[l]
   	end) 
    end
    update(pt_1, nexus.Point, "Selected Point Add")
  end
})
Farm:AddSlider({
Name = "Point Limit",
Default = nexus.PointLimit or 1,
Min = 1,
Max = 350,
ValueName = "",
Increment = 1,
Callback = function(a)
nexus.PointLimit = a
end
})


--Tabs


local SubFarm = Window:MakeTab({
 Name = "Sub-Farming",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

autoelite = SubFarm:AddToggle({
  Name = "Auto Elite", 
  Default= nexus.AutoElite or false,
  Callback = function (lll) 
    nexus.AutoElite = lll
    end
})

SubFarm:AddToggle({
  Name = "Auto Dough King", 
  Default= nexus.AutoDoughKing or false,
  Callback = function (lll) 
    nexus.AutoDoughKing = lll
    end
})
SubFarm:AddToggle({
  Name = "Auto Trade Bone", 
  Default= nexus.AutoTradeBone or false,
  Callback = function (lll) 
    nexus.AutoTradeBone = lll
    spawn(function () 
      while wait() and nexus.AutoTradeBone do 
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
        end 
      end)
    end
})
local Settings = Window:MakeTab({
 Name = "Settings",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

Settings:AddDropdown({
  Name = "Debug Sea",
  Default = nexus.DSea or "3", 
  Options = {"1","2", "3"},
  Callback = function(v)
    nexus.DSea= v
  end 
  
})
Settings:AddDropdown({
  Name = "Select Team",
  Default = nexus.Team or "Pirates", 
  Options = {"Pirates", "Marines"},
  Callback = function(v)
    nexus.Team = v
  end 
  
})
Settings:AddSlider({
  Name = "Save Config Delay",
  Default = nexus.SaveConfigDelay or 5,
  Min = 5,
  Max = 120,
  Increment = 1,
  ValueName = "s",
  Callback = function(q)
    nexus.SaveConfigDelay= q 
    end
})
Settings:AddSlider({
  Name = "Fast Attack Delay",
  Default = nexus.FastAttackDelay or .075,
  Min = 0,
  Max = .5,
  Increment = .1,
  ValueName = "s",
  Callback = function(q)
    nexus.FastAttackDelay = q 
    end
})

Settings:AddToggle({
  Name = "Fast Attack",
  Default = nexus.FastAttack or true,
  Callback = function(aaaA) 
    nexus.FastAttack = aaaA
    end
})

Settings:AddToggle({
  Name = "Buso",
  Default = nexus.Buso or true,
  Callback = function(l)
    nexus.Buso = l 
    end
})
Settings:AddToggle({
  Name = "Ken",
  Default = nexus.Buso or true,
  Callback = function(l)
    nexus.Ken= l 
    end
})

function ref(a, b, c)
end 


smt_1 = Settings:AddDropdown({
  Name = "Select Mastery Skills",
  Default= nil,
  Options = {"Z", "X", "C", "V", "F"},
  Callback = function(w) 
    if not w then return end 
    if not smt_2 or not smt_3 then return end
    aaO = w
    
    smt_2:Set(nexus.MasterySkills[w][1])
    smt_3:Set(nexus.MasterySkills[w][2] or 0)
    end
})

smt_2 = Settings:AddToggle({
  Name = "Enable",
  Default= false,
  Callback = function(a) 
  if not smt_2 then return end
    if not aaO and a then
      noti(nil, "Please Select Skill First")
      return smt_2:Set(false)
      end
    nexus.MasterySkills[aaO][1] = a
 --   print(game:GetService"HttpService":JSONEncode(nexus))
    end
})

smt_3 = Settings:AddSlider({

  Name = "Skill Hold",
  Default = 0,
  Min = 0,
  Max = 1,
  Increment = .1,
  ValueName = "s",
  Callback = function(q)
    if not aaO then
      noti(nil, "Please Select Skill First")
      return
    end
    nexus.MasterySkills[aaO][2] = q
    end
})

Settings:AddSlider({

  Name = "Health To Using Skills ",
  Default = nexus.HealthToSendSkills or 30,
  Min = 0,
  Max = 100,
  Increment = 1,
  ValueName = "%",
  Callback = function(q) 
    nexus.HealthToSendSkills = q 
  end 
  }) 
Settings:AddSlider({

  Name = "Farm Angles ",
  Default = nexus.Kangle or 30,
  Min = 0,
  Max = 100,
  Increment = 1,
  ValueName = "m",
  Callback = function(q) 
    nexus.Kangle = q 
  end 
  }) 
Settings:AddSlider({

  Name = "Farm Radius",
  Default = nexus.Kradius or 30,
  Min = 0,
  Max = 100,
  Increment = 1,
  ValueName = "m",
  Callback = function(q) 
    nexus.Kradius = q 
  end 
  }) 

Settings:AddSlider({

  Name = "Y Height",
  Default = nexus.Ky or 35,
  Min = 0,
  Max = 100,
  Increment = 1,
  ValueName = "m",
  Callback = function(q) 
    nexus.Ky = q 
  end 
  }) 

Settings:AddSlider({

  Name = "Circle Speed",
  Default = nexus.Kspeed or 40,
  Min = 0,
  Max = 100,
  Increment = 1,
  ValueName = "mps",
  Callback = function(q) 
    nexus.Kspeed = q 
  end 
  }) 

Settings:AddSlider({

  Name = "Tween Speed",
  Default = nexus.Tspeed or 250,
  Min = 10,
  Max = 500,
  Increment = 1,
  ValueName = "mps",
  Callback = function(q) 
    nexus.Tspeed = q 
  end 
  }) 

Settings:AddToggle({
  Name = "Allow Bypass Teleport",
  Default = nexus.BypassTp or true, 
  Callback = function(jjj) 
    nexus.BypassTp = jjj
  end 
})
Settings:AddToggle({
  Name = "Allow Request Entrance",
  Default = nexus.requestEntrance or true, 
  Callback = function(jjj) 
    nexus.requestEntrance = jjj
  end 
})

local Items = Window:MakeTab({
 Name = "Items",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

Items:AddToggle({
  Name = "Fully Mode",
  Default = nexus.FullyMode or true,
  Callback = function(q) 
    nexus.FullyMode = q 
    end 
})
droplist = {
  ["Twin Hooks"] = {
    Name = "Captain Elephant [Lv. 1875] [Boss]",
    Sea = 3
  },
  ["Buddy Sword"] = {
    Name = "Cake Queen [Lv. 2175] [Boss]",
    Sea = 3
  },
  ["Canvander"] = {
    Name = "Beautiful Pirate [Lv. 1950] [Boss]",
    Sea = 3
  },
  ["Hallow Scythe"] = {
    Name = "Soul Reaper [Lv. 2100] [Raid Boss]", 
    Sea = 3
  },
  ["Midnight Blade"] = {
    Name = "Cursed Captain [Lv. 1325] [Raid Boss]",
    Sea = 2,
  }, 
  ["Pole (1st form)"] = {
    Name = "Thunder God [Lv. 575] [Boss]",
    Sea = 1,
  }

}
l1 = {}
for i, v in pairs(droplist) do
  print(i, v)
  table.insert(l1, i) 
end 
wait(1)
Items:AddDropdown({
  Name = "Select Method", 
  Default= nexus.ItemMethod or "Hop If No Requirements",
  Options = {
    "Hop If No Requirements", 
    "Do Another Stuff If No Requirements"
  },
Callback = function(lwkhd) 
  nexus.ItemMethod = lwkhd 
  end 
})

nexus.ItemDrop = nexus.ItemDrop or {}
gr_2 = Items:AddParagraph("Selected Drops Item: ", "Wait") 

Items:AddDropdown({
  Name = "Auto Item Drop", 
  Options = l1,
  Callback = function(sec) 
    if not sec then return end
    if not nexus.ItemDrop[sec] then
      nexus.ItemDrop[sec] = true
    else 
      nexus.ItemDrop[sec] = false
    end 
    noti("Item Drop", sec..": "..tostring(nexus.ItemDrop[sec])..tostring(count(nexus.ItemDrop)))
    update(gr_2, nexus.ItemDrop, "Selected Drops Items:  ")
      
  end 
  
}) 

  update(gr_2, nexus.ItemDrop, "Selected Drops Item: ")

automobdrop = Items:AddToggle({
  Name = "Auto Item Drop",
  Defaut = nexus.ItemDropEnable or false, 
  Callback = function(lll) 
    nexus.ItemDropEnable = lll 
    end
})

autocdk = Items:AddToggle({
  Name = "Auto Cursed Dual Katana",
  Default = nexus.ICursedDualKatana or false ,
  Callback = function (jk) 
    nexus.ICursedDualKatana = jk 
  end 
  
})

autoyama = Items:AddToggle({
  Name = "Auto Yama",
  Default = nexus.IYama or false ,
  Callback = function (jk) 
    nexus.IYama = jk 
  end 
  
})

autotushita = Items:AddToggle({
  Name = "Auto Tushita",
  Default = nexus.ITushita or false ,
  Callback = function (jk) 
    nexus.ITushita = jk 
  end 
  
}) 

autosaber = Items:AddToggle({
  Name = "Auto Saber",
  Default = nexus.ISaber or false ,
  Callback = function (jk) 
    nexus.ISaber= jk 
  end 
  
})

autorengoku = Items:AddToggle({
  Name = "Auto Rengoku",
  Default = nexus.IRengoku or false ,
  Callback = function (jk) 
    nexus.IRengoku = jk 
    
    
  end 
  
})

Items:AddSection({Name="Auto Melee"}) 

autosuperhuman = Items:AddToggle({
  Name = "Auto Superhuman", 
  Default= nexus.AutoSuperhuman or false, 
  Callback = function (k)
    nexus.AutoSuperhuman = k
    end
})
autosuperhuman = Items:AddToggle({
  Name = "Auto Death Step", 
  Default= nexus.AutoDeathStep or false, 
  Callback = function (k)
    nexus.AutoDeathStep = k
    end
})
autosuperhuman = Items:AddToggle({
  Name = "Auto Sharkman Karate", 
  Default= nexus.AutoSharkmanKarate or false, 
  Callback = function (k)
    nexus.AutoSharkmanKarate = k
    end
})
autosuperhuman = Items:AddToggle({
  Name = "Auto Electric Claw", 
  Default= nexus.AutoElectricClaw or false, 
  Callback = function (k)
    nexus.AutoElectricClaw = k
    end
})
autosuperhuman = Items:AddToggle({
  Name = "Auto Dragon Talon", 
  Default= nexus.AutoDragonTalon or false, 
  Callback = function (k)
    nexus.AutoDragonTalon = k
    end
})
autosuperhuman = Items:AddToggle({
  Name = "Auto Godhuman", 
  Default= nexus.AutoGodhuman or false, 
  Callback = function (k)
    nexus.AutoGodhuman = k
    end
})

         function checkMelee(melee)


            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy" .. melee, true) == 1 or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", melee, "1") == 1 then
               return true
            end
if NameMelee() == meleetable4[melee] then return true end
            return false;
         end
         
         browhat = {

            ["Black Leg"] = "BuyBlackLeg",
            ["Fishman Karate"] = "BuyFishmanKarate",
            ["Electro"] = "BuyElectro",
            ["Dragon Claw"] = function()
            dragonclawtrue = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1") == 1
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
            return dragonclawtrue
            end,
            ["Superhuman"] = "BuySuperhuman",
            ["Sharkman Karate"] = "BuySharkmanKarate",
            ["Death Step"] = "BuyDeathStep",
            ["Dragon Talon"] = "BuyDragonTalon",
            ["Godhuman"] = "BuyGodhuman",
            ["Electric Claw"] = "BuyElectricClaw"
         }

         function NameMelee(a)
            a = a or false
            for r, v in next, game:GetService("Players").LocalPlayer.Backpack:GetChildren() do
               if v:IsA("Tool") and v.ToolTip == "Melee" then
                  if a then
                     return v
                  else
                     return v.Name
                  end
               end
            end
            for r, v in next, game:GetService("Players").LocalPlayer.Character:GetChildren() do
               if v:IsA("Tool") and v.ToolTip == "Melee" then
                  if a then
                     return v
                  else
                     return v.Name
                  end
               end
            end
         end
         thua = {}
         function GetAndCheckMeleeMastery(bu, bs)

            mm = bu
            if thua[mm] and NameMelee() ~= mm then return thua[mm] end
            usingmelee = browhat[NameMelee()]
            momo = browhat[mm]
            -- print(bu, mm, usingmelee , momo, browhat[mm])
            --  print(momo)
            if type(momo) == "string" then
               momo = (game.ReplicatedStorage.Remotes.CommF_:InvokeServer(momo, true) == 1)
            else
               momo = momo()
            end
            if momo then
               if
               not game.Players.LocalPlayer.Character:FindFirstChild(mm) and
               not game.Players.LocalPlayer.Backpack:FindFirstChild(mm)
               then
                  momo = browhat[mm]
                  if type(momo) == "string" then
                     game.ReplicatedStorage.Remotes.CommF_:InvokeServer(momo, true)
                     momo = game.ReplicatedStorage.Remotes.CommF_:InvokeServer(momo)
                  else
                     momo = momo()
                  end
               end
               if game.Players.LocalPlayer.Character:FindFirstChild(mm) or game.Players.LocalPlayer.Backpack:FindFirstChild(mm) then
                  kwekrwe = {game.Players.LocalPlayer.Character, game.Players.LocalPlayer.Backpack}
                  for r, v in pairs(kwekrwe) do
                     if v:FindFirstChild(mm) then
                        thua[mm] = v[mm].Level.Value
                        return v[mm].Level.Value
                     end
                  end
               end
            end
            thua[mm] = 0
            return 0
         end

 
 

         function buyMelee(melee)
          --  if table.find(meleetable, melee) then
               pcall(function()
               game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", melee, "2")
               game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy" .. melee) 
               end)
           -- end
         end

spawn(function () 
  while wait() do
  if nexus.AutoSuperhuman and ((checkMelee("Superhuman") and not nexus.FullyMode) or GetAndCheckMeleeMastery("Superhuman") < 400) then
    if GetAndCheckMeleeMastery("Black Leg") < 300 then
      repeat wait(5) 
        buyMelee("BlackLeg")
      until GetAndCheckMeleeMastery("Black Leg") > 299
      end
    if GetAndCheckMeleeMastery("Electric") < 300 then
      repeat wait(5) 
        buyMelee("Electric")
      until GetAndCheckMeleeMastery("Electric") > 299
      end
    if GetAndCheckMeleeMastery("Fishman Karate") < 300 then
      repeat wait(5) 
        buyMelee("FishmanKarate")
      until GetAndCheckMeleeMastery("Fishman Karate") > 299
      end
    if GetAndCheckMeleeMastery("Dragon Claw") < 300 then
      repeat wait(5) 
        if not checkMelee("Dragon Claw") then 
          AutoFullyRaid:Set(true) 
        else 
          AutoFullyRaid:Set(false)
        end 
        
        buyMelee("DragonClaw")
      until GetAndCheckMeleeMastery("Dragon Claw") > 299
    end 
    buyMelee("Superhuman")
   
   elseif GetAndCheckMeleeMastery("Superhuman") > 399 then
     autosuperhuman:Set(false) 
     noti("Auto Superhuman", "Ok Ok") 
   end
   
    end
end)

local PlayerTab = Window:MakeTab({
	Name = "Player",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

PlayerTab:AddLabel("Aiming") 
PlayerTab:AddDropdown({
  Name = "Select Aim Method", 
  Default = nexus.AimMethod or "Hook Position",
  Options = {"Hook Position", "Hook Ray", "Camera Lock"},
  Callback = function (l)
    nexus.AimMethod = l
    end
})

function refreshplayer() 
  if not selectplr then return end 
  local plrsss = {}
  for i, v in pairs(game.Players:GetPlayers()) do 
    table.insert(plrsss, v.Name) 
  end 
  selectplr:Refresh(plrsss, true) 
end 
PlayerTab:AddDropdown({
  Name = "Select Target Fetch Method", 
  Default = nexus.TargetFetchMethod or "Nearest",
  Options = {"Nearest", "Tap"},
  Callback = function (q) 
    nexus.TargetFetchMethod = q
  end
})

selectplr = PlayerTab:AddDropdown({
  Name = "Select Target", 
  Options = {},
  Callback = function (q) 
    if not  game.Players:FindFirstChild(q) then return refreshplayer() end
    target = game.Players:FindFirstChild(q)
    end
})



PlayerTab:AddButton({
  Name = "Refresh Player", 
  Callback = refreshplayer,
})

PlayerTab:AddToggle({
  Name = "Team Check", 
  Default = nexus.TeamCheck or true, 
  Callback = function (l) 
    nexus.TeamCheck = l
  end 
}) 


PlayerTab:AddSlider({
  Name = "Hit Range", 
  Default= nexus.HitRange or 70, 
  Min = 0, 
  Max = 350, 
  Callback = function(q) 
    nexus.HitRange = q 
    end
})
PlayerTab:AddLabel("PvP") 
PlayerTab:AddToggle({
  Name = "Enable Aimbot",
  Default = nexus.EnableAimbot or false, 
  Callback = function(qqqw) 
    nexus.EnableAimbot = qqqw
  end 
 
})

PlayerTab:AddButton({
  Name = "Bring Player [Electric Claw]",
  Callback = function (lll) 
    if lll then 
      equip("Melee") 
      wait(1) 
      down("X", 1) 
      repeat game:GetService("RunService").Stepped:Wait() 
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(target.Character.Head.CFrame) 
      until not game.Players.LocalPlayer.Character.Busy.Value
      end 
    end
}) 

PlayerTab:AddToggle({
  Name = "Strafe Player",
  Default =  false,
  Callback = function(qqqw) 
    StrafePlayer = qqqw
    
    while StrafePlayer and task.wait() do 
   
      pcall(function () 
        strafe() 
        end)
      end

  end 
 
})

PlayerTab:AddSlider({
  Name = "Strafe Distance", 
  Default= nexus.StrafeDistance or 70, 
  Min = 0, 
  Max = 350, 
  Callback = function(q) 
    nexus.StrafeDistance = q 
    end
})

PlayerTab:AddSlider({
  Name = "Strafe Speed", 
  Default= nexus.StrafeSpeed or 70, 
  Min = 0, 
  Max = 350, 
  Callback = function(q) 
    nexus.StrafeSpeed = q 
    end
}) 

PlayerTab:AddSlider({
  Name = "Strafe Y ", 
  Default= nexus.StrafeY or 70, 
  Min = 0, 
  Max = 350, 
  Callback = function(q) 
    nexus.StrafeY = q 
    end
}) 

local RaidTab = Window:MakeTab({
 Name = "Raid",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

local Section = RaidTab:AddSection({
 Name = "Law Boss Raid"
})

RaidTab:AddButton({
	Name = "Buy Microchip Law Boss",
	Callback = function()
      	local args = {
       [1] = "BlackbeardReward",
       [2] = "Microchip",
       [3] = "2"
    }
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  	end    
})

RaidTab:AddButton({
	Name = "Start Boss Raid",
	Callback = function()
      	fireclickdetector(game:GetService("Workspace").Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
  	end    
})

local FruitTab = Window:MakeTab({
 Name = "Fruit",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

FruitTab:AddButton({
	Name = "Random Fruit",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin","Buy")
  	end    
})

FruitTab:AddToggle({
	Name = "Auto Random Fruit",
	Default = false,
	Callback = function(Value)
		nexus.Random_Auto = Value
		Random_Auto()
	end    
})

local TeleportTab = Window:MakeTab({
 Name = "Teleport",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

TeleportTab:AddButton({
	Name = "Teleport To First Sea",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain")
  	end    
})

TeleportTab:AddButton({
	Name = "Teleport To Second Sea",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
  	end    
})

TeleportTab:AddButton({
	Name = "Teleport To Third Sea",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
  	end    
})

local Section = TeleportTab:AddSection({
 Name = "Island Teleport"
})

TeleportTab:AddButton({
	Name = "Mansion",
	Callback = function()
      	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
  	end    
})

if World1 then
    Island = {
        "WindMill",
        "Marine",
        "Middle Town",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Snow Island",
        "MarineFord",
        "Colosseum",
        "Sky Island 1",
        "Sky Island 2",
        "Sky Island 3",
        "Prison",
        "Magma Village",
        "Under Water Island",
        "Fountain City",
        "Shank Room",
        "Mob Island"
        }
elseif World2 then  
    Island = {
        "The Cafe",
        "Frist Spot",
        "Dark Area",
        "Flamingo Mansion",
        "Flamingo Room",
        "Green Zone",
        "Factory",
        "Colossuim",
        "Zombie Island",
        "Two Snow Mountain",
        "Punk Hazard",
        "Cursed Ship",
        "Ice Castle",
        "Forgotten Island",
        "Ussop Island",
        "Mini Sky Island"
        }
else
    Island = {
        "Mansion",
        "Port Town",
        "Great Tree",
        "Castle On The Sea",
        "MiniSky", 
        "Hydra Island",
        "Floating Turtle",
        "Haunted Castle",
        "Ice Cream Island",
        "Peanut Island",
        "Cake Island"
        }	
end

TeleportTab:AddDropdown({
	Name = "Select Island",
	Default = "",
	Options = Island,
	Callback = function(Value)
		nexus.Select_Island = value
	end    
})

local RaceV4Tab = Window:MakeTab({
 Name = "Race v4",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

RaceV4Tab:AddButton({
	Name = "Teleport To Temple Of Time",
	Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14896.8505859375, 102.62469482421875)
  	end    
})

RaceV4Tab:AddButton({
	Name = "Teleport To Red Head Essence",
	Callback = function()
			local TweenService = game:GetService("TweenService")
			local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
			{CFrame = CFrame.new(28981.552734375, 14888.4267578125, -120.245849609375)}):Play()
  	end    
})

local Section = RaceV4Tab:AddSection({
 Name = "Teleport To Race Doors"
})

RaceV4Tab:AddButton({
	Name = "Human Doors",
	Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14896.8505859375, 102.62469482421875)
      		local TweenService = game:GetService("TweenService")
			local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
			{CFrame = CFrame.new(29221.822265625, 14890.9755859375, -205.99114990234375)}):Play()
  	end    
})

RaceV4Tab:AddButton({
	Name = "Skypie Doors",
	Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14896.8505859375, 102.62469482421875)
      		local TweenService = game:GetService("TweenService")
			local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
			{CFrame = CFrame.new(28960.158203125, 14919.6240234375, 235.03948974609375)}):Play()
  	end    
})

RaceV4Tab:AddButton({
	Name = "Fishman Doors",
	Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14896.8505859375, 102.62469482421875)
      		local TweenService = game:GetService("TweenService")
			local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
			{CFrame = CFrame.new(28231.17578125, 14890.9755859375, -211.64173889160156)}):Play()
  	end    
})

RaceV4Tab:AddButton({
	Name = "Cybog Doors",
	Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14896.8505859375, 102.62469482421875)
      		local TweenService = game:GetService("TweenService")
			local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
			{CFrame = CFrame.new(28492.4140625, 14894.4267578125, -422.1100158691406)}):Play()
  	end    
})

RaceV4Tab:AddButton({
	Name = "Ghoul Doors",
	Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14896.8505859375, 102.62469482421875)
      		local TweenService = game:GetService("TweenService")
			local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
			{CFrame = CFrame.new(28674.244140625, 14890.6767578125, 445.4310607910156)}):Play()
  	end    
})

RaceV4Tab:AddButton({
	Name = "Mink Doors",
	Callback = function()
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(28286.35546875, 14896.8505859375, 102.62469482421875)
      		local TweenService = game:GetService("TweenService")
			local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
			{CFrame = CFrame.new(29012.341796875, 14890.9755859375, -380.1492614746094)}):Play()
  	end    
})

local Section = RaceV4Tab:AddSection({
 Name = "Complete Race Trial"
})

RaceV4Tab:AddToggle({
	Name = "Auto Active Race",
	Default = false,
	Callback = function(Value)
		nexus.AutoAgility = Value
		AutoAgility()
	end    
})

RaceV4Tab:AddToggle({
	Name = "Human, Ghoul Race",
	Default = false,
	Callback = function(Value)
		nexus.auto = Value
		auto()
	end    
})

RaceV4Tab:AddButton({
	Name = "Skypie Race",
	Callback = function()
      	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.SkyTrial.Model.FinishPart.CFrame
  	end    
})

RaceV4Tab:AddButton({
	Name = "Mink Race",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace").Map.MinkTrial.Ceiling.CFrame * CFrame.new(0,-5,0)
	end    
})

RaceV4Tab:AddToggle({
	Name = "Cybog Race",
	Default = false,
	Callback = function(Value)
		nexus.cybograce = Value
		cybograce()
	end    
})

RaceV4Tab:AddLabel("============================")

RaceV4Tab:AddButton({
	Name = "Teleport To Safe Zone When Pvp",
	Callback = function()
      		local TweenService = game:GetService("TweenService")
			local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
			{CFrame = CFrame.new(28273.0859375, 14896.5078125, 157.42063903808594)}):Play()
  	end    
})

RaceV4Tab:AddButton({
	Name = "Teleport To PVP Zone",
	Callback = function()
      		local TweenService = game:GetService("TweenService")
			local Tw = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out,0,false,0), 
			{CFrame = CFrame.new(28766.681640625, 14967.1455078125, -164.13290405273438)}):Play()
  	end    
})

local ShopTab = Window:MakeTab({
 Name = "Shop",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})
local Section = ShopTab:AddDropdown({
  Name = "Select Abilitiy",
  Default = "",
  Options = {
    "Geppo",
    "Buso",
    "Soru",
    "Ken Haki",
  },
  Callback = function(aA) 
    if aA == "Ken Haki" then 
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy")
      return 
    end
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki",aA) 
    end
})

local Section = ShopTab:AddDropdown({
  Name = "Select Melee",
  Default = "",
  Options = {"Dragon Talon", "Superhuman", "God human", "Electric Claw", "Sharkman Karate", "Death Step", "Black Leg", "Fishman Karate", "Electro", "Dragon Claw"},
  Callback = function(aA) 
    if not bM(string.gsub(aA, " ", "")) then
      noti(nil, "You Arent Unlocked This Melee Yet")
      end
    end
})

local Section = ShopTab:AddSection({
 Name = "Fighting Style Shop"
})

ShopTab:AddButton({
	Name = "Buy Black Leg",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBlackLeg")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Electron",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectro")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Fishman Karate",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyFishmanKarate")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Dragon Breathe",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","1")
            	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","DragonClaw","2")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Superhuman",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySuperhuman")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Dealth Step",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDeathStep")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Sharkman Karate",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate",true)
            	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuySharkmanKarate")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Electric Claw",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyElectricClaw")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Dragon Talon",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyDragonTalon")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Godhuman",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman")
  	end    
})

local Section = ShopTab:AddSection({
 Name = "Sword Shop"
})

ShopTab:AddButton({
	Name = "Buy Cutlass",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cutlass")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Katana",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Katana")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Iron Mace",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Iron Mace")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Duel Katana",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Duel Katana")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Triple Katana",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Triple Katana")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Pipe",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Pipe")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Dual-Headed Blade",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Dual-Headed Blade")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Bisento",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Bisento")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Soul Cane",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Soul Cane")
  	end    
})

local Section = ShopTab:AddSection({
 Name = "Accessory Shop"
})

ShopTab:AddButton({
	Name = "Buy Tomoe Ring",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Tomoe Ring")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Black Cape",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Black Cape")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Swordsman Hat",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Swordsman Hat")
  	end    
})

local Section = ShopTab:AddSection({
 Name = "Gun Shop"
})

ShopTab:AddButton({
	Name = "Buy Slingshot",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Slingshot")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Musket",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Musket")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Flintlock",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Flintlock")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Refined Flintlock",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Refined Flintlock")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Canon",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem","Cannon")
  	end    
})

ShopTab:AddButton({
	Name = "Buy Kabucha",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","1")
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
  	end    
})

local Section = ShopTab:AddSection({
 Name = "Race Shop"
})

ShopTab:AddButton({
	Name = "Buy Cybog Race",
	Callback = function()
      		local args = {
                [1] = "CyborgTrainer",
                [2] = "Buy"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  	end    
})

ShopTab:AddButton({
	Name = "Buy Ghoul Race",
	Callback = function()
      		local args = {
                [1] = "Ectoplasm",
                [2] = "BuyCheck",
                [3] = 4
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            local args = {
                [1] = "Ectoplasm",
                [2] = "Change",
                [3] = 4
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  	end    
})

ShopTab:AddButton({
	Name = "Random Races",
	Callback = function()
      		local args = {
                [1] = "BlackbeardReward",
                [2] = "Reroll",
                [3] = "2"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  	end    
})

ShopTab:AddButton({
	Name = "Reset Stats",
	Callback = function()
      		local args = {
                [1] = "BlackbeardReward",
                [2] = "Refund",
                [3] = "2"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  	end    
})

ShopTab:AddButton({
	Name = "Random Bones",
	Callback = function()
      		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones","Buy",1,1)
  	end    
})

local MiscTab = Window:MakeTab({
 Name = "Misc",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})


local Section = MiscTab:AddSection({
    Name = "Setting"
   })
   
   MiscTab:AddToggle({
       Name = "White Screen [FPS Boost]",
       Default = false,
       Callback = function(state)
           if state then
            game:GetService("RunService"):Set3dRenderingEnabled(false)
       else
            game:GetService("RunService"):Set3dRenderingEnabled(true)
       end
       end    
   })
   
   MiscTab:AddButton({
       Name = "FPS Boost",
       Callback = function()
           local decalsyeeted = true
           local g = game
           local w = g.Workspace
           local l = g.Lighting
           local t = w.Terrain
           t.WaterWaveSize = 0
           t.WaterWaveSpeed = 0
           t.WaterReflectance = 0
           t.WaterTransparency = 0
           l.GlobalShadows = false
           l.FogEnd = 9e9
           l.Brightness = 0
           settings().Rendering.QualityLevel = "Level01"
           for i, v in pairs(g:GetDescendants()) do
               if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then 
                   v.Material = "Plastic"
                   v.Reflectance = 0
               elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                   v.Transparency = 1
               elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                   v.Lifetime = NumberRange.new(0)
               elseif v:IsA("Explosion") then
                   v.BlastPressure = 1
                   v.BlastRadius = 1
               elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                   v.Enabled = false
               elseif v:IsA("MeshPart") then
                   v.Material = "Plastic"
                   v.Reflectance = 0
                   v.TextureID = 10385902758728957
               end
           end
           for i, e in pairs(l:GetChildren()) do
               if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                   e.Enabled = false
               end
           end
         end    
   })
   
   MiscTab:AddToggle({
       Name = "Auto Click",
       Default = false,
       Callback = function(Value)
           AutoClick = Value
           repeat task.wait()
           game:GetService'VirtualUser':Button1Down(Vector2.new(0.9,0.9))
           game:GetService'VirtualUser':Button1Up(Vector2.new(0.9,0.9))
           until not AutoClick
       end
   })
   
   MiscTab:AddToggle({
       Name = "No Dodge Cool Down",
       Default = false,
       Callback = function(Value)
           nododgecool = Value
           if nododgecool then
               for i,v in next, getgc() do
                   if game.Players.LocalPlayer.Character.Dodge then
                       if typeof(v) == "function" and getfenv(v).script == game.Players.LocalPlayer.Character.Dodge then
                           for i2,v2 in next, getupvalues(v) do
                               if tostring(v2) == "0.4" then
                                   repeat task.wait(.1)
                                       setupvalue(v,i2,0)
                                   until not nododgecool
                               end
                           end
                       end
                   end
               end
           end
       end    
   })
   
   MiscTab:AddButton({
       Name = "Remove Lava",
       Callback = function()
           for i,v in pairs(game.Workspace:GetDescendants()) do
               if v.Name == "Lava" then   
                   v:Destroy()
               end
           end
           for i,v in pairs(game.ReplicatedStorage:GetDescendants()) do
               if v.Name == "Lava" then   
                   v:Destroy()
               end
           end
         end    
   })   

local Section = MiscTab:AddSection({
 Name = "Joins"
})

MiscTab:AddButton({
	Name = "Join Pirates Team",
	Callback = function()
      		local args = {
                [1] = "SetTeam",
                [2] = "Pirates"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args)) 
            local args = {
                [1] = "BartiloQuestProgress"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  	end    
})

MiscTab:AddButton({
	Name = "Join Marines Team",
	Callback = function()
      		local args = {
                [1] = "SetTeam",
                [2] = "Marines"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            local args = {
                [1] = "BartiloQuestProgress"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
  	end    
})

MiscTab:AddButton({
	Name = "Rejoin Server",
	Callback = function()
		local ts = game:GetService("TeleportService")
            	local p = game:GetService("Players").LocalPlayer
            	ts:Teleport(game.PlaceId, p)
  	end    
})

MiscTab:AddButton({
	Name = "Server Hop",
	Callback = function()
		Hop()
  	end    
})


local Section = MiscTab:AddSection({
 Name = "Open Menu"
})

MiscTab:AddButton({
	Name = "Inventory",
	Callback = function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryWeapons")
        game.Players.localPlayer.PlayerGui.Main.Inventory.Visible = true
  	end    
})

MiscTab:AddButton({
	Name = "Devil Fruit Inventory",
	Callback = function()
		local args = {
                [1] = "getInventoryFruits"
            }
            
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventoryFruits")
            game:GetService("Players").LocalPlayer.PlayerGui.Main.FruitInventory.Visible = true
  	end    
})

MiscTab:AddButton({
	Name = "Devil Fruit Shop",
	Callback = function()
		local args = {
                [1] = "GetFruits"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            game.Players.localPlayer.PlayerGui.Main.FruitShop.Visible = true
  	end    
})

MiscTab:AddButton({
	Name = "Title Name",
	Callback = function()
		local args = {
                [1] = "getTitles"
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            game.Players.localPlayer.PlayerGui.Main.Titles.Visible = true
  	end    
})

MiscTab:AddButton({
	Name = "Color Haki",
	Callback = function()
		game.Players.localPlayer.PlayerGui.Main.Colors.Visible = true
  	end    
})

local Section = MiscTab:AddSection({
 Name = "Code"
})

MiscTab:AddDropdown({
	Name = "Selected Code",
	Default = "1",
	Options = {"1MLIKES_RESET","THIRDSEA","SUB2GAMERROBOT_RESET1","SUB2UNCLEKIZARU"},
	Callback = function(Value)
		nexus.CodeSelect = Value
	end    
})

MiscTab:AddButton({
	Name = "Redeem Code",
	Callback = function()
      	game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(nexus.CodeSelect)
  	end    
})

local Section = MiscTab:AddSection({
 Name = "Player Misc"
})

MiscTab:AddDropdown({
	Name = "Select Haki Stage",
	Default = "1",
	Options = {"State 0","State 1","State 2","State 3","State 4","State 5"},
	Callback = function(Value)
		nexus.SelectStateHaki = Value
	end    
})

MiscTab:AddButton({
	Name = "Change Buso Haki Stage",
	Callback = function()
      	if nexus.SelectStateHaki == "State 0" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage",0)

        elseif nexus.SelectStateHaki == "State 1" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage",1)

        elseif nexus.SelectStateHaki == "State 2" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage",2)

        elseif nexus.SelectStateHaki == "State 3" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage",3)

        elseif nexus.SelectStateHaki == "State 4" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage",4)

        elseif nexus.SelectStateHaki == "State 5" then

            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage",5)

        end
  	end    
})

MiscTab:AddButton({
	Name = "Anti Afk",
	Callback = function()
		for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
			v:Disable()
		end
	end    
})

MiscTab:AddButton({
	Name = "Unlock Fps",
	Callback = function()
      		setfpscap(100)
  	end    
})

MiscTab:AddButton({
	Name = "Invisible",
	Callback = function()
      		game:GetService("Players").LocalPlayer.Character.LowerTorso:Destroy()
  	end    
})

local InfoTab = Window:MakeTab({
	Name = "Info",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
   })

InfoTab:AddLabel("Version: "..Gui_Version);

InfoTab:AddButton({
	Name = "Destroy Gui",
	Callback = function()
        OrionLib:Destroy();
  	end    
})

OrionLib:Init()
