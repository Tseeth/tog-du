--Deploy To:  unit.start()

-- Button Code

-- Basic UI library to create clickable areas in screen units

-- ClickableArea class
xClickableArea = {}
xClickableArea.__index = ClickableArea;

function xClickableArea.new(x, y, hx, hy, fun)
    local self = setmetatable({}, ClickableArea)
    self.x = x
    self.y = y
    self.hx = hx
    self.hy = hy
    self.fun = fun
    return self
end

function xClickableArea.contains(self, x, y)
	return x > self.x and x < self.x + self.hx and
	       y > self.y and y < self.y + self.hy
end

-- xGui class
xGui = {}
xGui.__index = xGui;

function xGui.new()
    local self = setmetatable({}, xGui)
    self.areas = {}
    return self
end

function xGui.createClickableArea(self, id, x, y, hx, hy, fun)
	self.areas[id] = xClickableArea.new(x, y, hx, hy, fun)
end

function xGui.deleteClickableArea(self, id)
	table.remove(self.areas, id)
end

function xGui.createButtonArea(self, screen, x, y, hx, hy, bgcolor, color, text, fun)
	button = "<div class='bootstrap' style='background:" .. bgcolor .. ";color:" .. color .. ";width:".. (hx*100) ..
	         "vw;height:" .. (hy*100) .."vh;overflow:hidden;font-size:".. (hy*50) ..
	         "vh;'>" .. text .. "</div>"
	id = screen.addContent(x * 100, y * 100, button)
	self:createClickableArea(id, x, y, hx, hy, fun)
	return id
end

function xGui.createTextArea(self, screen, x, y, hx, hy, bgcolor, color, text)
	button = "<div class='bootstrap' style='background:" .. bgcolor .. ";color:" .. color .. ";width:".. (hx*100) ..
	         "vw;height:" .. (hy*100) .."vh;overflow:hidden;font-size:".. (hy*50) ..
	         "vh;'>" .. text .. "</div>"
	id = screen.addContent(x * 100, y * 100, button)
	return id
end

function xGui.customizeButtonArea(self, screen, id, style)
	-- here we should retrive the content via the id, inject the style and update the content again
end


function xGui.updateTextArea(self, screen, id, x, y, hx, hy, bgcolor, color, text)
	button = "<div class='bootstrap' style='background:" .. bgcolor .. ";color:" .. color .. ";width:".. (hx*100) ..
	         "vw;height:" .. (hy*100) .."vh;overflow:hidden;font-size:".. (hy*50) ..
	         "vh;'>" .. text .. "</div>"
	screen.resetContent(id, button)	
end

function xGui.deleteButtonArea(self, screen, id)
	screen.deleteContent(id)
	self:deleteClickableArea(id)
end

function xGui.process(self, x, y)
	for key, area in pairs(self.areas) do
		if area:contains(x, y) then
			area.fun()
		end
	end
end

ui = xGui.new()
screen1.activate()
screen2.activate()
screen3.activate()
screen4.activate()


unit.setTimer("update",1)


-- Deploy To: unit.tick(update)

screen1label = 'Carbon'
screen2label = 'Iron'
screen3label = 'Aluminium'
screen4label = 'Silicon'
cont1maxvolume = 83200
cont1massperitem = 2.27
cont1mass = utils.round(container1.getItemsMass(),.1)
cont1volume = utils.round(cont1mass / cont1massperitem,.1)
cont1percentage = utils.round((cont1volume / cont1maxvolume)*100,.1)
cont2maxvolume = 358400
cont2massperitem = 7.85
cont2mass = utils.round(container2.getItemsMass(),.1)
cont2volume = utils.round(cont2mass / cont2massperitem,.1)
cont2percentage = utils.round((cont2volume / cont2maxvolume)*100,.1)
cont3maxvolume = 83200
cont3massperitem = 2.70
cont3mass = utils.round(container3.getItemsMass(),.1)
cont3volume = utils.round(cont3mass / cont3massperitem,.1)
cont3percentage = utils.round((cont3volume / cont3maxvolume)*100,.1)
cont4maxvolume = 83200
cont4massperitem = 2.33
cont4mass = utils.round(container4.getItemsMass(),.1)
cont4volume = utils.round(cont4mass / cont4massperitem,.1)
cont4percentage = utils.round((cont4volume / cont4maxvolume)*100,.1)

if cont1percentage >= 75 then
    screen1label2color = "#008000"
    elseif cont1percentage >= 25 then
    screen1label2color = "#FFFF00"
    else
    screen1label2color = "#FF0000"
end

if cont2percentage >= 75 then
    screen2label2color = "#008000"
    elseif cont2percentage >= 25 then
    screen2label2color = "#FFFF00"
    else
    screen2label2color = "#FF0000"
end

if cont3percentage >= 75 then
    screen3label2color = "#008000"
    elseif cont3percentage >= 25 then
    screen3label2color = "#FFFF00"
    else
    screen3label2color = "#FF0000"
end

if cont4percentage >= 75 then
    screen4label2color = "#008000"
    elseif cont4percentage >= 25 then
    screen4label2color = "#FFFF00"
    else
    screen4label2color = "#FF0000"
end
screen1.clear()
screen2.clear()
screen3.clear()
screen4.clear()

screen1label1 = ui:createTextArea(screen1,0,.25,.5,.25,'#FFFFFF','#000000',screen1label)
screen1label2 = ui:createTextArea(screen1,.5,.25,.5,.25,'#000000',screen1label2color,cont1percentage .. '%')
screen1label3 = ui:createTextArea(screen1,0,.50,1,.25,'#000000','#FFFFFF',cont1volume .. 'L')

screen2label1 = ui:createTextArea(screen2,0,.25,.5,.25,'#FFFFFF','#000000',screen2label)
screen2label2 = ui:createTextArea(screen2,.5,.25,.5,.25,'#000000',screen2label2color,cont2percentage .. '%')
screen2label3 = ui:createTextArea(screen2,0,.50,1,.25,'#000000','#FFFFFF',cont2volume .. 'L')

screen3label1 = ui:createTextArea(screen3,0,.25,.5,.25,'#FFFFFF','#000000',screen3label)
screen3label2 = ui:createTextArea(screen3,.5,.25,.5,.25,'#000000',screen3label2color,cont3percentage .. '%')
screen3label3 = ui:createTextArea(screen3,0,.50,1,.25,'#000000','#FFFFFF',cont3volume .. 'L')

screen4label1 = ui:createTextArea(screen4,0,.25,.5,.25,'#FFFFFF','#000000',screen4label)
screen4label2 = ui:createTextArea(screen4,.5,.25,.5,.25,'#000000',screen4label2color,cont4percentage .. '%')
screen4label3 = ui:createTextArea(screen4,0,.50,1,.25,'#000000','#FFFFFF',cont4volume .. 'L')

-- Deploy To: unit.stop()

screen1.deactivate()
screen2.deactivate()
screen3.deactivate()
screen4.deactivate()

