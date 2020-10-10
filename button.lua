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
	         "vw;height:" .. (hy*100) .."vh;overflow:hidden;font-size:".. (hy*35) ..
	         "vh;'>" .. text .. "</div>"
	id = screen.addContent(x * 100, y * 100, button)
	self:createClickableArea(id, x, y, hx, hy, fun)
	return id
end

function xGui.createTextArea(self, screen, x, y, hx, hy, bgcolor, color, text)
	button = "<div class='bootstrap' style='background:" .. bgcolor .. ";color:" .. color .. ";width:".. (hx*100) ..
	         "vw;height:" .. (hy*100) .."vh;overflow:hidden;font-size:".. (hy*35) ..
	         "vh;'>" .. text .. "</div>"
	id = screen.addContent(x * 100, y * 100, button)
	return id
end

function xGui.createGauge(self, screen, x, y, hx, hy, value)
	vhx = hx * value
	bgcolor = '#656565'
	if value <= .25 then
		barcolor = '#FF0000'
	elseif value > .25 and value <= .50 then
		barcolor = '#FFFF00'
	else
		barcolor = '#00FF00'
	end
	button = "<div class='bootstrap' style='border-radius: 50vh;background:" .. bgcolor .. ";width:".. (hx*100) ..
	         "vw;height:" .. (hy*100) .."vh;overflow:hidden;font-size:".. (hy*35) ..
	         "vh;'></div>"
	button2 = "<div class='bootstrap' style='border-radius: 50vh;background:" .. barcolor .. ";width:".. (vhx*100) ..
	         "vw;height:" .. (hy*100) .."vh;overflow:hidden;'></div>"			 
	id = screen.addContent(x * 100, y * 100, button)
	id2 = screen.addContent(x * 100, y * 100, button2)
	return id2
end


function xGui.updateGauge(self, screen, id, x, y, hx, hy, value)
	vhx = hx * value
	bgcolor = '#656565'
	if value <= .25 then
		barcolor = '#FF0000'
	elseif value > .25 and value <= .50 then
		barcolor = '#FFFF00'
	else
		barcolor = '#00FF00'
	end
	button2 = "<div class='bootstrap' style='border-radius: 50vh;background:" .. barcolor .. ";width:".. (vhx*100) ..
	         "vw;height:" .. (hy*100) .."vh;overflow:hidden;'></div>"	 
	screen.resetContent(id, button2)
end


function xGui.customizeButtonArea(self, screen, id, style)
	-- here we should retrive the content via the id, inject the style and update the content again
end


function xGui.updateTextArea(self, screen, id, x, y, hx, hy, bgcolor, color, text)
	button = "<div class='bootstrap' style='background:" .. bgcolor .. ";color:" .. color .. ";width:".. (hx*100) ..
	         "vw;height:" .. (hy*100) .."vh;overflow:hidden;font-size:".. (hy*35) ..
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

