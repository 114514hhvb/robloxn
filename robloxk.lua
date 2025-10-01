-- 第一步：显示原神秘弹窗
gg.alert("666神秘脚本")

-- 第二步：新增用户输入交互
local userInput = gg.prompt(
    {"请输入一个你喜欢的数字（神秘彩蛋触发）"}, 
    {"比如666～"}, 
    {"number"}
)

-- 第三步：根据输入反馈趣味内容
if userInput then  -- 若用户输入了内容
    local num = userInput[1]
    if num == 666 then
        gg.alert("哇！你选了脚本专属数字，运气值+666！")
    else
        gg.alert("你选的数字" .. num .. "也超棒～ 神秘脚本为你点赞！")
    end
else  -- 若用户取消输入
    gg.alert("没关系，下次再和神秘脚本互动吧～")
end

-- 第四步：最终退出提示
gg.alert("脚本即将退出，下次见！")
os.exit()
