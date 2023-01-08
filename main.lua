window_width=800
window_height=800

gravity=800

require "bomb"
require "fruit"
require "blade"

timer=0
timer_count=math.random(2,5)

fruit_counter=0
fruit_missed=0
highscore=0

game_over=0

mousex,mousey=love.mouse.getPosition()


function love.load()
    love.window.setMode(window_width, window_height)
    types_of_fruit={{full=love.graphics.newImage("Images/Water_Melon/wat_1.png"), cut_1=love.graphics.newImage("Images/Water_Melon/wat_2.png"), cut_2=love.graphics.newImage("Images/Water_Melon/wat_3.png")},
    {full=love.graphics.newImage("Images/Oranges/orange_1.png"), cut_1=love.graphics.newImage("Images/Oranges/orange_2.png"), cut_2=love.graphics.newImage("Images/Oranges/orange_3.png")}} 
    type_bomb={full=love.graphics.newImage("Images/Bombs/bomb.png")}
    blade_image=love.graphics.newImage("Images/Swords/sword_red.png")
    background=love.graphics.newImage("Images/Background/Wiki-background.jpg")
    background_width,background_height=background:getDimensions()
end


function love.update(dt)
    if (game_over==0)then
    mousex,mousey=love.mouse.getPosition()
    if(highscore<fruit_counter)then
        highscore=fruit_counter
    end
    --------------------------------------------
    timer=timer+dt
    if(timer>timer_count)then
        timer_count=math.random(2,5)
        timer=0
        local number=math.random(1,3)
        for i=1, number, 1 do
            create_fruit()
        end
        
    end
    -- timer_count=math.random(2,5)
    -- if(timer>timer_count)then
    --     timer_count=math.random(2,5)
    --     timer=0
    --     local number=math.random(1,2)
    --     for i=1, number, 1 do
    --         create_bomb()
    --     end
    -- end
    --------------------------------------------
    fruit_mechanics(dt)
    cut_fruits_mechanics(dt)
    bomb_mechanics(dt)
    cut_bomb_mechanics(dt)
    for key,value in pairs(bombs)do
        value.x=value.x+value.xspeed*dt
        value.y=value.y+value.yspeed*dt
        value.yspeed=value.yspeed+gravity*dt
    end
    blade_mechanics(dt)
    -- for key,value in pairs(bombs)do
    --     fruit_partition(value.x,value.y , value.height*1.27, rot, value.xspeed, value.yspeed, value.type)
    -- end
    end
end

function love.mousepressed(x, y, button) 
    if (button==1 and game_over==0)then
        -- if(highscore>fruit_counter)then
        --     highscore=fruit_counter
        -- end
        create_fruit()
        create_blade(x,y)
        create_bomb()
    end
    if (button==2 and game_over==1)then
        
        game_over=0
        fruit_counter=0
    end

end

function love.mousereleased(x, y, button, istouch)
    if (button==1 and game_over==0)then
        blade={}
    end
end

function love.draw()
    if(game_over==0)then
    love.graphics.draw(background,0,0,0,window_width/background_width, window_height/background_height)
    fruit_draw()
    bomb_draw()
    blade_draw()
    cut_fruits_draw()
    love.graphics.print(fruit_counter)
    love.graphics.print(fruit_missed,700,100)
    end
    if(game_over==1)then
    love.graphics.print("GAME OVER!!!",310,350)
    love.graphics.print("Score",300,400)
    love.graphics.print(fruit_counter,400,400)
    love.graphics.print("Highscore",300,420)
    love.graphics.print(highscore,400,420)
    love.graphics.print("Right click to Restart",300,460)
    end
end


