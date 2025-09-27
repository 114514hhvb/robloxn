# robloxn

-- 基本运算函数定义
function add(a, b)
    return a + b
end -- 加法配置

function sub(c, d)
    return c - d
end -- 减法配置

function div(e, f)
    return e / f -- 除法配置
end

function mul(g, h)
    return g * h
end

function exit()
    gg.alert("祝你天天开心") -- 退出之前先送个祝福
    os.exit()
end

-- 配置区域
function a()
    k = gg.prompt({"请输入第1个加数"}, {"请您输入"}, {"number"})
    g = gg.prompt({"请输入第2个加数"}, {"请您输入"}, {"number"})
    local s = add(k[1], g[1])
    gg.alert("和为" .. s)
    main()
end

function b()
    local a = gg.prompt({"请输入被减数"}, {"请您输入"}, {"number"})
    local b = gg.prompt({"请输入减数"}, {"请您输入"}, {"number"})
    local s = sub(a[1], b[1])
    gg.alert("差为" .. s)
end

function c()
    local a = gg.prompt({"请输入第1个因数"}, {"请您输入"}, {"number"})
    local b = gg.prompt({"请输入第2个因数"}, {"请您输入"}, {"number"})
    local s = mul(a[1], b[1])
    gg.alert("积为" .. s)
end

function d()
    local a = gg.prompt({"请输入被除数\n如果你想进行对小数部分的舍去可不看以下提示\n(注意这里的数字必须至少保留一位小数如果是整数则转化为几点零)\n例如10.0"}, {"请您输入"}, {"number"})
    local b = gg.prompt({"请输入除数\n如果你想进行对小数部分的舍去可不看以下提示\n(注意这里的数字必须至少保留一位小数如果是整数则转化为几点零)\n例如10.0"}, {"请您输入"}, {"number"})
    local s = div(a[1], b[1])
    gg.alert("商为" .. s)
end

function main() -- 主函数
    CMR = gg.choice({
        "加法",
        "减法",
        "乘法",
        "除法",
        "退出计算机",
    }, nil, os.date("The world is very big, why do we meet, just because of love, this is a simple calculator, for reference only, if there is a way to write. Please point out the mistakes in the report.\n当前是%Y年-%m月-%d日 %H时:%M分\n今年已过:%j天\n作者程某人\n请输入数字，否则可能会导致报错 "))
    if CMR == 1 then a() end
    if CMR == 2 then b() end
    if CMR == 3 then c() end
    if CMR == 4 then d() end
    if CMR == 5 then exit() end
end

while true do
    main()
end -- 如果点取消就退出脚本这并不合我的意思，没什么办法。不会高级的写法只能这么做

-- 以下为注释掉的测试代码
-- c = gg.prompt({"请输入数字"}, {"请您输入"}, {"number"})
-- print(c[1])
