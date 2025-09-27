-- 游戏初始化
function love.load()
    -- 网格尺寸（控制蛇和食物大小）
    gridSize = 20
    -- 窗口大小（需为网格尺寸的整数倍）
    windowWidth, windowHeight = 600, 400
    love.window.setMode(windowWidth, windowHeight, {resizable = false})
    love.window.setTitle("Lua 贪吃蛇")

    -- 蛇初始化：初始3节身体，方向向右
    snake = {
        {x = 10, y = 10},  -- 蛇头
        {x = 9, y = 10},   -- 第一节身体
        {x = 8, y = 10}    -- 第二节身体
    }
    direction = "right"  -- 初始方向
    nextDirection = "right"  -- 缓冲方向（防止反向）

    -- 食物初始化（随机生成）
    food = spawnFood()

    -- 游戏参数
    speed = 0.15  -- 移动间隔（秒），值越小越快
    timer = 0     -- 计时用
    score = 0     -- 得分
    gameOver = false  -- 游戏结束标记
end

-- 生成食物（避免生成在蛇身上）
function spawnFood()
    local foodX, foodY
    local onSnake = true

    -- 循环直到食物不在蛇身上
    while onSnake do
        onSnake = false
        -- 随机生成网格内坐标
        foodX = love.math.random(1, windowWidth / gridSize)
        foodY = love.math.random(1, windowHeight / gridSize)

        -- 检查是否与蛇身重叠
        for _, segment in ipairs(snake) do
            if segment.x == foodX and segment.y == foodY then
                onSnake = true
                break
            end
        end
    end

    return {x = foodX, y = foodY}
end

-- 键盘控制（方向键或 WASD）
function love.keypressed(key)
    -- 游戏结束时按 R 重启
    if gameOver and key == "r" then
        love.load()
        return
    end

    -- 方向控制（防止180度反向）
    if key == "right" and direction ~= "left" then
        nextDirection = "right"
    elseif key == "left" and direction ~= "right" then
        nextDirection = "left"
    elseif key == "up" and direction ~= "down" then
        nextDirection = "up"
    elseif key == "down" and direction ~= "up" then
        nextDirection = "down"
    -- WASD 控制
    elseif key == "d" and direction ~= "left" then
        nextDirection = "right"
    elseif key == "a" and direction ~= "right" then
        nextDirection = "left"
    elseif key == "w" and direction ~= "down" then
        nextDirection = "up"
    elseif key == "s" and direction ~= "up" then
        nextDirection = "down"
    end
end

-- 游戏逻辑更新（按时间间隔执行）
function love.update(dt)
    if gameOver then return end  -- 游戏结束则停止更新

    -- 计时：达到间隔后移动蛇
    timer = timer + dt
    if timer >= speed then
        timer = 0
        direction = nextDirection  -- 更新方向

        -- 1. 计算新蛇头位置
        local head = {x = snake[1].x, y = snake[1].y}
        if direction == "right" then
            head.x = head.x + 1
        elseif direction == "left" then
            head.x = head.x - 1
        elseif direction == "up" then
            head.y = head.y - 1
        elseif direction == "down" then
            head.y = head.y + 1
        end

        -- 2. 碰撞检测（边界或自身）
        -- 边界碰撞：超出窗口网格范围
        if head.x < 1 or head.x > windowWidth/gridSize or
           head.y < 1 or head.y > windowHeight/gridSize then
            gameOver = true
            return
        end
        -- 自身碰撞：蛇头碰到身体
        for _, segment in ipairs(snake) do
            if segment.x == head.x and segment.y == head.y then
                gameOver = true
                return
            end
        end

        -- 3. 添加新蛇头
        table.insert(snake, 1, head)

        -- 4. 检查是否吃到食物
        if head.x == food.x and head.y == food.y then
            score = score + 10  -- 得分+10
            food = spawnFood()  -- 重新生成食物
            -- 每得50分加速（可选）
            if score % 50 == 0 and speed > 0.05 then
                speed = speed - 0.01
            end
        else
            -- 没吃到食物则删除尾部（保持长度不变）
            table.remove(snake)
        end
    end
end

-- 绘制游戏画面
function love.draw()
    -- 1. 绘制蛇（绿色蛇头，深绿色身体）
    for i, segment in ipairs(snake) do
        if i == 1 then
            love.graphics.setColor(0, 1, 0)  -- 蛇头：亮绿色
        else
            love.graphics.setColor(0, 0.7, 0)  -- 蛇身：深绿色
        end
        -- 绘制矩形（网格坐标转像素坐标）
        love.graphics.rectangle(
            "fill",
            (segment.x - 1) * gridSize,
            (segment.y - 1) * gridSize,
            gridSize - 1,  -- 减1避免蛇身粘连
            gridSize - 1
        )
    end

    -- 2. 绘制食物（红色）
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle(
        "fill",
        (food.x - 1) * gridSize,
        (food.y - 1) * gridSize,
        gridSize - 1,
        gridSize - 1
    )

    -- 3. 绘制得分
    love.graphics.setColor(1, 1, 1)  -- 白色文字
    love.graphics.print("得分: " .. score, 10, 10, 0, 1.2, 1.2)  -- 放大1.2倍

    -- 4. 绘制游戏结束提示
    if gameOver then
        love.graphics.setColor(1, 0, 0)
        love.graphics.printf(
            "游戏结束！\n得分: " .. score .. "\n按 R 重新开始",
            0,
            windowHeight / 2 - 50,
            windowWidth,
            "center",
            0,
            2,
            2  -- 放大2倍
        )
    end
end
