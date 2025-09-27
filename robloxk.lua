-- 最终可运行指令：加载修复后的 robloxk.lua
local loadSuccess, loadErr = pcall(function()
    -- 正确的 robloxk.lua Raw 链接（需替换为你仓库的实际 Raw 链接，示例如下）
    local robloxkRawUrl = "https://raw.githubusercontent.com/114514hhvb/robloxn/216456166b8918afcb9fdd3d400c6007bd0485f2/robloxk.lua"
    local robloxkCode = game:HttpGetAsync(robloxkRawUrl, Enum.HttpContentType.TextPlain)
    loadstring(robloxkCode)()
end)

if not loadSuccess then
    warn("加载 robloxk.lua 失败：" .. loadErr)
end
