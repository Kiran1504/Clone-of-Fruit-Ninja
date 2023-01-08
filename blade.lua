blade={}


function create_blade(x,y)
    local blade_point={}
    blade_point.x=x
    blade_point.y=y
    blade_point.radius=10
    table.insert(blade,blade_point)
end

function blade_mechanics(dt)
    if (#blade>0)then
        local speed=math.sqrt(((mousey-blade[1].y)^2)+((mousex-blade[1].x)^2))/0.1
        -- local m=(mousey-blade[1].y)/(mousex-blade[1].x)
        local rot=math.atan2((mousey-blade[1].y),(mousex-blade[1].x))
        local xspeed=speed*math.cos(rot)
        local yspeed=speed*math.sin(rot)
        blade[1].x=blade[1].x+xspeed*dt
        blade[1].y=blade[1].y+yspeed*dt
    end
end

function collision(x, y, radius)
    local dist=math.sqrt(((mousey-y)^2)+((mousex-x)^2))
    if(dist<radius)then
        return true
    else
        return false
    end
end

function blade_draw()
    local sword_width,sword_height=blade_image:getDimensions()
    if(#blade>0)then
        local dist=math.sqrt(((mousey-blade[1].y)^2)+((mousex-blade[1].x)^2))
        love.graphics.draw(blade_image, mousex,mousey, math.atan2(mousey-blade[1].y,mousex-blade[1].x)+math.pi/2, 0.1, dist/800*40*0.05, sword_width/2, 400)
    end
    
    -- for k,v in pairs(blade)do
    --     love.graphics.circle("line", v.x, v.y, v.radius)
    -- end
    -- for k,v in pairs(bombs)do
    --     love.graphics.draw(v.image, v.x, v.y, 0, 3, 3, v.width/2, v.height/2)
    -- end
    -- love.graphics.circle("line", mousex,mousey,10,100)
    -- if(#blade>0)then
    --     love.graphics.line(mousex,mousey,blade[1].x , blade[1].y)
    -- end 
end