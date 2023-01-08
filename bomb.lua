bombs={}
cut_bomb={}

function create_bomb()
    local bomb={}
    bombwidth,bombheight=type_bomb.full:getDimensions()
    bomb.image=type_bomb.full
    bomb.width,bomb.height=50,28
    bomb.x=math.random(0,window_width)
    bomb.y=window_height+100
    bomb.xspeed=(bomb.x<(window_width/2)) and math.random(0,300) or math.random(-300,0)
    bomb.yspeed=math.random(-1100,-800)
    table.insert(bombs, bomb)
end

function bomb_draw()
    for k,v in pairs(bombs)do
        love.graphics.draw(v.image, v.x,v.y , 0,0.1,0.1, v.width/0.05,v.height/0.05)
        love.graphics.circle("line",v.x, v.y,v.height,100)
    end
end

function bomb_mechanics(dt)
    for key,value in pairs(bombs)do
        -- value.x=value.x+value.xspeed*dt
        -- value.y=value.y+value.yspeed*dt
        -- value.yspeed=value.yspeed+gravity*dt
        if(value.y>window_height+100)then
            table.remove(bombs,key)
        end
    end
    if(#blade>0)then
        for key,value in pairs(bombs)do
            if(collision(value.x,value.y, value.height*1.27))then
                local rot=math.atan2((mousey-blade[1].y),(mousex-blade[1].x))
                game_over=1
                fruits={}
                bombs={}
                bomb={}
                cut_fruits={}
                -- cut_bomb={}
                -- bomb_partition(value.x,value.y , value.height*1.27,rot, value.xspeed, value.yspeed, value.type)
                -- table.remove(bombs,key)
            end
        end
    end
end

function bomb_partition(x,y, r, rotation, xspeed, yspeed, type)
    local upper_cut={}
    upper_cut.x=x+r*(math.cos(rotation-math.pi/2))/4
    upper_cut.y=y+r*(math.sin(rotation-math.pi/2))/4
    upper_cut.xspeed=xspeed+math.random(50,100)*(math.cos(rotation-math.pi/2))
    upper_cut.yspeed=yspeed+math.random(50,100)*(math.sin(rotation-math.pi/2))
    upper_cut.r=r/2
    upper_cut.rotation=rotation+math.pi/2
    upper_cut.image=type_bomb.full

    local lower_cut={}
    lower_cut.x=x+r*(math.cos(rotation+math.pi/2))/4
    lower_cut.y=y+r*(math.sin(rotation+math.pi/2))/4
    lower_cut.xspeed=xspeed+math.random(50,100)*(math.cos(rotation+math.pi/2))
    lower_cut.yspeed=yspeed+math.random(50,100)*(math.sin(rotation+math.pi/2))
    lower_cut.r=r/2
    lower_cut.rotation=rotation+math.pi/2
    lower_cut.image=type_bomb.full


    table.insert(cut_bomb,upper_cut)
    table.insert(cut_bomb,lower_cut)
end

function cut_bomb_mechanics(dt)
    for key,value in pairs(cut_bomb)do
        value.x=value.x+value.xspeed*dt
        value.y=value.y+value.yspeed*dt
        value.yspeed=value.yspeed+gravity*dt
        if(value.y>window_height+100)then
            table.remove(cut_bomb,key)
        end
    end
end

function cut_bomb_mechanics(dt)
    for key,value in pairs(cut_bomb)do
        value.x=value.x+value.xspeed*dt
        value.y=value.y+value.yspeed*dt
        value.yspeed=value.yspeed+gravity*dt
        if(value.y>window_height+100)then
            table.remove(cut_bomb,key)
        end
    end
end