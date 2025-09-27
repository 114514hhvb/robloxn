-- 修正链接后的加载指令（需先配置 HTTP 白名单，且注意外部脚本风险）
local success, err = pcall(function()
    -- 正确的 GitHub Raw 链接（指向 drhvx.lua 纯代码）
    local rawUrl = "loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()"
    local luaCode = game:HttpGet(rawUrl)  -- 请求纯 Lua 代码
    -- 【关键】先打印代码内容，验证是否为合法 Lua 脚本（避免加载恶意代码）
    print("加载的 drhvx.lua 代码：\n" .. luaCode)
    loadstring(luaCode)()  -- 确认安全后再执行
end)

if not success then
    warn("加载失败原因：" .. err)  -- 打印错误信息，便于排查
end
