MainMenuState = {}
MainMenuState.__index = MainMenuState
setmetatable(MainMenuState, State)

function MainMenuState.create()
	local self = setmetatable({}, MainMenuState)

	self.inputs = {}
	self.inputs[1] = KeyboardInput.create()
	self.inputs[2] = MouseInput.create()
	self.inputs[3] = JoystickInput.create(1)
	
	self.cursor = Cursor.create(WIDTH/2, HEIGHT/2, 1)

	self.menu = Menu.create((WIDTH-200)/2, 220, 220, 32, 16, self)
	self.menu:addButton("START GAME", "start")
	self.menu:addButton("OPTIONS", "options")
	self.menu:addButton("LEVEL EDITOR", "editor")
	self.menu:addButton("QUIT", "quit")

	return self
end

function MainMenuState:update(dt)
	for i,v in ipairs(self.inputs) do
		if v:wasClicked() then
			self.menu:click(self.cursor.x, self.cursor.y)
		end
		self.cursor:move(v:getMovement(dt))
	end
	for i,v in ipairs(self.inputs) do
		if v:wasClicked() then
			self.menu:click(self.cursor.x, self.cursor.y)
		end
	end
end

function MainMenuState:draw()
	self.menu:draw()
	love.graphics.print("1 START TEST", 32, 32)
	love.graphics.print("2 START TEST2", 32, 48)
	love.graphics.print("3 START CUSTOM MAP", 32, 64)
	love.graphics.print("4 LEVEL EDITOR", 32, 80)

	self.cursor:getDrawable():draw(self.cursor.x, self.cursor.y)
end

function MainMenuState:keypressed(k, uni)
	for i,v in ipairs(self:getInputs()) do
		v:keypressed(k, uni)
	end

	if k == "1" then
		pushState(IngameState.create("res/maps/test.lua", Rules.create()))
	elseif k == "2" then
		pushState(IngameState.create("res/maps/test2.lua", Rules.create()))
	elseif k == "3" then
		pushState(IngameState.create("usermaps/custom.lua", Rules.create()))
	elseif k == "4" then
		pushState(LevelEditorState.create())
	end
end

function MainMenuState:buttonPressed(id)
	if id == "editor" then
		pushState(LevelEditorState.create())
	elseif id == "quit" then
		love.event.quit()
	end
end