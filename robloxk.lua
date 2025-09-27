-- Roblox 原生弹窗提示脚本（放在 StarterPlayerScripts 中）
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- 创建弹窗UI
local AlertGui = Instance.new("ScreenGui")
AlertGui.Name = "AlertGui"
AlertGui.Parent = PlayerGui

local AlertFrame = Instance.new("Frame")
AlertFrame.Size = UDim2.new(0, 300, 0, 150)
AlertFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
AlertFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
AlertFrame.BackgroundTransparency = 0.2
AlertFrame.Parent = AlertGui

local AlertText = Instance.new("TextLabel")
AlertText.Size = UDim2.new(0.9, 0, 0.6, 0)
AlertText.Position = UDim2.new(0.05, 0, 0.2, 0)
AlertText.BackgroundTransparency = 1
AlertText.TextColor3 = Color3.new(1, 1, 1)
AlertText.Text = "666神秘脚本"
AlertText.TextScaled = true
AlertText.Parent = AlertFrame

-- 3秒后自动关闭弹窗
task.delay(3, function()
    AlertGui:Destroy()
end)
