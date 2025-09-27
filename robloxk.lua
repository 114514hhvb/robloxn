-- 脚本说明：需将此脚本放在 ServerScriptService 中，门模型需命名为 "Door" 并放在 Workspace 中
local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- 1. 基础配置（可自定义）
local DOOR_NAME = "Door" -- 门模型的名称
local CORRECT_PASSWORD = "123456" -- 正确密码
local DOOR_OPEN_DURATION = 2 -- 门打开/关闭的动画时长（秒）
local DOOR_OPEN_ANGLE = 90 -- 门打开的角度（绕Y轴旋转）

-- 2. 查找门模型（需确保Workspace中有名为Door的Part/Model）
local Door = Workspace:FindFirstChild(DOOR_NAME)
if not Door then
    warn("错误：Workspace中未找到名为 " .. DOOR_NAME .. " 的门模型，请检查名称！")
    return
end
local DoorRoot = Door:FindFirstChild("RootPart") or Door -- 门的根部件（用于旋转动画）
local DoorOriginalCFrame = DoorRoot.CFrame -- 门的初始位置（用于重置）

-- 3. 创建门的打开/关闭动画
local function createDoorTween(targetCFrame)
    local tweenInfo = TweenInfo.new(
        DOOR_OPEN_DURATION,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.InOut
    )
    local tweenGoal = {CFrame = targetCFrame}
    return TweenService:Create(DoorRoot, tweenInfo, tweenGoal)
end

-- 4. 给每个玩家创建密码输入UI
local function onPlayerAdded(player)
    player.CharacterAdded:Connect(function(character)
        -- 等待玩家的HumanoidRootPart加载（用于检测玩家位置）
        local HumanoidRootPart = character:WaitForChild("HumanoidRootPart")
        
        -- 4.1 创建ScreenGui（UI容器）
        local PasswordGui = Instance.new("ScreenGui")
        PasswordGui.Name = "PasswordGui"
        PasswordGui.Parent = player.PlayerGui
        PasswordGui.Enabled = false -- 初始隐藏
        
        -- 4.2 创建UI背景框
        local Background = Instance.new("Frame")
        Background.Size = UDim2.new(0, 300, 0, 200)
        Background.Position = UDim2.new(0.5, -150, 0.5, -100)
        Background.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
        Background.BackgroundTransparency = 0.3
        Background.BorderSizePixel = 2
        Background.BorderColor3 = Color3.new(0.5, 0.8, 1)
        Background.Parent = PasswordGui
        
        -- 4.3 创建密码输入框
        local PasswordInput = Instance.new("TextBox")
        PasswordInput.Size = UDim2.new(0.8, 0, 0, 40)
        PasswordInput.Position = UDim2.new(0.1, 0, 0.3, 0)
        PasswordInput.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
        PasswordInput.TextColor3 = Color3.new(1, 1, 1)
        PasswordInput.PlaceholderText = "请输入密码..."
        PasswordInput.PlaceholderColor3 = Color3.new(0.6, 0.6, 0.6)
        PasswordInput.ClearTextOnFocus = false
        PasswordInput.Parent = Background
        
        -- 4.4 创建确认按钮
        local ConfirmButton = Instance.new("TextButton")
        ConfirmButton.Size = UDim2.new(0.6, 0, 0, 40)
        ConfirmButton.Position = UDim2.new(0.2, 0, 0.6, 0)
        ConfirmButton.BackgroundColor3 = Color3.new(0.3, 0.6, 1)
        ConfirmButton.TextColor3 = Color3.new(1, 1, 1)
        ConfirmButton.Text = "确认"
        ConfirmButton.Parent = Background
        
        -- 4.5 创建提示文本（显示正确/错误信息）
        local TipText = Instance.new("TextLabel")
        TipText.Size = UDim2.new(0.9, 0, 0, 20)
        TipText.Position = UDim2.new(0.05, 0, 0.1, 0)
        TipText.BackgroundTransparency = 1
        TipText.TextColor3 = Color3.new(1, 0.3, 0.3)
        TipText.Text = ""
        TipText.Parent = Background
        
        -- 4.6 检测玩家是否靠近门（距离小于5 studs时显示UI）
        local function checkPlayerDistance()
            local distance = (HumanoidRootPart.Position - DoorRoot.Position).Magnitude
            PasswordGui.Enabled = distance <= 5 -- 距离小于5时显示UI
        end
        
        -- 4.7 确认按钮点击事件（验证密码）
        ConfirmButton.Activated:Connect(function()
            local inputPassword = PasswordInput.Text
            if inputPassword == CORRECT_PASSWORD then
                -- 密码正确：显示提示+开门
                TipText.Text = "密码正确，门已打开！"
                TipText.TextColor3 = Color3.new(0.3, 1, 0.3)
                PasswordInput.Text = ""
                
                -- 执行开门动画（绕Y轴旋转指定角度）
                local doorOpenCFrame = DoorOriginalCFrame * CFrame.Angles(0, math.rad(DOOR_OPEN_ANGLE), 0)
                createDoorTween(doorOpenCFrame):Play()
                
                -- 3秒后自动关门
                task.delay(3, function()
                    createDoorTween(DoorOriginalCFrame):Play()
                end)
            else
                -- 密码错误：显示提示
                TipText.Text = "密码错误，请重新输入！"
                TipText.TextColor3 = Color3.new(1, 0.3, 0.3)
                PasswordInput.Text = ""
            end
        end)
        
        -- 4.8 实时检测玩家位置（更新UI显示状态）
        HumanoidRootPart:GetPropertyChangedSignal("Position"):Connect(checkPlayerDistance)
        checkPlayerDistance() -- 初始检测一次
    end)
end

-- 5. 监听新玩家加入
Players.PlayerAdded:Connect(onPlayerAdded)

-- 6. 对已加入的玩家执行初始化（避免脚本加载晚于玩家加入）
for _, player in ipairs(Players:GetPlayers()) do
    onPlayerAdded(player)
end
