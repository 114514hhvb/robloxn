-- 工具函数：封装 Roblox 官方通知弹窗（替代 gg.alert）
local function showAlert(title, text)
    -- 使用 Roblox 核心通知系统，避免自定义 UI 复杂操作
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = 5 -- 弹窗显示5秒后自动消失
    })
end

-- 工具函数：创建数字输入界面（替代 gg.prompt）
local function showNumberInput(promptText, placeholder)
    -- 1. 创建临时 ScreenGui 存储输入界面
    local gui = Instance.new("ScreenGui")
    gui.Name = "NumberInputGui"
    gui.Parent = game:GetService("Players").LocalPlayer.PlayerGui

    -- 2. 创建背景面板
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 200)
    frame.Position = UDim2.new(0.5, -175, 0.5, -100)
    frame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.new(0.8, 0.8, 0.8)
    frame.Parent = gui

    -- 3. 创建提示文本
    local promptLabel = Instance.new("TextLabel")
    promptLabel.Size = UDim2.new(0.9, 0, 0, 30)
    promptLabel.Position = UDim2.new(0.05, 0, 0.1, 0)
    promptLabel.Text = promptText
    promptLabel.TextColor3 = Color3.new(1, 1, 1)
    promptLabel.TextScaled = true
    promptLabel.Parent = frame

    -- 4. 创建数字输入框
    local inputBox = Instance.new("TextBox")
    inputBox.Size = UDim2.new(0.8, 0, 0, 40)
    inputBox.Position = UDim2.new(0.1, 0, 0.4, 0)
    inputBox.PlaceholderText = placeholder
    inputBox.TextColor3 = Color3.new(1, 1, 1)
    inputBox.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
    inputBox.ClearTextOnFocus = false
    inputBox.Parent = frame
    -- 限制仅输入数字和小数点
    inputBox:GetPropertyChangedSignal("Text"):Connect(function()
        inputBox.Text = inputBox.Text:gsub("[^%d%.]", "") -- 过滤非数字、非小数点字符
        -- 确保仅存在一个小数点
        local dotCount = select(2, inputBox.Text:gsub("%.", ""))
        if dotCount > 1 then
            inputBox.Text = inputBox.Text:sub(1, inputBox.Text:find("%.") + 1)
        end
    end)

    -- 5. 创建确认按钮
    local confirmBtn = Instance.new("TextButton")
    confirmBtn.Size = UDim2.new(0.3, 0, 0, 35)
    confirmBtn.Position = UDim2.new(0.2, 0, 0.75, 0)
    confirmBtn.Text = "确认"
    confirmBtn.TextColor3 = Color3.new(1, 1, 1)
    confirmBtn.BackgroundColor3 = Color3.new(0.2, 0.6, 1)
    confirmBtn.Parent = frame

    -- 6. 创建取消按钮
    local cancelBtn = Instance.new("TextButton")
    cancelBtn.Size = UDim2.new(0.3, 0, 0, 35)
    cancelBtn.Position = UDim2.new(0.5, 0, 0.75, 0)
    cancelBtn.Text = "取消"
    cancelBtn.TextColor3 = Color3.new(1, 1, 1)
    cancelBtn.BackgroundColor3 = Color3.new(0.8, 0.2, 0.2)
    cancelBtn.Parent = frame

    -- 7. 等待用户操作（返回输入的数字或 nil）
    local result = nil
    local waitForInput = Instance.new("BindableEvent")

    confirmBtn.MouseButton1Click:Connect(function()
        if inputBox.Text ~= "" then
            result = tonumber(inputBox.Text) -- 转为数字类型
        end
        waitForInput:Fire()
    end)

    cancelBtn.MouseButton1Click:Connect(function()
        waitForInput:Fire()
    end)

    waitForInput.Event:Wait()
    gui:Destroy() -- 关闭界面并清理
    return result
end

-- 主逻辑：还原原脚本交互流程
local function main()
    -- 1. 显示初始神秘弹窗
    showAlert("666神秘脚本", "欢迎使用合规版脚本～")
    task.wait(2) -- 等待2秒，让用户看清弹窗

    -- 2. 让用户输入喜欢的数字
    local userNum = showNumberInput(
        "请输入一个你喜欢的数字（神秘彩蛋触发）",
        "比如666～"
    )

    -- 3. 根据输入反馈趣味内容
    if userNum then
        if userNum == 666 then
            showAlert("彩蛋触发！", "哇！你选了脚本专属数字，运气值+666！")
        else
            showAlert("点赞！", "你选的数字" .. userNum .. "也超棒～ 神秘脚本为你点赞！")
        end
    else
        showAlert("下次再见", "没关系，下次再和神秘脚本互动吧～")
    end
    task.wait(3) -- 等待3秒，让用户看清反馈

    -- 4. 最终退出提示
    showAlert("脚本结束", "脚本即将退出，下次见！")
end

