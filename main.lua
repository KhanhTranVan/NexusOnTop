local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/memaybeohub/Function-Scripts/main/OrionLib.lua"))() 

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

    Workspace = "ArisuProject/BloxFruit/main",

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




function bM(ab)
  if not ab then return end 
  return ( game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy"..tostring(ab)) == 1 ) or game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", ab, "1") == 1
end


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
           -- if not workspace:FindFirstChild"ArisuProject_ENEMYSPAWM" then 
--              main_folder = Instance.new("Folder", workspace)
--              main_folder.Name = "ArisuProject_ENEMYSPAWM"
--            end
--            
          -- mobname = mobname:gsub(" .Lv. %d+.", ""):gsub(" ", "")
           for i, v in pairs(game.Workspace.Enemies:GetChildren()) do
         if GrayWibi(v) then 
             if not EnemySpawn[v.Name] then 
               EnemySpawn[v.Name] = v.HumanoidRootPart.CFrame
             end 
           end
         end 
         for i, v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do 
           if v.Name and not table.find(EnemySpawn, v.Name) then 
             EnemySpawn[v.Name:gsub(" .Lv. %d+.", "")] = v.CFrame 
           end 
         end 
         for i, v in pairs(getnilinstances()) do 
      
           if v and v.Name and not EnemySpawn[(v.Name:gsub(" .Lv. %d+.", ""))] then 
             if math.random(10, 70) == 25 then 
               task.wait() 
             end
             
         --Tabs    print("Scanning Mob: "..v.Name.." ("..i.." Items Scanned")
             local cach = gqgqj(v)
             if  cach then
             
               EnemySpawn[v.Name:gsub(" .Lv. %d+.", "")] = cach
             end 
           end 
         
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
   if a and a: FindFirstChild"HumanoidRootPart" then
     return a.HumanoidRootPart.CFrame 
   end
   if a:GetAttribute("CFrame") then 
   return a.CFrame 
   end
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

function q1(I, II) 
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
      if (aL-check3).Magnitude < aN and aM ~= aL then
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
                  if GrayWibi(v9471) and table.find(elite, v9471.Humanoid.DisplayName) then
                     return v9471
                  end
               end
               for v746, v9471 in pairs(game.ReplicatedStorage:GetChildren()) do
                  if GrayWibi(v9471) and table.find(elite, v9471.Humanoid.DisplayName) then
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

game.Players.LocalPlayer.Character.Humanoid.Running:Connect(function () 
  local head = game.Players.LocalPlayer.Character.Head:FindFirstChild"eltrul"
  if head then 
    head:Destroy() 
  end 
  
    for a, b in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
      if b:IsA"BasePart" then
         b.CanCollide = true
      end
   end
end)

function to(vg1)
  if sexroblox then sexroblox:Cancel() end
--print("ncall")
  if not vg1 then return end 
--  print("continue ")
  vg2 = CFrame.new(vg1.X, vg1.Y, vg1.Z) 
  game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
  
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
   vg3 = getPortal(vg2) 
   vg5 = game.Players.LocalPlayer.Character.HumanoidRootPart
   vg4 = vg5.CFrame
   vg7 = q1(vg4, vg2)
   if nexus.requestEntrance and vg7 > q1(vg3, vg2) then
     --print("request")
     return request(vg3) 
   end
   if vg7 < 220 then
    vg5.CFrame = vg2 
--    print("set")
   return 
   end 
   vg6 = vg7/nexus.Tspeed 
  sexroblox = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(vg6, Enum.EasingStyle.Linear),{CFrame = vg2})

   sexroblox:Play() 
  -- print("tween")
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

function FindAverageCFrame(cframeList)
    local totalPosition = Vector3.new(0,0,0)
    local validCount = 0
    for i = 1, #cframeList do
        local cframe = cframeList[i]
        totalPosition = totalPosition + cframe.Position
        validCount = validCount + 1
    end
    local averagePosition = totalPosition / validCount
    local averageCFrame = CFrame.new(averagePosition)
    return averageCFrame
end
function anhlalongmabacgianganhdachantraidutchantraianhdachanphaidutchanphaianhbiennhungdieukhongthethanhcothe(BringName)
        BringName = tostring(BringName)
        BringList = {}
        AGuyWhoSuckedOnZooPorn = {}
        Protected_Mon = workspace.Enemies:GetChildren()
        for i, v in pairs(Protected_Mon) do
          
          if v and v.Parent and v:FindFirstChild("HumanoidRootPart") and v.Name == BringName and v:FindFirstChild("HumanoidRootPart") then
                table.insert(BringList,v.HumanoidRootPart.CFrame)
                table.insert(AGuyWhoSuckedOnZooPorn, v)
            end
        end
        
        BringCFrame = FindAverageCFrame(BringList)
        
        for i,v in pairs(AGuyWhoSuckedOnZooPorn) do
           if v and v.Name == BringName and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and (v.HumanoidRootPart.Position - BringCFrame.Position).Magnitude < 350 then
                v.PrimaryPart.CFrame = BringCFrame
                v.Humanoid.JumpPower = 0
            		v.Humanoid.WalkSpeed = 0
                v.HumanoidRootPart.CanCollide = false
            		sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
            		v.Humanoid:ChangeState(14)
            	
            end
        end
end

            function down(used, hold) -- Send key to client
              use = true
               game:service("VirtualInputManager"):SendKeyEvent(true, used, false, game)
               task.wait(hold or 0)
               game:service("VirtualInputManager"):SendKeyEvent(false, used, false, game)
               use = false
            end

            function equip(tooltip)
               local player = game.Players.LocalPlayer
               local character = player.Character or player.CharacterAdded:Wait()
               for _, item in pairs(player.Backpack:GetChildren()) do
                 if item.ToolTip == "" then 
                   item.Parent = character 
                 end 
                 
                  if item:IsA("Tool") and item.ToolTip == tooltip then
                     local humanoid = character:FindFirstChildOfClass("Humanoid")
                     if humanoid and not humanoid:IsDescendantOf(item) then
                       if not game.Players.LocalPlayer.Character:FindFirstChild(item.Name) then
                        game.Players.LocalPlayer.Character.Humanoid:EquipTool(item)
                        end
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
  if not mon or not GrayWibi(mon) then return end
  anhlalongmabacgianganhdachantraidutchantraianhdachanphaidutchanphaianhbiennhungdieukhongthethanhcothe(mon) 
 if nexus.Buso then 
       Buso() 
 end 
     FarmPod = getKillVector3(mon.HumanoidRootPart.CFrame)
     if game.Players.LocalPlayer:DistanceFromCharacter(FarmPod.p) < 650 and nexus.AIFarm then 
      game.Players.LocalPlayer.Character.Humanoid:MoveTo(FarmPod.p) 
      down("Q") 
      
    else 
      to(FarmPod)
     end
    
 -- if vailoz then return end 
  
 -- vailoz = true
  
 if mon and mon:FindFirstChild("HumanoidRootPart") then 
  if nexus.StartMasteryFarm and ((mon.Humanoid.Health/mon.Humanoid.MaxHealth)*100) < nexus.HealthToSendSkills then
    equip(nexus.MasteryWeapon)
    for lq, ql in pairs(nexus.MasterySkills) do 
      if ql[1] then
        
      if game.Players.LocalPlayer:DistanceFromCharacter(FarmPod.p) < 650 and nexus.AIFarm then 
      game.Players.LocalPlayer.Character.Humanoid:MoveTo(FarmPod.p) 
      down("Q") 
      
    else 
      to(FarmPod)
      end 
   if not mon or not mon:FindFirstChild("PrimaryPart") then return end 
      lockpos = mon.PrimaryPart.Position
        down(lq, ql[2]) 
        lockpos = nil 
        
      end 
    end 
    else
  equip(nexus.Weapon) 
--  vailoz = false
  end
  end 
-- end)
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
  return a:gsub(" .Lv. %d+.", "") 
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
   
      for _, lol in pairs (workspace.Enemies:GetChildren()) do 
        pcall(function ()
        if lol.Humanoid.Health <1 then
          lol:Destroy() 
        end 
        end)
      end 
      
    if click then
      if nexus.FastAttack then
      click2() 
      else 
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton1(Vector2.new(1000,1000))
        end
    end
  
  end 
end) 
function checkenemy(en) 
  for i, v in pairs(workspace.Enemies:GetChildren()) do
    if cac1(v.Name) == cac1(en) then
      return true 
    end 
  end 
end 

print(" Loading NPC Spawns")
SpawnPoint()

