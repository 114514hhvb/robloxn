-- 多功能文本处理工具：支持统计、排序、过滤
local TextTool = {}

-- 1. 文本基础统计（字符数、单词数、行数）
function TextTool.countTextInfo(text)
    if type(text) ~= "string" then
        error("输入必须是字符串！")
    end

    -- 统计字符数（含空格）
    local charCount = #text
    -- 统计单词数（以空格/标点分割，忽略空字符）
    local wordCount = 0
    for word in string.gmatch(text, "%S+") do
        wordCount = wordCount + 1
    end
    -- 统计行数（以\n分割，空行也计入）
    local lineCount = 1  -- 至少1行
    for _ in string.gmatch(text, "\n") do
        lineCount = lineCount + 1
    end

    return {
        charCount = charCount,
        wordCount = wordCount,
        lineCount = lineCount
    }
end

-- 2. 单词按字母顺序排序（忽略大小写）
function TextTool.sortWords(text)
    local words = {}
    -- 提取所有单词（仅字母，忽略数字和符号）
    for word in string.gmatch(text, "%a+") do
        table.insert(words, string.lower(word))  -- 统一转为小写排序
    end

    -- 冒泡排序（按字母ASCII码）
    for i = 1, #words - 1 do
        for j = 1, #words - i do
            if words[j] > words[j + 1] then
                words[j[j words[j + 1] = words[j + 1[j words[j]
            end
        end
    end

    return words
end

-- 3. 敏感词过滤（替换为*）
function TextTool.filterSensitiveWords(text, sensitiveWords)
    local filteredText = text
    -- 遍历敏感词库，替换匹配内容
    for _, word in ipairs(sensitiveWords) do
        -- 忽略大小写匹配（如"bad"和"Bad"都过滤）
        local pattern = string.gsub(word, "%p", "%%%1")  -- 转义标点符号
        filteredText = string.gsub(filteredText, pattern, string.rep("*", #word), 1)
    end
    return filteredText
end

-- ====================== 测试示例 ======================
-- 自定义输入文本
local inputText = [[
Hello Lua! This is a test text. 
Lua is a lightweight programming language. 
Be careful with bad words like "error" (just a demo).
]]

-- 自定义敏感词库
local sensitiveWords = {"bad", "error"}

-- 1. 测试文本统计
local countResult = TextTool.countTextInfo(inputText)
print("=== 文本统计结果 ===")
print("字符数（含空格）：" .. countResult.charCount)
print("单词数：" .. countResult.wordCount)
print("行数：" .. countResult.lineCount)

-- 2. 测试单词排序
local sortedWords = TextTool.sortWords(inputText)
print("\n=== 排序后的单词 ===")
print(table.concat(sortedWords, ", "))

-- 3. 测试敏感词过滤
local filteredText = TextTool.filterSensitiveWords(inputText, sensitiveWords)
print("\n=== 过滤后的文本 ===")
print(filteredText)
