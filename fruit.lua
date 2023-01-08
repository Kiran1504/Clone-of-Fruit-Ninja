fruits={}
cut_fruits={}


function create_fruit()
    local fruit={}
    watermelonwidth,watermelonheight=types_of_fruit[1].full:getDimensions()
    orangewidth,orangeheight=types_of_fruit[2].full:getDimensions()
    fruit.type=math.random(1,2)
    fruit.image=types_of_fruit[fruit.type].full
    fruit.width,fruit.height=fruit.image:getDimensions()
    fruit.x=math.random(0,window_width)
    fruit.y=window_height+100
    fruit.xspeed=(fruit.x<(window_width/2)) and math.random(0,300) or math.random(-300,0)
    fruit.yspeed=math.random(-1000,-700)
    table.insert(fruits,fruit)
end

function fruit_mechanics(dt)
    for key,value in pairs(fruits)do
        value.x=value.x+value.xspeed*dt
        value.y=value.y+value.yspeed*dt
        value.yspeed=value.yspeed+gravity*dt
        if(value.y>window_height+100)then
            table.remove(fruits,key)
            fruit_missed=fruit_missed+1
            if(fruit_missed>=3)then
                fruit_missed=0
                game_over=1
                cut_fruits={}
                fruits={}
                blade={}
            end
        end
    end
    if(#blade>0)then
        for key,value in pairs(fruits)do
            if(collision(value.x,value.y, value.height*1.27))then
                local rot=math.atan2((mousey-blade[1].y),(mousex-blade[1].x))
                fruit_counter=fruit_counter+1
                fruit_partition(value.x,value.y , value.height*1.27,rot, value.xspeed, value.yspeed, value.type)
                table.remove(fruits,key)
            end
        end
    end
end

function fruit_partition(x,y, r, rotation, xspeed, yspeed, type)
    local upper_cut={}
    upper_cut.x=x+r*(math.cos(rotation-math.pi/2))/4
    upper_cut.y=y+r*(math.sin(rotation-math.pi/2))/4
    upper_cut.xspeed=xspeed+math.random(50,100)*(math.cos(rotation-math.pi/2))
    upper_cut.yspeed=yspeed+math.random(50,100)*(math.sin(rotation-math.pi/2))
    upper_cut.r=r/2
    upper_cut.rotation=rotation+math.pi/2
    upper_cut.image=types_of_fruit[type].cut_1

    local lower_cut={}
    lower_cut.x=x+r*(math.cos(rotation+math.pi/2))/4
    lower_cut.y=y+r*(math.sin(rotation+math.pi/2))/4
    lower_cut.xspeed=xspeed+math.random(50,100)*(math.cos(rotation+math.pi/2))
    lower_cut.yspeed=yspeed+math.random(50,100)*(math.sin(rotation+math.pi/2))
    lower_cut.r=r/2
    lower_cut.rotation=rotation+math.pi/2
    lower_cut.image=types_of_fruit[type].cut_2


    table.insert(cut_fruits,upper_cut)
    table.insert(cut_fruits,lower_cut)
end

function cut_fruits_draw()
    for k,v in pairs(cut_fruits)do
        local ox,oy=v.image:getDimensions()
        love.graphics.draw(v.image ,v.x,v.y,v.rotation,3,3,ox/2,oy/2 )
        
    end
end

function fruit_draw()
    for key,value in pairs(fruits)do
        love.graphics.draw(value.image,value.x, value.y,0,3,3,value.width/2,value.height/2)
        love.graphics.circle("line",value.x, value.y,value.height*1.27,100)
        -- love.graphics.print(#fruits)
    end
end

function cut_fruits_mechanics(dt)
    for key,value in pairs(cut_fruits)do
        value.x=value.x+value.xspeed*dt
        value.y=value.y+value.yspeed*dt
        value.yspeed=value.yspeed+gravity*dt
        if(value.y>window_height+100)then
            table.remove(cut_fruits,key)
        end
    end
end