print("Loaded ", #EnemySpawn, "Region(s)")

print(" Loading Tasks")

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
            
              click = true 
              MonStuff(m)
            
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
        if not CheckBoss("Soul Reaper") then
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
            to(CheckBoss("Soul Reaper").HumanoidRootPart.CFrame)
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


print(" Successfully Loaded Functions")

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
                           for a, b in pairs(getconnections(game:GetService("UserInputService").TouchTapInWorld)) do 
                             b:Fire() 
                             end
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

          wait(2) 
          
          
spawn(function ()
  while task.wait(nexus.SaveConfigDelay or 10) do 
    
    SpawnPoint() 
    save() 
  end end) 
  function getAllBoss() 
    gR = {}
    for _, l in pairs(workspace.Enemies:GetChildren()) do 
      if l:FindFirstChild("Humanoid") and l.Name ~= "Fishboat" and l.Humanoid:GetAttribute("DisplayName") and ( string.find(l.Humanoid.DisplayName, "Boss") or string.find(l.Humanoid.DisplayName, "Raid Boss"))  then 
        table.insert(gR, l.Name) 
      end
    end 
    for _, l in pairs(game.ReplicatedStorage:GetChildren()) do 
      if l:FindFirstChild("Humanoid") and l.Humanoid:GetAttributes("DisplayName") and ( string.find(l.Humanoid.DisplayName, "Boss") or string.find(l.Humanoid.DisplayName, "Raid Boss")) then 
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
            if string.find(c5, " .Raid Boss.") then
               a = string.gsub(c5, ".Lv. %d+.", "")
               ab = string.gsub(a, "  .Raid Boss.", "")
            else
               a = string.gsub(c5, ".Lv. %d+.", "")
               ab = string.gsub(a, "  .Boss.", "")
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
  if not string.find(boss.Name, string.gsub(string.gsub(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat ", ""), " .(0/1).", "")) then 
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

PlayerSea = 1 

if CheckSea(2) then 
  PlayerSea = 2
elseif CheckSea(3) then 
  PlayerSea = 3 
end 

numval = {"First", "Second", "Third"} 

NowSea = numval[PlayerSea].." Sea"

print(NowSea)
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
            if not isfolder("ArisuProject/Cache/") then
               makefolder("ArisuProject/Cache/")
            end
            writefile("ArisuProject/Cache/" .. bN, HttpService:JSONEncode(bM))
         end
         function ReadSetting2()
            local s, o =
            pcall(
            function()
               local HttpService = game:GetService("HttpService")
               Hub = game:GetService("HttpService")
               if not isfolder("ArisuProject/Cache/") then
                  makefolder("ArisuProject/Cache/")
               end
               return HttpService:JSONDecode(readfile("ArisuProject/Cache/" .. bN))
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
               noti("Hop Server", "Joining...")
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
                                 to(CFrame.new(0, math.random(9999,99999), 0))

                              until not check11()
                              
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
                        local v68 = CheckBoss("Mob Leader")
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
  wboss = CheckBoss("Saber Expert") 
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
     if CheckBoss("Awakened Ice Admiral") then 
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
   function meleereq() 
     if CheckSea(2) and game:GetService("Workspace").Map.IceCastle.Hall.LibraryDoor:FindFirstChild"PhoeyuDoor" and game:GetService("Workspace").Map.IceCastle.Hall.LibraryDoor:FindFirstChild"PhoeyuDoor".Transparency == 0 then 
       if getAllBoss()["Awakened Ice Admiral [Lv. 1400] [Boss]"] then
         graygray:Refresh(getAllBoss(), true)
         killsb:Set(true) 
         graygray:Set("Awakened Ice Admiral [Lv. 1400] [Boss]")
       end 
       if checkitem"Library Door" then 
         EquipWeaponName"Library Door" 
         to(CFrame.new(6376.93164, 296.760071, -6843.54932, -0.906182051, -1.26464874e-08, -0.422887832, -7.46116324e-09, 1, -1.39169662e-08, 0.422887832, -9.45606971e-09, -0.906182051))
         end 
     end 
   end 
   spawn(function () 
     while wait() do 
      
      if nexus.targetFetchMethod == "Nearest" then 
        local qw; lw = nil, math.huge
        for q, w in pairs(game.Players:GetPlayers()) do 
          if w and GrayWibi(w) and game.Players.LocalPlayer:DistanceFromCharacter(w.Character.Head.Position) then
            if w.Name ~= game.Players.LocalPlayer.Name and not nexus.TeamCheck or ( tostring(game.Players.LocalPlayer.Team) == "Pirates" or tostring(game.Players.LocalPlayer.Team) ~= tostring(b.Team)) then
            qw = w 
            w = game.Players.LocalPlayer:DistanceFromCharacter(w.Character.Head.Position) 
            end
          end 
        end
        target = qw
      end
     
  if nexus.AutoSuperhuman then
    if ((checkMelee("Superhuman") and not nexus.FullyMode) or GetAndCheckMeleeMastery("Superhuman") < 400) then
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
   
   elseif GetAndCheckMeleeMastery("Superhuman") > 399 and nexus.AutoSuperhuman then
     autosuperhuman:Set(false) 
     noti("Auto Superhuman", "Ok Ok") 
   end
   end
   if nexus.AutoDeathStep and ((checkMelee"DeathStep" or not nexus.FullyMode) or GetAndCheckMeleeMastery("Death Step") > 399) then 
       
     if GetAndCheckMeleeMastery("Black Leg") < 399 then
       repeat wait(5) 
     
         buyMelee("BlackLeg") 
         if game.Players.LocalPlayer.Data.Fragments.Value < 5000 then 
           AutoRaid:Set(true) 
         else
             AutoRaid:Set(false) 
         end 
       until GetAndCheckMeleeMastery("Black Leg") > 399 or not nexus.AutoDeathStep 
       buyMelee("DeathStep")
     end 
    
     end
     end
   end) 
   
     
task.spawn(function() 
  while task.wait() do
    if PostWebhook2 then 
 if os.time()-(oldtime or ((nexus.WHDelay or 1)-1)) > (nexus.WHDelay or 0) then 
  if nexus.WHServerStat then 
    PostWebhook2(getserverstatwebhook()) 
  end 
  if nexus.WHAccStat then 
    PostWebhook2(getaccountstatwebhook())
  end 
  oldtime = os.time()
end 
end
    (function()
      local vaithua000 = game.Players.localPlayer 
      
      
     if not Arisu.Loaded or not vaithua000.Character or not vaithua000.Character:FindFirstChild("Humanoid") then return end
    --[[   for _, anim in pairs(game.Players.LocalPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
            anim:Stop()
    end]]
      
      if nexus.ICursedDualKatana and cdk() then
      elseif nexus.AutoBounty.Start then
--      print("step")
bbbbb = game.Players.LocalPlayer.Character
if not bbbbb:FindFirstChild("Head") or not bbbbb:FindFirstChild('Busy') then return end
      checktarget()
      Buso()
      if abuse then
        if abuse.Character:FindFirstChild("Humanoid") then 
          if Label_2 then Label_2:Set("Health: "..abuse.Character.Humanoid.Health) end
          end
      local health = game.Players.LocalPlayer.Character.Humanoid.Health
      if health < nexus.AutoBounty.HideFrom or (hided and health < nexus.AutoBounty.HideTo)  then
        to(abuse.Character.PrimaryPart.CFrame+Vector3.new(0,nexus.AutoBounty.YH2,0))
        hided = true
      elseif q1(game.Players.LocalPlayer.Character.PrimaryPart.CFrame, abuse.Character.PrimaryPart.CFrame) < 200 then
        hided = false
        
        to((abuse.Character.PrimaryPart.CFrame+Vector3.new(0,nexus.AutoBounty.YH,0))+shitpredict(abuse).p)
     task.wait(nexus.AutoBounty.SleepTime or 1)
        m1 = AC() 
        print(unpack(m1))
        if m1[2] then
         if m1[4]. Enable then 
           
          equip(m1[1])
          to(abuse.Character.PrimaryPart.CFrame*shitpredict(abuse))
            mt = down(m1[3], m1[4].HoldDelay) 
          --  task.wait()
            --repeat task.wait() print('shshshshshhs') until not GrayWibi(game.Players.LocalPlayer.Character) or not game.Players.LocalPlayer.Character:FindFirstChild("Busy") or not game.Players.LocalPlayer.Character.Busy.Value
            print("close")
        end
        end
         
   
        else 
          to(abuse.Character.PrimaryPart.CFrame*shitpredict(abuse))
       end
      end
    
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
        
        repeat task.wait() 
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
      elseif nexus.AutoFactory and autofactory() then
      elseif nexus.AutoPirateRaid and autopirateraid() then
      elseif nexus.AutoFullItemMas and autofullmassword() then
      elseif nexus.IRengoku and rengoku() then 
      elseif nexus.IYama and iyama() then 
      elseif nexus.ISaber and saber() then 
      elseif meleereq() then
      elseif nexus.AutoRaceV2 and racev2() then
      elseif nexus.AutoRaceV3 and racev3() then
      elseif nexus.AutoSeaEvents and autoseaevents() then 
      elseif nexus.StartFarm then 
        if nexus.FarmMode == "Level" then
          lv = game.Players.LocalPlayer.Data.Level.Value
          if lv > 80 and lv < 700 and CheckSea(1) then 
            if game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("PlayerHunter")  ~=  "I don't have anything for you right now. Come back later." then
              from = from or os.time()
              target = string.gsub(string.gsub(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat ", ""), " %p(0/1)%p", "") 
              targetreal = game.Players:FindFirstChild(target) 
              if targetreal.Data.Level.Value < (lv + 100) and targetreal.Humanoid.Health < 2000 then 
                while task.wait() and targetreal.Character.Humanoid.Health > 0 do 
                  to(targetreal.Character.PrimaryPart.CFrame) 
                 -- AutoCliclLlLl:Set(true)
                  if targetreal:DistanceFromCharacter(game.Players.LocalPlayer.Character.Head.Position) < 25 then 
                    down("Z")
                    down("X") 
                  end
                  
                end 
                from = nil
          else
            game.ReplicatedStorage.Remotes["CommF_"]:InvokeServer("PlayerHunter") 
            if os.time()-from > 7 then
              HopServer() 
            end
            return
              end
        end end
          if lv < 80 then
            mon = "Shanda" 
            mon2 = "Shanda [Lv. 475]"
            
            to(EnemySpawn[mon] or EnemySpawn[mon2]) 
            mon = CheckBoss(mon) 
            repeat task.wait() 
              click = true 
              MonStuff(mon) 
            until not GrayWibi(mon) 
            click = false
            return
          end
          
          if not game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
            GetQuest() 
            return
          end
          if string.gsub(string.gsub(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat . ", ""), "s .(./.).", "") ~= CacheMon then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest") 
            
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
            if GrayWibi(gq) and cac1(gq.Humanoid.DisplayName) == lonof[1] then 
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
          to(EnemySpawn[cac1(lonof[1][math.random(1, #lonof[1])])])
          end
          for _, gq in pairs(getsortedmon()) do 
            if GrayWibi(gq) then
            if table.find(lonof[1], gq.Humanoid.DisplayName) then 
              lonof[3] = os.time()

              lonof[4] = gq.Humanoid.Health
              repeat task.wait() 
                click= true 
                MonStuff(gq)
              until not GrayWibi(gq) or ((os.time()-lonof[3] > 15 and gq.Humanoid.Health >= (lonof[4] - 30))) or not whatcheck("Bone", true)
              click = false
            end
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
         to(EnemySpawn[cac1(lonof[2][math.random(1, #lonof[1])])])
         for _, gq in pairs(getsortedmon()) do 
           if GrayWibi(gq) then
            if table.find(lonof[2], gq.Humanoid.DisplayName) then 
              lonof[3] = os.time()

              lonof[4] = gq.Humanoid.Health
              repeat task.wait() 
                click= true 
                MonStuff(gq)
              until not GrayWibi(gq) or ((os.time()-lonof[3] > 15 and gq.Humanoid.Health >= (lonof[4] - 30))) or not whatcheck("Katakuri", true)
                click= false
              
        end
           end 
       end
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner") 
        elseif nexus.FarmMode == "Ectoplasm" then 
          lonof = {
            [1] = {"Ship Deckhand [Lv. 1250]", "Ship Engineer [Lv. 1275]", "Ship Steward [Lv. 1300]"}
          } 
          to(EnemySpawn[cac1(lonof[1][math.random(1, #lonof[1])])])
          for _, gq in pairs(getsortedmon()) do 
            if GrayWibi(gq) then
            if table.find(lonof[1], gq.Humanoid.DisplayName) then 
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
      end
    end)()
--    print ("call niga")
   -- if not x then warn(z) end
end
end) 
 
  

  

function getDirection(Origin, Position)
    return (Position - Origin).Unit * 1000
end

function grcheck() 
  return game.Players.LocalPlayer.Character:FindFirstChild"Busy" and game.Players.LocalPlayer.Character:FindFirstChild"Busy".Value and nexus.EnableAimbot
end 


spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg,false)
    gg.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if (nexus.EnableAimbot and nexus.AimMethod == "Hook Position" and target) or lockpos then
                        args[2] = lockpos or target.Character.Head.Position
                        
                        return old(unpack(args))
                    end
                end
            end
        end
        return old(...)
    end)
end)

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(...)
    local Method = getnamecallmethod()
    local Arguments = {...}
    local self = Arguments[1]
 
    if self == workspace and not checkcaller() then
        if Method == "FindPartOnRayWithIgnoreList" then
          if abuse and nexus.AutoBounty.Start then
            
          Origin = Arguments[2].Origin
          Direction = getDirection(Origin, ((target or abuse).Character.HumanoidRootPart.CFrame*CFrame.new(0,-8,1)).Position)
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

if not target or not target.Character or not target.Character:WaitForChild("HumanoidRootPart", 9e3) then return end
      if game.Players.LocalPlayer.Character.Busy.Value then
        to(target.Character.Head.CFrame)
        else
      to(getKillVector3(target.Character.Head.CFrame)) 
      end
    
    end 
      

function GetNearestPlayerFrom(pos) 
  for a, b in pairs(game.Players:GetPlayers()) do 
    if (not target or target.Name ~= b.Name) and not nexus.TeamCheck or ( tostring(game.Players.LocalPlayer.Team) == "Pirates" or tostring(game.Players.LocalPlayer.Team) ~= tostring(b.Team)) then 
      if b:DistanceFromCharacter(pos) < nexus.HitRange and b.Name ~= game.Players.LocalPlayer.Name then
        if not target or target.Name ~= b.Name then
         target = b 
         noti("Nexus PvP", "target Champed: "..b.Name)
         break; 
         end
        end 
    end
      
  end
    if nexus.AimMethod == "Camera Lock" and target then 
      lockto(target.Character.Head.CFrame) 
    end 
    
end
local function onTouch(input)
    local touchPosition = input.Position
    local clickPosition = workspace.CurrentCamera:ScreenPointToRay(touchPosition.X, touchPosition.Y).Origin
    print(clickPosition)
    GetNearestPlayerFrom(clickPosition)
end

game:GetService("UserInputService").InputBegan:Connect(function(input)
  if nexus.targetFetchMethod == "Tap" then 
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local mouse = game.Players.LocalPlayer:GetMouse()
        local clickPosition = mouse.Hit.p -- Lấy tọa độ 3D của điểm click
        GetNearestPlayerFrom(clickPosition)
    end
    end
end)

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
   if nexus.targetFetchMethod == "Tap" then 
    if not gameProcessedEvent and input.UserInputType == Enum.UserInputType.Touch then
        onTouch(input)
        end
    end
end)

print(" Building GUI")


local Window = OrionLib:MakeWindow({Name = "Nexus Hub", HidePremium = false, IntroText = "Con Cu Bu", SaveConfig = true, ConfigFolder = "ArisuProject/BloxFruit/Main/"})
wait()
local StatsTab = Window:MakeTab({
 Name = "Con Cac",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

StatsTab:AddParagraph("Work Nào Mấy Em", "Todo: Auto Fully Melee");

wait()
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
       
NowSea = "Main"
if CheckSea(2) then 
  NowSea = "Second Sea" 
elseif CheckSea(3) then
  NowSea = "Third Sea" 
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
  data = game:GetService("HttpService"):JSONEncode((data))
 -- print(data)
  data = to_base64(data) 
  a0 = os.date("*t").min 
  data = caesarCipher(data, 9+37+12522*155*18)
  return data 
end 
 
 api = ""
 
 function hidetext(originalString) 
 
 
local preservedLength = 7
local preservedPart = string.sub(originalString, 1, preservedLength)
local maskedPart = string.rep("x", #originalString - preservedLength)
local finalString = preservedPart .. maskedPart
return finalString 
end 

print("Player Logged: ", hidetext(game.Players.LocalPlayer.Name), NowSea)

 function post(name, typeh) 
  -- warn("Post")
 --  warn("Hashed Data:", hash({Name=name, ServerID=game.JobId,Sender=hidetext(game.Players.LocalPlayer.Name), Sea=NowSea}))
   timenow = game:HttpGet("https://arisu.iesnesanulwl.repl.co/api/v1/time")
   if timenow ~= tostring(os.time()+1) then 
   
    
     return post(name, typeh)
   end
   warn(typeh, hash({Name=name, ServerID="game:GetService('TeleportService'):Teleport('"..game.JobId.."')", Sender=hidetext(game.Players.LocalPlayer.Name), Sea=NowSea}))
   
   outputing  = game:HttpGet('https://arisu.iesnesanulwl.repl.co/api/v1/notify/'..typeh..'?data='..hash({Name=name, ServerID="game:GetService('TeleportService'):Teleport('"..game.JobId.."')", Sender=hidetext(game.Players.LocalPlayer.Name), Sea=NowSea}))
   warn(outputing)
   if not string.find(outputing, "Successfully Send") then
     
     
     return post(name, typeh) 
   end 
 end
 
 
 
posted = {}

spawn(function () 
    local connection = game:HttpGet"https://arisu.iesnesanulwl.repl.co/api/v1" 
    Server:Set(" [❌] Failed To Connect")
    if string.find(connection, '"success":true') then 
      Server:Set(" [🟢] Connected To Server (took "..math.floor((tick()-wtfwtfwtf)*60).."ms)")
    end
    while wait(2) do 
      if Moon and Mirage then
      
       pcall(function ()
        if moonTextures[game:GetService("Lighting").Sky.MoonTextureId] == " [🌕] Full Moon" then 
          if not posted.Moon then
            posted.Moon = true 
            post("Full Moon", "Moon")
          end 
        end
       end) 
      
      
      spawn(function ()
        Mirage:Set(" [❌] Mirage") 
        if isMirageSpawn() and not posted.Mirage then 
          posted.Mirage = true
          Mirage:Set(" [🟢] Mirage Spawned") 
          post("Mirage", "Mirage")
        end
      end)
       
        Moon:Set(" [🌑] Moon")  
        
        moon = moonTextures[game:GetService("Lighting").Sky.MoonTextureId]
          Moon:Set(moonTextures[game:GetService("Lighting").Sky.MoonTextureId])
     
        Elite:Set(" [❌] Elite [Not Spawn]" )
        if getElite() then 
          Elite:Set(" [🟢] Elite: "..getElite().Name)
        end
       
     end
    end
end)

wait()
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

selectwpm = Farm:AddDropdown({
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

wait()
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

autoracev2 = SubFarm:AddToggle({
  Name = "Auto Race V2", 
  Default= nexus.AutoRaceV2 or false,
  Callback = function (lll) 
    nexus.AutoRaceV2 = lll
    end
})

function cuop(r)

  local aA, aB = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1"), game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
  if game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") and r == 4 then 
    return true
  end
  if aA == -2 and r == 3 then
    return true
  end 
  if aB == -2 and r == 2 then 
    return true
  end
  if r == 1 then 
  return true
  end 
  return false
end 
function racev2() 
  if cuop(2) then noti("Auto Race V2", "Ok") return autoracev2:Set(false) end  
  if game.Players.LocalPlayer.Data.Beli.Value < 750000 then return end 
  game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "1")
   game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Alchemist", "2")
     if not checkitem"Flower 1"  then
       to(workspace.Flower1.CFrame)
     elseif not checkitem("Flower 2") and workspace:FindFirstChild("Flower2") then 
       to(workspace.Flower2.CFrame) 
     elseif not checkitem("Flower 3") then
       repeat task.wait()  
         click = true 
         MonStuff("Swan Pirate [Lv. 775]")
       until checkitem("Flower 3")
       click = false 
     else 
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Alchemist", "3") 
     end 
end 
   

SubFarm:AddParagraph("Note", "Only Human, Mink")
autoracev3 = SubFarm:AddToggle({
  Name = "Auto Race V3", 
  Default= nexus.AutoRaceV3 or false,
  Callback = function (lll) 
    nexus.AutoRaceV3 = lll
    end
}) 

function ongtrumskidder() 
  return game:GetService("Players").LocalPlayer.Data.Race.Value 
end 

function yeumayemzubu(t1, t2) 
  for bQ, aZ in pairs (t1) do
    if table.find(t2, bQ) then 
      return bQ
    end
  end 
end 


function sh()

    local bf = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "1")
    if bf == 0 then
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Wenlocktoad", "2") 
    end 
end
    
function racev3() 
  if cuop(3) then autoracev3:Set(false) return noti("Auto Race V3", "Ok") end
  if game.Players.LocalPlayer.Data.Beli.Value < 2000000 then return end 
  sh()
  if ongtrumskidder() == "Human" then 
    sbibidi = { 
      ["Fajita [Lv. 925] [Boss]"] = false,
      ["Jeremy [Lv. 850] [Boss]"] = false,
      ["Diamond [Lv. 750] [Boss]"] = false
    } 
    local zZ = yeumayemzubu() 
    if zZ and not sbibidi[zZ] then 
      repeat task.wait() 
        click= true 
        MonStuff(zZ)
      until not GrayWibi(zZ) 
      click = false 
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "3") 
    end
  
  elseif ongtrumskidder() == "Mink" or ongtrumskidder() == "Rabbit" then
    local aS = 0 
    for _, lq in pairs(workspace:GetChildren()) do
      if string.find(lq.Name, "Chest") then 
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(lq.CFrame) 
        equip("Melee")
        equip("Sword")
        equip("Gun") 
        aS = as + 1 
        if aS % 5 == 1 then
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", nexus.Team) 
        end 
        if aS >= 30 then
          game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Wenlocktoad", "3") 
        end
      end
    end
   end
end

SubFarm:AddToggle({
  Name = "Auto Factory", 
  Default= nexus.AutoFactory or false,
  Callback = function (lll) 
    nexus.AutoFactory = lll
    end
})

function autofactory() 
  local Core = CheckBoss("Core") 
  if Core then
    repeat task.wait() 
    click = true
    MonStuff(Core)
    until not nexus.AutoFactory or not GrayWibi(Core) 
  end 
end 

SubFarm:AddToggle({
  Name = "Auto Pirate Raid", 
  Default= nexus.AutoPirateRaid or false,
  Callback = function (lll) 
    nexus.AutoPirateRaid = lll
    end
})


            function getMobPirateRaid()
              if not CheckSea(3) then return end
              for i, v in pairs(game.ReplicatedStorage:GetChildren()) do 
                if
                     not string.find(v.Name, "Brigade") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and
                     v:FindFirstChild("HumanoidRootPart") and
                     (v.HumanoidRootPart.Position -
                     Vector3.new(-5543.5327148438, 313.80062866211, -2964.2585449219)).magnitude <= 3000 and
                     not string.find(v.Name, "Boss") and
                     not string.find(v.Name, "Friend")
                     then 
                to(CFrame.new(Vector3.new(-5543.5327148438, 313.80062866211, -2964.2585449219))) 
                     end 
              end 
                   
              if checkNotify"pirates are raiding" then 
                to(CFrame.new(Vector3.new(-5543.5327148438, 313.80062866211, -2964.2585449219))) 
                return
                end
               for r, v in pairs(workspace.Enemies:GetChildren()) do 
                 
                     if
                     not string.find(v.Name, "Brigade") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and
                     v:FindFirstChild("HumanoidRootPart") and
                     (v.HumanoidRootPart.Position -
                     Vector3.new(-5543.5327148438, 313.80062866211, -2964.2585449219)).magnitude <= 3000 and
                     not string.find(v.Name, "Boss") and
                     not string.find(v.Name, "Friend")
                     then
                       
                        return v
                     end
                 
                  
                  
                  
               end
               for r, v in pairs(game.ReplicatedStorage:GetChildren()) do
               
                  spawn(
                  function()
                     if
                     not string.find(v.Name, "Brigade") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and
                     v:FindFirstChild("HumanoidRootPart") and
                     (v.HumanoidRootPart.Position -
                     Vector3.new(-5543.5327148438, 313.80062866211, -2964.2585449219)).magnitude <= 3000 and
                     not string.find(v.Name, "Boss") and
                     not string.find(v.Name, "Friend")
                     then
                        return v
                     end
                  end
                  
                  )
               end 
               
             
            end 
        


function autopirateraid() 
  Mobs = getMobPirateRaid() 
  if Mobs then
    repeat task.wait() 
      click = true 
      MonStuff(Mobs) 
    until not nexus.AutoPirateRaid or not MonStuff(Mobs) 
  end 
end 

autobartilo = SubFarm:AddToggle({
  Name = "Auto Bartilo", 
  Default= nexus.AutoBartilo or false,
  Callback = function (lll) 
    nexus.AutoRaceV2 = lll
    end
}) 
function bp()
  return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo" ) 
end 

function scanq(...) 
  for _, d in pairs({...}) do 
    local QuestTitle = game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text 
    if QuestTitle:find(tostring(d)) then 
      return true 
    end 
  end 
end 

function bpr() 
  local req = CheckSea(2) and getPlayerLevel() > 849 
  local req2 = bp() ~= 3 
  if not req2 then autobartilo:Set(false) noti("Auto Bartilo", "Ok") end 
  if not req then
    if nexus.FullyMode and not CheckSea(2) then
      TeleportSea(2) 
     
     end
    return false
  end 
end 

  
 
function bartilo() 
  if not bpr() then return end 
  if bp() == 0 then 
    if not game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible then
      return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1) 
    end
    if not scanq("Swan", "50") then
     return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest") 
    end 
    GMon = workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") 
    if not GMon then 
      return to(EnemySpawn["Swan Pirate"])
    end 
    repeat task.wait() 
      click = true 
      MonStuff(GMon) 
    until not GrayWibi(GMon) or not nexus.AutoBartilo 
    click = false 
  elseif bp() == 1 then 
    local v84 = CheckBoss("Jeremy") 
    if v84 then
      repeat task.wait() 
        click = true 
        MonStuff(v84) 
      until not GrayWibi(v84) or not nexus.AutoBartilo 
    end 
  elseif bp() == 2 then
    local LoadPosition = CFrame.new(-1837.46155,44.2921753,1656.1987,0.999881566,-1.03885048e-22,-0.0153914848,1.07805858e-22,1,2.53909284e-22,0.0153914848,-2.55538502e-22,0.999881566) 
    if q1(LoadPosition, game.Players.LocalPlayer.Character.Head.CFrame) < 10 then 
      to(LoadPosition) 
    else 
      game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame =
      CFrame.new(-1836, 11, 1714)
      wait(.5)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
      CFrame.new(-1850.49329, 13.1789551, 1750.89685)
      wait(1)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
      CFrame.new(-1858.87305, 19.3777466, 1712.01807)
      wait(1)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
      CFrame.new(-1803.94324, 16.5789185, 1750.89685)
      wait(1)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
      CFrame.new(-1858.55835, 16.8604317, 1724.79541)
      wait(1)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
      CFrame.new(-1869.54224, 15.987854, 1681.00659)
      wait(1)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
      CFrame.new(-1800.0979, 16.4978027, 1684.52368)
      wait(1)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
      CFrame.new(-1819.26343, 14.795166, 1717.90625)
      wait(1)
      game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =
      CFrame.new(-1813.51843, 14.8604736, 1724.79541)
    end
  end
end

SubFarm:AddToggle({
  Name = "Auto Full Mastery Sword [Enable With Farm Pls]", 
  Default= nexus.AutoFullItemMas or false,
  Callback = function (lll) 
    nexus.AutoFullItemMas = lll
    end
}) 


 function checkitem2(sw)
    local a = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(sw)
    local b =  game.Players.LocalPlayer.Character:FindFirstChild(sw)
    if not a and not b then return end
    return {Mastery = vcl(a or b, 0)}
      
      
 end

function caculate_timemas(masnow, tomas) 
  intva1l = 10 
  masreq = tomas-masnow 
  whatwht = masreq/10 
  
  return tostring(whatwht).."m" 
end 

function autofullmassword() 
  for Sword, SwordData in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do 
    if SwordData.Type == "Sword" and not checkitem2(Sword) then 
      for _, ty in pairs(SwordData.MasteryRequirements) do
        MaxSkills = tonumber(ty)
      end 
      if SwordData.Mastery < MaxSkills and not checkitem2(SwordData.Name) then 
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadItem", SwordData.Name)
        WeaponDrop:Set("Sword")
        noti("Auto Sword Mastery",SwordData.Name.." [Mas. "..tostring(SwordData.Mastery).." / "..tostring(MaxSkills).."] ["..caculate_timemas(SwordData.Mastery, MaxSkills).." To Done]")
        return 
      end
    end 
  end 
end

SubFarm:AddToggle({
  Name = "Auto Upgrade Sword Tier [Not Done Yet]", 
  Default= nexus.AutoUpTierSword or false,
  Callback = function (lll) 
    nexus.AutoUpTierSword = lll
    end
}) 

function getBoat() 
  for i, v in pairs(workspace.Boats:GetChildren()) do 
   -- print(v.Owner, typeof(v.Owner))
    if v and v:GetAttributes("Owner") and v.Owner:GetAttributes("Value") and v.Owner.Value == game.Players.LocalPlayer then 
      table.foreach(v:GetDescendants(), function(a, child)
                    if child:IsA("BasePart") or child:IsA("MeshPart") or child:IsA("Part") then
                        child.CanCollide = false
                    end
                end)
      return v 
    end 
  end
end 

function getSeaEntities()

    for r, v in next, game:GetService("Workspace").SeaBeasts:GetChildren() do
        if v.Name == "SeaBeast1" then
            local s = v.HealthBBG.Frame.TextLabel.Text
            local c5 = s:gsub("/%d+,%d+", "")
            local a = v.HealthBBG.Frame.TextLabel.Text
            local ab
            if string.find(c5, ",") then
                ab = a:gsub("%d+,%d+/", "")
            else
                ab = a:gsub("%d+/", "")
            end
            local c = ab:gsub(",", "")
            if tonumber(c) >= 34500 then
                return {[1] = v.HumanoidRootPart.CFrame*CFrame. new (0,350,-50), [2] = "Seabeast", [3] = v}
            end
        end
    end
    local cl = {"PirateBasic", "PirateBrigade"}

    for r, v in next, game:GetService("Workspace").Enemies:GetChildren() do
        if table.find(cl, v.Name) and v:FindFirstChild("Health") and v.Health.Value > 0 then
            return {[1] = v.Engine.CFrame*CFrame.new(0,55,0), [2] = "PirateRaid", [3] = v}
        end
        if v.Name == "Shark" or v.Name == "Leviathan" then
          print("Found Shark/Leviathan ")
          if GrayWibi(v) then 
            return {v.PrimaryPart.CFrame*CFrame.new(0,15,0), v.Name, v}
            end
          end
    end
    return false
end

function spawnBoat() 
  boat=getBoat() 
  if not boat then 
    print("No Boat")
    to(EnemySpawn["Luxury Boat Dealer"]) 
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyBoat","PirateBrigade") 
    if nexus.AutoSeaEvents then
      return spawnBoat() 
    end
    else 
      if not game.Players.LocalPlayer.Character.Humanoid.Sit or game.Players.LocalPlayer:DistanceFromCharacter(boat.VehicleSeat.Position) > 10 then
       -- print("To Boat")
      boat.VehicleSeat.CFrame = CFrame.new(SeaZone.X, boat.VehicleSeat.CFrame.Y, SeaZone.Z)
      to(boat.VehicleSeat.CFrame*CFrame.new(0,0,3))
      
      game.Players.LocalPlayer.Character.Humanoid:MoveTo(boat.VehicleSeat.Position)
      else 
        down(({"W", "A", "S", "D"})[math.random(1,4)], math.random(1,5)) 
        
      end
  end
end 


-- Function to get a random key and its value from a table
function getrandomontable(tables)
  local keys = {}
  for key, value in pairs(tables) do
    if value.Enable and oldvvv ~= value then 
    table.insert(keys,{ key, value})
    end
  end
  local randomIndex = math.random(1, #keys)
  oldvvv = keys[randomIndex]
  return keys[randomIndex]
end

function spamskillsea() 
    NameWeapon1, DataWeapon1= unpack(getrandomontable(nexus.SeaEvent.Weapon))
    if DataWeapon1 and DataWeapon1.Enable then 
      equip(NameWeapon1) 
    end 
    if DataWeapon1 and DataWeapon1.Skills then 
    NameSkill, DataSkill = getrandomontable(DataWeapon1.Skills)
    if DataSkill and DataSkill.Enable then
      
      down(NameSkill, DataSkill.HoldDelay) 
      end
    end 
end 
  
function spamskill() 
  vlcringe = getrandomontable(nexus.AutoBounty.Weapon)
    NameWeapon1, DataWeapon1 = vlcringe[1], vlcringe[2]
    print(NameWeapon1)
    if DataWeapon1 and DataWeapon1.Enable then 
      equip(NameWeapon1) 
    end
    if DataWeapon1 and DataWeapon1.Skills then 
    vlcringe = getrandomontable(DataWeapon1.Skills) 
    NameSkill, DataSkill = vlcringe[1], vlcringe[2]
    if DataSkill and DataSkill.Enable then
      use= true
      wait()
      down(NameSkill, DataSkill.HoldDelay) 
      use= false
      end
    end 
end 
  
function autoseaevents() 
 if CheckSea(1) then
   as1e:Set(false) 
   return noti("Auto Sea Events", "Sea 2/3 Only")
 end
 --Doughprint(1)
 Entities = getSeaEntities() 
 if not Entities then
 --  print (2)
 spawnBoat()
 else 
 --  print(3)
   to(Entities[1]) 
   lockpos = Entities[3].PrimaryPart.Position
   if game.Players.LocalPlayer:DistanceFromCharacter(Entities[1].p) < 500 then
   spamskillsea() 
   end
 end 
 
end

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
wait()
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
  Min = 1,
  Max = 60,
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
  Name = "Normal Move Farm ",
  Default = nexus.AIFarm or false,
  Callback = function(aaaA) 
    nexus.AIFarm = aaaA
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
wait()
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
            ["Dragon Claw"] = function(a)
            dragonclawtrue = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1") == 1
            if not a then 
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
            end
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





nexus.SeaEvent = nexus.SeaEvent or {
  Weapon = {
    Melee = {
      Enable = true, 
      
      Skills = {
        Z = {Enable=true,HoldDelay=0},
        X = {Enable=true,HoldDelay=0},
        C = {Enable=true,HoldDelay=0}
      }
    },
    ["Blox Fruit"] = {
      Enable = true, 
      
      Skills = {
        Z = {Enable=true,HoldDelay=0},
        X = {Enable=true,HoldDelay=0},
        C = {Enable=true,HoldDelay=0},
        V = {Enable=true,HoldDelay=0},
        F = {Enable=true,HoldDelay=0}
      }
    },
    Gun = {
      Enable = true, 
    
      Skills = {
        Z = {Enable=true,HoldDelay=0},
        X = {Enable=true,HoldDelay=0},
      }
    },
    Sword = {
      Enable = true, 
     
      Skills = {
        Z = {Enable=true,HoldDelay=0},
        X = {Enable=true,HoldDelay=0},
      }
    },
  }
}
wait()
local SeaTab = Window:MakeTab({
	Name = "Sea Event",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
SeaTab:AddDropdown({
  Name = "Select Auto Sea Events Weapon", Options={"Melee", "Sword", "Blox Fruit", "Gun"},Flag="SeaEventsW",Save=true,Callback = function (a)
    if Itemsenable1 and Itemsdelay1 and Itemskills1 then 
      SeaEventsW = a
      --Itemsdelay1:Set( nexus.SeaEvent.Weapon[a].Delay) 
      Itemsenable1:Set( nexus.SeaEvent.Weapon[a].Enable) 
      llllllll = {}
      for q, w in pairs( nexus.SeaEvent.Weapon[a].Skills) do 
        table.insert(llllllll, q) 
      end 
      Itemskills1:Refresh(llllllll, true)
    end 
    
  end 
  }) 

Itemsenable1 = SeaTab:AddToggle({
  Name = "Enable Weapon",
  Callback = function(l) 
    if not SeaEventsW then return end
     nexus.SeaEvent.Weapon[SeaEventsW].Enable = l
  end
}) 

  
Itemskills1 = SeaTab:AddDropdown({
  Name="Select Skills",
  Options={"..."}, 
  Flag="SeaEventsS",
  Save=true,
  Callback = function(q)
    if not SkillsEnable or not Itemsdelay1 or not SeaEventsW then print("exit") return end 
    SeaEventsS = q
    SkillsEnablea:Set(nexus.SeaEvent.Weapon[SeaEventsW].Skills[q].Enable)
    Itemsdelay1:Set(nexus.SeaEvent.Weapon[SeaEventsW].Skills[q].HoldDelay)
  end 
  
})

SkillsEnablea = SeaTab:AddToggle({
  Name = "Enable",
  Callback = function(q) 
     
    
    if not SeaEventsW or not SeaEventsS then return end 
    
     nexus.SeaEvent.Weapon[SeaEventsW].Skills[SeaEventsS].Enable = q
  end 
  
})

Itemsdelay1 = SeaTab:AddSlider({
  Name = "Skill Hold", 
  Min = 0, 
  Max = 5,
  ValueName = "s" ,
  Increment = 0.15, 
  Callback = function(ll) 
    
    
    if not SeaEventsW or not SeaEventsS then return end 
    nexus.SeaEvent.Weapon[SeaEventsW].Skills[SeaEventsS].HoldDelay = ll 
  end
  
})



SeaTab:AddDropdown({
  Name = "Select Sea Events Mode", 
  Options = {"Normal", "Dark Zone"} ,
  Default= nexus.SeaEvent.Zone or "Normal", 
  Callback = function (p) 
    SeaZone = CFrame.new(-3500, 300, -6100) 
    if p == "Dark Zone" then 
      SeaZone = CFrame.new(-11000,300, 17150) 
    end
  end 
  
})
as1e = SeaTab:AddToggle({
  Name = "Auto Sea Events", 
  Default= nexus.AutoSeaEvents or false,
  Callback = function (lll) 
    nexus.AutoSeaEvents = lll
    end
})

SeaTab:AddToggle({
  Name = "Farm Sea Beast", 
  Default= nexus.AutoSeaEventsSB or false,
  Callback = function (lll) 
    nexus.AutoSeaEventsSB = lll
    end
}) 

SeaTab:AddToggle({
  Name = "Farm Pirate Boat", 
  Default= nexus.AutoSeaEventsB or false,
  Callback = function (lll) 
    nexus.AutoSeaEventsB = lll
    end
})

SeaTab:AddToggle({
  Name = "Auto Spam Skill", 
  Default= false,
  Callback = function (lll) 
    SpamSkill = lll
    while SpamSkill and wait() do 
      spamskillsea() 
      end
    end
})

wait()
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

function lockto(p) 
  local lookAtPos = game.Workspace.CurrentCamera.CFrame.p + p * 100
  game.Workspace.CurrentCamera.CFrame = CFrame.lookAt(game.Workspace.CurrentCamera.CFrame.p, lookAtPos)
end
function refreshplayer() 
  if not selectplr then return end 
  local plrsss = {}
  for i, v in pairs(game.Players:GetPlayers()) do 
    table.insert(plrsss, v.Name) 
  end 
  selectplr:Refresh(plrsss, true) 
end 
PlayerTab:AddDropdown({
  Name = "Select target Fetch Method", 
  Default = nexus.targetFetchMethod or "Nearest",
  Options = {"Nearest", "Tap", "By Select"},
  Callback = function (q) 
    nexus.targetFetchMethod = q
  end
})

selectplr = PlayerTab:AddDropdown({
  Name = "Select target", 
  Options = {},
  Callback = function (q) 
    if not  game.Players:FindFirstChild(q) then return refreshplayer() end
    abuse = game.Players:FindFirstChild(q)
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
    
      equip("Melee") 
      wait(1) 
      sttttt = os.time()
      repeat game:GetService("RunService").Stepped:Wait() 
        game.Players.LocalPlayer.Character:SetPrimaryPartCFrame(abuse.Character.Head.CFrame) 
        
      down("X", 2) 
      until not game.Players.LocalPlayer.Character.Busy.Value and os.time()-sttttt > 3
      
    end
}) 

PlayerTab:AddToggle({
  Name = "Strafe Player",
  Default =  false,
  Callback = function(qqqw) 
    StrafePlayer = qqqw
    
    while StrafePlayer and wait() do 
   
      
        strafe() 
    
      end

  end 
 
})

PlayerTab:AddParagraph("Auto Bounty", " This Just A Basically Config, Go To workspace/ArisuProject/BloxFruit/Main/"..game.Players.LocalPlayer.Name..".json for more config\n Please Dont Use Any Farm Method If Using Auto Bounty \n Enable Aimbot In Top For Aimbot") 
nexus.AutoBounty = nexus.AutoBounty or {
  SkipV4= true, 
  Chat= {"Im Just Too Good"}, 
  Hop = true, 
  Start = false, 
  SkipSpec = true, 
  V3 = true, 
  V4 = true, 
  Hide = true, 
  HideFrom = 1500, 
  HideTo = 5000, 
  SkipV4= true, 
  SkipFruit = {"Buddha-Buddha", "Portal-Portal", "Leopard-Leopard"},
  Weapon = {
    Melee = {
      Enable = true, 
      Delay = 0, 
      Skills = {
        Z = {Enable=true,HoldDelay=0},
        X = {Enable=true,HoldDelay=0},
        C = {Enable=true,HoldDelay=0}
      }
    },
    ["Blox Fruit"] = {
      Enable = true, 
      Delay = 0, 
      Skills = {
        Z = {Enable=true,HoldDelay=0},
        X = {Enable=true,HoldDelay=0},
        C = {Enable=true,HoldDelay=0},
        V = {Enable=true,HoldDelay=0},
        F = {Enable=true,HoldDelay=0}
      }
    },
    Gun = {
      Enable = true, 
      Delay = 0, 
      Skills = {
        Z = {Enable=true,HoldDelay=0},
        X = {Enable=true,HoldDelay=0},
      }
    },
    Sword = {
      Enable = true, 
      Delay = 0, 
      Skills = {
        Z = {Enable=true,HoldDelay=0},
        X = {Enable=true,HoldDelay=0},
      }
    },
  }
}

PlayerTab:AddDropdown({
  Name = "Select Auto Bounty Weapon", Options={"Melee", "Sword", "Blox Fruit", "Gun"},Flag="SelectedW",Save=true,Callback = function (a)
    if ItemsEnable and ItemsDelay and ItemSkills then 
      SelectedW = a
      ItemsDelay:Set( nexus.AutoBounty.Weapon[a].Delay) 
      ItemsEnable:Set( nexus.AutoBounty.Weapon[a].Enable) 
      llllllll = {}
      for q, w in pairs( nexus.AutoBounty.Weapon[a].Skills) do 
        table.insert(llllllll, q) 
      end 
      ItemSkills:Refresh(llllllll, true)
    end 
    
  end 
  }) 

ItemsEnable = PlayerTab:AddToggle({
  Name = "Enable Weapon",
  Callback = function(l) 
    if not SelectedW then return end
     nexus.AutoBounty.Weapon[SelectedW].Enable = l
  end
}) 

ItemsDelay = PlayerTab:AddSlider({
  Name = "Item Delay", 
  Min = 0, 
  Max = 5,
  ValueName = "s" ,
  Increment = 0.15, 
  Callback = function(ll) 
    if not SelectedW then return end
     nexus.AutoBounty.Weapon[SelectedW].Delay = ll
  end 
  
})

ItemSkills = PlayerTab:AddDropdown({
  Name="Select Skills",
  Options={"..."}, 
  Flag="SelectedS",
  Save=true,
  Callback = function(q)
    if not SkillsEnable or not ItemsDelay or not SelectedW then return end 
    SelectedS = q
    SkillsEnable:Set(nexus.AutoBounty.Weapon[SelectedW].Skills[q].Enable)
    ItemsDelay:Set(nexus.AutoBounty.Weapon[SelectedW].Skills[q].HoldDelay)
  end 
  
})

SkillsEnable = PlayerTab:AddToggle({
  Name = "Enable",
  Callback = function(q) 
     
    
    if not SelectedW or not SelectedS then return end 
    
     nexus.AutoBounty.Weapon[SelectedW].Skills[SelectedS].Enable = q
  end 
  
})

ItemsDelay = PlayerTab:AddSlider({
  Name = "Skill Hold", 
  Min = 0, 
  Max = 5,
  ValueName = "s" ,
  Increment = 0.15, 
  Callback = function(ll) 
    
    
    if not SelectedW or not SelectedS then return end 
    nexus.AutoBounty.Weapon[SelectedW].Skills[SelectedS].HoldDelay = ll 
  end
  
})

PlayerTab:AddToggle({
  Name = "Enable V3 Race",
  Default = nexus.AutoBounty.V3, 
  Callback = function(q) 
    nexus.AutoBounty.V3 = q
  end 
}) 
PlayerTab:AddToggle({
  Name = "Enable V4 Race",
  Default = nexus.AutoBounty.V4, 
  Callback = function(q) 
    nexus.AutoBounty.V4 = q
  end 
}) 
PlayerTab:AddToggle({
  Name = "Auto Hide If Low Health",
  Default = nexus.AutoBounty.Hide, 
  Callback = function(q) 
    nexus.AutoBounty.Hide = q
  end 
}) 

PlayerTab:AddSlider({
Name = "Hide Health (2)",
Default = nexus.AutoBounty.HideTo or 4500,
Min = 1000,
Max = 7000,
ValueName = "",
Increment = 1,
Callback = function(a)
nexus.AutoBounty.HideTo = a
end
})
PlayerTab:AddSlider({
Name = "Hide Health (1)",
Default = nexus.AutoBounty.HideFrom or 2000,
Min = 1000,
Max = 7000,
ValueName = "",
Increment = 1,
Callback = function(a)
nexus.AutoBounty.HideFrom = a
end
})



PlayerTab:AddSlider({
Name = "Sleep Time",
Default = nexus.AutoBounty.SleepTime or .5,
Min = 0,
Max = 5,
ValueName = "s",
Increment = .5,
Callback = function(a)
nexus.AutoBounty.SleepTime = a
end
})

PlayerTab:AddSlider({
Name = "Normal Y Height",
Default = nexus.AutoBounty.YH or 100,
Min = 0,
Max = 800,
ValueName = "m",
Increment = 10,
Callback = function(a)
nexus.AutoBounty.YH = a
end
}) 
PlayerTab:AddSlider({
Name = "Low Health Y Height",
Default = nexus.AutoBounty.YH2 or 8888,
Min = 20,
Max = 9999,
ValueName = "m",
Increment = 10,
Callback = function(a)
nexus.AutoBounty.YH2 = a
end
}) 

PlayerTab:AddToggle({
  Name = "Skip Human, Leopard And Portal User",
  Default = nexus.AutoBounty.SkipSpec, 
  Callback = function(q) 
    nexus.AutoBounty.SkipSpec = q
  end 
}) 

function n4(g1)
  if not og1 then return Vector3.new(0,0,0) end 
  return (g1-og1)*2.14
end 

function shitpredict(plr) 

  if not GrayWibi(plr.Character) then return Vector3.new(0,0,0) end
  ai1 = n4(plr.Character.PrimaryPart.Position)
  og1 = plr.Character.PrimaryPart.Position 
  return CFrame.new(ai1)
end

PlayerTab:AddToggle({
  Name = "Allow Hop",
  Default = nexus.AutoBounty.Hop, 
  Callback = function(q)
    nexus.AutoBounty.Hop = q
  end 
}) 

local Label_1 = PlayerTab:AddLabel("Target: 🥶")
local Label_2 = PlayerTab:AddLabel("Health: 🥶")
niga = {}
ablekejs = {
  "Buddha-Buddha",
  "Leopard-Leopard",
  "Portal-Portal",
  "Venom-Venom"
  
  
}
function FeCl2(NaCl, CaCO3) 
  for _, Fe2SO4 in pairs(NaCl) do
    if Fe2SO4 ==tostring(CaCO3) then
      return true 
    end
  end
end

function find_target() 
  distaaaaaaaa, abuse = math.huge, nil
  for a, b in pairs(game.Players:GetPlayers()) do 
    if b and b.Name and b.Name ~= game.Players.LocalPlayer.Name and b.Character and not niga[b.Name] == true and b.Character:FindFirstChild"Head" and tonumber(b.Data.Level.Value) > 1900 and b.Team ~= nil and b.Character.PrimaryPart and (b.Character.PrimaryPart.CFrame).Y < 3500 and not string.find(tostring(b.Team), "ture") and game.Players.LocalPlayer:DistanceFromCharacter(b.Character.Head.Position) < distaaaaaaaa and (not nexus.AutoBounty.SkipV4 or not b.Backpack:FindFirstChild('Awakening')) and (not nexus.SkipSpec or not FeCl2(ablekejs, b.Data.DevilFruit.Value)) then
        distaaaaaaaa = game.Players.LocalPlayer:DistanceFromCharacter(b.Character.Head.Position) 
        abuse = b 
    end 
  end
   
  if not abuse and nexus.AutoBounty.Hop then 
    noti("Hop Server", "Finding Server...") 
    to(CFrame.new(0,999999,0)) 
   
    if nexus.WHBounty then  PostWebhook2({
      content = getpinger(),
      tts = false,
      embeds = { {
        id = 652627557,
        title = "Auto Bounty / Server Hop",
        description = "Player: "..tostring(game.Players.LocalPlayer.Name).."\n Total Bounty: "..tostring(start_bounty),
        color = 13858455,
        fields = { {
          id = 814454215,
          name = "Summary",
          value = string.format("``` %s ```", tostring(tonumber(game.Players.LocalPlayer.leaderstats["Bounty/Honor"].Value)-start_bounty2) ),
          inline = false
          }, {
          id = 238037337,
          name = "Job Id",
          value = "``` "..tostring(game.JobId).." ```",
          inline = false
        } },
        author = {
          name = "Nexus Hub / Blox Kid"
        }
      }
      } 
    }) end
    return HopServer() 
    
  end 
  if not abuse then return end
  noti("Auto Bounty", abuse.Name)
  niga[abuse.Name] = true
  fromtime = os.time()
  Label_1:Set("Target: "..abuse.Name) 
end 
PlayerTab:AddButton({
  Name = "Next Player", 
  Callback = find_target
})
  
  start_bounty = game.Players.LocalPlayer.leaderstats["Bounty/Honor"].Value
  function getpinger() 
    if nexus.WHPing and nexus.WHPingID then 
      return "<@"..nexus.WHPingID..">" 
    else 
      return "Blox Sus" 
    end 
  end 
    start_bounty2 = game.Players.LocalPlayer.leaderstats["Bounty/Honor"].Value
  
  function calculate_earn() 
    earned =tonumber(game.Players.LocalPlayer.leaderstats["Bounty/Honor"].Value)-tonumber(start_bounty) 
    start_bounty = game.Players.LocalPlayer.leaderstats["Bounty/Honor"].Value
    
    if earned > 0 then
      if nexus.WHBounty then 
        PostWebhook2({
      content = getpinger(),
      tts = false,
      embeds = { {
        id = 652627557,
        title = "Auto Bounty",
        description = "Player: "..tostring(game.Players.LocalPlayer.Name).."\n Total Bounty: "..tostring(start_bounty),
        color = 13858455,
        fields = { {
          id = 814454215,
          name = "Target",
          value = string.format("``` %s ```", tostring(abuse) ),
          inline = false
        }, {
          id = 762477139,
          name = "Earned",
          value = string.format("``` %s ```", tostring(earned)),
          inline = false
        }, {
          id = 238037337,
          name = "Job Id",
          value = "``` "..tostring(game.JobId).." ```",
          inline = false
        } },
        author = {
          name = "Nexus Hub / Blox Kid"
        }
      }
      } 
    
})
    return tostring(earned) 
      end 
end 
end
  
    

function checktarget() 
  if not abuse then 
    print("1 f", abuse)
    return find_target() 
  end
  if not abuse.Character then 
    print(2,"f")
    return find_target() 
  end 
  
  if abuse.Character.Humanoid.Health <= 0 then
    
    
    noti("Auto Bounty", "Player: "..(abuse.Name or "?").."/ Earned: "..(calculate_earn() or "nil"))
    
    return find_target() 
  end
  
  if checkNotify("ayer") then
    noti("Auto Bounty", "Skip Player Due target Is Not Enable PvP")
    return find_target() 
  end 
  
  if game.Players.LocalPlayer.PlayerGui.Main.SafeZone.Visible and abuse:DistanceFromCharacter(game.Players.LocalPlayer.Character.Head.Position) < 10 then
    noti("Auto Bounty","SafeZone Detected [Gui Detect]") 
    return find_target()
  end
  if abuse:DistanceFromCharacter(game.Players.LocalPlayer.Character.Head.Position) < 100 then 
    if os.time()-fromtime > 15 and not game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible then 
      noti("Auto Bounty", "Not Incombat") 
      return find_target() 
    end 
  else 
    fromtime = os.time() 
  end
  
      
end 

  

         function checkNotify(msg)
            for r, k in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do

               

                  if k and k.Text and string.find(string.lower(k.Text), msg) then
                    k:Destroy()
                   
                     return true
                  end
               
            end
         end
         
function AB(M)
  for _, Q in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do 
    if Q.ToolTip == M then 
      return Q
    end 
  end 
  for _, Q in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 
    if Q:IsA("Tool") and Q.ToolTip == M then 
      return Q
    end 
  end 
end

  
    
function UU(Q, L) 
  if not Q or not L then return end 
  O = AB(Q) 
  warn("wp", O, Q, L)
  V = game.Players.LocalPlayer.PlayerGui.Main.Skills
  if V:FindFirstChild(O.Name) then 
    if V[O.Name]:FindFirstChild(L) then 
      return V[O.Name][L].Cooldown.AbsoluteSize.X 
    end 
  end 
  return false 
end

function AC() 
  n1 = getrandomontable(nexus.AutoBounty.Weapon) 
  n2 = getrandomontable(n1[2].Skills) 
  return {n1[1], n1[2].Enable, n2[1], n2[2]}
end 

function AW(b1) 
  game:service("VirtualInputManager"):SendKeyEvent(true, b1 ,false, game)
  return function () game:service("VirtualInputManager"):SendKeyEvent(false, b1, false, game) end
end 

  
PlayerTab:AddToggle({
  Name = "Start Auto Bounty",
  Default = nexus.AutoBounty.Start, 
  Callback = function(q) 
    nexus.AutoBounty.Start = q
   
end
})
local RaidTab = Window:MakeTab({
 Name = "Raid",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

function PostWebhook(cm, cn)
    local co = http_request or request or HttpPost or syn.request
    local cp =    
        co(
        {
            Url = cm,    
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = game:GetService("HttpService"):JSONEncode(cn)
        }
    )
 
   
   --setclipboard(game:GetService("HttpService"):JSONEncode(cp))
end
function PostWebhook2(data) 
  return PostWebhook(nexus.WebhookURL, data) 
end 

local Webhook = Window:MakeTab({
 Name = "Webhook",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

Webhook:AddTextbox({
	Name = "Webhook URL",
	Default = nexus.WebhookURL or "...",
	TextDisappear = false,
	Callback = function(Value) 
	  if not Value or not string.find(Value, "discord") then return noti("Webhook", "Invaild Webhook") end
		nexus.WebhookURL = Value
	end	  
})
Webhook:AddButton({
  Name = "Test Webhook",
  Callback = function() 
    if not nexus.WebhookURL then return noti("Webhook", "Set Webhook First") end
    PostWebhook(nexus.WebhookURL, {embeds={{title="Tao Bi Gay", description="cmmb test webhook"}}})
    noti("Webhook", "Successfully Post")
    end
})
Webhook:AddTextbox({
	Name = "Pinger ID",
	Default = nexus.WHPingID or "...",
	TextDisappear = false,
	Callback = function(Value) 
	  
		nexus.WHPingID = Value
	end	  
})


Webhook:AddToggle({
  Name = "Ping If Send Webhook", 
  Default= nexus.WHPing or true,
  Callback = function(q) 
    nexus.WHPing = q
     end
})

Webhook:AddToggle({
  Name = "Post Account Status", 
  Default = nexus.WHAccStat or false, 
  Callback = function(val) 
    nexus.WHAccStat = val 
  end 
  
})
Webhook:AddToggle({
  Name = "Post Server Status", 
  Default = nexus.WHServerStat or false, 
  Callback = function(val) 
    nexus.WHServerStat = val 
  end 
  
})
Webhook:AddToggle({
  Name = "Post Autobounty Status", 
  Default = nexus.WHBounty or false, 
  Callback = function(val) 
    nexus.WHBounty = val 
  end 
  
})


Webhook:AddTextbox({
	Name = "Send Delay",
	Default = nexus.WHDelay or "...",
	TextDisappear = false,
	Callback = function(Value) 
	  if not tonumber(Value) then return noti("Value Must Be A Number") end
		nexus.WHDelay = tonumber(Value)
	end	  
})

function getaccountstatwebhook() 
  Plr = game.Players.LocalPlayer 
  local Name = Plr.Name 
  local DisplayName = Plr.Character:WaitForChild("Humanoid", 9e9).DisplayName 
  local Level = tostring(Plr.Data.Level.Value)
  local Beli = tostring(Plr.Data.Beli.Value)
  local Frag = tostring(Plr.Data.Fragments.Value)
  local DF = tostring(Plr.Data.DevilFruit.Value)
  local Melees = ""
  local inv = {
    Sword="",
    Gun="",
    Wear="",
    ["Blox Fruit"]="",
    Material=""
  }
  for i, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do 
    v.Type = v.Type or "Gun" 
    if string.len(inv[v.Type]) < 1000 then 
      print(inv[v.Type], v.Name, rarity[v.Rarity])
      inv[v.Type] = inv[v.Type]..v.Name.." ["..rarity[v.Rarity].."] " 
      
    end
    end
  for i, v in pairs(browhat) do 
    if type(v) == "string" then 
      if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(v, true) then 
        Melees = Melees..i.." \n "
      end 
      else 
        if v() then
          Melees = Melees..i.." \n "
        end 
    end 
  end 
  return {
  content = getpinger(),
  tts = false,
  embeds = { {
    id = 652627557,
    title = "Account Status ",
    description = "** "..Name.." **",
    color = 13858455,
    fields = { {
      id = 63991295,
      name = "Basic Information",
      value = string.format([[Name: %s \n Display Name: %s, Level: %s, Beli: %s, Fragments: %s, Devil Fruit: %s \n Sea: %s]], Name, DisplayName, Level, Beli, Frag, DF, NowSea),
      inline = true
    }, {
      id = 794829953,
      name = "Melee(s)",
      value = Melees or "..."
    }, {
      id = 864911390,
      name = "Sword",
      value = inv.Sword or "..."
    }, {
      id = 654938296,
      name = "Accessories",
      value = inv.Wear or "..."
    }, {
      id = 618125704,
      name = "Gun",
      value = inv.Gun or "..."
    }, {
      id = 864802918,
      name = "Blox Fruit",
      value = inv["Blox Fruit"] or "..."
    }, {
      id = 824901769,
      name = "Materials",
      value = inv.Material or "..."
    }
    },
    author = {
      name = "Nexus Hub / Blox Fruits"
    }
  } },
  components = { },
  actions = { }
} 
end

function getserverstatwebhook() 
  moon = moon or "Bad Moon"
  local Bosses = "No Bosses Found On This Server" 
  for i, v in pairs(getAllBoss()) do 
    string.gsub(Bosses, "No Bosses Found On This Server", "") 
    Bosses = Bosses..v.." \n " 
  end 
  local spawnfruit = "No Spawn Fruit Found On This Server" 
  for i, v in pairs(workspace:GetChildren()) do 
    if string.find(v.Name, "Fruit") then
    string.gsub(spawnfruit, "No Spawn Fruit Found On This Server", "") 
    spawnfruit = spawnfruit..v.Name.." \n " 
    end 
  end
  local npcs = "No NPCs Found On This Server"
  for i, v in pairs(game.Workspace.NPCs:GetChildren()) do 
    
    string.gsub(npcs, "No NPCs Found On This Server", "") 
    npcs = npcs..v.Name.." \n " 
    
  end
  local playerlist = "" 
  for i, v in pairs(game.Players:GetPlayers()) do 
    if v and GrayWibi(v) and v:FindFirstChild("Data") and v.Data:FindFirstChild("Level") then 
      playerlist = playerlist.." [Lv. "..v.Data.Level.Value.."] \n" 
    end 
  end 
  

  
  
  return {
  content = getpinger(),
  tts = false,
  embeds = { {
    id = 652627557,
    title = "Server Status ",
    description = "Sender: "..game.Players.LocalPlayer.Name,
    color = 13858455,
    fields = { {
      id = 63991295,
      name = "Basic Information",
      value = string.format([[Sea: %s \n Moon Status: %s \n Mirage Status: %s]], NowSea, moon, tostring(isMirageSpawn())), 
      inline = true
    }, {
      id = 794829953,
      name = "Boss",
      value = Bosses or "..."
    }, {
      id = 864911390,
      name = "Spawn Fruit",
      value = spawnfruit or "..."
    }, {
      id = 654938296,
      name = "NPC(s)",
      value = npcs or "..."
    }, {
      id = 618125704,
      name = "Player List",
      value = playerlist or "..."
    }, {
      id = 864802918,
      name = "Job ID",
      value = game.JobId or "Nigga Cant Get"
    } },
    author = {
      name = "Nexus Hub / Blox Fruits"
    }
  } },
  components = { },
  actions = { }
}
end 


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
wait()
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
	--	Random_Auto()
	end    
})
function FruitNameToStringId(name) 
  local parts = {}
            for part in string.gmatch(name, "[^-]+") do
               table.insert(parts, part)
            end
            local key = table.concat(parts, "-")
            return key 
end 

print(FruitNameToStringId("Human-Human: Buddha"))
            
FruitTab:AddToggle({
  Name = "Auto Store Fruit", 
  Default = nexus.AutoStoreFruit or true, 
  Callback = function (l) 
    nexus.AutoStoreFruit = l 
  
 
  end 
})
wait()
local TeleportTab = Window:MakeTab({
 Name = "Teleport",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
})

function getAllNpcPosition() 
  local lla = {} 
  for q, l in pairs(EnemySpawn) do 
    table.insert(lla, q) 
  end 
  return lla 
end 


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

TeleportTab:AddSection({Name="Teleport Npc/Mob"}) 

vaithua = TeleportTab:AddDropdown({
  Name = "Select Npc / Entities Teleport", 
  Options = getAllNpcPosition() or {}, 
  Callback = function(sel) 
    Select_Tel1 = sel 
  end
}) 

TeleportTab:AddToggle({
  Name = "Tween To Select Npc / Entities", 
  Callback = function(q) 
    pcall(function () sexroblox:Cancel() end) 
    if q then 
      to(EnemySpawn[Select_Tel1])
    end 
  end 
})

TeleportTab:AddButton({
  Name = "Refresh Npc / Entities Drop", 
  Callback = vaithua:Refresh(getAllNpcPosition(), true)
})
wait()
local RaceV4Tab = Window:MakeTab({
 Name = "Race v4",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
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
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buy"..string.gsub(aA, " ", ""))
    end
})
local Section = ShopTab:AddDropdown({
  Name = "Select Item To Buy",
  Default = "",
  Options = {"----- Sword -----", "Cutlass", "Katana","Iron Mace", "Duel Katana", "Triple Katana", "Pipe", "Dual-Headed Blade", "Bisento", "Soul Cane", "----- Accessory -----", "Swordsman Hat", "Black Cape", "Tomoe Ring", "----- Gun -----", "Slingshot", "Musket", "Flintlock", "Refined Flintlock", "Cannon" },
  Callback = function(aA) 
    if aA == "Kabucha" then 
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","1")
      game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Slingshot","2")
      return 
    end
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyItem",aA)
    end
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
wait()
local MiscTab = Window:MakeTab({
 Name = "Misc",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
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
   
   AutoCliclLlLl = MiscTab:AddToggle({
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
	Callback = HopServer
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
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ChangeBusoStage", tonumber(string.gsub(Value, "Stage ", "")))
	end    
})
MiscTab:AddButton({
	Name = "Anti Idling / Afk",
	Callback = function()
		for i,v in pairs(getconnections(game.Players.LocalPlayer.Idled)) do
			v:Disable()
		end
	end
})


MiscTab:AddSlider({
Name = "Fps Caplity",
Default = nexus.FpsCap or 120,
Min = 1,
Max = 350,
ValueName = "",
Increment = 1,
Callback = function(a)
nexus.FpsCap = a 
setfpscap(a)
end
})



dev = {
 "UocGiCoAiMuaAcc",
 "iesnesanul",
}
if table.find(dev, game.Players.LocalPlayer.Name) then
local DevTab = Window:MakeTab({
 Name = "Developer Tab",
 Icon = "rbxassetid://4483345998",
 PremiumOnly = false
}) 
DevTab:AddToggle({
 Name = "Unload Loop", 
 Callback = function(q) 
  Arisu.Loaded = q
  end
})

DevTab:AddButton({
 Name = "Remove Terrain [Fps Improve]" ,
 Callback = function () 
  require(game.ReplicatedStorage.Util.CameraShaker):Stop()
hookfunction(error, function() end)
               -- game:GetService("ReplicatedStorage").Notification:Destroy() 

                game:GetService("ReplicatedStorage").Effect.Container.LevelUp:Destroy()
                game:GetService("ReplicatedStorage").Util.Sound:Destroy()
                game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild("LevelUp_Proxy"):Destroy()
                game:GetService("ReplicatedStorage").Util.Sound.Storage.Other:FindFirstChild("LevelUp"):Destroy()
                game:GetService("ReplicatedStorage").Effect.Container.Respawn:Destroy()   
     local g = game

local w = g.Workspace

local l = g.Lighting
local t = w.Terrain
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = 0
l.FogEnd = 99
l.Brightness = 0
l.GlobalShadows = false
local decalsyeeted = true
for i, v in pairs(game.Workspace.Map:GetDescendants()) do
    if
        v.Name == "Tavern" or v.Name == "SmileFactory" or v.Name == "Tree" or v.Name == "Rocks" or v.Name == "PartHouse" or
            v.Name == "Hotel" or
            v.Name == "WallPiece" or
            v.Name == "MiddlePillars" or
            v.Name == "Cloud" or
            v.Name == "PluginGrass" or
            v.Name == "BigHouse" or
            v.Name == "SmallHouse" or
            v.Name == "Detail"
     then
        v:Destroy()
    end
end
for i, v in pairs(game.ReplicatedStorage.Unloaded:GetDescendants()) do
    if
        v.Name == "Tavern" or v.Name == "SmileFactory" or v.Name == "Tree" or v.Name == "Rocks" or v.Name == "PartHouse" or
            v.Name == "Hotel" or
            v.Name == "WallPiece" or
            v.Name == "MiddlePillars" or
            v.Name == "Cloud" or
            v.Name == "PluginGrass" or
            v.Name == "BigHouse" or
            v.Name == "SmallHouse" or
            v.Name == "Detail"
     then
        v:Destroy()
    end
end
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
    if
        e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or
            e:IsA("DepthOfFieldEffect")
     then
        e.Enabled = false
    end
end
sethiddenproperty(l, "Technology", 2)
sethiddenproperty(t, "Decoration", false)
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(w:GetDescendants()) do
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") and decalsyeeted then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    elseif v:IsA("SpecialMesh") and decalsyeeted then
        v.TextureId = 0
    elseif v:IsA("ShirtGraphic") and decalsyeeted then
        v.Graphic = 0
    elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
        v[v.ClassName .. "Template"] = 0
    end
end
for i = 1, #l:GetChildren() do
    e = l:GetChildren()[i]
    if
        e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or
            e:IsA("DepthOfFieldEffect")
     then
        e.Enabled = false
    end
end
w.DescendantAdded:Connect(
    function(v)
        wait()
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
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
        elseif v:IsA("MeshPart") and decalsyeeted then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        elseif v:IsA("SpecialMesh") and decalsyeeted then
            v.TextureId = 0
        elseif v:IsA("ShirtGraphic") and decalsyeeted then
            v.ShirtGraphic = 0
        elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
            v[v.ClassName .. "Template"] = 0
        end
    end
)
  end
})
end 


setfflag("AbuseReportScreenshot", "False")

setfflag("AbuseReportScreenshotPercentage", "0")
  
print(" Successfully Loaded")
Arisu.Loaded = true
end
if nexus.AutoBounty.Start and nexus.WHBounty then 
  lllll = ""
  for i, v in pairs(game.Players:GetPlayers()) do 
    lllll = lllll..v.Name.." "
  end 
  
      PostWebhook2({
      content = getpinger(),
      tts = false,
      embeds = { {
        id = 652627557,
        title = "Auto Bounty / Server Recived",
        description = "Player: "..tostring(game.Players.LocalPlayer.Name).."\n Total Bounty: "..tostring(start_bounty),
        color = 13858455,
        fields = { {
          id = 814454215,
          name = "Total Player",
          value = string.format("``` %s ```", tostring(lllll) ),
          inline = false
          }, {
          id = 238037337,
          name = "Job Id",
          value = "``` "..tostring(game.JobId).." ```",
          inline = false
        } },
        author = {
          name = "Nexus Hub / Blox Kid"
        }
      }
      } 
    })
 end
