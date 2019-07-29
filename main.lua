local map = {
    {" ", " ", " "},
    {" ", " ", " "},
    {" ", " ", " "}
}

local solutions = {
    {{x = 1, y = 1}, {y = 2, x = 1}, {y = 3, x = 1}},
    {{y = 1, x = 3}, {y = 2, x = 3}, {y = 3, x = 3}},
    {{y = 1, x = 1}, {y = 1, x = 2}, {y = 1, x = 3}},
    {{y = 3, x = 1}, {y = 3, x = 2}, {y = 3, x =3}},
    {{y = 1, x = 1}, {y = 2, x = 2}, {y = 3, x = 3}},
    {{y = 1, x = 3}, {y = 2, x = 2}, {y = 3, x = 1}},
    {{y = 2, x = 1}, {y = 2, x = 2}, {y = 2, x = 3}}
}

local emptyImage, oImage, xImage, scale
local turn = "x"
local text = "x turn"
local finish = false
function love.load()
    scale = 4
    emptyImage = love.graphics.newImage("empty.png")
    emptyImage:setFilter("nearest")
    oImage = love.graphics.newImage("o.png")
    oImage:setFilter("nearest")
    xImage = love.graphics.newImage("x.png")
    xImage:setFilter("nearest")
end

function love.draw()
    love.graphics.print(text)
    for y=1, #map do
        for x = 1, #map[y] do -- error deberia ser #map[y]
            local value = map[y][x]
            if value == " " then
                love.graphics.draw(emptyImage, x * 32 * scale, y * 32 * scale, 0, scale, scale)
            elseif value == "x" then
                love.graphics.draw(xImage, x * 32 * scale, y * 32 * scale, 0, scale, scale)
            else
                love.graphics.draw(oImage, x * 32 * scale, y * 32 * scale, 0, scale, scale)
            end
        end
    end
end

function love.mousepressed(x, y, button)
    if not finish then
        if button == 1 then
            for yMap = 1, 3 do
                for xMap = 1, 3 do
                    if x > xMap * 32 * scale and x < (xMap + 1) * 32 * scale then
                        if y > yMap * 32 * scale and y < (yMap + 1) * 32 * scale then
                            if map[yMap][xMap] == " " then
                                map[yMap][xMap] = turn
                                if turn == "x" then turn = "o" else turn = "x" end
                                text = turn .. " turn"
                            end
                            checkWin()
                            return
                        end
                    end
                end
            end
        end
    else
        map = {
            {" ", " ", " "},
            {" ", " ", " "},
            {" ", " ", " "}
        }
        finish = false
        turn = "x"
        text = "x turn"
    end
end

function checkWin()
    for i = 1, #solutions do
        local item = solutions[i]
        if map[item[1].y][item[1].x] == map[item[2].y][item[2].x] then
            if map[item[3].y][item[3].x] == map[item[2].y][item[2].x] then
                if map[item[1].y][item[1].x] ~= " " then
                    text = map[item[1].y][item[1].x] .. " wins!"
                    finish = true
                end
            end
        end
    end
end
