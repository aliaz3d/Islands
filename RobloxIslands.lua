

	if (not game:IsLoaded()) then
		game.Loaded:Wait();
	end


	local name = "Foxi cheats V2 (anti afk always enabled) Update [Changelog]!"




	local AcessTable = {
		1061454726, --[[aliaz3d]]
		3955398800, --[[aliaz15d]]
	
		
	}



	local Acess = false

	for i, v in pairs(AcessTable) do
		if game.Players.LocalPlayer.UserId == v then
			Acess = true
		end
	end

	if not Acess then
		print("refused")
		--game.CoreGui:FindFirstChild(name).Main.Visible = false
		--venyx:Notify("You're not whitelisted", "Do you want to buy the cheat ?", function(value)
		--	if value then
		--		print(game.PlaceId)
		--		game:GetService("TeleportService"):Teleport(31285342 , game.Players.LocalPlayer)
		--	end
		--end)
		return
	else
		print("Valid ^^")
	end




	-- Venyx Ui
	-- init
	local player = game.Players.LocalPlayer
	local mouse = player:GetMouse()

	-- services
	local input = game:GetService("UserInputService")
	local run = game:GetService("RunService")
	local tween = game:GetService("TweenService")
	local tweeninfo = TweenInfo.new
	local alive = true

	--Obj
	local MainContainer

	-- additional
	local utility = {}

	-- themes
	local objects = {}



	if not themes then
		themes = {
			DarkContrast = Color3.new(0.117647, 0.117647, 0.117647),
			Glow = Color3.new(0, 0, 0),
			LightContrast = Color3.new(0.156863, 0.156863, 0.156863),
			SliderColor = Color3.new(1, 0.443137, 0.2),
			NotToggledColor = Color3.new(0, 1, 0.791667),
			ButtonColor = Color3.new(0.243137, 0.243137, 0.243137),
			ToggledColor = Color3.new(0.126866, 0.925, 0.0128472),
			TopBarColor = Color3.new(0.137255, 0.137255, 0.137255),
			Background = Color3.new(0.0980392, 0.0980392, 0.0980392),
			TextColor = Color3.new(1, 1, 1),
			Accent = Color3.new(1, 0.443137, 0.2),
		}
	end

	do
		-- Dynamic Scroll
		function dynamicscroll(scrollingframe,uilis)
			uilis:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
				scrollingframe.CanvasSize = UDim2.new(0, 0, 0, uilis.AbsoluteContentSize.Y + 10)
			end)
		end 

		function utility:Create(instance, properties, children)
			local object = Instance.new(instance)

			for i, v in pairs(properties or {}) do
				object[i] = v

				if typeof(v) == "Color3" then -- save for theme changer later
					local theme = utility:Find(themes, v)

					if theme then
						objects[theme] = objects[theme] or {}
						objects[theme][i] = objects[theme][i] or setmetatable({}, {_mode = "k"})

						table.insert(objects[theme][i], object)
					end
				end
			end

			for i, module in pairs(children or {}) do
				module.Parent = object
			end

			return object
		end

		function utility:Tween(instance, properties, duration, ...)
			tween:Create(instance, tweeninfo(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), properties):Play()
		end

		function utility:Wait()
			run.RenderStepped:Wait()
			return true
		end

		function utility:Find(table, value) -- table.find doesn't work for dictionaries
			for i, v in  pairs(table) do
				if v == value then
					return i
				end
			end
		end

		function utility:Sort(pattern, values)
			local new = {}
			pattern = pattern:lower()

			if pattern == "" then
				return values
			end

			for i, value in pairs(values) do
				if tostring(value):lower():find(pattern) then
					table.insert(new, value)
				end
			end

			return new
		end

		function utility:Pop(object, shrink)
			local clone = object:Clone()

			clone.AnchorPoint = Vector2.new(0.5, 0.5)
			clone.Size = clone.Size - UDim2.new(0, shrink, 0, shrink)
			clone.Position = UDim2.new(0.5, 0, 0.5, 0)

			clone.Parent = object
			clone:ClearAllChildren()

			object.ImageTransparency = 1
			utility:Tween(clone, {Size = object.Size}, 0.2)

			spawn(function()
				wait(0.2)

				object.ImageTransparency = 0
				clone:Destroy()
			end)

			return clone
		end

		function utility:InitializeKeybind()
			self.keybinds = {}
			self.ended = {}

			input.InputBegan:Connect(function(key)
				if self.keybinds[key.KeyCode] then
					for i, bind in pairs(self.keybinds[key.KeyCode]) do
						bind()
					end
				end
			end)

			input.InputEnded:Connect(function(key)
				if key.UserInputType == Enum.UserInputType.MouseButton1 then
					for i, callback in pairs(self.ended) do
						callback()
					end
				end
			end)
		end

		function utility:BindToKey(key, callback)

			self.keybinds[key] = self.keybinds[key] or {}

			table.insert(self.keybinds[key], callback)

			return {
				UnBind = function()
					for i, bind in pairs(self.keybinds[key]) do
						if bind == callback then
							table.remove(self.keybinds[key], i)
						end
					end
				end
			}
		end

		function utility:KeyPressed() -- yield until next key is pressed
			local key = input.InputBegan:Wait()

			while key.UserInputType ~= Enum.UserInputType.Keyboard	 do
				key = input.InputBegan:Wait()
			end

			wait() -- overlapping connection

			return key
		end

		function utility:DraggingEnabled(frame, parent)

			parent = parent or frame

			-- stolen from wally or kiriot, kek
			local dragging = false
			local dragInput, mousePos, framePos

			frame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					mousePos = input.Position
					framePos = parent.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			frame.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					dragInput = input
				end
			end)

			input.InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					local delta = input.Position - mousePos
					parent.Position  = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
				end
			end)

		end

		function utility:DraggingEnded(callback)
			table.insert(self.ended, callback)
		end

		local mouse = game.Players.LocalPlayer:GetMouse()

		local DRAGGER_SIZE = 20
		local DRAGGER_TRANSPARENCY = .5

		local dragging = false


		function utility:makeResizable(obj:GuiObject, minSize)

			local resizer = Instance.new("Frame")
			resizer.AnchorPoint = Vector2.new(1, 1)
			resizer.Position = UDim2.new(1, -3, 1, -3)
			resizer.Size = UDim2.new(0, 30, 0, 30)
			resizer.BackgroundTransparency = 1
			resizer.ClipsDescendants = true

			local dragger = Instance.new("ImageButton", resizer)
			dragger.BackgroundColor3 = Color3.new(0, 0, 0)
			dragger.Image = "rbxassetid://10756675188"
			dragger.ImageTransparency = 0
			dragger.BackgroundTransparency = .5
			dragger.Size = UDim2.new(1, 0, 1, 0)
			dragger.ZIndex = 5

			local Corner = Instance.new("UICorner", dragger)
			Corner.CornerRadius = UDim.new(0, 8)

			resizer.Size = UDim2.fromOffset(DRAGGER_SIZE, DRAGGER_SIZE)
			--resizer.Position = UDim2.new(1, -DRAGGER_SIZE, 1, -DRAGGER_SIZE)

			local duic = dragger.UICorner
			minSize = minSize or Vector2.new(160, 90)

			local startDrag, startSize
			local gui = obj:FindFirstAncestorWhichIsA("ScreenGui")
			resizer.Parent = obj

			local function finishResize(tr)
				dragger.Position = UDim2.new(0,0,0,0)
				dragger.Size = UDim2.new(1,0,1,0)
				dragger.Parent = resizer
				dragger.BackgroundTransparency = tr
				dragger.ImageTransparency = 0
				duic.Parent = dragger
				startDrag = nil
			end
			dragger.MouseButton1Down:Connect(function()
				if not startDrag then
					startSize = obj.AbsoluteSize			
					startDrag = Vector2.new(mouse.X, mouse.Y)
					dragger.BackgroundTransparency = 1
					dragger.ImageTransparency = 1
					dragger.Size = UDim2.fromOffset(gui.AbsoluteSize.X, gui.AbsoluteSize.Y)
					dragger.Position = UDim2.new(0,0,0,0)
					duic.Parent = nil
					dragger.Parent = gui
				end
			end)	
			dragger.MouseMoved:Connect(function()
				if startDrag then		
					local m = Vector2.new(mouse.X, mouse.Y)
					local mouseMoved = Vector2.new(m.X - startDrag.X, m.Y - startDrag.Y)

					local s = startSize + mouseMoved
					local sx = math.max(minSize.X, s.X) 
					local sy = math.max(minSize.Y, s.Y)

					obj.Size = UDim2.fromOffset(sx, sy)

				end
			end)
			dragger.MouseEnter:Connect(function()
				finishResize(DRAGGER_TRANSPARENCY)				
			end)
			dragger.MouseLeave:Connect(function()
				finishResize(.5)
			end)		
			dragger.MouseButton1Up:Connect(function()
				finishResize(DRAGGER_TRANSPARENCY)
			end)	
		end

	end

	-- classes

	local library = {} -- main
	local page = {}
	local section = {}

	do
		library.__index = library
		page.__index = page
		section.__index = section

		-- new classes

		function library.new(title)
			local container = utility:Create("ScreenGui", {
				Name = title,
				Parent = game.CoreGui
			}, {
				utility:Create("ImageLabel", {
					Name = "Main",
					BackgroundTransparency = 1,
					Position = UDim2.new(0.05, 0, 0.5, 0),
					Size = UDim2.new(0, 500, 0, 350),
					Image = "rbxassetid://4641149554",
					ImageColor3 = themes.Background,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(4, 4, 296, 296)
				}, {
					utility:Create("ImageLabel", {
						Name = "Glow",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, -15, 0, -15),
						Size = UDim2.new(1, 30, 1, 30),
						ZIndex = 0,
						Image = "rbxassetid://5028857084",
						ImageColor3 = themes.Glow,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(24, 24, 276, 276)
					}),
					utility:Create("ImageLabel", {
						Name = "Pages",
						BackgroundTransparency = 1,
						ClipsDescendants = true,
						Position = UDim2.new(0, 0, 0, 38),
						Size = UDim2.new(0, 126, 1, -38),
						ZIndex = 3,
						Image = "rbxassetid://5012534273",
						ImageColor3 = themes.DarkContrast,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(4, 4, 296, 296)
					},
					{
						utility:Create("Frame", {
							Name = "sadsad",
							Parent = library.pagesContainer,
							BackgroundTransparency = 0,
							BackgroundColor3 = themes.LightContrast,
							BorderSizePixel = 0,
							AnchorPoint = Vector2.new(0.5,0),
							Position = UDim2.new(0.5, 0, 0, 65),
							Size = UDim2.new(0,60,0,2),
							ZIndex = 5,

						}),
						utility:Create("ImageLabel", {
							Name = "HubLogo",
							Parent = library.pagesContainer,
							BackgroundTransparency = 1,
							AnchorPoint = Vector2.new(0.5,0),
							Position = UDim2.new(0.5, 0, 0, 5),
							Size = UDim2.new(0,70,0,70),
							ZIndex = 5,
							ImageColor3 = Color3.new(1,1,1),
							Image = "rbxassetid://10574963725",

						}),


						utility:Create("ScrollingFrame", {
							Name = "Pages_Container",
							Active = true,
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 0, 0, 80),
							Size = UDim2.new(1, 0, 1, -20),
							CanvasSize = UDim2.new(0, 0, 0, 20),
							AutomaticCanvasSize = Enum.AutomaticSize.Y,
							ScrollBarThickness = 5,
							ScrollBarImageTransparency = 0,
							ScrollBarImageColor3 = themes.LightContrast
						}, {
							utility:Create("UIListLayout", {
								SortOrder = Enum.SortOrder.LayoutOrder,
								Padding = UDim.new(0, 10)
							})
						})
					}

					),
					utility:Create("ImageLabel", {
						Name = "TopBar",
						BackgroundTransparency = 1,
						ClipsDescendants = true,
						Size = UDim2.new(1, 0, 0, 38),
						ZIndex = 5,
						Image = "rbxassetid://4595286933",
						ImageColor3 = themes.TopBarColor,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(4, 4, 296, 296)
					}, {
						utility:Create("TextLabel", { -- title
							Name = "Title",
							AnchorPoint = Vector2.new(0, 0.5),
							BackgroundTransparency = 1,
							Position = UDim2.new(0, 12, 0, 19),
							Size = UDim2.new(1, -46, 0, 16),
							ZIndex = 5,
							Font = Enum.Font.GothamBold,
							Text = title,
							RichText = true , 
							TextColor3 = themes.TextColor,
							TextSize = 14,
							TextXAlignment = Enum.TextXAlignment.Center
						}),
					})
				})
			})


			utility:InitializeKeybind()
			utility:DraggingEnabled(container.Main.TopBar, container.Main)

			spawn(function()
				utility:makeResizable(container.Main, Vector2.new(444, 216))
			end)


			return setmetatable({
				container = container,
				pagesContainer = container.Main.Pages.Pages_Container,
				pages = {}
			}, library)
		end


		function page.new(library, title, icon)

			local button = utility:Create("TextButton", {
				Name = title,
				Parent = library.pagesContainer,
				BackgroundTransparency = 0.3,
				BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255),
				BorderSizePixel = 0,
				Size = UDim2.new(1, -6, 0, 26),
				ZIndex = 3,
				AutoButtonColor = false,
				Font = Enum.Font.Gotham,
				Text = "",
				TextSize = 14
			}, {
				utility:Create("TextLabel", {
					Name = "Title",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 36, 0.5, 0),
					Size = UDim2.new(0, 76, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextTransparency = 0.65,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("UICorner", {

				}),
				icon and utility:Create("ImageLabel", {
					Name = "Icon",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0.5, 0),
					Size = UDim2.new(0, 20, 0, 20),
					ZIndex = 3,
					Image = "rbxassetid://" .. tostring(icon),
					ImageColor3 = themes.TextColor,
					ImageTransparency = 0.64,
					ScaleType = Enum.ScaleType.Fit
				}) or {}
			})

			local container = utility:Create("ScrollingFrame", {
				Name = title,
				Parent = library.container.Main,
				Active = true,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0, 134, 0, 46),
				Size = UDim2.new(1, -142, 1, -56),
				CanvasSize = UDim2.new(0, 0, 0, 0),
				ScrollBarThickness = 3,
				ScrollBarImageColor3 = themes.DarkContrast,
				Visible = false
			})
			local uilist =  utility:Create("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 10),
				Parent = container, 
			})
        --[[

        uilist:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
            container.CanvasSize = UDim2.new(0, 0, 0, uilist.AbsoluteContentSize.Y + 10)
        end) 
        ]]

			return setmetatable({
				library = library,
				container = container,
				button = button,
				sections = {}
			}, page)
		end

		function section.new(page, title)
			local container = utility:Create("ImageLabel", {
				Name = title,
				Parent = page.container,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, -10, 0, 28),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.LightContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(4, 4, 296, 296),
				ClipsDescendants = true
			}, {
				utility:Create("Frame", {
					Name = "Container",
					Active = true,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 8, 0, 8),
					Size = UDim2.new(1, -16, 1, -16)
				}, {
					utility:Create("TextLabel", {
						Name = "Title",
						BackgroundTransparency = 1,
						Size = UDim2.new(1, 0, 0, 20),
						ZIndex = 2,
						Font = Enum.Font.Gotham,
						Text =  title,
						TextColor3 = themes.Accent,
						TextSize = 14,
						TextXAlignment = Enum.TextXAlignment.Center,
						TextTransparency = 1
					}),
					utility:Create("UIListLayout", {
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 4)
					})
				})
			})


			return setmetatable({
				page = page,
				container = container.Container,
				colorpickers = {},
				modules = {},
				binds = {},
				lists = {},
			}, section)
		end

		function library:addPage(...)

			local page = page.new(self, ...)
			local button = page.button

			table.insert(self.pages, page)

			button.MouseButton1Click:Connect(function()
				self:SelectPage(page, true)
			end)

			return page
		end

		function page:addSection(...)
			local section = section.new(self, ...)

			table.insert(self.sections, section)

			return section
		end

		-- functions

		function library:setTheme(theme, color3)
			themes[theme] = color3

			for property, objects in pairs(objects[theme]) do
				for i, object in pairs(objects) do
					if not object.Parent or (object.Name == "Button" and object.Parent.Name == "ColorPicker") then
						objects[i] = nil -- i can do this because weak tables :D
					else
						object[property] = color3
					end
				end
			end
		end
		local SavedSize
		function library:toggle()

			if self.toggling then
				return
			end

			self.toggling = true

			local container = self.container.Main
			local topbar = container.TopBar

			if self.position then
				utility:Tween(container, {
					Size = SavedSize,
					Position = self.position
				}, 0.2)
				wait(0.2)

				utility:Tween(topbar, {Size = UDim2.new(1, 0, 0, 38)}, 0.2)
				wait(0.2)

				container.ClipsDescendants = false
				self.position = nil
			else
				self.position = container.Position
				container.ClipsDescendants = true


				SavedSize = container.Size

				utility:Tween(topbar, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)
				wait(0.2)

				utility:Tween(container, {
					Size = UDim2.new(0, SavedSize.X.Offset, 0, 0),
					Position = self.position + UDim2.new(0, 0, 0, SavedSize.Y.Offset)
				}, 0.2)
				wait(0.2)
			end

			self.toggling = false
		end

		-- new modules

		function library:Notify(title, text, callback)

			-- overwrite last notification
			if self.activeNotification then
				self.activeNotification = self.activeNotification()
			end

			-- standard create
			local notification = utility:Create("ImageLabel", {
				Name = "Notification",
				Parent = self.container,
				BackgroundTransparency = 1,
				Size = UDim2.new(0, 200, 0, 60),
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.Background,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(4, 4, 296, 296),
				ZIndex = 3,
				ClipsDescendants = true
			}, {
				utility:Create("ImageLabel", {
					Name = "Flash",
					Size = UDim2.new(1, 0, 1, 0),
					BackgroundTransparency = 1,
					Image = "rbxassetid://4641149554",
					ImageColor3 = themes.TextColor,
					ZIndex = 5
				}),
				utility:Create("ImageLabel", {
					Name = "Glow",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, -15, 0, -15),
					Size = UDim2.new(1, 30, 1, 30),
					ZIndex = 2,
					Image = "rbxassetid://5028857084",
					ImageColor3 = themes.Glow,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(24, 24, 276, 276)
				}),
				utility:Create("TextLabel", {
					Name = "Title",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 8),
					Size = UDim2.new(1, -40, 0, 16),
					ZIndex = 4,
					Font = Enum.Font.GothamSemibold,
					TextColor3 = themes.TextColor,
					TextSize = 14.000,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("TextLabel", {
					Name = "Text",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 1, -24),
					Size = UDim2.new(1, -40, 0, 16),
					ZIndex = 4,
					Font = Enum.Font.Gotham,
					TextColor3 = themes.TextColor,
					TextSize = 12.000,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("ImageButton", {
					Name = "Accept",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -26, 0, 8),
					Size = UDim2.new(0, 16, 0, 16),
					Image = "rbxassetid://5012538259",
					ImageColor3 = themes.TextColor,
					ZIndex = 4
				}),
				utility:Create("ImageButton", {
					Name = "Decline",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -26, 1, -24),
					Size = UDim2.new(0, 16, 0, 16),
					Image = "rbxassetid://5012538583",
					ImageColor3 = themes.TextColor,
					ZIndex = 4
				})
			})

			-- dragging
			utility:DraggingEnabled(notification)

			-- position and size
			title = title or "Notification"
			text = text or ""

			notification.Title.Text = title
			notification.Text.Text = text

			local padding = 10
			local textSize = game:GetService("TextService"):GetTextSize(text, 12, Enum.Font.Gotham, Vector2.new(math.huge, 16))

			notification.Position = library.lastNotification or UDim2.new(0, padding, 1, -(notification.AbsoluteSize.Y + padding))
			notification.Size = UDim2.new(0, 0, 0, 60)

			utility:Tween(notification, {Size = UDim2.new(0, textSize.X + 70, 0, 60)}, 0.2)
			wait(0.2)

			notification.ClipsDescendants = false
			utility:Tween(notification.Flash, {
				Size = UDim2.new(0, 0, 0, 60),
				Position = UDim2.new(1, 0, 0, 0)
			}, 0.2)

			-- callbacks
			local active = true
			local close = function()

				if not active then
					return
				end

				active = false
				notification.ClipsDescendants = true

				library.lastNotification = notification.Position
				notification.Flash.Position = UDim2.new(0, 0, 0, 0)
				utility:Tween(notification.Flash, {Size = UDim2.new(1, 0, 1, 0)}, 0.2)

				wait(0.2)
				utility:Tween(notification, {
					Size = UDim2.new(0, 0, 0, 60),
					Position = notification.Position + UDim2.new(0, textSize.X + 70, 0, 0)
				}, 0.2)

				wait(0.2)
				notification:Destroy()
			end

			self.activeNotification = close

			notification.Accept.MouseButton1Click:Connect(function()

				if not active then
					return
				end

				if callback then
					callback(true)
				end

				close()
			end)

			notification.Decline.MouseButton1Click:Connect(function()

				if not active then
					return
				end

				if callback then
					callback(false)
				end

				close()
			end)
		end

		function section:addButton(title, callback)
			local button = utility:Create("ImageButton", {
				Name = "Button",
				Parent = self.container,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 30),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.ButtonColor,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("TextLabel", {
					Name = "Title",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextTransparency = 0.10000000149012
				})
			})

			table.insert(self.modules, button)
			--self:Resize()

			local text = button.Title
			local debounce

			button.MouseButton1Click:Connect(function()



				if debounce then
					return
				end

				-- animation
				utility:Pop(button, 15)

				debounce = true
				text.TextSize = 0
				utility:Tween(button.Title, {TextSize = 13}, 0.2)

				wait(0.2)
				utility:Tween(button.Title, {TextSize = 12}, 0.2)

				spawn(function()
					if callback then
						callback(function(...)
							self:updateButton(button, ...)
						end)
					end
				end)


				debounce = false
			end)
			local buttonfunc = {}
			function buttonfunc:SetText()

			end 

			return buttonfunc,button
		end

		function section:addText(title)
			local button = utility:Create("ImageButton", {
				Name = "Button",
				Parent = self.container,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 30),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.ButtonColor,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("TextLabel", {
					Name = "Title",
					BackgroundTransparency = 1,
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = title,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextTransparency = 0.10000000149012
				})
			})

			table.insert(self.modules, button)
			self:Resize()

			local text = button.Title
			local debounce

			--button.MouseButton1Click:Connect(function()



			--	if debounce then
			--		return
			--	end

			--	-- animation
			--	utility:Pop(button, 15)

			--	debounce = true
			--	text.TextSize = 0
			--	utility:Tween(button.Title, {TextSize = 13}, 0.2)

			--	wait(0.2)
			--	utility:Tween(button.Title, {TextSize = 12}, 0.2)

			--	spawn(function()
			--		if callback then
			--			callback(function(...)
			--				self:updateButton(button, ...)
			--			end)
			--		end
			--	end)


			--	debounce = false
			--end)
			local buttonfunc = {}
			function buttonfunc:SetText()

			end 

			return buttonfunc,button
		end

		function section:addToggle(title, default, callback)
			local sec = self 

			-- local title = t or "Toggle"
			-- local default = typeof(d) == 'bool' and d or false
			-- local callback = typeof(d) == 'function' and d or typeof(c) == 'function' and c or function() end

			local toggle = utility:Create("ImageButton", {
				Name = "Toggle",
				Parent = self.container,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 30),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.DarkContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			},{
				utility:Create("TextLabel", {
					Name = "Title",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0.5, 1),
					Size = UDim2.new(0.5, 0, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextTransparency = 0.10000000149012,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("ImageLabel", {
					Name = "Button",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(1, -50, 0.5, -8),
					Size = UDim2.new(0, 40, 0, 16),
					ZIndex = 2,
					Image = "rbxassetid://5028857472",
					ImageColor3 = themes.NotToggledColor,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("ImageLabel", {
						Name = "Frame",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 2, 0.5, -6),
						Size = UDim2.new(1, -22, 1, -4),
						ZIndex = 2,
						Image = "rbxassetid://5028857472",
						ImageColor3 = themes.TextColor,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(2, 2, 298, 298)
					})
				})
			})

			table.insert(self.modules, toggle)
			--self:Resize()

			local active = default
			self:updateToggle(toggle, nil, active)

			toggle.MouseButton1Click:Connect(function()
				active = not active
				self:updateToggle(toggle, nil, active)

				if callback then
					callback(active, function(...)
						self:updateToggle(toggle, ...)
					end)
				end
			end)
			local togglefunc = {}
			function togglefunc:Set(bool)
				active =  bool
				sec:updateToggle(toggle,nil,active)
				if callback then
					callback(active, function(...)
						sec:updateToggle(toggle, ...)
					end)
				end

			end 



			return togglefunc,toggle
		end

		function section:addTextbox(title, default, callback)
			local textbox = utility:Create("ImageButton", {
				Name = "Textbox",
				Parent = self.container,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 30),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.DarkContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("TextLabel", {
					Name = "Title",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0.5, 1),
					Size = UDim2.new(0.5, 0, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextTransparency = 0.10000000149012,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("ImageLabel", {
					Name = "Button",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -110, 0.5, -8),
					Size = UDim2.new(0, 100, 0, 16),
					ZIndex = 2,
					Image = "rbxassetid://5028857472",
					ImageColor3 = themes.LightContrast,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("TextBox", {
						Name = "Textbox",
						BackgroundTransparency = 1,
						TextTruncate = Enum.TextTruncate.AtEnd,
						Position = UDim2.new(0, 5, 0, 0),
						Size = UDim2.new(1, -10, 1, 0),
						ClearTextOnFocus = false,
						ZIndex = 3,
						Font = Enum.Font.GothamSemibold,
						Text = default or "",
						TextColor3 = themes.TextColor,
						TextSize = 11
					})
				})
			})

			table.insert(self.modules, textbox)
			--self:Resize()

			local button = textbox.Button
			local input = button.Textbox

			textbox.MouseButton1Click:Connect(function()

				if textbox.Button.Size ~= UDim2.new(0, 100, 0, 16) then
					return
				end

				utility:Tween(textbox.Button, {
					Size = UDim2.new(0, 200, 0, 16),
					Position = UDim2.new(1, -210, 0.5, -8)
				}, 0.2)

				wait()

				input.TextXAlignment = Enum.TextXAlignment.Left
				input:CaptureFocus()
			end)

			input:GetPropertyChangedSignal("Text"):Connect(function()

				if button.ImageTransparency == 0 and (button.Size == UDim2.new(0, 200, 0, 16) or button.Size == UDim2.new(0, 100, 0, 16)) then -- i know, i dont like this either
					utility:Pop(button, 10)
				end

				if callback then
					callback(input.Text, nil, function(...)
						self:updateTextbox(textbox, ...)
					end)
				end
			end)

			input.FocusLost:Connect(function()

				input.TextXAlignment = Enum.TextXAlignment.Center

				utility:Tween(textbox.Button, {
					Size = UDim2.new(0, 100, 0, 16),
					Position = UDim2.new(1, -110, 0.5, -8)
				}, 0.2)

				if callback then
					callback(input.Text, true, function(...)
						self:updateTextbox(textbox, ...)
					end)
				end
			end)

			return textbox
		end

		function section:addKeybind(title, default, callback, changedCallback)
			local keybind = utility:Create("ImageButton", {
				Name = "Keybind",
				Parent = self.container,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 30),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.DarkContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("TextLabel", {
					Name = "Title",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0.5, 1),
					Size = UDim2.new(1, 0, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextTransparency = 0.10000000149012,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("ImageLabel", {
					Name = "Button",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -110, 0.5, -8),
					Size = UDim2.new(0, 100, 0, 16),
					ZIndex = 2,
					Image = "rbxassetid://5028857472",
					ImageColor3 = themes.LightContrast,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("TextLabel", {
						Name = "Text",
						BackgroundTransparency = 1,
						ClipsDescendants = true,
						Size = UDim2.new(1, 0, 1, 0),
						ZIndex = 3,
						Font = Enum.Font.GothamSemibold,
						Text = default and default.Name or "None",
						TextColor3 = themes.TextColor,
						TextSize = 11
					})
				})
			})

			table.insert(self.modules, keybind)
			--self:Resize()

			local text = keybind.Button.Text
			local button = keybind.Button

			local animate = function()
				if button.ImageTransparency == 0 then
					utility:Pop(button, 10)
				end
			end

			self.binds[keybind] = {callback = function()
				if not game:GetService("UserInputService"):GetFocusedTextBox() and alive then
					animate()

					if callback then
						callback(function(...)
							self:updateKeybind(keybind, ...)
						end)
					end
				end
			end}

			if default and callback then
				self:updateKeybind(keybind, nil, default)
			end

			keybind.MouseButton1Click:Connect(function()

				animate()

				if self.binds[keybind].connection then -- unbind
					return self:updateKeybind(keybind)
				end

				if text.Text == "None" then -- new bind
					text.Text = "..."

					local key = utility:KeyPressed()

					self:updateKeybind(keybind, nil, key.KeyCode)
					animate()

					if changedCallback then
						changedCallback(key, function(...)
							self:updateKeybind(keybind, ...)
						end)
					end
				end
			end)

			return keybind
		end

		function section:addColorPicker(title, default, callback)
			local colorpicker = utility:Create("ImageButton", {
				Name = "ColorPicker",
				Parent = self.container,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Size = UDim2.new(1, 0, 0, 30),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.DarkContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			},{
				utility:Create("TextLabel", {
					Name = "Title",
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0.5, 1),
					Size = UDim2.new(0.5, 0, 1, 0),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextTransparency = 0.10000000149012,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("ImageButton", {
					Name = "Button",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(1, -50, 0.5, -7),
					Size = UDim2.new(0, 40, 0, 14),
					ZIndex = 2,
					Image = "rbxassetid://5028857472",
					ImageColor3 = Color3.fromRGB(255, 255, 255),
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				})
			})

			local tab = utility:Create("ImageLabel", {
				Name = "ColorPicker",
				Parent = self.page.library.container,
				BackgroundTransparency = 1,
				Position = UDim2.new(0.75, 0, 0.400000006, 0),
				Selectable = true,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Size = UDim2.new(0, 162, 0, 169),
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.Background,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298),
				Visible = false,
			}, {
				utility:Create("ImageLabel", {
					Name = "Glow",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, -15, 0, -15),
					Size = UDim2.new(1, 30, 1, 30),
					ZIndex = 0,
					Image = "rbxassetid://5028857084",
					ImageColor3 = themes.Glow,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(22, 22, 278, 278)
				}),
				utility:Create("TextLabel", {
					Name = "Title",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 8),
					Size = UDim2.new(1, -40, 0, 16),
					ZIndex = 2,
					Font = Enum.Font.GothamSemibold,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 14,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("ImageButton", {
					Name = "Close",
					BackgroundTransparency = 1,
					Position = UDim2.new(1, -26, 0, 8),
					Size = UDim2.new(0, 16, 0, 16),
					ZIndex = 2,
					Image = "rbxassetid://5012538583",
					ImageColor3 = themes.TextColor
				}),
				utility:Create("Frame", {
					Name = "Container",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 8, 0, 32),
					Size = UDim2.new(1, -18, 1, -40)
				}, {
					utility:Create("UIListLayout", {
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 6)
					}),
					utility:Create("ImageButton", {
						Name = "Canvas",
						BackgroundTransparency = 1,
						BorderColor3 = themes.LightContrast,
						Size = UDim2.new(1, 0, 0, 60),
						AutoButtonColor = false,
						Image = "rbxassetid://5108535320",
						ImageColor3 = Color3.fromRGB(255, 0, 0),
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(2, 2, 298, 298)
					}, {
						utility:Create("ImageLabel", {
							Name = "White_Overlay",
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 60),
							Image = "rbxassetid://5107152351",
							SliceCenter = Rect.new(2, 2, 298, 298)
						}),
						utility:Create("ImageLabel", {
							Name = "Black_Overlay",
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 0, 60),
							Image = "rbxassetid://5107152095",
							SliceCenter = Rect.new(2, 2, 298, 298)
						}),
						utility:Create("ImageLabel", {
							Name = "Cursor",
							BackgroundColor3 = themes.TextColor,
							AnchorPoint = Vector2.new(0.5, 0.5),
							BackgroundTransparency = 1.000,
							Size = UDim2.new(0, 10, 0, 10),
							Position = UDim2.new(0, 0, 0, 0),
							Image = "rbxassetid://5100115962",
							SliceCenter = Rect.new(2, 2, 298, 298)
						})
					}),
					utility:Create("ImageButton", {
						Name = "Color",
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0, 0, 0, 4),
						Selectable = false,
						Size = UDim2.new(1, 0, 0, 16),
						ZIndex = 2,
						AutoButtonColor = false,
						Image = "rbxassetid://5028857472",
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(2, 2, 298, 298)
					}, {
						utility:Create("Frame", {
							Name = "Select",
							BackgroundColor3 = themes.TextColor,
							BorderSizePixel = 1,
							Position = UDim2.new(1, 0, 0, 0),
							Size = UDim2.new(0, 2, 1, 0),
							ZIndex = 2
						}),
						utility:Create("UIGradient", { -- rainbow canvas
							Color = ColorSequence.new({
								ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 0)),
								ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
								ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
								ColorSequenceKeypoint.new(0.50, Color3.fromRGB(0, 255, 255)),
								ColorSequenceKeypoint.new(0.66, Color3.fromRGB(0, 0, 255)),
								ColorSequenceKeypoint.new(0.82, Color3.fromRGB(255, 0, 255)),
								ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 0))
							})
						})
					}),
					utility:Create("Frame", {
						Name = "Inputs",
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 10, 0, 158),
						Size = UDim2.new(1, 0, 0, 16)
					}, {
						utility:Create("UIListLayout", {
							FillDirection = Enum.FillDirection.Horizontal,
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, 6)
						}),
						utility:Create("ImageLabel", {
							Name = "R",
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(0.305, 0, 1, 0),
							ZIndex = 2,
							Image = "rbxassetid://5028857472",
							ImageColor3 = themes.DarkContrast,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(2, 2, 298, 298)
						}, {
							utility:Create("TextLabel", {
								Name = "Text",
								BackgroundTransparency = 1,
								Size = UDim2.new(0.400000006, 0, 1, 0),
								ZIndex = 2,
								Font = Enum.Font.Gotham,
								Text = "R:",
								TextColor3 = themes.TextColor,
								TextSize = 10.000
							}),
							utility:Create("TextBox", {
								Name = "Textbox",
								BackgroundTransparency = 1,
								Position = UDim2.new(0.300000012, 0, 0, 0),
								Size = UDim2.new(0.600000024, 0, 1, 0),
								ZIndex = 2,
								Font = Enum.Font.Gotham,
								PlaceholderColor3 = themes.DarkContrast,
								Text = "255",
								TextColor3 = themes.TextColor,
								TextSize = 10.000
							})
						}),
						utility:Create("ImageLabel", {
							Name = "G",
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(0.305, 0, 1, 0),
							ZIndex = 2,
							Image = "rbxassetid://5028857472",
							ImageColor3 = themes.DarkContrast,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(2, 2, 298, 298)
						}, {
							utility:Create("TextLabel", {
								Name = "Text",
								BackgroundTransparency = 1,
								ZIndex = 2,
								Size = UDim2.new(0.400000006, 0, 1, 0),
								Font = Enum.Font.Gotham,
								Text = "G:",
								TextColor3 = themes.TextColor,
								TextSize = 10.000
							}),
							utility:Create("TextBox", {
								Name = "Textbox",
								BackgroundTransparency = 1,
								Position = UDim2.new(0.300000012, 0, 0, 0),
								Size = UDim2.new(0.600000024, 0, 1, 0),
								ZIndex = 2,
								Font = Enum.Font.Gotham,
								Text = "255",
								TextColor3 = themes.TextColor,
								TextSize = 10.000
							})
						}),
						utility:Create("ImageLabel", {
							Name = "B",
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							Size = UDim2.new(0.305, 0, 1, 0),
							ZIndex = 2,
							Image = "rbxassetid://5028857472",
							ImageColor3 = themes.DarkContrast,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(2, 2, 298, 298)
						}, {
							utility:Create("TextLabel", {
								Name = "Text",
								BackgroundTransparency = 1,
								Size = UDim2.new(0.400000006, 0, 1, 0),
								ZIndex = 2,
								Font = Enum.Font.Gotham,
								Text = "B:",
								TextColor3 = themes.TextColor,
								TextSize = 10.000
							}),
							utility:Create("TextBox", {
								Name = "Textbox",
								BackgroundTransparency = 1,
								Position = UDim2.new(0.300000012, 0, 0, 0),
								Size = UDim2.new(0.600000024, 0, 1, 0),
								ZIndex = 2,
								Font = Enum.Font.Gotham,
								Text = "255",
								TextColor3 = themes.TextColor,
								TextSize = 10.000
							})
						}),
					}),
					utility:Create("ImageButton", {
						Name = "Button",
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Size = UDim2.new(1, 0, 0, 20),
						ZIndex = 2,
						Image = "rbxassetid://5028857472",
						ImageColor3 = themes.DarkContrast,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(2, 2, 298, 298)
					}, {
						utility:Create("TextLabel", {
							Name = "Text",
							BackgroundTransparency = 1,
							Size = UDim2.new(1, 0, 1, 0),
							ZIndex = 3,
							Font = Enum.Font.Gotham,
							Text = "Submit",
							TextColor3 = themes.TextColor,
							TextSize = 11.000
						})
					})
				})
			})

			utility:DraggingEnabled(tab)
			table.insert(self.modules, colorpicker)
			--self:Resize()

			local allowed = {
				[""] = true
			}

			local canvas = tab.Container.Canvas
			local color = tab.Container.Color

			local canvasSize, canvasPosition = canvas.AbsoluteSize, canvas.AbsolutePosition
			local colorSize, colorPosition = color.AbsoluteSize, color.AbsolutePosition

			local draggingColor, draggingCanvas

			local color3 = default or Color3.fromRGB(255, 255, 255)
			local hue, sat, brightness = 0, 0, 1
			local rgb = {
				r = 255,
				g = 255,
				b = 255
			}

			self.colorpickers[colorpicker] = {
				tab = tab,
				callback = function(prop, value)
					rgb[prop] = value
					hue, sat, brightness = Color3.toHSV(Color3.fromRGB(rgb.r, rgb.g, rgb.b))
				end
			}

			local callback = function(value)
				if callback then
					callback(value, function(...)
						self:updateColorPicker(colorpicker, ...)
					end)
				end
			end

			utility:DraggingEnded(function()
				draggingColor, draggingCanvas = false, false
			end)

			if default then
				self:updateColorPicker(colorpicker, nil, default)

				hue, sat, brightness = Color3.toHSV(default)
				default = Color3.fromHSV(hue, sat, brightness)

				for i, prop in pairs({"r", "g", "b"}) do
					rgb[prop] = default[prop:upper()] * 255
				end
			end

			for i, container in pairs(tab.Container.Inputs:GetChildren()) do -- i know what you are about to say, so shut up
				if container:IsA("ImageLabel") then
					local textbox = container.Textbox
					local focused

					textbox.Focused:Connect(function()
						focused = true
					end)

					textbox.FocusLost:Connect(function()
						focused = false

						if not tonumber(textbox.Text) then
							textbox.Text = math.floor(rgb[container.Name:lower()])
						end
					end)

					textbox:GetPropertyChangedSignal("Text"):Connect(function()
						local text = textbox.Text

						if not allowed[text] and not tonumber(text) then
							textbox.Text = text:sub(1, #text - 1)
						elseif focused and not allowed[text] then
							rgb[container.Name:lower()] = math.clamp(tonumber(textbox.Text), 0, 255)

							local color3 = Color3.fromRGB(rgb.r, rgb.g, rgb.b)
							hue, sat, brightness = Color3.toHSV(color3)

							self:updateColorPicker(colorpicker, nil, color3)
							callback(color3)
						end
					end)
				end
			end

			canvas.MouseButton1Down:Connect(function()
				draggingCanvas = true

				while draggingCanvas do

					local x, y = mouse.X, mouse.Y

					sat = math.clamp((x - canvasPosition.X) / canvasSize.X, 0, 1)
					brightness = 1 - math.clamp((y - canvasPosition.Y) / canvasSize.Y, 0, 1)

					color3 = Color3.fromHSV(hue, sat, brightness)

					for i, prop in pairs({"r", "g", "b"}) do
						rgb[prop] = color3[prop:upper()] * 255
					end

					self:updateColorPicker(colorpicker, nil, {hue, sat, brightness}) -- roblox is literally retarded
					utility:Tween(canvas.Cursor, {Position = UDim2.new(sat, 0, 1 - brightness, 0)}, 0.1) -- overwrite

					callback(color3)
					utility:Wait()
				end
			end)

			color.MouseButton1Down:Connect(function()
				draggingColor = true

				while draggingColor do

					hue = 1 - math.clamp(1 - ((mouse.X - colorPosition.X) / colorSize.X), 0, 1)
					color3 = Color3.fromHSV(hue, sat, brightness)

					for i, prop in pairs({"r", "g", "b"}) do
						rgb[prop] = color3[prop:upper()] * 255
					end

					local x = hue -- hue is updated
					self:updateColorPicker(colorpicker, nil, {hue, sat, brightness}) -- roblox is literally retarded
					utility:Tween(tab.Container.Color.Select, {Position = UDim2.new(x, 0, 0, 0)}, 0.1) -- overwrite

					callback(color3)
					utility:Wait()
				end
			end)

			-- click events
			local button = colorpicker.Button
			local toggle, debounce, animate

			lastColor = Color3.fromHSV(hue, sat, brightness)
			animate = function(visible, overwrite)

				if overwrite then

					if not toggle then
						return
					end

					if debounce then
						while debounce do
							utility:Wait()
						end
					end
				elseif not overwrite then
					if debounce then
						return
					end

					if button.ImageTransparency == 0 then
						utility:Pop(button, 10)
					end
				end

				toggle = visible
				debounce = true

				if visible then

					if self.page.library.activePicker and self.page.library.activePicker ~= animate then
						self.page.library.activePicker(nil, true)
					end

					self.page.library.activePicker = animate
					lastColor = Color3.fromHSV(hue, sat, brightness)

					local x1, x2 = button.AbsoluteSize.X / 2, 162--tab.AbsoluteSize.X
					local px, py = button.AbsolutePosition.X, button.AbsolutePosition.Y

					tab.ClipsDescendants = true
					tab.Visible = true
					tab.Size = UDim2.new(0, 0, 0, 0)

					tab.Position = UDim2.new(0, x1 + x2 + px, 0, py)
					utility:Tween(tab, {Size = UDim2.new(0, 162, 0, 169)}, 0.2)

					-- update size and position
					wait(0.2)
					tab.ClipsDescendants = false

					canvasSize, canvasPosition = canvas.AbsoluteSize, canvas.AbsolutePosition
					colorSize, colorPosition = color.AbsoluteSize, color.AbsolutePosition
				else
					utility:Tween(tab, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
					tab.ClipsDescendants = true

					wait(0.2)
					tab.Visible = false
				end

				debounce = false
			end

			local toggleTab = function()
				animate(not toggle)
			end

			button.MouseButton1Click:Connect(toggleTab)
			colorpicker.MouseButton1Click:Connect(toggleTab)

			tab.Container.Button.MouseButton1Click:Connect(function()
				animate()
			end)

			tab.Close.MouseButton1Click:Connect(function()
				self:updateColorPicker(colorpicker, nil, lastColor)
				animate()
			end)

			return colorpicker
		end

		function section:addSlider(title, default, min, max, callback)
			local slider = utility:Create("ImageButton", {
				Name = "Slider",
				Parent = self.container,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Position = UDim2.new(0.292817682, 0, 0.299145311, 0),
				Size = UDim2.new(1, 0, 0, 50),
				ZIndex = 2,
				Image = "rbxassetid://5028857472",
				ImageColor3 = themes.DarkContrast,
				ScaleType = Enum.ScaleType.Slice,
				SliceCenter = Rect.new(2, 2, 298, 298)
			}, {
				utility:Create("TextLabel", {
					Name = "Title",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 6),
					Size = UDim2.new(0.5, 0, 0, 16),
					ZIndex = 3,
					Font = Enum.Font.Gotham,
					Text = title,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextTransparency = 0.10000000149012,
					TextXAlignment = Enum.TextXAlignment.Left
				}),
				utility:Create("TextBox", {
					Name = "TextBox",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Position = UDim2.new(1, -30, 0, 6),
					Size = UDim2.new(0, 20, 0, 16),
					ZIndex = 3,
					Font = Enum.Font.GothamSemibold,
					Text = default or min,
					TextColor3 = themes.TextColor,
					TextSize = 12,
					TextXAlignment = Enum.TextXAlignment.Right
				}),
				utility:Create("TextLabel", {
					Name = "Slider",
					BackgroundTransparency = 1,
					Position = UDim2.new(0, 10, 0, 28),
					Size = UDim2.new(1, -20, 0, 16),
					ZIndex = 3,
					Text = "",
				}, {
					utility:Create("ImageLabel", {
						Name = "Bar",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 0, 0.5, 0),
						Size = UDim2.new(1, 0, 0, 4),
						ZIndex = 3,
						Image = "rbxassetid://5028857472",
						ImageColor3 = themes.LightContrast,
						ScaleType = Enum.ScaleType.Slice,
						SliceCenter = Rect.new(2, 2, 298, 298)
					}, {
						utility:Create("ImageLabel", {
							Name = "Fill",
							BackgroundTransparency = 1,
							Size = UDim2.new(0.8, 0, 1, 0),
							ZIndex = 3,
							Image = "rbxassetid://5028857472",
							ImageColor3 = themes.TextColor,
							ScaleType = Enum.ScaleType.Slice,
							SliceCenter = Rect.new(2, 2, 298, 298)
						}, {
							utility:Create("ImageLabel", {
								Name = "Circle",
								AnchorPoint = Vector2.new(0.5, 0.5),
								BackgroundTransparency = 1,
								ImageTransparency = 1.000,
								ImageColor3 = themes.TextColor,
								Position = UDim2.new(1, 0, 0.5, 0),
								Size = UDim2.new(0, 10, 0, 10),
								ZIndex = 3,
								Image = "rbxassetid://4608020054"
							})
						})
					})
				})
			})

			table.insert(self.modules, slider)
			--self:Resize()

			local allowed = {
				[""] = true,
				["-"] = true
			}

			local textbox = slider.TextBox
			local circle = slider.Slider.Bar.Fill.Circle

			local value = default or min
			local dragging, last

			local callback = function(value)
				if callback then
					callback(value, function(...)
						self:updateSlider(slider, ...)
					end)
				end
			end

			self:updateSlider(slider, nil, value, min, max)

			utility:DraggingEnded(function()
				dragging = false
			end)

			slider.MouseButton1Down:Connect(function(input)
				dragging = true

				while dragging do
					utility:Tween(circle, {ImageTransparency = 0}, 0.1)

					value = self:updateSlider(slider, nil, nil, min, max, value)
					callback(value)

					utility:Wait()
				end

				wait(0.5)
				utility:Tween(circle, {ImageTransparency = 1}, 0.2)
			end)

			textbox.FocusLost:Connect(function()
				if not tonumber(textbox.Text) then
					value = self:updateSlider(slider, nil, default or min, min, max)
					callback(value)
				end
			end)

			textbox:GetPropertyChangedSignal("Text"):Connect(function()
				local text = textbox.Text

				if not allowed[text] and not tonumber(text) then
					textbox.Text = text:sub(1, #text - 1)
				elseif not allowed[text] then	
					value = self:updateSlider(slider, nil, tonumber(text) or value, min, max)
					callback(value)
				end
			end)

			return slider
		end

		function section:addDropdown(title, list, callback)
			local dropdown = utility:Create("Frame", {
				Name = "Dropdown",
				Parent = self.container,
				BackgroundTransparency = 1,
				Size = UDim2.new(1, 0, 0, 30),
				ClipsDescendants = true
			}, {
				utility:Create("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 4)
				}),
				utility:Create("ImageLabel", {
					Name = "Search",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 30),
					ZIndex = 2,
					Image = "rbxassetid://5028857472",
					ImageColor3 = themes.DarkContrast,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("TextBox", {
						Name = "TextBox",
						AnchorPoint = Vector2.new(0, 0.5),
						BackgroundTransparency = 1,
						TextTruncate = Enum.TextTruncate.AtEnd,
						Position = UDim2.new(0, 10, 0.5, 1),
						Size = UDim2.new(1, -42, 1, 0),
						ZIndex = 3,
						Font = Enum.Font.Gotham,
						Text = title,
						TextColor3 = themes.TextColor,
						TextSize = 12,
						TextTransparency = 0.10000000149012,
						TextXAlignment = Enum.TextXAlignment.Left
					}),
					utility:Create("ImageButton", {
						Name = "Button",
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(1, -28, 0.5, -9),
						Size = UDim2.new(0, 18, 0, 18),
						ZIndex = 3,
						Image = "rbxassetid://5012539403",
						ImageColor3 = themes.TextColor,
						SliceCenter = Rect.new(2, 2, 298, 298)
					})
				}),
				utility:Create("ImageLabel", {
					Name = "List",
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, -34),
					ZIndex = 2,
					Image = "rbxassetid://5028857472",
					ImageColor3 = themes.Background,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("ScrollingFrame", {
						Name = "Frame",
						Active = true,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Position = UDim2.new(0, 4, 0, 4),
						Size = UDim2.new(1, -8, 1, -8),
						CanvasPosition = Vector2.new(0, 28),
						CanvasSize = UDim2.new(0, 0, 0, 120),
						ZIndex = 2,
						ScrollBarThickness = 3,
						ScrollBarImageColor3 = themes.DarkContrast
					}, {
						utility:Create("UIListLayout", {
							SortOrder = Enum.SortOrder.LayoutOrder,
							Padding = UDim.new(0, 4)
						})
					})
				})
			})

			table.insert(self.modules, dropdown)
			--self:Resize()

			local search = dropdown.Search
			local focused

			list = list or {}

			search.Button.MouseButton1Click:Connect(function()
				if search.Button.Rotation == 0 then
					self:updateDropdown(dropdown, nil, list, callback)
				else
					self:updateDropdown(dropdown, nil, nil, callback)
				end
			end)

			search.TextBox.Focused:Connect(function()
				if search.Button.Rotation == 0 then
					self:updateDropdown(dropdown, nil, list, callback)
				end

				focused = true
			end)

			search.TextBox.FocusLost:Connect(function()
				focused = false
			end)

			search.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
				if focused then
					local list = utility:Sort(search.TextBox.Text, list)
					list = #list ~= 0 and list 

					self:updateDropdown(dropdown, nil, list, callback)
				end
			end)

			dropdown:GetPropertyChangedSignal("Size"):Connect(function()
				self:Resize()
			end)

			return dropdown
		end

		-- class functions


		function library:SelectPage(page, toggle)

			if toggle and self.focusedPage == page then -- already selected
				return
			end

			local button = page.button

			if toggle then
				-- page button
				--button.Title.TextTransparency = 0

				utility:Tween(button.Title, {TextTransparency = 0}, 0.5)
				button.Title.Font = Enum.Font.FredokaOne

				if button:FindFirstChild("Icon") then
					utility:Tween(button.Icon, {ImageTransparency = 0}, 0.5)
					--button.Icon.ImageTransparency = 0
				end

				-- update selected page
				local focusedPage = self.focusedPage
				self.focusedPage = page

				if focusedPage then
					self:SelectPage(focusedPage)
				end

				-- sections
				local existingSections = focusedPage and #focusedPage.sections or 0
				local sectionsRequired = #page.sections - existingSections

				page:Resize()

				for i, section in pairs(page.sections) do
					section.container.Parent.ImageTransparency = 0
				end

				if sectionsRequired < 0 then -- "hides" some sections
					for i = existingSections, #page.sections + 1, -1 do
						local section = focusedPage.sections[i].container.Parent

						utility:Tween(section, {ImageTransparency = 1}, 0.1)
					end
				end

				wait(0.1)
				page.container.Visible = true

				if focusedPage then
					focusedPage.container.Visible = false
				end

				if sectionsRequired > 0 then -- "creates" more section
					for i = existingSections + 1, #page.sections do
						local section = page.sections[i].container.Parent

						section.ImageTransparency = 1
						utility:Tween(section, {ImageTransparency = 0}, 0.05)
					end
				end

				wait(0.05)

				for i, section in pairs(page.sections) do

					utility:Tween(section.container.Title, {TextTransparency = 0}, 0.1)
					section:Resize(true)

					wait(0.05)
				end

				wait(0.05)
				page:Resize(true)
			else
				-- page button
				button.Title.Font = Enum.Font.Gotham
				--button.Title.TextTransparency = 0.65
				utility:Tween(button.Title, {TextTransparency = 0.65}, 0.5)

				if button:FindFirstChild("Icon") then
					--button.Icon.ImageTransparency = 0.65
					utility:Tween(button.Icon, {ImageTransparency = 0.65}, 0.5)
				end

				-- sections
				for i, section in pairs(page.sections) do
					utility:Tween(section.container.Parent, {Size = UDim2.new(1, -10, 0, 28)}, 0.1)
					utility:Tween(section.container.Title, {TextTransparency = 1}, 0.1)
				end

				wait(0.1)

				page.lastPosition = page.container.CanvasPosition.Y
				page:Resize()
			end
		end

		function page:Resize(scroll)
			local padding = 10
			local size = 0

			for i, section in pairs(self.sections) do
				size = size + section.container.Parent.AbsoluteSize.Y + padding
			end

			self.container.CanvasSize = UDim2.new(0, 0, 0, size)
			self.container.ScrollBarImageTransparency = size > self.container.AbsoluteSize.Y

			if scroll then
				utility:Tween(self.container, {CanvasPosition = Vector2.new(0, self.lastPosition or 0)}, 0.2)
			end
		end

		function section:Resize(smooth)

			if self.page.library.focusedPage ~= self.page then
				return
			end

			local padding = 4
			local size = (4 * padding) + self.container.Title.AbsoluteSize.Y -- offset

			for i, module in pairs(self.modules) do
				size = size + module.AbsoluteSize.Y + padding
			end

			if smooth then
				utility:Tween(self.container.Parent, {Size = UDim2.new(1, -10, 0, size)}, 0.05)
			else
				self.container.Parent.Size = UDim2.new(1, -10, 0, size)
				self.page:Resize()
			end
		end

		function section:getModule(info)

			if table.find(self.modules, info) then
				return info
			end

			for i, module in pairs(self.modules) do
				if (module:FindFirstChild("Title") or module:FindFirstChild("TextBox", true)).Text == info then
					return module
				end
			end

			error("No module found under "..tostring(info))
		end

		-- updates

		function section:updateButton(button, title)
			button = self:getModule(button)

			button.Title.Text = title
		end

		function section:updateToggle(toggle, title, value)
			spawn(function()
				toggle = self:getModule(toggle)

				local position = {
					In = UDim2.new(0, 2, 0.5, -6),
					Out = UDim2.new(0, 20, 0.5, -6)
				}
				local color = {
					In = themes.NotToggledColor,
					Out = themes.ToggledColor
				}

				local frame = toggle.Button.Frame
				local btn = toggle.Button
				value = value and "Out" or "In"

				if title then
					toggle.Title.Text = title
				end

				utility:Tween(frame, {
					Size = UDim2.new(1, -22, 1, -9),
					Position = position[value] + UDim2.new(0, 0, 0, 2.5)
				}, 0.2)

				utility:Tween(btn, {
					ImageColor3 = color[value]
				}, 0.2)

				wait(0.1)
				utility:Tween(frame, {
					Size = UDim2.new(1, -22, 1, -4),
					Position = position[value]
				}, 0.1)
			end)
		end



		function section:updateTextbox(textbox, title, value)
			textbox = self:getModule(textbox)

			if title then
				textbox.Title.Text = title
			end

			if value then
				textbox.Button.Textbox.Text = value
			end

		end

		function section:updateKeybind(keybind, title, key)
			keybind = self:getModule(keybind)

			local text = keybind.Button.Text
			local bind = self.binds[keybind]

			if title then
				keybind.Title.Text = title
			end

			if bind.connection then
				bind.connection = bind.connection:UnBind()
			end

			if key then
				self.binds[keybind].connection = utility:BindToKey(key, bind.callback)
				text.Text = key.Name
			else
				text.Text = "None"
			end
		end

		function section:updateColorPicker(colorpicker, title, color)
			colorpicker = self:getModule(colorpicker)

			local picker = self.colorpickers[colorpicker]
			local tab = picker.tab
			local callback = picker.callback

			if title then
				colorpicker.Title.Text = title
				tab.Title.Text = title
			end

			local color3
			local hue, sat, brightness

			if type(color) == "table" then -- roblox is literally retarded x2
				hue, sat, brightness = unpack(color)
				color3 = Color3.fromHSV(hue, sat, brightness)
			else
				color3 = color
				hue, sat, brightness = Color3.toHSV(color3)
			end

			utility:Tween(colorpicker.Button, {ImageColor3 = color3}, 0.5)
			utility:Tween(tab.Container.Color.Select, {Position = UDim2.new(hue, 0, 0, 0)}, 0.1)

			utility:Tween(tab.Container.Canvas, {ImageColor3 = Color3.fromHSV(hue, 1, 1)}, 0.5)
			utility:Tween(tab.Container.Canvas.Cursor, {Position = UDim2.new(sat, 0, 1 - brightness)}, 0.5)

			for i, container in pairs(tab.Container.Inputs:GetChildren()) do
				if container:IsA("ImageLabel") then
					local value = math.clamp(color3[container.Name], 0, 1) * 255

					container.Textbox.Text = math.floor(value)
					--callback(container.Name:lower(), value)
				end
			end
		end

		function section:updateSlider(slider, title, value, min, max, lvalue)
			slider = self:getModule(slider)

			if title then
				slider.Title.Text = title
			end

			local bar = slider.Slider.Bar
			local percent = (mouse.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X

			if value then -- support negative ranges
				percent = (value - min) / (max - min)
			end

			percent = math.clamp(percent, 0, 1)
			value = value or math.floor(min + (max - min) * percent)

			slider.TextBox.Text = value
			utility:Tween(bar.Fill, {
				Size = UDim2.new(percent, 0, 1, 0),
				ImageColor3 = themes.Slider
			}, 0.1)

			if value ~= lvalue and slider.ImageTransparency == 0 then
				utility:Pop(slider, 10)
			end

			return value
		end
		function section:clearDropdown(dropdown)
			dropdown = self:getModule(dropdown)

			if title then
				dropdown.Search.TextBox.Text = title
			end


			for i, button in pairs(dropdown.List.Frame:GetChildren()) do
				if button:IsA("ImageButton") then
					button:Destroy()
				end
			end

		end 
		function section:updateDropdown(dropdown, title, list, callback)
			dropdown = self:getModule(dropdown)

			if title then
				dropdown.Search.TextBox.Text = title
			end

			local entries = 0

			utility:Pop(dropdown.Search, 10)

			for i, button in pairs(dropdown.List.Frame:GetChildren()) do
				if button:IsA("ImageButton") then
					button:Destroy()
				end
			end

			for i, value in pairs(list or {}) do
				local button = utility:Create("ImageButton", {
					Parent = dropdown.List.Frame,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 30),
					ZIndex = 2,
					Image = "rbxassetid://5028857472",
					ImageColor3 = themes.DarkContrast,
					ScaleType = Enum.ScaleType.Slice,
					SliceCenter = Rect.new(2, 2, 298, 298)
				}, {
					utility:Create("TextLabel", {
						BackgroundTransparency = 1,
						Position = UDim2.new(0, 10, 0, 0),
						Size = UDim2.new(1, -10, 1, 0),
						ZIndex = 3,
						Font = Enum.Font.Gotham,
						Text = value,
						TextColor3 = themes.TextColor,
						TextSize = 12,
						TextXAlignment = "Left",
						TextTransparency = 0.10000000149012
					})
				})

				button.MouseButton1Click:Connect(function()
					if callback then
						callback(value, function(...)
							self:updateDropdown(dropdown, ...)
						end)	
					end

					self:updateDropdown(dropdown, value, nil, callback)
				end)

				entries = entries + 1
			end

			local frame = dropdown.List.Frame

			utility:Tween(dropdown, {Size = UDim2.new(1, 0, 0, (entries == 0 and 30) or math.clamp(entries, 0, 3) * 34 + 38)}, 0.3)
			utility:Tween(dropdown.Search.Button, {Rotation = list and 180 or 0}, 0.3)

			if entries > 3 then

				for i, button in pairs(dropdown.List.Frame:GetChildren()) do
					if button:IsA("ImageButton") then
						button.Size = UDim2.new(1, -6, 0, 30)
					end
				end

				frame.CanvasSize = UDim2.new(0, 0, 0, (entries * 34) - 4)
				frame.ScrollBarImageTransparency = 0
			else
				frame.CanvasSize = UDim2.new(0, 0, 0, 0)
				frame.ScrollBarImageTransparency = 1
			end
		end
	end





	-- init
	--local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/oxilegeek/gui-creator/main/gui%20creator"))()
	local venyx = library.new(name, 8988759357)

	if hided then
		game.CoreGui:FindFirstChild(name).Main.Visible = false
		venyx:toggle()
		game.CoreGui:FindFirstChild(name).Main.Visible = true
	end



	local UIS = game:GetService("UserInputService")
	local ThePlayer = game.Players.LocalPlayer
	local Teams = game:GetService("Teams")

	-- var
	local noclip = false
	local UserInputService = game:GetService("UserInputService")
	local infiniJump = false
	local runservice = game:GetService("RunService")
	local bot = false
	local bringChest = false
	local toChest = false
	local autocollect = false
	local autocollectEgg = false
	local HideReward = false
	local baseSpeed = game.StarterPlayer.CharacterWalkSpeed
	local baseJump = game.StarterPlayer.CharacterJumpPower
	local baseGravity = game.Workspace.Gravity
	local baseLevit = 2
	local killAuraTarget1 = nil
	local killAuraTarget2 = nil
	local killAuraTarget3 = nil
	local killAuraTarget4 = nil
	local spamHit1 = false
	local spamHit2 = false
	local spamHit3 = false
	local spamHit4 = false
	local KillAura = false
	local autoHit = false
	local tpPlayerFocus = nil
	local autofarm = false
	local BotFocus = nil
	local FollowBot = false
	local autoEat = false
	local cooldownEat = 0
	local CanKillGorilla = true
	local CanKillCerber = true
	local eToTeleport = false
	local oldMaxZoom = game.Players.LocalPlayer.CameraMaxZoomDistance
	local createPackName = nil
	local RoleplayName = nil
	local ShowPosition = false
	local BossKillFarm = false
	local BossKillFarmFix = false
	local testSpeedValue = 16
	local BossKillFarmFixFocus = "Trex"
	local BABAutofarmSpeed = 1
	local antiPortalAbuse = false
	local slowloop = 1
	local ZombieKillAura = false
	local ZombieAutofarm = false
	local flyKeybindToggle = true
	local doCashier = false
	local doCook = false
	local doBoxer = false
	local ffc = game.FindFirstChild
	local orderDict={["3540529228"]="Cheese",["3540530535"]="Sausage",["3540529917"]="Pepperoni",["2512571151"]="Dew",["2512441325"]="Dew"}
	local cookingDict = {Cheese=0,Sausage=0,Pepperoni=0,Dew=0}
	local cookPtick = 0
	local cookDtick = 0
	local cookWarned = false
	local boxerWarned = false
	local basicSpeed = baseSpeed
	local basicJump = baseJump
	local basicLevitation = baseLevit
	local basicGravity = baseGravity
	local autoSetSpeed = false
	local doDelivery = false
	local DefaultSky
	local DefaultSkyStat
	local alwaysDay = false
	local doSupplier = false
	local ESPToggle = false
	local currentSpeed = 0
	local shiftToSprint = false
	local sprintSpeed = 20
	local autoDeletePart = false
	local alwaysNight = false
	local timePositionValue = 0
	local showFarmOffer = false
	local PriceFrame = nil
	local ArtistToCopyName = ""
	local PaintSpeed = 0.4
	local ArtistPlotNum = 1
	local PaintID = 1
	local invisibleWallTable = {}
	local invisibleWallsShowed = false
	local keys = shared.keys or {"A", "S", "D", "F"} -- MAKE THIS YOUR ROBEATS KEYBINDS FROM LEFT TO RIGHT, OR SET IN SHARED.KEYS
	local Autoplayer = {}
	local focusTpPlayer = false
	local focusTpPlayerName
	local IsInvisible = false
	local jetpack = false
	local autocollectEggSpeed = 10
	local flingEnabled = false

	local VirtualInputManager = game:GetService("VirtualInputManager")
	local camera = workspace.CurrentCamera
	local RobeatsAutoplayToggle = false



	local function deleteGui()
		game.CoreGui:FindFirstChild(name):Destroy()
		game.CoreGui:FindFirstChild("FoxiMusic"):Destroy()
		alive = false
		for i, v in pairs(workspace:GetDescendants()) do
			if v.Name == "OxiCheatESP" or v.Name == "OxiCheatESPHealth" then
				v:Destroy()
			end
		end

		for i, v in pairs(invisibleWallTable) do
			if v then
				v.Transparency = 1
			end
		end

		invisibleWallTable = {}
	end

	-- delete old menu
	game.CoreGui.ChildAdded:Connect(function(child)
		if ( child.Name == name or child:FindFirstChild("imAFox") ) and alive == true then
			deleteGui()
		end
	end)

	--local DefaultSky = game.Lighting.Sky print("{" ..DefaultSky.MoonAngularSize ..", " ..'"' ..DefaultSky.MoonTextureId ..'"' ..", " ..'"' ..DefaultSky.SkyboxBk ..'"' ..", " ..'"' ..DefaultSky.SkyboxDn ..'"' ..", " ..'"' ..DefaultSky.SkyboxFt ..'"' ..", " ..'"' ..DefaultSky.SkyboxLf ..'"' ..", " ..'"' ..DefaultSky.SkyboxRt ..'"' ..", " ..'"' ..DefaultSky.SkyboxUp ..'"' ..", " ..DefaultSky.StarCount ..", " ..DefaultSky.SunAngularSize ..", " ..'"' ..DefaultSky.SunTextureId ..'"' .."}")

	local presetsSky = {
		["Realistic sky"] = {true, 11, "rbxasset://sky/moon.jpg", "http://www.roblox.com/asset/?id=144933338", "http://www.roblox.com/asset/?id=144931530", "http://www.roblox.com/asset/?id=144933262", "http://www.roblox.com/asset/?id=144933244", "http://www.roblox.com/asset/?id=144933299", "http://www.roblox.com/asset/?id=144931564", 1500, 5, "rbxasset://sky/sun.jpg"},
		["Cartoon sky"] = {true, 11, "rbxasset://sky/moon.jpg", "http://www.roblox.com/asset/?id=5333954202", "http://www.roblox.com/asset/?id=5333944933", "http://www.roblox.com/asset/?id=5333954202", "http://www.roblox.com/asset/?id=5333954202", "http://www.roblox.com/asset/?id=5333954202", "http://www.roblox.com/asset/?id=5333943668", 3000, 21, "rbxasset://sky/sun.jpg"},
		["Pink sky"] = {false, 11, "rbxasset://sky/moon.jpg", "http://www.roblox.com/asset/?id=271042516", "http://www.roblox.com/asset/?id=271077243", "http://www.roblox.com/asset/?id=271042556", "http://www.roblox.com/asset/?id=271042310", "http://www.roblox.com/asset/?id=271042467", "http://www.roblox.com/asset/?id=271077958", 1334, 21, "rbxasset://sky/sun.jpg"},
		["Island theme sky"] = {false, 11, "rbxasset://sky/moon.jpg", "rbxassetid://600830446", "rbxassetid://600831635", "rbxassetid://600832720", "rbxassetid://600886090", "rbxassetid://600833862", "rbxassetid://600835177", 3000, 21, "rbxasset://sky/sun.jpg"},
		["Galaxy sky"] = {false, 11, "rbxasset://sky/moon.jpg", "http://www.roblox.com/asset/?id=159454299", "http://www.roblox.com/asset/?id=159454296", "http://www.roblox.com/asset/?id=159454293", "http://www.roblox.com/asset/?id=159454286", "http://www.roblox.com/asset/?id=159454300", "http://www.roblox.com/asset/?id=159454288", 0, 21, "rbxasset://sky/sun.jpg"},
		["Night time sky"] = {false, 1.5, "rbxassetid://1075087760", "rbxassetid://2670643994", "rbxassetid://2670643365", "rbxassetid://2670643214", "rbxassetid://2670643070", "rbxassetid://2670644173", "rbxassetid://2670644331", 500, 12, "rbxassetid://1084351190"},
		["Night City sky"] = {true, 11, "rbxasset://sky/moon.jpg", "http://www.roblox.com/asset/?id=386170521", "http://www.roblox.com/asset/?id=386170789", "http://www.roblox.com/asset/?id=386170521", "http://www.roblox.com/asset/?id=386170521", "http://www.roblox.com/asset/?id=386170521", "http://www.roblox.com/asset/?ID=2013298", 3000, 21, "rbxassetid://4693618"},

	}
	local ActiveSky = "Default"

	--database var
	local basicPrint = "hi ^^"

	--build a boat
	local BABFastAutofarm = false
	local TheEnd = false
	local SlotNumber = nil


	--Database
	--local printData = game:GetService("DataStoreService"):GetDataStore("PrintData")


	-- function
	local vu = game:GetService("VirtualUser")
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
		wait(1)
		vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)

	end)


	function findNearestTorso(pos)
		local list = game.Players:GetPlayers()
		local torso = nil
		local dist = 1000
		local temp = nil
		local human = nil
		local temp2 = nil
		for x = 1, #list do
			temp2 = list[x]
			if temp2.Name == game.Players.LocalPlayer.Name then

			else
				temp = temp2.Character:findFirstChild("HumanoidRootPart")
				human = temp2.Character:findFirstChild("Humanoid")
				if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
					if (temp.Position - pos).magnitude < dist then
						torso = temp
						dist = (temp.Position - pos).magnitude
					end
				end
			end
		end
		return torso
	end


	do

		------------------------------------------------------------------------
		-- Freecam
		-- Cinematic free camera for spectating and video production.
		------------------------------------------------------------------------

		local pi    = math.pi
		local abs   = math.abs
		local clamp = math.clamp
		local exp   = math.exp
		local rad   = math.rad
		local sign  = math.sign
		local sqrt  = math.sqrt
		local tan   = math.tan

		local ContextActionService = game:GetService("ContextActionService")
		local Players = game:GetService("Players")
		local RunService = game:GetService("RunService")
		local StarterGui = game:GetService("StarterGui")
		local UserInputService = game:GetService("UserInputService")
		local Workspace = game:GetService("Workspace")
		local Settings = UserSettings()
		local GameSettings = Settings.GameSettings

		local LocalPlayer = Players.LocalPlayer
		if not LocalPlayer then
			Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
			LocalPlayer = Players.LocalPlayer
		end

		local Camera = Workspace.CurrentCamera
		Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
			local newCamera = Workspace.CurrentCamera
			if newCamera then
				Camera = newCamera
			end
		end)

		local FFlagUserExitFreecamBreaksWithShiftlock
		do
			local success, result = pcall(function()
				return UserSettings():IsUserFeatureEnabled("UserExitFreecamBreaksWithShiftlock")
			end)
			FFlagUserExitFreecamBreaksWithShiftlock = success and result
		end

		------------------------------------------------------------------------

		local TOGGLE_INPUT_PRIORITY = Enum.ContextActionPriority.Low.Value
		local INPUT_PRIORITY = Enum.ContextActionPriority.High.Value
		local FREECAM_MACRO_KB = {Enum.KeyCode.LeftShift, Enum.KeyCode.P}

		local NAV_GAIN = Vector3.new(1, 1, 1)*64
		local PAN_GAIN = Vector2.new(0.75, 1)*8
		local FOV_GAIN = 300

		local PITCH_LIMIT = rad(90)

		local VEL_STIFFNESS = 1.5
		local PAN_STIFFNESS = 1.0
		local FOV_STIFFNESS = 4.0

		------------------------------------------------------------------------

		local Spring = {} do
			Spring.__index = Spring

			function Spring.new(freq, pos)
				local self = setmetatable({}, Spring)
				self.f = freq
				self.p = pos
				self.v = pos*0
				return self
			end

			function Spring:Update(dt, goal)
				local f = self.f*2*pi
				local p0 = self.p
				local v0 = self.v

				local offset = goal - p0
				local decay = exp(-f*dt)

				local p1 = goal + (v0*dt - offset*(f*dt + 1))*decay
				local v1 = (f*dt*(offset*f - v0) + v0)*decay

				self.p = p1
				self.v = v1

				return p1
			end

			function Spring:Reset(pos)
				self.p = pos
				self.v = pos*0
			end
		end

		------------------------------------------------------------------------

		local cameraPos = Vector3.new()
		local cameraRot = Vector2.new()
		local cameraFov = 0

		local velSpring = Spring.new(VEL_STIFFNESS, Vector3.new())
		local panSpring = Spring.new(PAN_STIFFNESS, Vector2.new())
		local fovSpring = Spring.new(FOV_STIFFNESS, 0)

		------------------------------------------------------------------------

		local Input = {} do
			local thumbstickCurve do
				local K_CURVATURE = 2.0
				local K_DEADZONE = 0.15

				local function fCurve(x)
					return (exp(K_CURVATURE*x) - 1)/(exp(K_CURVATURE) - 1)
				end

				local function fDeadzone(x)
					return fCurve((x - K_DEADZONE)/(1 - K_DEADZONE))
				end

				function thumbstickCurve(x)
					return sign(x)*clamp(fDeadzone(abs(x)), 0, 1)
				end
			end

			local gamepad = {
				ButtonX = 0,
				ButtonY = 0,
				DPadDown = 0,
				DPadUp = 0,
				ButtonL2 = 0,
				ButtonR2 = 0,
				Thumbstick1 = Vector2.new(),
				Thumbstick2 = Vector2.new(),
			}

			local keyboard = {
				W = 0,
				A = 0,
				S = 0,
				D = 0,
				E = 0,
				Q = 0,
				U = 0,
				H = 0,
				J = 0,
				K = 0,
				I = 0,
				Y = 0,
				Up = 0,
				Down = 0,
				LeftShift = 0,
				RightShift = 0,
			}

			local mouse = {
				Delta = Vector2.new(),
				MouseWheel = 0,
			}

			local NAV_GAMEPAD_SPEED  = Vector3.new(1, 1, 1)
			local NAV_KEYBOARD_SPEED = Vector3.new(1, 1, 1)
			local PAN_MOUSE_SPEED    = Vector2.new(1, 1)*(pi/64)
			local PAN_GAMEPAD_SPEED  = Vector2.new(1, 1)*(pi/8)
			local FOV_WHEEL_SPEED    = 1.0
			local FOV_GAMEPAD_SPEED  = 0.25
			local NAV_ADJ_SPEED      = 0.75
			local NAV_SHIFT_MUL      = 0.25

			local navSpeed = 1

			function Input.Vel(dt)
				navSpeed = clamp(navSpeed + dt*(keyboard.Up - keyboard.Down)*NAV_ADJ_SPEED, 0.01, 4)

				local kGamepad = Vector3.new(
					thumbstickCurve(gamepad.Thumbstick1.X),
					thumbstickCurve(gamepad.ButtonR2) - thumbstickCurve(gamepad.ButtonL2),
					thumbstickCurve(-gamepad.Thumbstick1.Y)
				)*NAV_GAMEPAD_SPEED

				local kKeyboard = Vector3.new(
					keyboard.D - keyboard.A + keyboard.K - keyboard.H,
					keyboard.E - keyboard.Q + keyboard.I - keyboard.Y,
					keyboard.S - keyboard.W + keyboard.J - keyboard.U
				)*NAV_KEYBOARD_SPEED

				local shift = UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)

				return (kGamepad + kKeyboard)*(navSpeed*(shift and NAV_SHIFT_MUL or 1))
			end

			function Input.Pan(dt)
				local kGamepad = Vector2.new(
					thumbstickCurve(gamepad.Thumbstick2.Y),
					thumbstickCurve(-gamepad.Thumbstick2.X)
				)*PAN_GAMEPAD_SPEED
				local kMouse = mouse.Delta*PAN_MOUSE_SPEED
				mouse.Delta = Vector2.new()
				return kGamepad + kMouse
			end

			function Input.Fov(dt)
				local kGamepad = (gamepad.ButtonX - gamepad.ButtonY)*FOV_GAMEPAD_SPEED
				local kMouse = mouse.MouseWheel*FOV_WHEEL_SPEED
				mouse.MouseWheel = 0
				return kGamepad + kMouse
			end

			do
				local function Keypress(action, state, input)
					keyboard[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
					return Enum.ContextActionResult.Sink
				end

				local function GpButton(action, state, input)
					gamepad[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
					return Enum.ContextActionResult.Sink
				end

				local function MousePan(action, state, input)
					local delta = input.Delta
					mouse.Delta = Vector2.new(-delta.y, -delta.x)
					return Enum.ContextActionResult.Sink
				end

				local function Thumb(action, state, input)
					gamepad[input.KeyCode.Name] = input.Position
					return Enum.ContextActionResult.Sink
				end

				local function Trigger(action, state, input)
					gamepad[input.KeyCode.Name] = input.Position.z
					return Enum.ContextActionResult.Sink
				end

				local function MouseWheel(action, state, input)
					mouse[input.UserInputType.Name] = -input.Position.z
					return Enum.ContextActionResult.Sink
				end

				local function Zero(t)
					for k, v in pairs(t) do
						t[k] = v*0
					end
				end

				function Input.StartCapture()
					ContextActionService:BindActionAtPriority("FreecamKeyboard", Keypress, false, INPUT_PRIORITY,
						Enum.KeyCode.W, Enum.KeyCode.U,
						Enum.KeyCode.A, Enum.KeyCode.H,
						Enum.KeyCode.S, Enum.KeyCode.J,
						Enum.KeyCode.D, Enum.KeyCode.K,
						Enum.KeyCode.E, Enum.KeyCode.I,
						Enum.KeyCode.Q, Enum.KeyCode.Y,
						Enum.KeyCode.Up, Enum.KeyCode.Down
					)
					ContextActionService:BindActionAtPriority("FreecamMousePan",          MousePan,   false, INPUT_PRIORITY, Enum.UserInputType.MouseMovement)
					ContextActionService:BindActionAtPriority("FreecamMouseWheel",        MouseWheel, false, INPUT_PRIORITY, Enum.UserInputType.MouseWheel)
					ContextActionService:BindActionAtPriority("FreecamGamepadButton",     GpButton,   false, INPUT_PRIORITY, Enum.KeyCode.ButtonX, Enum.KeyCode.ButtonY)
					ContextActionService:BindActionAtPriority("FreecamGamepadTrigger",    Trigger,    false, INPUT_PRIORITY, Enum.KeyCode.ButtonR2, Enum.KeyCode.ButtonL2)
					ContextActionService:BindActionAtPriority("FreecamGamepadThumbstick", Thumb,      false, INPUT_PRIORITY, Enum.KeyCode.Thumbstick1, Enum.KeyCode.Thumbstick2)
				end

				function Input.StopCapture()
					navSpeed = 1
					Zero(gamepad)
					Zero(keyboard)
					Zero(mouse)
					ContextActionService:UnbindAction("FreecamKeyboard")
					ContextActionService:UnbindAction("FreecamMousePan")
					ContextActionService:UnbindAction("FreecamMouseWheel")
					ContextActionService:UnbindAction("FreecamGamepadButton")
					ContextActionService:UnbindAction("FreecamGamepadTrigger")
					ContextActionService:UnbindAction("FreecamGamepadThumbstick")
				end
			end
		end

		local function GetFocusDistance(cameraFrame)
			local znear = 0.1
			local viewport = Camera.ViewportSize
			local projy = 2*tan(cameraFov/2)
			local projx = viewport.x/viewport.y*projy
			local fx = cameraFrame.rightVector
			local fy = cameraFrame.upVector
			local fz = cameraFrame.lookVector

			local minVect = Vector3.new()
			local minDist = 512

			for x = 0, 1, 0.5 do
				for y = 0, 1, 0.5 do
					local cx = (x - 0.5)*projx
					local cy = (y - 0.5)*projy
					local offset = fx*cx - fy*cy + fz
					local origin = cameraFrame.p + offset*znear
					local _, hit = Workspace:FindPartOnRay(Ray.new(origin, offset.unit*minDist))
					local dist = (hit - origin).magnitude
					if minDist > dist then
						minDist = dist
						minVect = offset.unit
					end
				end
			end

			return fz:Dot(minVect)*minDist
		end

		------------------------------------------------------------------------

		local function StepFreecam(dt)
			local vel = velSpring:Update(dt, Input.Vel(dt))
			local pan = panSpring:Update(dt, Input.Pan(dt))
			local fov = fovSpring:Update(dt, Input.Fov(dt))

			local zoomFactor = sqrt(tan(rad(70/2))/tan(rad(cameraFov/2)))

			cameraFov = clamp(cameraFov + fov*FOV_GAIN*(dt/zoomFactor), 1, 120)
			cameraRot = cameraRot + pan*PAN_GAIN*(dt/zoomFactor)
			cameraRot = Vector2.new(clamp(cameraRot.x, -PITCH_LIMIT, PITCH_LIMIT), cameraRot.y%(2*pi))

			local cameraCFrame = CFrame.new(cameraPos)*CFrame.fromOrientation(cameraRot.x, cameraRot.y, 0)*CFrame.new(vel*NAV_GAIN*dt)
			cameraPos = cameraCFrame.p

			Camera.CFrame = cameraCFrame
			Camera.Focus = cameraCFrame*CFrame.new(0, 0, -GetFocusDistance(cameraCFrame))
			Camera.FieldOfView = cameraFov
		end

		local function CheckMouseLockAvailability()
			local devAllowsMouseLock = Players.LocalPlayer.DevEnableMouseLock
			local devMovementModeIsScriptable = Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
			local userHasMouseLockModeEnabled = GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch
			local userHasClickToMoveEnabled =  GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
			local MouseLockAvailable = devAllowsMouseLock and userHasMouseLockModeEnabled and not userHasClickToMoveEnabled and not devMovementModeIsScriptable

			return MouseLockAvailable
		end

		------------------------------------------------------------------------

		local PlayerState = {} do
			local mouseBehavior
			local mouseIconEnabled
			local cameraType
			local cameraFocus
			local cameraCFrame
			local cameraFieldOfView
			local screenGuis = {}
			local coreGuis = {
				Backpack = true,
				Chat = true,
				Health = true,
				PlayerList = true,
			}
			local setCores = {
				BadgesNotificationsActive = true,
				PointsNotificationsActive = true,
			}

			-- Save state and set up for freecam
			function PlayerState.Push()
				for name in pairs(coreGuis) do
					coreGuis[name] = StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType[name])
					StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[name], false)
				end
				for name in pairs(setCores) do
					setCores[name] = StarterGui:GetCore(name)
					StarterGui:SetCore(name, false)
				end
				local playergui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
				if playergui then
					for _, gui in pairs(playergui:GetChildren()) do
						if gui:IsA("ScreenGui") and gui.Enabled then
							screenGuis[#screenGuis + 1] = gui
							gui.Enabled = false
						end
					end
				end

				cameraFieldOfView = Camera.FieldOfView
				Camera.FieldOfView = 70

				cameraType = Camera.CameraType
				Camera.CameraType = Enum.CameraType.Custom

				cameraCFrame = Camera.CFrame
				cameraFocus = Camera.Focus

				mouseIconEnabled = UserInputService.MouseIconEnabled
				UserInputService.MouseIconEnabled = false

				if FFlagUserExitFreecamBreaksWithShiftlock and CheckMouseLockAvailability() then
					mouseBehavior = Enum.MouseBehavior.Default
				else
					mouseBehavior = UserInputService.MouseBehavior
				end
				UserInputService.MouseBehavior = Enum.MouseBehavior.Default
			end

			-- Restore state
			function PlayerState.Pop()
				for name, isEnabled in pairs(coreGuis) do
					StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType[name], isEnabled)
				end
				for name, isEnabled in pairs(setCores) do
					StarterGui:SetCore(name, isEnabled)
				end
				for _, gui in pairs(screenGuis) do
					if gui.Parent then
						gui.Enabled = true
					end
				end

				Camera.FieldOfView = cameraFieldOfView
				cameraFieldOfView = nil

				Camera.CameraType = cameraType
				cameraType = nil

				Camera.CFrame = cameraCFrame
				cameraCFrame = nil

				Camera.Focus = cameraFocus
				cameraFocus = nil

				UserInputService.MouseIconEnabled = mouseIconEnabled
				mouseIconEnabled = nil

				UserInputService.MouseBehavior = mouseBehavior
				mouseBehavior = nil
			end
		end

		local function StartFreecam()
			local cameraCFrame = Camera.CFrame
			cameraRot = Vector2.new(cameraCFrame:toEulerAnglesYXZ())
			cameraPos = cameraCFrame.p
			cameraFov = Camera.FieldOfView

			velSpring:Reset(Vector3.new())
			panSpring:Reset(Vector2.new())
			fovSpring:Reset(0)

			PlayerState.Push()
			RunService:BindToRenderStep("Freecam", Enum.RenderPriority.Camera.Value, StepFreecam)
			Input.StartCapture()
		end

		local function StopFreecam()
			Input.StopCapture()
			RunService:UnbindFromRenderStep("Freecam")
			PlayerState.Pop()
		end

		------------------------------------------------------------------------

		do
			local enabled = false

			function ToggleFreecam()
				if enabled then
					StopFreecam()
				else
					StartFreecam()
				end
				enabled = not enabled
			end

			local function CheckMacro(macro)
				for i = 1, #macro - 1 do
					if not UserInputService:IsKeyDown(macro[i]) then
						return
					end
				end
				ToggleFreecam()
			end


		end
	end



	local function autoFarmBAB()
		repeat wait(0.1) until game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		local stages = game.Workspace.BoatStages.NormalStages:GetChildren()
		for i = 1, #stages do
			if alive then
				if i < 11 then
					if BABFastAutofarm then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(stages[i].DarknessPart.Position)
						wait(BABAutofarmSpeed)
					end
				else
					if i == 12 then
						break
					end
					if BABFastAutofarm then
						TheEnd = true
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.BoatStages.NormalStages.TheEnd.GoldenChest.Base.LockPosition.Position)
					end
				end
			end
		end
	end

	if game.GameId == 210851291 then
		game.Players.LocalPlayer.PlayerGui.RiverResultsGui.Frame.Changed:Connect(function()
			if BABFastAutofarm then
				autoFarmBAB()
			end
		end)
	end

	local trackEmote
	function StartEmote(id, looped)
		if trackEmote then
			trackEmote:Stop()
		end

		local animation = Instance.new("Animation")
		animation.AnimationId = "rbxassetid://" ..id
		wait(1)
		trackEmote = game.Players.LocalPlayer.Character.Humanoid:LoadAnimation(animation)
		trackEmote.Looped = looped

		trackEmote:Play()

		print("played")
	end


	function bot()
		while wait() do
			local goal = game.Players:FindFirstChild(FollowBot).Character.HumanoidRootPart

			local pathfinding = game:GetService("PathfindingService")

			local path = pathfinding:CreatePath()
			path:ComputeAsync(game.Players.LocalPlayer.Character.HumanoidRootPart.Position, goal.Position)

			local waypoints = path:GetWaypoints()


			for i, waypoint in pairs(waypoints) do

				if waypoint.Action == Enum.PathWaypointAction.Jump then

					game.Players.LocalPlayer.Character.Humanoid.Jump = true
				end

				game.Players.LocalPlayer.Character.Humanoid:MoveTo(waypoint.Position)

				game.Players.LocalPlayer.Character.Humanoid.MoveToFinished:Wait()

			end
		end
	end

	_G.FLYING = false
	local CONTROL = {F = 0, B = 0, L = 0, R = 0}
	local lCONTROL = {F = 0, B = 0, L = 0, R = 0}
	local SPEED = 5
	local MOUSE = game.Players.LocalPlayer:GetMouse()
	local flySpeed = 50


	local function FLY()
		local BG = Instance.new('BodyGyro', game.Players.LocalPlayer.Character.HumanoidRootPart)
		local BV = Instance.new('BodyVelocity', game.Players.LocalPlayer.Character.HumanoidRootPart)
		BG.P = 9e4
		BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
		BG.cframe = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
		BV.velocity = Vector3.new(0, 0.1, 0)
		BV.maxForce = Vector3.new(9e9, 9e9, 9e9)


		spawn(function()
			repeat wait()
				game.Players.LocalPlayer.Character.Humanoid.PlatformStand = true
				if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 then
					SPEED = flySpeed
				elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0) and SPEED ~= 0 then
					SPEED = 0
				end
				if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 then
					BV.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
					lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
				elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and SPEED ~= 0 then
					BV.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B) * 0.2, 0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
				else
					BV.velocity = Vector3.new(0, 0.1, 0)
				end
				BG.cframe = game.Workspace.CurrentCamera.CoordinateFrame
			until not _G.FLYING or _G.FLYING and not flyKeybindToggle
			CONTROL = {F = 0, B = 0, L = 0, R = 0}
			lCONTROL = {F = 0, B = 0, L = 0, R = 0}
			SPEED = 0
			BG:destroy()
			BV:destroy()
			game.Players.LocalPlayer.Character.Humanoid.PlatformStand = false
		end)
	end

	MOUSE.KeyDown:connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 1
		elseif KEY:lower() == 's' then
			CONTROL.B = -1
		elseif KEY:lower() == 'a' then
			CONTROL.L = -1 
		elseif KEY:lower() == 'd' then 
			CONTROL.R = 1
		end
	end)

	MOUSE.KeyUp:connect(function(KEY)
		if KEY:lower() == 'w' then
			CONTROL.F = 0
		elseif KEY:lower() == 's' then
			CONTROL.B = 0
		elseif KEY:lower() == 'a' then
			CONTROL.L = 0
		elseif KEY:lower() == 'd' then
			CONTROL.R = 0
		end
	end)

	function GetDefaultSky()
		local skyFounded = false
		for i, v in pairs(game.Lighting:GetChildren()) do
			if not skyFounded and v:IsA("Sky") then
				skyFounded = true
				return v
			end
		end
	end

	ALLYCOLOR = {0,255,255}  	
	ENEMYCOLOR =  {255,0,0} 	
	TRANSPARENCY = 0.5		
	HEALTHBAR_ACTIVATED = true 	





	function createFlex()


		players = game:GetService("Players")
		faces = {"Front","Back","Bottom","Left","Right","Top"}
		currentPlayer = nil 
		lplayer = players.LocalPlayer 

		players.PlayerAdded:Connect(function(p)
			currentPlayer = p
			p.CharacterAdded:Connect(function(character)
				wait(0.1)
				createESP(character)			
			end)		
		end)

		function checkPart(obj)  if (obj:IsA("Part") or obj:IsA("MeshPart") or obj:IsA("UnionOperation")) then return true end end

		function actualESP(obj) 

			for i=0,5 do
				surface = Instance.new("SurfaceGui",obj) 
				surface.Face = Enum.NormalId[faces[i+1]]
				surface.AlwaysOnTop = true
				--surface.MaxDistance = math.huge
				surface.Enabled = ESPToggle
				surface.Name = "OxiCheatESP"

				local frame = Instance.new("Frame",surface)	
				frame.Size = UDim2.new(1,0,1,0)
				frame.BorderSizePixel = 0												
				frame.BackgroundTransparency = TRANSPARENCY
				spawn(function()
					local TempPlr = players:FindFirstChild(surface.Parent.Parent.Name) 
					while true do 
						if TempPlr.Team == players.LocalPlayer.Team then
							frame.BackgroundColor3 = Color3.new(ALLYCOLOR[1],ALLYCOLOR[2],ALLYCOLOR[3])											
						else
							frame.BackgroundColor3 = Color3.new(ENEMYCOLOR[1],ENEMYCOLOR[2],ENEMYCOLOR[3])
						end
						wait(1)
					end
				end)


				surface:GetPropertyChangedSignal("AlwaysOnTop"):connect(function()
					surface.AlwaysOnTop = true
				end)

			end
		end

		function createHealthbar(hrp) 
			board =Instance.new("BillboardGui",hrp)
			board.Name = "OxiCheatESPHealth"
			board.Size = UDim2.new(1,0,1,0)
			board.StudsOffset = Vector3.new(3,1,0)
			board.AlwaysOnTop = true
			board.Enabled = ESPToggle
			--board.MaxDistance = math.huge

			bar = Instance.new("Frame",board)
			bar.BackgroundColor3 = Color3.new(255,0,0)
			bar.BorderSizePixel = 0
			bar.Size = UDim2.new(0.2,0,4,0)
			bar.Name = "total2"

			health = Instance.new("Frame",bar)
			health.BackgroundColor3 = Color3.new(0,255,0)
			health.BorderSizePixel = 0
			health.Size = UDim2.new(1,0,hrp.Parent.Humanoid.Health/ hrp.Parent.Humanoid.MaxHealth,0)
			hrp.Parent.Humanoid.Changed:Connect(function(property) 
				if hrp:FindFirstChild("OxiCheatESPHealth") then
					hrp.OxiCheatESPHealth.total2.Frame.Size = UDim2.new(1,0, hrp.Parent.Humanoid.Health / hrp.Parent.Humanoid.MaxHealth, 0)							
				end
			end)

			board:GetPropertyChangedSignal("AlwaysOnTop"):connect(function()
				board.AlwaysOnTop = true
			end)
		end

		function createESP(c)
			if c then
				bugfix = c:WaitForChild("Head") 
				for i,v in pairs(c:GetChildren()) do
					if checkPart(v) then
						actualESP(v)
					end
				end
				if HEALTHBAR_ACTIVATED then
					createHealthbar(c:WaitForChild("HumanoidRootPart")) 
				end
			end
		end

		for i,people in pairs(players:GetChildren())do
			if people ~= players.LocalPlayer then
				currentPlayer = people
				createESP(people.Character)
				people.CharacterAdded:Connect(function(character)
					createESP(character)			
				end)
			end
		end
	end


	function closeESP()
		for i, v in pairs(workspace:GetDescendants()) do
			if v.Name == "OxiCheatESP" or v.Name == "OxiCheatESPHealth" then
				v:Destroy()
			end
		end
	end

	function openESP()
		spawn(createFlex)
	end



	do
		local PlaceId = game.PlaceId

		local Players = game:GetService("Players");
		local HttpService = game:GetService("HttpService");
		local Workspace = game:GetService("Workspace");
		local Teams = game:GetService("Teams")
		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService");

		local CurrentCamera = Workspace.CurrentCamera
		local WorldToViewportPoint = CurrentCamera.WorldToViewportPoint
		local GetPartsObscuringTarget = CurrentCamera.GetPartsObscuringTarget

		local Inset = game:GetService("GuiService"):GetGuiInset().Y

		local FindFirstChild = game.FindFirstChild
		local FindFirstChildWhichIsA = game.FindFirstChildWhichIsA
		local IsA = game.IsA
		local Vector2new = Vector2.new
		local Vector3new = Vector3.new
		local CFramenew = CFrame.new
		local Color3new = Color3.new

		local Tfind = table.find
		local create = table.create
		local format = string.format
		local floor = math.floor
		local gsub = string.gsub
		local sub = string.sub
		local lower = string.lower
		local upper = string.upper
		local random = math.random

		local DefaultSettings = {
			Esp = {
				NamesEnabled = false,
				DisplayNamesEnabled = false,
				DistanceEnabled = false,
				HealthEnabled = false,
				TracersEnabled = false,
				BoxEsp = false,
				TeamColors = true,
				Thickness = 1.5,
				TracerThickness = 1.6,
				Transparency = .9,
				TracerTrancparency = .7,
				Size = 16,
				RenderDistance = 9e9,
				Color = Color3.fromRGB(19, 130, 226),
				OutlineColor = Color3new(),
				TracerTo = "Head",
				BlacklistedTeams = {}
			},
			Aimbot = {
				Enabled = false,
				SilentAim = false,
				Wallbang = false,
				ShowFov = false,
				Snaplines = true,
				ThirdPerson = false,
				FirstPerson = false,
				ClosestCharacter = false,
				ClosestCursor = true,
				Smoothness = 1,
				SilentAimHitChance = 100,
				FovThickness = 1,
				FovTransparency = 1,
				FovSize = 150,
				FovColor = Color3new(1, 1, 1),
				Aimlock = "Head",
				SilentAimRedirect = "Head",
				BlacklistedTeams = {}
			},
			WindowPosition = UDim2.new(0.5, -200, 0.5, -139);

			Version = 1.2
		}

		--local EncodeConfig, DecodeConfig;
		--do
		--	local deepsearchset;
		--	deepsearchset = function(tbl, ret, value)
		--		if (type(tbl) == 'table') then
		--			local new = {}
		--			for i, v in next, tbl do
		--				new[i] = v
		--				if (type(v) == 'table') then
		--					new[i] = deepsearchset(v, ret, value);
		--				end
		--				if (ret(i, v)) then
		--					new[i] = value(i, v);
		--				end
		--			end
		--			return new
		--		end
		--	end

		--	DecodeConfig = function(Config)
		--		local DecodedConfig = deepsearchset(Config, function(Index, Value)
		--			return type(Value) == "table" and (Value.HSVColor or Value.Position);
		--		end, function(Index, Value)
		--			local Color = Value.HSVColor
		--			local Position = Value.Position
		--			if (Color) then
		--				return Color3.fromHSV(Color.H, Color.S, Color.V);
		--			end
		--			if (Position and Position.Y and Position.X) then
		--				return UDim2.new(UDim.new(Position.X.Scale, Position.X.Offset), UDim.new(Position.Y.Scale, Position.Y.Offset));
		--			else
		--				return DefaultSettings.WindowPosition;
		--			end
		--		end);
		--		return DecodedConfig
		--	end

		--	EncodeConfig = function(Config)
		--		local ToHSV = Color3new().ToHSV
		--		local EncodedConfig = deepsearchset(Config, function(Index, Value)
		--			return typeof(Value) == "Color3" or typeof(Value) == "UDim2"
		--		end, function(Index, Value)
		--			local Color = typeof(Value) == "Color3"
		--			local Position = typeof(Value) == "UDim2"
		--			if (Color) then
		--				local H, S, V = ToHSV(Value);
		--				return { HSVColor = { H = H, S = S, V = V } };
		--			end
		--			if (Position) then
		--				return { Position = {
		--					X = { Scale = Value.X.Scale, Offset = Value.X.Offset };
		--					Y = { Scale = Value.Y.Scale, Offset = Value.Y.Offset }
		--				} };
		--			end
		--		end)
		--		return EncodedConfig
		--	end
		--end

		--local GetConfig = function()
		--	local read, data = pcall(readfile, "fates-esp.json");
		--	local canDecode, config = pcall(HttpService.JSONDecode, HttpService, data);
		--	if (read and canDecode) then
		--		local Decoded = DecodeConfig(config);
		--		if (Decoded.Version ~= DefaultSettings.Version) then
		--			local Encoded = HttpService:JSONEncode(EncodeConfig(DefaultSettings));
		--			writefile("fates-esp.json", Encoded);
		--			return DefaultSettings;
		--		end
		--		return Decoded;
		--	else
		--		local Encoded = HttpService:JSONEncode(EncodeConfig(DefaultSettings));
		--		writefile("fates-esp.json", Encoded);
		--		return DefaultSettings
		--	end
		--end

		local Settings = DefaultSettings;

		local LocalPlayer = Players.LocalPlayer
		local Mouse = LocalPlayer:GetMouse();
		local MouseVector = Vector2new(Mouse.X, Mouse.Y);
		local Characters = {}

		local CustomGet = {
			[0] = function()
				return {}
			end
		}

		local Get;
		if (CustomGet[PlaceId]) then
			Get = CustomGet[PlaceId]();
		end

		local GetCharacter = function(Player)
			if (Get) then
				return Get.GetCharacter(Player);
			end
			return Player.Character
		end
		local CharacterAdded = function(Player, Callback)
			if (Get) then
				return
			end
			Player.CharacterAdded:Connect(Callback);
		end
		local CharacterRemoving = function(Player, Callback)
			if (Get) then
				return
			end
			Player.CharacterRemoving:Connect(Callback);
		end

		local GetTeam = function(Player)
			if (Get) then
				return Get.GetTeam(Player);
			end
			return Player.Team
		end

		local Drawings = {}

		AimbotSettings = Settings.Aimbot
		EspSettings = Settings.Esp

		FOV = Drawing.new("Circle");
		FOV.Color = AimbotSettings.FovColor
		FOV.Thickness = AimbotSettings.FovThickness
		FOV.Transparency = AimbotSettings.FovTransparency
		FOV.Filled = false
		FOV.Radius = AimbotSettings.FovSize

		Snaplines = Drawing.new("Line");
		Snaplines.Color = AimbotSettings.FovColor
		Snaplines.Thickness = .1
		Snaplines.Transparency = 1
		Snaplines.Visible = AimbotSettings.Snaplines

		table.insert(Drawings, FOV);
		table.insert(Drawings, Snaplines);

		local HandlePlayer = function(Player)
			local Character = GetCharacter(Player);
			if (Character) then
				Characters[Player] = Character
			end
			CharacterAdded(Player, function(Char)
				Characters[Player] = Char
			end);
			CharacterRemoving(Player, function(Char)
				Characters[Player] = nil
				local PlayerDrawings = Drawings[Player]
				if (PlayerDrawings) then
					PlayerDrawings.Text.Visible = false
					PlayerDrawings.Box.Visible = false
					PlayerDrawings.Tracer.Visible = false
				end
			end);

			if (Player == LocalPlayer) then return; end

			local Text = Drawing.new("Text");
			Text.Color = EspSettings.Color
			Text.OutlineColor = EspSettings.OutlineColor
			Text.Size = EspSettings.Size
			Text.Transparency = EspSettings.Transparency
			Text.Center = true
			Text.Outline = true

			local Tracer = Drawing.new("Line");
			Tracer.Color = EspSettings.Color
			Tracer.From = Vector2new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y);
			Tracer.Thickness = EspSettings.TracerThickness
			Tracer.Transparency = EspSettings.TracerTrancparency

			local Box = Drawing.new("Quad");
			Box.Thickness = EspSettings.Thickness
			Box.Transparency = EspSettings.Transparency
			Box.Filled = false
			Box.Color = EspSettings.Color

			Drawings[Player] = { Text = Text, Tracer = Tracer, Box = Box }
		end

		for Index, Player in pairs(Players:GetPlayers()) do
			HandlePlayer(Player);
		end
		Players.PlayerAdded:Connect(function(Player)
			HandlePlayer(Player);
		end);

		Players.PlayerRemoving:Connect(function(Player)
			Characters[Player] = nil
			local PlayerDrawings = Drawings[Player]
			for Index, Drawing in pairs(PlayerDrawings or {}) do
				Drawing.Visible = false
			end
			Drawings[Player] = nil
		end);

		SetProperties = function(Properties)
			for Player, PlayerDrawings in pairs(Drawings) do
				if (type(Player) ~= "number") then
					for Property, Value in pairs(Properties.Tracer or {}) do
						PlayerDrawings.Tracer[Property] = Value
					end
					for Property, Value in pairs(Properties.Text or {}) do
						PlayerDrawings.Text[Property] = Value
					end
					for Property, Value in pairs(Properties.Box or {}) do
						PlayerDrawings.Box[Property] = Value
					end
				end
			end
		end


		GetClosestPlayerAndRender = function()
			local MousePos = UIS:GetMouseLocation()
			MouseVector = Vector2.new(Mouse.X, Mouse.Y + Inset);

			local Closest = create(4);
			local Vector2Distance = math.huge
			local Vector3DistanceOnScreen = math.huge
			local Vector3Distance = math.huge

			if (AimbotSettings.ShowFov) then
				FOV.Position = MouseVector
				FOV.Visible = true
				Snaplines.Visible = false
			else
				FOV.Visible = false
			end

			local LocalRoot = Characters[LocalPlayer] and FindFirstChild(Characters[LocalPlayer], "HumanoidRootPart");
			for Player, Character in pairs(Characters) do
				if (Player == LocalPlayer) then continue; end
				local PlayerDrawings = Drawings[Player]
				local PlayerRoot = FindFirstChild(Character, "HumanoidRootPart");
				local PlayerTeam = GetTeam(Player);
				if (PlayerRoot) then
					local Redirect = FindFirstChild(Character, AimbotSettings.Aimlock);
					if (not Redirect) then
						PlayerDrawings.Text.Visible = false
						PlayerDrawings.Box.Visible = false
						PlayerDrawings.Tracer.Visible = false
						continue;
					end
					local RedirectPos = Redirect.Position
					local Tuple, Visible = WorldToViewportPoint(CurrentCamera, RedirectPos);
					local CharacterVec2 = Vector2new(Tuple.X, Tuple.Y);
					local Vector2Magnitude = (MouseVector - CharacterVec2).Magnitude
					local Vector3Magnitude = LocalRoot and (RedirectPos - LocalRoot.Position).Magnitude or math.huge
					local InRenderDistance = Vector3Magnitude <= EspSettings.RenderDistance

					if (not Tfind(AimbotSettings.BlacklistedTeams, PlayerTeam)) then
						local InFovRadius = Vector2Magnitude <= FOV.Radius
						if (InFovRadius) then
							if (Visible and Vector2Magnitude <= Vector2Distance and AimbotSettings.ClosestCursor) then
								Vector2Distance = Vector2Magnitude
								Closest = {Character, CharacterVec2, Player, Redirect}
								if (AimbotSettings.Snaplines and AimbotSettings.ShowFov) then
									Snaplines.Visible = true
									Snaplines.From = MouseVector
									Snaplines.To = CharacterVec2
								else
									Snaplines.Visible = false
								end
							end

							if (Visible and Vector3Magnitude <= Vector3DistanceOnScreen and Settings.ClosestPlayer) then
								Vector3DistanceOnScreen = Vector3Magnitude
								Closest = {Character, CharacterVec2, Player, Redirect}
							end
						end
					end

					if (InRenderDistance and Visible and not Tfind(EspSettings.BlacklistedTeams, PlayerTeam)) then
						local CharacterHumanoid = FindFirstChildWhichIsA(Character, "Humanoid") or { Health = 0, MaxHealth = 0 };
						PlayerDrawings.Text.Text = format("%s\n%s%s",
							EspSettings.NamesEnabled and Player.Name or "",
							EspSettings.DistanceEnabled and format("[%s]",
								floor(Vector3Magnitude)
							) or "",
							EspSettings.HealthEnabled and format(" [%s/%s]",
								floor(CharacterHumanoid.Health),
								floor(CharacterHumanoid.MaxHealth)
							)  or ""
						);

						PlayerDrawings.Text.Position = Vector2new(Tuple.X, Tuple.Y - 40);

						if (EspSettings.TracersEnabled) then
							PlayerDrawings.Tracer.To = CharacterVec2
						end

						if (EspSettings.BoxEsp) then
							local Parts = {}
							for Index, Part in pairs(Character:GetChildren()) do
								if (IsA(Part, "BasePart")) then
									local ViewportPos = WorldToViewportPoint(CurrentCamera, Part.Position);
									Parts[Part] = Vector2new(ViewportPos.X, ViewportPos.Y);
								end
							end

							local Top, Bottom, Left, Right
							local Distance = math.huge
							local ClosestPart = nil
							for i2, Pos in next, Parts do
								local Mag = (Pos - Vector2new(Tuple.X, 0)).Magnitude;
								if (Mag <= Distance) then
									ClosestPart = Pos
									Distance = Mag
								end
							end
							Top = ClosestPart
							ClosestPart = nil
							Distance = math.huge
							for i2, Pos in next, Parts do
								local Mag = (Pos - Vector2new(Tuple.X, CurrentCamera.ViewportSize.Y)).Magnitude;
								if (Mag <= Distance) then
									ClosestPart = Pos
									Distance = Mag
								end
							end
							Bottom = ClosestPart
							ClosestPart = nil
							Distance = math.huge
							for i2, Pos in next, Parts do
								local Mag = (Pos - Vector2new(0, Tuple.Y)).Magnitude;
								if (Mag <= Distance) then
									ClosestPart = Pos
									Distance = Mag
								end
							end
							Left = ClosestPart
							ClosestPart = nil
							Distance = math.huge
							for i2, Pos in next, Parts do
								local Mag = (Pos - Vector2new(CurrentCamera.ViewportSize.X, Tuple.Y)).Magnitude;
								if (Mag <= Distance) then
									ClosestPart = Pos
									Distance = Mag
								end
							end
							Right = ClosestPart
							ClosestPart = nil
							Distance = math.huge

							PlayerDrawings.Box.PointA = Vector2new(Right.X, Top.Y);
							PlayerDrawings.Box.PointB = Vector2new(Left.X, Top.Y);
							PlayerDrawings.Box.PointC = Vector2new(Left.X, Bottom.Y);
							PlayerDrawings.Box.PointD = Vector2new(Right.X, Bottom.Y);
						end

						if (EspSettings.TeamColors) then
							local TeamColor;
							if (PlayerTeam) then
								local BrickTeamColor = PlayerTeam.TeamColor
								TeamColor = BrickTeamColor.Color
							else
								TeamColor = Color3new(0.639216, 0.635294, 0.647059);
							end
							PlayerDrawings.Text.Color = TeamColor
							PlayerDrawings.Box.Color = TeamColor
							PlayerDrawings.Tracer.Color = TeamColor
						end

						PlayerDrawings.Text.Visible = true
						PlayerDrawings.Box.Visible = EspSettings.BoxEsp
						PlayerDrawings.Tracer.Visible = EspSettings.TracersEnabled
					else
						PlayerDrawings.Text.Visible = false
						PlayerDrawings.Box.Visible = false
						PlayerDrawings.Tracer.Visible = false
					end
				else
					PlayerDrawings.Text.Visible = false
					PlayerDrawings.Box.Visible = false
					PlayerDrawings.Tracer.Visible = false
				end
			end

			return unpack(Closest);
		end

		local Locked, SwitchedCamera = false, false
		UserInputService.InputBegan:Connect(function(Inp)
			if (AimbotSettings.Enabled and Inp.UserInputType == Enum.UserInputType.MouseButton2) then
				Locked = true
				if (AimbotSettings.FirstPerson and LocalPlayer.CameraMode ~= Enum.CameraMode.LockFirstPerson) then
					LocalPlayer.CameraMode = Enum.CameraMode.LockFirstPerson
					SwitchedCamera = true
				end
			end
		end);
		UserInputService.InputEnded:Connect(function(Inp)
			if (AimbotSettings.Enabled and Inp.UserInputType == Enum.UserInputType.MouseButton2) then
				Locked = false
				if (SwitchedCamera) then
					LocalPlayer.CameraMode = Enum.CameraMode.Classic
				end
			end
		end);

		local ClosestCharacter, Vector, Player, Aimlock;
		RunService.RenderStepped:Connect(function()

			if (Locked and AimbotSettings.Enabled) then
				ClosestCharacter, Vector, Player, Aimlock = GetClosestPlayerAndRender();
				if ClosestCharacter then
					if (AimbotSettings.FirstPerson) then
						if (syn) then
							CurrentCamera.CoordinateFrame = CFramenew(CurrentCamera.CoordinateFrame.p, Aimlock.Position);
						else
							mousemoverel((Vector.X - MouseVector.X) / AimbotSettings.Smoothness, (Vector.Y - MouseVector.Y) / AimbotSettings.Smoothness);
						end
					elseif (AimbotSettings.ThirdPerson) then
						mousemoveabs(Vector.X, Vector.Y);
					end
				end
			end
		end);

		local Hooks = {
			HookedFunctions = {},
			OldMetaMethods = {},
			MetaMethodHooks = {},
			HookedSignals = {}
		}

		local OtherDeprecated = {
			children = "GetChildren"
		}

		local RealMethods = {}
		local FakeMethods = {}

		local HookedFunctions = Hooks.HookedFunctions
		local MetaMethodHooks = Hooks.MetaMethodHooks
		local OldMetaMethods = Hooks.OldMetaMethods

		local randomised = random(1, 10);
		local randomisedVector = Vector3new(random(1, 10), random(1, 10), random(1, 10));
		Mouse.Move:Connect(function()
			randomised = random(1, 10);
			randomisedVector = Vector3new(random(1, 10), random(1, 10), random(1, 10));
		end);

		local x = setmetatable({}, {
			__index = function(...)
				print("index", ...);
			end,
			__add = function(...)
				print("add", ...);
			end,
			__sub = function(...)
				print("sub", ...);
			end,
			__mul = function(...)
				print("mul", ...);
			end
		});

		MetaMethodHooks.Index = function(...)
			local __Index = OldMetaMethods.__index

			if (Player and Aimlock and ... == Mouse and not checkcaller()) then
				local CallingScript = getfenv(2).script;
				if (CallingScript.Name == "CallingScript") then
					return __Index(...);
				end

				local _Mouse, Index = ...
				if (type(Index) == 'string') then
					Index = gsub(sub(Index, 0, 100), "%z.*", "");
				end
				local PassedChance = random(1, 100) < AimbotSettings.SilentAimHitChance
				if (PassedChance and AimbotSettings.SilentAim) then
					local Parts = GetPartsObscuringTarget(CurrentCamera, {CurrentCamera.CFrame.Position, Aimlock.Position}, {LocalPlayer.Character, ClosestCharacter});

					Index = string.gsub(Index, "^%l", upper);
					local Hit = #Parts == 0 or AimbotSettings.Wallbang
					if (not Hit) then
						return __Index(...);
					end
					if (Index == "Target") then
						return Aimlock
					end
					if (Index == "Hit") then
						local hit = __Index(...);
						local pos = Aimlock.Position + randomisedVector / 10
						return CFramenew(pos.X, pos.Y, pos.Z, unpack({hit:components()}, 4));
					end
					if (Index == "X") then
						return Vector.X + randomised / 10
					end
					if (Index == "Y") then
						return Vector.Y + randomised / 10
					end
				end
			end

			return __Index(...);
		end

		MetaMethodHooks.Namecall = function(...)
			local __Namecall = OldMetaMethods.__namecall
			local self = ...
			local Method = gsub(getnamecallmethod() or "", "^%l", upper);
			local Hooked = HookedFunctions[Method]
			if (Hooked and self == Hooked[1]) then
				return Hooked[3](...);
			end

			return __Namecall(...);
		end

		for MMName, MMFunc in pairs(MetaMethodHooks) do
			local MetaMethod = string.format("__%s", string.lower(MMName));
			Hooks.OldMetaMethods[MetaMethod] = hookmetamethod(game, MetaMethod, MMFunc);
		end

		HookedFunctions.FindPartOnRay = {Workspace, Workspace.FindPartOnRay, function(...)
			local OldFindPartOnRay = HookedFunctions.FindPartOnRay[4]
			if (AimbotSettings.SilentAim and Player and Aimlock and not checkcaller()) then
				local PassedChance = random(1, 100) < AimbotSettings.SilentAimHitChance
				if (ClosestCharacter and PassedChance) then
					local Parts = GetPartsObscuringTarget(CurrentCamera, {CurrentCamera.CFrame.Position, Aimlock.Position}, {LocalPlayer.Character, ClosestCharacter});
					if (#Parts == 0 or AimbotSettings.Wallbang) then
						return Aimlock, Aimlock.Position + (Vector3new(random(1, 10), random(1, 10), random(1, 10)) / 10), Vector3new(0, 1, 0), Aimlock.Material
					end
				end
			end
			return OldFindPartOnRay(...);
		end};

		HookedFunctions.FindPartOnRayWithIgnoreList = {Workspace, Workspace.FindPartOnRayWithIgnoreList, function(...)
			local OldFindPartOnRayWithIgnoreList = HookedFunctions.FindPartOnRayWithIgnoreList[4]
			if (Player and Aimlock and not checkcaller()) then
				local CallingScript = getcallingscript();
				local PassedChance = random(1, 100) < AimbotSettings.SilentAimHitChance
				if (CallingScript.Name ~= "ControlModule" and ClosestCharacter and PassedChance) then
					local Parts = GetPartsObscuringTarget(CurrentCamera, {CurrentCamera.CFrame.Position, Aimlock.Position}, {LocalPlayer.Character, ClosestCharacter});
					if (#Parts == 0 or AimbotSettings.Wallbang) then
						return Aimlock, Aimlock.Position + (Vector3new(random(1, 10), random(1, 10), random(1, 10)) / 10), Vector3new(0, 1, 0), Aimlock.Material
					end
				end
			end
			return OldFindPartOnRayWithIgnoreList(...);
		end};

		for Index, Function in pairs(HookedFunctions) do
			Function[4] = hookfunction(Function[2], Function[3]);
		end

	end



	--Animal function
	if game.GameId == 2023680558 then
		function findNearestZombieTorso(pos)
			local list = game:GetService("Workspace").NPC:GetChildren()
			local torso = nil
			local dist = 1000
			local temp = nil
			local human = nil
			local temp2 = nil
			for x = 1, #list do
				temp2 = list[x]
				if temp2.Name == "Zombie" or temp2.Name == "BigSpider" then
					temp = temp2:findFirstChild("HumanoidRootPart")
					human = temp2:findFirstChild("Humanoid")
					if (temp ~= nil) and (human ~= nil) and (human.Health > 0) then
						if (temp.Position - pos).magnitude < dist then
							torso = temp
							dist = (temp.Position - pos).magnitude
						end
					end
				end
			end
			return torso
		end
	end



	local supplyCounts = {TomatoSauce=99,Cheese=99,Sausage=99,Pepperoni=99,Dough=99,Box=99,Dew=99}
	local player = game:GetService("Players").LocalPlayer
	local ffc = game.FindFirstChild
	local RNG = Random.new()
	local network
	local character,root
	local boxPtick=0
	local boxDtick=0
	local delTool
	local delTouched=false
	local bcolorToSupply = {["Dark orange"]="Sausage",["Bright blue"]="Pepperoni",["Bright yellow"]="Cheese",["Bright red"]="TomatoSauce",["Dark green"]="Dew",["Brick yellow"]="Dough",["Light stone grey"]="Box",["Really black"]="Dew"}
	local supplyButtons = {}

	--Work at a pizza place func
	if game.GameId == 47545 then

		for _,button in ipairs(workspace.SupplyButtons:GetChildren()) do
			supplyButtons[bcolorToSupply[button.Unpressed.BrickColor.Name]] = button.Unpressed
		end

		do
			local reg = (getreg or debug.getregistry)()
			for i=1,#reg do
				local f = reg[i]
				if type(f)=="function" and tostring(getfenv(f).script)=="Paycheck" then
					for k,v in next,getupvalues(f) do
						if tostring(v) == "CashOut" then
							setupvalue(f,k,{MouseButton1Click={wait=function()end,Wait=function()end}})
							break
						end
					end
				elseif type(f)=="table" and rawget(f,"FireServer") and rawget(f,"BindEvents") then
					network = f
				end
			end
			local mt=getrawmetatable(game)
			if setreadonly then
				setreadonly(mt,false)
			elseif make_writeable then
				make_writeable(mt)
			end
			local old__newindex=mt.__newindex
			if newcclosure then
				mt.__newindex=newcclosure(function(t,k,v)
					if t~=workspace.CurrentCamera or tostring(getfenv(2).script)~="LocalMain" then
						return old__newindex(t,k,v)
					end
				end)
			else
				mt.__newindex=function(t,k,v)
					if t~=workspace.CurrentCamera or tostring(getfenv(2).script)~="LocalMain" then
						return old__newindex(t,k,v)
					end
				end
			end
			workspace.Main.RealignCamera.RealignCamera:Destroy()
			Instance.new("BindableEvent",workspace.Main.RealignCamera).Name="RealignCamera"
		end
		assert(network,"failed to find network")

		function onCharacterAdded(char)
			if not char then return end
			character=char
			root = character:WaitForChild("HumanoidRootPart")
			character:WaitForChild("Humanoid"):GetPropertyChangedSignal("WalkSpeed"):Connect(function()
				if delTool then
					character.Humanoid.WalkSpeed=16
				end
			end)
		end
		onCharacterAdded(player.Character or player.CharacterAdded:Wait())
		player.CharacterAdded:Connect(onCharacterAdded)


		for name in pairs(supplyCounts) do
			local lbl = workspace.SupplyCounters[name=="Dew" and "CounterMountainDew" or "Counter"..name].a.SG.Counter
			supplyCounts[name]=tonumber(lbl.Text)
			lbl.Changed:Connect(function()
				supplyCounts[name]=tonumber(lbl.Text)
			end)
		end

		function FindFirstCustomer()
			local children = workspace.Customers:GetChildren()
			for i=1,#children do
				local c = children[i]
				if ffc(c,"Head") and ffc(c,"Humanoid") and c.Head.CFrame.Z<102 and ffc(c.Head,"Dialog") and ffc(c.Head.Dialog,"Correct") and ((c.Humanoid.SeatPart and c.Humanoid.SeatPart.Anchored) or (c.Humanoid.SeatPart==nil and (c.Head.Velocity.Z^2)^.5<.0001)) then
					return c

				end
			end
		end



		function getOrders()
			local orders={}
			local tempCookingDict = {}
			for i,v in pairs(cookingDict) do tempCookingDict[i]=v end
			local children = workspace.Orders:GetChildren()
			for i=1,#children do
				local o = orderDict[children[i].SG.ImageLabel.Image:match("%d+$")]
				if o then
					if tempCookingDict[o]>0 then
						--ignores oven pizzas, so new orders are priority
						tempCookingDict[o]=tempCookingDict[o]-1
					elseif (o=="Dew" and #workspace.AllMountainDew:GetChildren()>0) or (supplyCounts[o]>0 and supplyCounts.TomatoSauce>0 and supplyCounts.Cheese>0) then
						--need supplies
						orders[#orders+1]=o
					end
				end
			end
			return orders
		end

		function FindFirstDew()
			local children = workspace.AllMountainDew:GetChildren()
			for i=1,#children do
				if not children[i].Anchored then
					return children[i]
				end
			end
		end

		function FindDoughAndWithout(str)
			local goodraw,p,raw,trash
			local children = workspace.AllDough:GetChildren()
			for i = #children, 2, -1 do --shuffle
				local j = RNG:NextInteger(1, i)
				children[j], children[i] = children[i], children[j]
			end
			for i=1,#children do
				local d = children[i]
				if d.Anchored==false and #d:GetChildren()>9 then
					if d.IsBurned.Value or d.HasBugs.Value or d.Cold.Value or (d.BrickColor.Name=="Bright orange" and ffc(d,"XBillboard")) then
						if trash==nil and d.Position.Y > 0 then
							trash=d
						end
					elseif p==nil and d.BrickColor.Name=="Bright orange" then
						p=d
					elseif goodraw==nil and d.Position.X<55 and d.BrickColor.Name=="Brick yellow" and ((str and not ffc(d.SG.Frame,str)) or (str==nil and ffc(d.SG.Frame,"Sausage")==nil and ffc(d.SG.Frame,"Pepperoni")==nil)) then
						--prefers flat
						if d.Mesh.Scale.Y<1.1 then
							goodraw=d
						else
							raw=d
						end
					end
					if goodraw and p and trash then
						return goodraw,p,trash
					end
				end
			end
			return goodraw or raw,p,trash
		end

		function getOvenNear(pos)
			local children = workspace.Ovens:GetChildren()
			for i=1,#children do
				if (children[i].Bottom.Position-pos).magnitude < 1.5 then
					return children[i]
				end
			end
		end
		function getDoughNear(pos)
			local children = workspace.AllDough:GetChildren()
			for i=1,#children do
				if (children[i].Position-pos).magnitude < 1.5 then
					return children[i]
				end
			end
		end
		function isFullyOpen(oven)
			return oven.IsOpen.Value==true and (oven.Door.Meter.RotVelocity.Z^2)^.5<.0001
		end

		function FindBoxes()
			local c,o,f
			local children = workspace.AllBox:GetChildren()
			for i=1,#children do
				local b = children[i]
				if ffc(b,"HasPizzaInside") or ffc(b,"Pizza") then
					if c==nil and b.Name=="BoxClosed" and b.Anchored==false and not b.HasPizzaInside.Value then
						c=b
					elseif o==nil and b.Name=="BoxOpen" and b.Anchored==false and not b.Pizza.Value then
						o=b
					elseif f==nil and (b.Name=="BoxOpen" and b.Pizza.Value) or (b.Name=="BoxClosed" and b.HasPizzaInside.Value) then
						f=b
					end
					if c and o and f then
						return c,o,f
					end
				end
			end
			return c,o,f
		end

		function FindBoxingFoods()
			local p,d
			local children = workspace.BoxingRoom:GetChildren()
			for i=1,#children do
				local f = children[i]
				if not f.Anchored then
					if p==nil and f.Name=="Pizza" then
						p=f
					elseif d==nil and f.Name=="Dew" then
						d=f
					end
					if p and d then
						return p,d
					end
				end
			end
			return p,d
		end


		function FindFirstDeliveryTool()
			local t
			local children = workspace:GetChildren()
			for i=1,#children do
				local v = children[i]
				if v.ClassName=="Tool" and v.Name:match("^%u%d$") and ffc(v,"House") and ffc(v,"Handle") and ffc(v,"Order") and v.Order.Value:match("%a") then
					if ffc(v.Handle,"X10") then
						return v
					end
					t = v
				end
			end
			return t
		end
		function getHousePart(address)
			local houses = workspace.Houses:GetChildren()
			for i=1,#houses do
				local h = houses[i]
				if ffc(h,"Address") and h.Address.Value==address and ffc(h,"CurrentUpgrade") and h.CurrentUpgrade.Value and ffc(h.CurrentUpgrade.Value,"GivePizza") then
					return h.CurrentUpgrade.Value.GivePizza
				end
			end
		end
		local delTouched=false
		function forgetDeliveryTool()
			if delTool then
				if delTool.Parent==player.Backpack then
					delTool.Parent = character
				end
				if delTool.Parent==character then
					wait(0.1)
					delTool.Parent = workspace
					wait(0.1)
				end
			end
			delTool=nil
			delTouched=false
			if ffc(character,"RightHand") and ffc(character.RightHand,"RightGrip") then
				character.RightHand.RightGrip:Destroy()
			end
		end

		function simTouch(part)
			local oldcc = part.CanCollide
			local oldcf = part.CFrame
			part.CanCollide = false
			root.CFrame = part.CFrame
			delay(0.01,function()
				part.CFrame = oldcf
				part.CanCollide = oldcc
			end)
		end
	end


	local function toggleInvisibleWall()
		if not invisibleWallsShowed then
			invisibleWallsShowed = true

			for i, v in pairs(workspace:GetDescendants()) do
				if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("WedgePart") or v:IsA("UnionOperator") then
					if v.Transparency == 1 then
						table.insert(invisibleWallTable, 1, v)
						v.BrickColor = BrickColor.new("Yellow flip/flop")
						v.Transparency = 0.5
					end
				end
			end

		else
			invisibleWallsShowed = false
			for i, v in pairs(invisibleWallTable) do
				if v then
					v.Transparency = 1
				end
			end

			invisibleWallTable = {}
		end
	end

	--Infinite yield


	function respawn(plr)
		--if invisRunning then TurnVisible() end
		local char = plr.Character
		if char:FindFirstChildOfClass("Humanoid") then char:FindFirstChildOfClass("Humanoid"):ChangeState(15) end
		char:ClearAllChildren()
		local newChar = Instance.new("Model")
		newChar.Parent = workspace
		plr.Character = newChar
		wait()
		plr.Character = char
		newChar:Destroy()
	end

	local refreshCmd = false
	function refresh(plr)
		refreshCmd = true
		local Human = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid", true)
		local pos = Human and Human.RootPart and Human.RootPart.CFrame
		local pos1 = workspace.CurrentCamera.CFrame
		respawn(plr)
		task.spawn(function()
			plr.CharacterAdded:Wait():WaitForChild("Humanoid").RootPart.CFrame, workspace.CurrentCamera.CFrame = pos, wait() and pos1
			refreshCmd = false
		end)
	end

	function getRoot(char)
		local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
		return rootPart
	end

	function tools(plr)
		if plr:FindFirstChildOfClass("Backpack"):FindFirstChildOfClass('Tool') or plr.Character:FindFirstChildOfClass('Tool') then
			return true
		end
	end

	function attach(speaker,target)
		if tools(speaker) then
			local char = speaker.Character
			local tchar = target
			local hum = speaker.Character:FindFirstChildOfClass("Humanoid")
			local hrp = getRoot(speaker.Character)
			local hrp2 = getRoot(target)
			hum.Name = "1"
			local newHum = hum:Clone()
			newHum.Parent = char
			newHum.Name = "Humanoid"
			wait()
			hum:Destroy()
			workspace.CurrentCamera.CameraSubject = char
			newHum.DisplayDistanceType = "None"
			local tool = speaker:FindFirstChildOfClass("Backpack"):FindFirstChildOfClass("Tool") or speaker.Character:FindFirstChildOfClass("Tool")
			tool.Parent = char
			hrp.CFrame = hrp2.CFrame * CFrame.new(0, 0, 0) * CFrame.new(math.random(-100, 100)/200,math.random(-100, 100)/200,math.random(-100, 100)/200)
			local n = 0
			repeat
				wait(.1)
				n = n + 1
				hrp.CFrame = hrp2.CFrame
			until (tool.Parent ~= char or not hrp or not hrp2 or not hrp.Parent or not hrp2.Parent or n > 250) and n > 2
		else
			venyx.notify("Error", 'Tool Required','You need to have an item in your inventory to use this command')
		end
	end

	function bring(speaker,target,fast)
		if tools(speaker) then
			if target ~= nil then
				local NormPos = getRoot(speaker.Character).CFrame
				if not fast then
					refresh(speaker)
					wait()
					repeat wait() until speaker.Character ~= nil and getRoot(speaker.Character)
					wait(0.3)
				end
				local hrp = getRoot(speaker.Character)
				attach(speaker,target)
				repeat
					wait()
					hrp.CFrame = NormPos
				until not getRoot(target) or not getRoot(speaker.Character)
				wait(game.Players.RespawnTime)
				speaker.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = NormPos
			end
		else
			venyx.notify("Error", 'Tool Required','You need to have an item in your inventory to use this command')
		end
	end

	function kill(speaker,target,fast)
		if tools(speaker) then
			if target ~= nil then
				local NormPos = getRoot(speaker.Character).CFrame
				if not fast then
					refresh(speaker)
					wait()
					repeat wait() until speaker.Character ~= nil and getRoot(speaker.Character)
					wait(0.3)
				end
				local hrp = getRoot(speaker.Character)
				attach(speaker,target)
				repeat
					wait()
					hrp.CFrame = CFrame.new(999999, workspace.FallenPartsDestroyHeight + 5,999999)
				until not getRoot(target.Character) or not getRoot(speaker.Character)
				wait(1)
				speaker.CharacterAdded:Wait():WaitForChild("HumanoidRootPart").CFrame = NormPos
			end
		else
			notify('Tool Required','You need to have an item in your inventory to use this command')
		end
	end

	spawn(function()
		while wait() do
			if FollowBot then
				local plrtrack = game.Players:FindFirstChild(tpPlayerFocus)
				if plrtrack and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					local path = game:GetService("PathfindingService"):ComputeRawPathAsync(game.Players.LocalPlayer.Character.HumanoidRootPart.Position,plrtrack.Character.HumanoidRootPart.Position,512)
					if path.Status == Enum.PathStatus.Success then
						local points = path:GetPointCoordinates()
						if #points < 3 then
							game.Players.LocalPlayer.Character.Humanoid:MoveTo(plrtrack.Character.HumanoidRootPart.Position)
						else
							game.Players.LocalPlayer.Character.Humanoid:MoveTo(points[3])
						end
					else
						game.Players.LocalPlayer.Character.Humanoid:MoveTo(plrtrack.Character.HumanoidRootPart.Position)
					end
				end
			end

			if not alive then
				break
			end
		end
	end)


	--DefaultSet
	DefaultSky = GetDefaultSky()
	if DefaultSky then
		DefaultSkyStat = {DefaultSky.CelestialBodiesShown, DefaultSky.MoonAngularSize, DefaultSky.MoonTextureId, DefaultSky.SkyboxBk, DefaultSky.SkyboxDn, DefaultSky.SkyboxFt, DefaultSky.SkyboxLf, DefaultSky.SkyboxRt, DefaultSky.SkyboxUp, DefaultSky.StarCount, DefaultSky.SunAngularSize, DefaultSky.SunTextureId}

	end

	local MusicIdToPlay = Instance.new("Sound", game.CoreGui)
	MusicIdToPlay.Name = "FoxiMusic"
	MusicIdToPlay.Looped = true




	local ScreenGui = game.CoreGui:FindFirstChild(name)


	-- CHARACTER
	local page = venyx:addPage("Character", 8988743366)
	local BasicHack = page:addSection("Basic hack")
	local CustomTools = page:addSection("Custom tools")
	local HumanoidStat = page:addSection("Humanoid stat")
	local TeleportPage = page:addSection("Player utility")
	--local BotPage = page:addSection("Bot")
	local FunPage = page:addSection("Fun")
	local GameAddonPage = page:addSection("GameAddon")

	BasicHack:addToggle("infinity jump", nil, function(value)
		infiniJump = value
	end)

	BasicHack:addToggle("Jetpack", nil, function(value)
		jetpack = value
	end)


	BasicHack:addToggle("noclip", nil, function(value)
		noclip = value
	end)

	invisRunning = false
	BasicHack:addToggle("Invisible", nil, function(value)
		if value then
			if invisRunning then return end
			invisRunning = true
			-- Full credit to AmokahFox @V3rmillion
			local Player = game.Players.LocalPlayer
			repeat wait(.1) until Player.Character
			local Character = Player.Character
			Character.Archivable = true
			local IsInvis = false
			local IsRunning = true
			local InvisibleCharacter = Character:Clone()
			InvisibleCharacter.Parent = game:GetService'Lighting'
			local Void = workspace.FallenPartsDestroyHeight
			InvisibleCharacter.Name = ""
			local CF

			local invisFix = game:GetService("RunService").Stepped:Connect(function()
				pcall(function()
					local IsInteger
					if tostring(Void):find'-' then
						IsInteger = true
					else
						IsInteger = false
					end
					local Pos = Player.Character.HumanoidRootPart.Position
					local Pos_String = tostring(Pos)
					local Pos_Seperate = Pos_String:split(', ')
					local X = tonumber(Pos_Seperate[1])
					local Y = tonumber(Pos_Seperate[2])
					local Z = tonumber(Pos_Seperate[3])
					if IsInteger == true then
						if Y <= Void then
							Respawn()
						end
					elseif IsInteger == false then
						if Y >= Void then
							Respawn()
						end
					end
				end)
			end)

			for i,v in pairs(InvisibleCharacter:GetDescendants())do
				if v:IsA("BasePart") then
					if v.Name == "HumanoidRootPart" then
						v.Transparency = 1
					else
						v.Transparency = .5
					end
				end
			end

			function Respawn()
				IsRunning = false
				if IsInvis == true then
					pcall(function()
						Player.Character = Character
						wait()
						Character.Parent = workspace
						Character:FindFirstChildWhichIsA'Humanoid':Destroy()
						IsInvis = false
						InvisibleCharacter.Parent = nil
						invisRunning = false
					end)
				elseif IsInvis == false then
					pcall(function()
						Player.Character = Character
						wait()
						Character.Parent = workspace
						Character:FindFirstChildWhichIsA'Humanoid':Destroy()
						TurnVisible()
					end)
				end
			end

			local invisDied
			invisDied = InvisibleCharacter:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
				Respawn()
				invisDied:Disconnect()
			end)

			if IsInvis == true then return end
			IsInvis = true
			CF = workspace.CurrentCamera.CFrame
			local CF_1 = Player.Character.HumanoidRootPart.CFrame
			Character:MoveTo(Vector3.new(0,math.pi*1000000,0))
			workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
			wait(.2)
			workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
			InvisibleCharacter = InvisibleCharacter
			Character.Parent = game:GetService'Lighting'
			InvisibleCharacter.Parent = workspace
			InvisibleCharacter.HumanoidRootPart.CFrame = CF_1
			Player.Character = InvisibleCharacter
			workspace.CurrentCamera.CameraSubject = Player.Character
			workspace.CurrentCamera:remove()
			wait(.1)
			repeat wait() until Player.Character ~= nil
			workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChildWhichIsA('Humanoid')
			workspace.CurrentCamera.CameraType = "Custom"
			Player.CameraMinZoomDistance = 0.5
			Player.CameraMaxZoomDistance = 400
			Player.CameraMode = "Classic"
			Player.Character.Head.Anchored = false
			Player.Character.Animate.Disabled = true
			Player.Character.Animate.Disabled = false

			function TurnVisible()
				if IsInvis == false then return end
				invisFix:Disconnect()
				invisDied:Disconnect()
				CF = workspace.CurrentCamera.CFrame
				Character = Character
				local CF_1 = Player.Character.HumanoidRootPart.CFrame
				Character.HumanoidRootPart.CFrame = CF_1
				InvisibleCharacter:Destroy()
				Player.Character = Character
				Character.Parent = workspace
				IsInvis = false
				Player.Character.Animate.Disabled = true
				Player.Character.Animate.Disabled = false
				invisDied = Character:FindFirstChildOfClass'Humanoid'.Died:Connect(function()
					Respawn()
					invisDied:Disconnect()
				end)
				invisRunning = false
			end
		else

			TurnVisible()
		end
	end)

	BasicHack:addToggle("key to teleport", nil, function(value)
		eToTeleport = value
	end)

	BasicHack:addKeybind("TeleportKey : ", Enum.KeyCode.E, function()
		local mouse = game.Players.LocalPlayer:GetMouse()
		if mouse.Target then
			if eToTeleport then
				-- Script generated by SimpleSpy - credits to exx#9394

				--wait(
				local pos = Vector3.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(pos)
			end
		end
	end)

	BasicHack:addToggle("Anchored", nil, function(value)
		if value then
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
		else
			game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
		end
	end)

	CustomTools:addButton("Give btools", function()
		a = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
		a.BinType = 2
		b = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
		b.BinType = 3
		c = Instance.new("HopperBin", game.Players.LocalPlayer.Backpack)
		c.BinType = 4
	end)

	CustomTools:addButton("Give gravity gun", function()
		--Physics gun
		function sandbox(var,func)
			local env = getfenv(func)
			local newenv = setmetatable({},{
				__index = function(self,k)
					if k=="script" then
						return var
					else
						return env[k]
					end
				end,
			})
			setfenv(func,newenv)
			return func
		end
		cors = {}
		mas = Instance.new("Model",game:GetService("Lighting"))
		Tool0 = Instance.new("Tool")
		Part1 = Instance.new("Part")
		CylinderMesh2 = Instance.new("CylinderMesh")
		Part3 = Instance.new("Part")
		LocalScript4 = Instance.new("LocalScript")
		Script5 = Instance.new("Script")
		LocalScript6 = Instance.new("LocalScript")
		Script7 = Instance.new("Script")
		LocalScript8 = Instance.new("LocalScript")
		Part9 = Instance.new("Part")
		Script10 = Instance.new("Script")
		Part11 = Instance.new("Part")
		Script12 = Instance.new("Script")
		Part13 = Instance.new("Part")
		Script14 = Instance.new("Script")
		Tool0.Name = "Physics Gun"
		Tool0.Parent = mas
		Tool0.CanBeDropped = false
		Part1.Name = "Handle"
		Part1.Parent = Tool0
		Part1.Material = Enum.Material.Neon
		Part1.BrickColor = BrickColor.new("Cyan")
		Part1.Transparency = 1
		Part1.Rotation = Vector3.new(0, 15.4200001, 0)
		Part1.CanCollide = false
		Part1.FormFactor = Enum.FormFactor.Custom
		Part1.Size = Vector3.new(1, 0.400000036, 0.300000012)
		Part1.CFrame = CFrame.new(-55.2695465, 0.696546972, 0.383156985, 0.96399641, -4.98074878e-05, 0.265921414, 4.79998416e-05, 1, 1.32960558e-05, -0.265921414, -5.30653779e-08, 0.96399641)
		Part1.BottomSurface = Enum.SurfaceType.Smooth
		Part1.TopSurface = Enum.SurfaceType.Smooth
		Part1.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		Part1.Position = Vector3.new(-55.2695465, 0.696546972, 0.383156985)
		Part1.Orientation = Vector3.new(0, 15.4200001, 0)
		Part1.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		CylinderMesh2.Parent = Part1
		CylinderMesh2.Scale = Vector3.new(0.100000001, 0.100000001, 0.100000001)
		CylinderMesh2.Scale = Vector3.new(0.100000001, 0.100000001, 0.100000001)
		Part3.Name = "Shoot"
		Part3.Parent = Tool0
		Part3.Material = Enum.Material.Neon
		Part3.BrickColor = BrickColor.new("Cyan")
		Part3.Reflectance = 0.30000001192093
		Part3.Transparency = 1
		Part3.Rotation = Vector3.new(90.9799957, 0.25999999, -91.409996)
		Part3.CanCollide = false
		Part3.FormFactor = Enum.FormFactor.Custom
		Part3.Size = Vector3.new(0.200000003, 0.25, 0.310000032)
		Part3.CFrame = CFrame.new(-54.7998123, 0.774299085, -0.757350147, -0.0245519895, 0.99968797, 0.00460194098, 0.0169109926, 0.00501798885, -0.999844491, -0.999555528, -0.0244703442, -0.0170289185)
		Part3.BottomSurface = Enum.SurfaceType.Smooth
		Part3.TopSurface = Enum.SurfaceType.Smooth
		Part3.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		Part3.Position = Vector3.new(-54.7998123, 0.774299085, -0.757350147)
		Part3.Orientation = Vector3.new(88.9899979, 164.87999, 73.4700012)
		Part3.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		LocalScript4.Parent = Tool0
		table.insert(cors,sandbox(LocalScript4,function()
			-- Variables for services
			local render = game:GetService("RunService").RenderStepped
			local contextActionService = game:GetService("ContextActionService")
			local userInputService = game:GetService("UserInputService")

			local player = game.Players.LocalPlayer
			local mouse = player:GetMouse()
			local Tool = script.Parent

			-- Variables for Module Scripts
			local screenSpace = require(Tool:WaitForChild("ScreenSpace"))

			local connection
			-- Variables for character joints

			local neck, shoulder, oldNeckC0, oldShoulderC0 

			local mobileShouldTrack = true

			-- Thourough check to see if a character is sitting
			local function amISitting(character)
				local t = character.Torso
				for _, part in pairs(t:GetConnectedParts(true)) do
					if part:IsA("Seat") or part:IsA("VehicleSeat") then
						return true
					end
				end
			end

			-- Function to call on renderstepped. Orients the character so it is facing towards
			-- the player mouse's position in world space. If character is sitting then the torso
			-- should not track
			local function frame(mousePosition)
				-- Special mobile consideration. We don't want to track if the user was touching a ui
				-- element such as the movement controls. Just return out of function if so to make sure
				-- character doesn't track
				if not mobileShouldTrack then return end

				-- Make sure character isn't swiming. If the character is swimming the following code will
				-- not work well; the character will not swim correctly. Besides, who shoots underwater?
				if player.Character.Humanoid:GetState() ~= Enum.HumanoidStateType.Swimming then
					local torso = player.Character.Torso
					local head = player.Character.Head

					local toMouse = (mousePosition - head.Position).unit
					local angle = math.acos(toMouse:Dot(Vector3.new(0,1,0)))

					local neckAngle = angle

					-- Limit how much the head can tilt down. Too far and the head looks unnatural
					if math.deg(neckAngle) > 110 then
						neckAngle = math.rad(110)
					end
					neck.C0 = CFrame.new(0,1,0) * CFrame.Angles(math.pi - neckAngle,math.pi,0)

					-- Calculate horizontal rotation
					local arm = player.Character:FindFirstChild("Right Arm")
					local fromArmPos = torso.Position + torso.CFrame:vectorToWorldSpace(Vector3.new(
						torso.Size.X/2 + arm.Size.X/2, torso.Size.Y/2 - arm.Size.Z/2, 0))
					local toMouseArm = ((mousePosition - fromArmPos) * Vector3.new(1,0,1)).unit
					local look = (torso.CFrame.lookVector * Vector3.new(1,0,1)).unit
					local lateralAngle = math.acos(toMouseArm:Dot(look))		

					-- Check for rogue math
					if tostring(lateralAngle) == "-1.#IND" then
						lateralAngle = 0
					end		

					-- Handle case where character is sitting down
					if player.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then			

						local cross = torso.CFrame.lookVector:Cross(toMouseArm)
						if lateralAngle > math.pi/2 then
							lateralAngle = math.pi/2
						end
						if cross.Y < 0 then
							lateralAngle = -lateralAngle
						end
					end	

					-- Turn shoulder to point to mouse
					shoulder.C0 = CFrame.new(1,0.5,0) * CFrame.Angles(math.pi/2 - angle,math.pi/2 + lateralAngle,0)	

					-- If not sitting then aim torso laterally towards mouse
					if not amISitting(player.Character) then
						torso.CFrame = CFrame.new(torso.Position, torso.Position + (Vector3.new(
							mousePosition.X, torso.Position.Y, mousePosition.Z)-torso.Position).unit)
					else
						--print("sitting")		
					end	
				end
			end

			-- Function to bind to render stepped if player is on PC
			local function pcFrame()
				frame(mouse.Hit.p)
			end

			-- Function to bind to touch moved if player is on mobile
			local function mobileFrame(touch, processed)
				-- Check to see if the touch was on a UI element. If so, we don't want to update anything
				if not processed then
					-- Calculate touch position in world space. Uses Stravant's ScreenSpace Module script
					-- to create a ray from the camera.
					local test = screenSpace.ScreenToWorld(touch.Position.X, touch.Position.Y, 1)
					local nearPos = game.Workspace.CurrentCamera.CoordinateFrame:vectorToWorldSpace(screenSpace.ScreenToWorld(touch.Position.X, touch.Position.Y, 1))
					nearPos = game.Workspace.CurrentCamera.CoordinateFrame.p - nearPos
					local farPos = screenSpace.ScreenToWorld(touch.Position.X, touch.Position.Y,50) 
					farPos = game.Workspace.CurrentCamera.CoordinateFrame:vectorToWorldSpace(farPos) * -1
					if farPos.magnitude > 900 then
						farPos = farPos.unit * 900
					end
					local ray = Ray.new(nearPos, farPos)
					local part, pos = game.Workspace:FindPartOnRay(ray, player.Character)

					-- if a position was found on the ray then update the character's rotation
					if pos then
						frame(pos)
					end
				end
			end

			local oldIcon = nil
			-- Function to bind to equip event
			local function equip()
				local torso = player.Character.Torso

				-- Setup joint variables
				neck = torso.Neck	
				oldNeckC0 = neck.C0
				shoulder = torso:FindFirstChild("Right Shoulder")
				oldShoulderC0 = shoulder.C0

				-- Remember old mouse icon and update current
				oldIcon = mouse.Icon
				mouse.Icon = "rbxassetid:// 509381906"

				-- Bind TouchMoved event if on mobile. Otherwise connect to renderstepped
				if userInputService.TouchEnabled then
					connection = userInputService.TouchMoved:connect(mobileFrame)
				else
					connection = render:connect(pcFrame)
				end

				-- Bind TouchStarted and TouchEnded. Used to determine if character should rotate
				-- during touch input
				userInputService.TouchStarted:connect(function(touch, processed)
					mobileShouldTrack = not processed
				end)	
				userInputService.TouchEnded:connect(function(touch, processed)
					mobileShouldTrack = false
				end)

				-- Fire server's equip event
				game.ReplicatedStorage.ROBLOX_PistolEquipEvent:FireServer()

				-- Bind event for when mouse is clicked to fire server's fire event
				mouse.Button1Down:connect(function()
					game.ReplicatedStorage.ROBLOX_PistolFireEvent:FireServer(mouse.Hit.p)
				end)

				-- Bind reload event to mobile button and r key
				contextActionService:BindActionToInputTypes("Reload", function() 
					game.ReplicatedStorage.ROBLOX_PistolReloadEvent:FireServer()		
				end, true, "")

				-- If game uses filtering enabled then need to update server while tool is
				-- held by character.
				if workspace.FilteringEnabled then
					while connection do
						wait()
						game.ReplicatedStorage.ROBLOX_PistolUpdateEvent:FireServer(neck.C0, shoulder.C0)
					end
				end
			end

			-- Function to bind to Unequip event
			local function unequip()
				if connection then connection:disconnect() end
				contextActionService:UnbindAction("Reload")
				game.ReplicatedStorage.ROBLOX_PistolUnequipEvent:FireServer()
				mouse.Icon = oldIcon
				neck.C0 = oldNeckC0
				shoulder.C0 = oldShoulderC0
			end

			-- Bind tool events
			Tool.Equipped:connect(equip)
			Tool.Unequipped:connect(unequip)
		end))
		Script5.Name = "qPerfectionWeld"
		Script5.Parent = Tool0
		table.insert(cors,sandbox(Script5,function()
			-- Created by Quenty (@Quenty, follow me on twitter).
			-- Should work with only ONE copy, seamlessly with weapons, trains, et cetera.
			-- Parts should be ANCHORED before use. It will, however, store relatives values and so when tools are reparented, it'll fix them.

--[[ INSTRUCTIONS
- Place in the model
- Make sure model is anchored
- That's it. It will weld the model and all children. 

THIS SCRIPT SHOULD BE USED ONLY BY ITSELF. THE MODEL SHOULD BE ANCHORED. 
THIS SCRIPT SHOULD BE USED ONLY BY ITSELF. THE MODEL SHOULD BE ANCHORED. 
THIS SCRIPT SHOULD BE USED ONLY BY ITSELF. THE MODEL SHOULD BE ANCHORED. 
THIS SCRIPT SHOULD BE USED ONLY BY ITSELF. THE MODEL SHOULD BE ANCHORED. 
THIS SCRIPT SHOULD BE USED ONLY BY ITSELF. THE MODEL SHOULD BE ANCHORED. 
THIS SCRIPT SHOULD BE USED ONLY BY ITSELF. THE MODEL SHOULD BE ANCHORED. 
THIS SCRIPT SHOULD BE USED ONLY BY ITSELF. THE MODEL SHOULD BE ANCHORED. 
THIS SCRIPT SHOULD BE USED ONLY BY ITSELF. THE MODEL SHOULD BE ANCHORED. 

This script is designed to be used is a regular script. In a local script it will weld, but it will not attempt to handle ancestory changes. 
]]

--[[ DOCUMENTATION
- Will work in tools. If ran more than once it will not create more than one weld.  This is especially useful for tools that are dropped and then picked up again.
- Will work in PBS servers
- Will work as long as it starts out with the part anchored
- Stores the relative CFrame as a CFrame value
- Takes careful measure to reduce lag by not having a joint set off or affected by the parts offset from origin
- Utilizes a recursive algorith to find all parts in the model
- Will reweld on script reparent if the script is initially parented to a tool.
- Welds as fast as possible
]]

			-- qPerfectionWeld.lua
			-- Created 10/6/2014
			-- Author: Quenty
			-- Version 1.0.3

			-- Updated 10/14/2014 - Updated to 1.0.1
			--- Bug fix with existing ROBLOX welds ? Repro by asimo3089

			-- Updated 10/14/2014 - Updated to 1.0.2
			--- Fixed bug fix. 

			-- Updated 10/14/2014 - Updated to 1.0.3
			--- Now handles joints semi-acceptably. May be rather hacky with some joints. :/

			local NEVER_BREAK_JOINTS = false -- If you set this to true it will never break joints (this can create some welding issues, but can save stuff like hinges).


			local function CallOnChildren(Instance, FunctionToCall)
				-- Calls a function on each of the children of a certain object, using recursion.  

				FunctionToCall(Instance)

				for _, Child in next, Instance:GetChildren() do
					CallOnChildren(Child, FunctionToCall)
				end
			end

			local function GetNearestParent(Instance, ClassName)
				-- Returns the nearest parent of a certain class, or returns nil

				local Ancestor = Instance
				repeat
					Ancestor = Ancestor.Parent
					if Ancestor == nil then
						return nil
					end
				until Ancestor:IsA(ClassName)

				return Ancestor
			end

			local function GetBricks(StartInstance)
				local List = {}

				-- if StartInstance:IsA("BasePart") then
				-- 	List[#List+1] = StartInstance
				-- end

				CallOnChildren(StartInstance, function(Item)
					if Item:IsA("BasePart") then
						List[#List+1] = Item;
					end
				end)

				return List
			end

			local function Modify(Instance, Values)
				-- Modifies an Instance by using a table.  

				assert(type(Values) == "table", "Values is not a table");

				for Index, Value in next, Values do
					if type(Index) == "number" then
						Value.Parent = Instance
					else
						Instance[Index] = Value
					end
				end
				return Instance
			end

			local function Make(ClassType, Properties)
				-- Using a syntax hack to create a nice way to Make new items.  

				return Modify(Instance.new(ClassType), Properties)
			end

			local Surfaces = {"TopSurface", "BottomSurface", "LeftSurface", "RightSurface", "FrontSurface", "BackSurface"}
			local HingSurfaces = {"Hinge", "Motor", "SteppingMotor"}

			local function HasWheelJoint(Part)
				for _, SurfaceName in pairs(Surfaces) do
					for _, HingSurfaceName in pairs(HingSurfaces) do
						if Part[SurfaceName].Name == HingSurfaceName then
							return true
						end
					end
				end

				return false
			end

			local function ShouldBreakJoints(Part)
				--- We do not want to break joints of wheels/hinges. This takes the utmost care to not do this. There are
				--  definitely some edge cases. 

				if NEVER_BREAK_JOINTS then
					return false
				end

				if HasWheelJoint(Part) then
					return false
				end

				local Connected = Part:GetConnectedParts()

				if #Connected == 1 then
					return false
				end

				for _, Item in pairs(Connected) do
					if HasWheelJoint(Item) then
						return false
					elseif not Item:IsDescendantOf(script.Parent) then
						return false
					end
				end

				return true
			end

			local function WeldTogether(Part0, Part1, JointType, WeldParent)
				--- Weld's 2 parts together
				-- @param Part0 The first part
				-- @param Part1 The second part (Dependent part most of the time).
				-- @param [JointType] The type of joint. Defaults to weld.
				-- @param [WeldParent] Parent of the weld, Defaults to Part0 (so GC is better).
				-- @return The weld created.

				JointType = JointType or "Weld"
				local RelativeValue = Part1:FindFirstChild("qRelativeCFrameWeldValue")

				local NewWeld = Part1:FindFirstChild("qCFrameWeldThingy") or Instance.new(JointType)
				Modify(NewWeld, {
					Name = "qCFrameWeldThingy";
					Part0  = Part0;
					Part1  = Part1;
					C0     = CFrame.new();--Part0.CFrame:inverse();
					C1     = RelativeValue and RelativeValue.Value or Part1.CFrame:toObjectSpace(Part0.CFrame); --Part1.CFrame:inverse() * Part0.CFrame;-- Part1.CFrame:inverse();
					Parent = Part1;
				})

				if not RelativeValue then
					RelativeValue = Make("CFrameValue", {
						Parent     = Part1;
						Name       = "qRelativeCFrameWeldValue";
						Archivable = true;
						Value      = NewWeld.C1;
					})
				end

				return NewWeld
			end

			local function WeldParts(Parts, MainPart, JointType, DoNotUnanchor)
				-- @param Parts The Parts to weld. Should be anchored to prevent really horrible results.
				-- @param MainPart The part to weld the model to (can be in the model).
				-- @param [JointType] The type of joint. Defaults to weld. 
				-- @parm DoNotUnanchor Boolean, if true, will not unachor the model after cmopletion.

				for _, Part in pairs(Parts) do
					if ShouldBreakJoints(Part) then
						Part:BreakJoints()
					end
				end

				for _, Part in pairs(Parts) do
					if Part ~= MainPart then
						WeldTogether(MainPart, Part, JointType, MainPart)
					end
				end

				if not DoNotUnanchor then
					for _, Part in pairs(Parts) do
						Part.Anchored = false
					end
					MainPart.Anchored = false
				end
			end

			local function PerfectionWeld()	
				local Tool = GetNearestParent(script, "Tool")

				local Parts = GetBricks(script.Parent)
				local PrimaryPart = Tool and Tool:FindFirstChild("Handle") and Tool.Handle:IsA("BasePart") and Tool.Handle or script.Parent:IsA("Model") and script.Parent.PrimaryPart or Parts[1]

				if PrimaryPart then
					WeldParts(Parts, PrimaryPart, "Weld", false)
				else
					warn("qWeld - Unable to weld part")
				end

				return Tool
			end

			local Tool = PerfectionWeld()


			if Tool and script.ClassName == "Script" then
				--- Don't bother with local scripts

				script.Parent.AncestryChanged:connect(function()
					PerfectionWeld()
				end)
			end

			-- Created by Quenty (@Quenty, follow me on twitter).

		end))
		LocalScript6.Name = "Animate"
		LocalScript6.Parent = Tool0
		table.insert(cors,sandbox(LocalScript6,function()
			local arms = nil
			local torso = nil
			local welds = {}
			local Tool = script.Parent
			local neck = nil
			local orginalC0 = CFrame.new(0, 1, 0, -1, -0, -0, 0, 0, 1, 0, 1, 0)

			function Equip(mouse)
				wait(0.01)
				arms = {Tool.Parent:FindFirstChild("Left Arm"), Tool.Parent:FindFirstChild("Right Arm")}
				head = Tool.Parent:FindFirstChild("Head") 
				torso = Tool.Parent:FindFirstChild("Torso")
				if neck == nil then 
					neck = Tool.Parent:FindFirstChild("Torso").Neck
				end 
				if arms ~= nil and torso ~= nil then
					local sh = {torso:FindFirstChild("Left Shoulder"), torso:FindFirstChild("Right Shoulder")}
					if sh ~= nil then
						local yes = true
						if yes then
							yes = false
							sh[1].Part1 = nil
							sh[2].Part1 = nil
							local weld1 = Instance.new("Weld")
							weld1.Part0 = head
							weld1.Parent = head
							weld1.Part1 = arms[1]
							welds[1] = weld1
							local weld2 = Instance.new("Weld")
							weld2.Part0 = head
							weld2.Parent = head
							weld2.Part1 = arms[2]
							welds[2] = weld2
							-------------------------here
							weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0, math.rad(-90))
							weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-15), 0)
							mouse.Move:connect(function ()
								--local Direction = Tool.Direction.Value 
								local Direction = mouse.Hit.p
								local b = head.Position.Y-Direction.Y
								local dist = (head.Position-Direction).magnitude
								local answer = math.asin(b/dist)
								neck.C0=orginalC0*CFrame.fromEulerAnglesXYZ(answer,0,0)
								wait(0.1)
							end)end
					else
						print("sh")
					end
				else
					print("arms")
				end
			end

			function Unequip(mouse)
				if arms ~= nil and torso ~= nil then
					local sh = {torso:FindFirstChild("Left Shoulder"), torso:FindFirstChild("Right Shoulder")}
					if sh ~= nil then
						local yes = true
						if yes then
							yes = false
							neck.C0 = orginalC0

							sh[1].Part1 = arms[1]
							sh[2].Part1 = arms[2]
							welds[1].Parent = nil
							welds[2].Parent = nil
						end
					else
						print("sh")
					end
				else
					print("arms")
				end
			end
			Tool.Equipped:connect(Equip)
			Tool.Unequipped:connect(Unequip)

			function Animate()
				arms = {Tool.Parent:FindFirstChild("Left Arm"), Tool.Parent:FindFirstChild("Right Arm")}
				if Tool.AnimateValue.Value == "Shoot" then 
					local weld1 = welds[1]
					local weld2 = welds[2]
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-15), 0)
					wait(0.00001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.05, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-15), 0)
					wait(0.00001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.1, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-95), math.rad(-15), 0)
					wait(0.00001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.3, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-110), math.rad(-15), 0)
					wait(0.00001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.35, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-115), math.rad(-15), 0)
					wait(0.00001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.4, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-120), math.rad(-15), 0)
					wait(0.00001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-15), 0)	
					Tool.AnimateValue.Value = "None"
				end 
				if Tool.AnimateValue.Value == "Reload" then 
					local weld1 = welds[1]
					local weld2 = welds[2]
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.4, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.4, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-95), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.4, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-100), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.4, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-105), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.4, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-110), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.4, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-115), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.45, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-120), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.9, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.5, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-120), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 1, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.55, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-120), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 1.1, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.57, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-120), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 1.2, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.6, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-120), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 1.3, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0.6, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-120), math.rad(-15), 0)
					wait(0.0001)
					weld1.C1 = CFrame.new(-0.5+1.5, 0.8, .9)* CFrame.fromEulerAnglesXYZ(math.rad(290), 0, math.rad(-90))
					weld2.C1 = CFrame.new(-1, 0.8, 0.5-1.5) * CFrame.fromEulerAnglesXYZ(math.rad(-90), math.rad(-15), 0)	
					Tool.AnimateValue.Value = "None"
				end 
			end 

			Tool.AnimateValue.Changed:connect(Animate)

		end))
		Script7.Name = "LineConnect"
		Script7.Parent = Tool0
		Script7.Disabled = true
		table.insert(cors,sandbox(Script7,function()
			wait()
			local check = script.Part2
			local part1 = script.Part1.Value
			local part2 = script.Part2.Value
			local parent = script.Par.Value
			local color = script.Color
			local line = Instance.new("Part")
			line.TopSurface = 0
			line.BottomSurface = 0
			line.Reflectance = .5
			line.Name = "Laser"
			line.Transparency = 0.6
			line.Locked = true
			line.CanCollide = false
			line.Anchored = true
			line.formFactor = 0
			line.Size = Vector3.new(0.4,0.4,1)
			local mesh = Instance.new("BlockMesh")
			mesh.Parent = line
			while true do
				if (check.Value==nil) then break end
				if (part1==nil or part2==nil or parent==nil) then break end
				if (part1.Parent==nil or part2.Parent==nil) then break end
				if (parent.Parent==nil) then break end
				local lv = CFrame.new(part1.Position,part2.Position)
				local dist = (part1.Position-part2.Position).magnitude
				line.Parent = parent
				line.Material = "Neon"
				line.BrickColor = color.Value.BrickColor
				line.Reflectance = color.Value.Reflectance
				line.Transparency = "0.2"
				line.CFrame = CFrame.new(part1.Position+lv.lookVector*dist/2)
				line.CFrame = CFrame.new(line.Position,part2.Position)
				mesh.Scale = Vector3.new(.25,.25,dist)
				wait()
			end
			line:remove()
			script:remove() 
		end))
		LocalScript8.Name = "MainScript"
		LocalScript8.Parent = Tool0
		table.insert(cors,sandbox(LocalScript8,function()
			--Physics gun created by Killersoldier45
			wait() 
			tool = script.Parent
			lineconnect = tool.LineConnect
			object = nil
			mousedown = false
			found = false
			BP = Instance.new("BodyPosition")
			BP.maxForce = Vector3.new(math.huge*math.huge,math.huge*math.huge,math.huge*math.huge) --pwns everyone elses bodyposition
			BP.P = BP.P*10 --faster movement. less bounceback.
			dist = nil
			point = Instance.new("Part")
			point.Locked = true
			point.Anchored = true
			point.formFactor = 0
			point.Shape = 0
			point.Material = 'Neon'
			point.BrickColor = BrickColor.new("Toothpaste")
			point.Size = Vector3.new(1,1,1)
			point.CanCollide = false
			local mesh = Instance.new("SpecialMesh")
			mesh.MeshType = "Sphere"
			mesh.Scale = Vector3.new(.2,.2,.2)
			mesh.Parent = point
			handle = tool.Shoot
			front = tool.Shoot
			color = tool.Shoot
			objval = nil
			local hooked = false 
			local hookBP = BP:clone() 
			hookBP.maxForce = Vector3.new(30000,30000,30000) 

			function LineConnect(part1,part2,parent)
				local p1 = Instance.new("ObjectValue")
				p1.Value = part1
				p1.Name = "Part1"
				local p2 = Instance.new("ObjectValue")
				p2.Value = part2
				p2.Name = "Part2"
				local par = Instance.new("ObjectValue")
				par.Value = parent
				par.Name = "Par"
				local col = Instance.new("ObjectValue")
				col.Value = color
				col.Name = "Color"
				local s = lineconnect:clone()
				s.Disabled = false
				p1.Parent = s
				p2.Parent = s
				par.Parent = s
				col.Parent = s
				s.Parent = workspace
				if (part2==object) then
					objval = p2
				end
			end

			function onButton1Down(mouse)
				if (mousedown==true) then return end
				mousedown = true
				coroutine.resume(coroutine.create(function()
					local p = point:clone()
					p.Parent = tool
					LineConnect(front,p,workspace)
					while (mousedown==true) do
						p.Parent = tool
						if (object==nil) then
							if (mouse.Target==nil) then
								local lv = CFrame.new(front.Position,mouse.Hit.p)
								p.CFrame = CFrame.new(front.Position+(lv.lookVector*1000))
							else
								p.CFrame = CFrame.new(mouse.Hit.p)
							end
						else
							LineConnect(front,object,workspace)
							break
						end
						wait()
					end
					p:remove()
				end))
				while (mousedown==true) do
					if (mouse.Target~=nil) then
						local t = mouse.Target
						if (t.Anchored==false) then
							object = t
							dist = (object.Position-front.Position).magnitude
							break
						end
					end
					wait()
				end
				while (mousedown==true) do
					if (object.Parent==nil) then break end
					local lv = CFrame.new(front.Position,mouse.Hit.p)
					BP.Parent = object
					BP.position = front.Position+lv.lookVector*dist
					wait()
				end
				BP:remove()
				object = nil
				objval.Value = nil
			end

			function onKeyDown(key,mouse) 
				local key = key:lower() 
				local yesh = false 
				if (key=="q") then 
					if (dist>=5) then 
						dist = dist-5 
					end 
				end 
				if key == "" then 
					if (object==nil) then return end 
					for _,v in pairs(object:children()) do 
						if v.className == "BodyGyro" then 
							return nil 
						end 
					end 
					BG = Instance.new("BodyGyro") 
					BG.maxTorque = Vector3.new(math.huge,math.huge,math.huge) 
					BG.cframe = CFrame.new(object.CFrame.p) 
					BG.Parent = object 
					repeat wait() until(object.CFrame == CFrame.new(object.CFrame.p)) 
					BG.Parent = nil 
					if (object==nil) then return end 
					for _,v in pairs(object:children()) do 
						if v.className == "BodyGyro" then 
							v.Parent = nil 
						end 
					end 
					object.Velocity = Vector3.new(0,0,0) 
					object.RotVelocity = Vector3.new(0,0,0) 
				end 
				if (key=="e") then
					dist = dist+5
				end
				if (string.byte(key)==27) then 
					if (object==nil) then return end
					local e = Instance.new("Explosion")
					e.Parent = workspace
					e.Position = object.Position
					color.BrickColor = BrickColor.Black()
					point.BrickColor = BrickColor.White() 
					wait(.48)
					color.BrickColor = BrickColor.White() 
					point.BrickColor = BrickColor.Black() 
				end
				if (key=="") then 
					if not hooked then 
						if (object==nil) then return end 
						hooked = true 
						hookBP.position = object.Position 
						if tool.Parent:findFirstChild("Torso") then 
							hookBP.Parent = tool.Parent.Torso 
							if dist ~= (object.Size.x+object.Size.y+object.Size.z)+5 then 
								dist = (object.Size.x+object.Size.y+object.Size.z)+5 
							end 
						end 
					else 
						hooked = false 
						hookBP.Parent = nil 
					end 
				end 
				if (key=="r") then 
					if (object==nil) then return end 
					color.BrickColor = BrickColor.new("Toothpaste") 
					point.BrickColor = BrickColor.new("Toothpaste") 
					object.Parent = nil 
					wait(.48) 
					color.BrickColor = BrickColor.new("Toothpaste")
					point.BrickColor = BrickColor.new("Toothpaste")
				end 
				if (key=="") then 
					if (object==nil) then return end 
					local New = object:clone() 
					New.Parent = object.Parent 
					for _,v in pairs(New:children()) do 
						if v.className == "BodyPosition" or v.className == "BodyGyro" then 
							v.Parent = nil 
						end 
					end 
					object = New 
					mousedown = false 
					mousedown = true 
					LineConnect(front,object,workspace) 
					while (mousedown==true) do
						if (object.Parent==nil) then break end
						local lv = CFrame.new(front.Position,mouse.Hit.p)
						BP.Parent = object
						BP.position = front.Position+lv.lookVector*dist
						wait()
					end
					BP:remove()
					object = nil
					objval.Value = nil
				end 
				if (key=="") then 
					local Cube = Instance.new("Part") 
					Cube.Locked = true 
					Cube.Size = Vector3.new(4,4,4) 
					Cube.formFactor = 0 
					Cube.TopSurface = 0 
					Cube.BottomSurface = 0 
					Cube.Name = "WeightedStorageCube" 
					Cube.Parent = workspace 
					Cube.CFrame = CFrame.new(mouse.Hit.p) + Vector3.new(0,2,0) 
					for i = 0,5 do 
						local Decal = Instance.new("Decal") 
						Decal.Texture = "http://www.roblox.com/asset/?id=2662260" 
						Decal.Face = i 
						Decal.Name = "WeightedStorageCubeDecal" 
						Decal.Parent = Cube 
					end 
				end 
				if (key=="") then 
					if dist ~= 15 then 
						dist = 15 
					end 
				end 
			end

			function onEquipped(mouse)
				keymouse = mouse
				local char = tool.Parent
				human = char.Humanoid
				human.Changed:connect(function() if (human.Health==0) then mousedown = false BP:remove() point:remove() tool:remove() end end)
				mouse.Button1Down:connect(function() onButton1Down(mouse) end)
				mouse.Button1Up:connect(function() mousedown = false end)
				mouse.KeyDown:connect(function(key) onKeyDown(key,mouse) end)
				mouse.Icon = "rbxassetid:// 509381906"
			end

			tool.Equipped:connect(onEquipped)
		end))
		Part9.Name = "GlowPart"
		Part9.Parent = Tool0
		Part9.Material = Enum.Material.Neon
		Part9.BrickColor = BrickColor.new("Cyan")
		Part9.Transparency = 0.5
		Part9.Rotation = Vector3.new(0, -89.5899963, 0)
		Part9.Shape = Enum.PartType.Cylinder
		Part9.Size = Vector3.new(1.20000005, 0.649999976, 2)
		Part9.CFrame = CFrame.new(-54.8191681, 0.773548007, -0.0522949994, 0.00736002205, 4.68389771e-11, -0.999974668, 4.72937245e-11, 1, 1.41590961e-10, 0.999974668, 5.09317033e-11, 0.00736002252)
		Part9.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		Part9.Position = Vector3.new(-54.8191681, 0.773548007, -0.0522949994)
		Part9.Orientation = Vector3.new(0, -89.5799942, 0)
		Part9.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		Script10.Name = "Glow Script"
		Script10.Parent = Part9
		table.insert(cors,sandbox(Script10,function()
			while true do
				wait(0.05)
				script.Parent.Transparency = .5
				wait(0.05)
				script.Parent.Transparency = .6
				wait(0.05)
				script.Parent.Transparency = .7
				wait(0.05)
				script.Parent.Transparency = .8
				wait(0.05)
				script.Parent.Transparency = .9
				wait(0.05)
				script.Parent.Transparency = .8
				wait(0.05)
				script.Parent.Transparency = .7
				wait(0.05)
				script.Parent.Transparency = .6
				wait(0.05)
				script.Parent.Transparency = .5
			end

		end))
		Part11.Name = "GlowPart"
		Part11.Parent = Tool0
		Part11.Material = Enum.Material.Neon
		Part11.BrickColor = BrickColor.new("Cyan")
		Part11.Transparency = 0.5
		Part11.Rotation = Vector3.new(-89.3799973, -55.7399979, -89.25)
		Part11.Size = Vector3.new(0.280000001, 0.25999999, 0.200000003)
		Part11.CFrame = CFrame.new(-54.9808807, 0.99843204, 0.799362957, 0.00736002205, 0.562958956, -0.826454222, 4.72937245e-11, 0.826475084, 0.56297338, 0.999974668, -0.00414349511, 0.00608287565)
		Part11.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		Part11.Position = Vector3.new(-54.9808807, 0.99843204, 0.799362957)
		Part11.Orientation = Vector3.new(-34.2599983, -89.5799942, 0)
		Part11.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		Script12.Name = "Glow Script"
		Script12.Parent = Part11
		table.insert(cors,sandbox(Script12,function()
			while true do
				wait(0.05)
				script.Parent.Transparency = .5
				wait(0.05)
				script.Parent.Transparency = .6
				wait(0.05)
				script.Parent.Transparency = .7
				wait(0.05)
				script.Parent.Transparency = .8
				wait(0.05)
				script.Parent.Transparency = .9
				wait(0.05)
				script.Parent.Transparency = .8
				wait(0.05)
				script.Parent.Transparency = .7
				wait(0.05)
				script.Parent.Transparency = .6
				wait(0.05)
				script.Parent.Transparency = .5
			end

		end))
		Part13.Name = "GlowPart"
		Part13.Parent = Tool0
		Part13.Material = Enum.Material.Neon
		Part13.BrickColor = BrickColor.new("Cyan")
		Part13.Transparency = 0.5
		Part13.Rotation = Vector3.new(95.1500015, -53.8199997, 98.0799942)
		Part13.Size = Vector3.new(0.280000001, 0.25999999, 0.200000003)
		Part13.CFrame = CFrame.new(-54.5909271, 0.978429973, 0.799362957, -0.0830051303, -0.584483683, -0.807150841, 0.0241250042, 0.808528602, -0.58796227, 0.996258855, -0.0682764053, -0.0530113392)
		Part13.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		Part13.Position = Vector3.new(-54.5909271, 0.978429973, 0.799362957)
		Part13.Orientation = Vector3.new(36.0099983, -93.7599945, 1.70999992)
		Part13.Color = Color3.new(0.0156863, 0.686275, 0.92549)
		Script14.Name = "Glow Script"
		Script14.Parent = Part13
		table.insert(cors,sandbox(Script14,function()
			while true do
				wait(0.05)
				script.Parent.Transparency = .5
				wait(0.05)
				script.Parent.Transparency = .6
				wait(0.05)
				script.Parent.Transparency = .7
				wait(0.05)
				script.Parent.Transparency = .8
				wait(0.05)
				script.Parent.Transparency = .9
				wait(0.05)
				script.Parent.Transparency = .8
				wait(0.05)
				script.Parent.Transparency = .7
				wait(0.05)
				script.Parent.Transparency = .6
				wait(0.05)
				script.Parent.Transparency = .5
			end

		end))
		for i,v in pairs(mas:GetChildren()) do
			v.Parent = game:GetService("Players").LocalPlayer.Backpack
			pcall(function() v:MakeJoints() end)
		end
		mas:Destroy()
		for i,v in pairs(cors) do
			spawn(function()
				pcall(v)
			end)
		end
	end)

	BasicHack:addButton("Respawn", function()
		respawn(game.Players.LocalPlayer)
	end)

	BasicHack:addToggle("fly", nil, function(value)
		_G.FLYING = value
		FLY()
	end)

	BasicHack:addKeybind("fly keybind : ", nil, function()
		BasicHack:updateToggle("fly", "fly", not _G.FLYING)
		_G.FLYING = not _G.FLYING
		FLY()
		--if _G.FLYING then
		--	FLY()
		--	flyKeybindToggle = not flyKeybindToggle
		--end
	end)

	BasicHack:addTextbox("Fly speed", "50", function(value, focusLost)
		if focusLost then
			if tonumber(value) > 0 then
				flySpeed = tonumber(value)
			end
		end
	end)




	HumanoidStat:addToggle("Coordinate", nil, function(value)
		if value then
			local CoUi = Instance.new("ScreenGui", game.CoreGui)
			CoUi.Name = "PositionGui"
			CoUi.ResetOnSpawn = false

			local CoLabel = Instance.new("TextLabel", CoUi)
			CoLabel.Name = "Pos"
			CoLabel.BackgroundTransparency = 1
			CoLabel.TextScaled = true
			CoLabel.Size = UDim2.new(0.3, 0, 0.1, 0)
			CoLabel.Position = UDim2.new(0.7, 0,0.2, 0)
			CoLabel.TextColor3 = Color3.new(255, 255, 255)
			CoLabel.TextStrokeTransparency = 0

			ShowPosition = true
		else
			ShowPosition = false
			game.CoreGui.PositionGui:Destroy()
		end
	end)

	HumanoidStat:addSlider("Speed", math.floor(baseSpeed), 0, 300, function(value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
		basicSpeed = value
	end)

	HumanoidStat:addSlider("Jump power", math.floor(baseJump), 0, 500, function(value)
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
		basicJump = value
	end)

	HumanoidStat:addSlider("Gravity", math.floor(baseGravity), 0, 500, function(value)
		game.Workspace.Gravity = value
		basicGravity = value
	end)

	HumanoidStat:addSlider("Levitation", math.floor(baseLevit * 10), 0, 500, function(value)
		game.Players.LocalPlayer.Character.Humanoid.HipHeight = value / 10
		basicLevitation = value
	end)

	local function updateAllBasicBars(human)
		if human.WalkSpeed ~= basicSpeed and alive then
			HumanoidStat:updateSlider("Speed", nil, human.WalkSpeed, 0, 300, 0)
			basicSpeed = human.WalkSpeed
		end

		if human.JumpPower ~= basicJump and alive then
			HumanoidStat:updateSlider("Jump power", nil, human.JumpPower, 0, 500, 0)
			basicJump = human.JumpPower
		end

		if human.HipHeight ~= basicLevitation and alive then
			HumanoidStat:updateSlider("Levitation", nil, math.floor(human.HipHeight * 10), 0, 500, 0)
			basicLevitation = human.HipHeight
		end
	end

	--Update bars
	game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
		if alive then
			local human = char:WaitForChild('Humanoid')
			wait(0.3)
			updateAllBasicBars(human)
			human.Changed:Connect(function()
				updateAllBasicBars(human)
			end)
		end
	end)

	HumanoidStat:addButton("Reset", function()
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = baseSpeed
		game.Workspace.Gravity = baseGravity
		game.Players.LocalPlayer.Character.Humanoid.JumpPower = baseJump
		game.Players.LocalPlayer.Character.Humanoid.HipHeight = baseLevit

		local human = game.Players.LocalPlayer.Character.Humanoid
		HumanoidStat:updateSlider("Speed", nil, math.floor(baseSpeed), 0, 300)
		HumanoidStat:updateSlider("Jump power", nil, math.floor(baseJump), 0, 500)
		HumanoidStat:updateSlider("Gravity", nil, math.floor(baseGravity), 0, 500)
		HumanoidStat:updateSlider("Levitation", nil, math.floor(baseLevit * 10) , 0, 500)
	end)

	HumanoidStat:addToggle("auto setSpeed (lag warning)", nil, function(value)
		autoSetSpeed = value
	end)



	TeleportPage:addTextbox("Player", "", function(value, focusLost)
		if focusLost then
			local tempPlr
			local NumPlayer = 0

			for i, v in pairs(game:GetService("Players"):GetPlayers()) do
				if string.sub(string.lower(v.Name), 0, string.len(value)) == string.lower(value) then
					tempPlr = v.Name
					NumPlayer += 1
				end
			end


			if NumPlayer == 1 then
				tpPlayerFocus = tempPlr
			elseif NumPlayer > 1 then
				tpPlayerFocus = nil
				venyx:Notify("Error", "There are " ..tostring(NumPlayer) .." players with the same name")
			elseif NumPlayer == 0 then
				tpPlayerFocus = nil
				venyx:Notify("Error", "No player found")
			end


		end
	end)


	--local plrs = {}
	--for i, v in pairs(game.Players:GetPlayers()) do
	--	table.insert(plrs, 1, v.Name)
	--end
	--TeleportPage:addDropdown("PlayerV2", plrs, function(value)
	--	tpPlayerFocus = value
	--end)

	--local function UpdatePlayerDropDown()
	--	local plrs = {}
	--	for i, v in pairs(game.Players:GetPlayers()) do
	--		table.insert(plrs, 1, v.Name)
	--	end
	--	wait(0.1)
	--	--TeleportPage:clearDropdown("PlayerV2")
	--	wait(0.1)
	--	TeleportPage:updateDropdown("PlayerV2", "PlayerV2", plrs)
	--end

	--players.PlayerAdded:Connect(UpdatePlayerDropDown)
	--players.PlayerRemoving:Connect(UpdatePlayerDropDown)



	--local plrNameTable = {}
	--for i, v in pairs(game.Players:GetPlayers()) do
	--	table.insert(plrNameTable, 1, v.Name)
	--end

	--TeleportPage:addDropdown("plr to teleport", plrNameTable, function(value)
	--	tpPlayerFocus = value
	--end)

	--function updatePlayerDropdown(theDropdown)
	--	if alive then
	--		local plrNameTableTemp = {}
	--		for i, v in pairs(game.Players:GetPlayers()) do
	--			table.insert(plrNameTableTemp, 1, v.Name)
	--		end

	--		TeleportPage:updateDropdown(theDropdown, nil, plrNameTableTemp)
	--	end
	--end

	--game.Players.PlayerAdded:Connect(function()
	--	updatePlayerDropdown("plr to teleport")
	--end)

	--game.Players.PlayerRemoving:Connect(function()
	--	updatePlayerDropdown("plr to teleport")
	--end)

	TeleportPage:addButton("Teleport", function()
		local success = pcall(function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players:FindFirstChild(tpPlayerFocus).Character.HumanoidRootPart.Position) end)
		if not success then
			venyx:Notify("ERROR", "player not found")
		end

	end)

	TeleportPage:addToggle("Follow player", nil, function(value)
		FollowBot = value

		if not value then
			wait()
			wait()
			game.Players.LocalPlayer.Character.Humanoid:MoveTo(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
		end
	end)

	TeleportPage:addToggle("Spam tp", nil, function(value)
		focusTpPlayer = value
	end)


	TeleportPage:addToggle("Fling player", nil, function(value)
		flingEnabled = value


		local BodyAngularVelocity
		if value then
			local Players = game:GetService("Players")
			local RunService = game:GetService("RunService")

			local LocalPlayer = Players.LocalPlayer
			local Target = Players:FindFirstChild(tpPlayerFocus)

			BodyAngularVelocity = Instance.new("BodyAngularVelocity")
			BodyAngularVelocity.AngularVelocity = Vector3.new(10^6, 10^6, 10^6)
			BodyAngularVelocity.MaxTorque = Vector3.new(10^6, 10^6, 10^6)
			BodyAngularVelocity.P = 10^6

			-- Start
			if not Target then return end
			BodyAngularVelocity.Parent = LocalPlayer.Character.HumanoidRootPart
		else
			BodyAngularVelocity.Parent = nil
			wait(1)
			respawn(game.Players.LocalPlayer)
		end
	end)


	TeleportPage:addButton("Bring (need tool)", function()


		if not game:GetService("Players"):FindFirstChild(tpPlayerFocus) then
			venyx:Notify("ERROR", "player not found")

		else
			spawn(function()
				bring(game.Players.LocalPlayer, game:GetService("Players"):FindFirstChild(tpPlayerFocus).Character, false)
			end)
		end

	end)

	TeleportPage:addButton("Kill (need tool)", function()


		if not game:GetService("Players"):FindFirstChild(tpPlayerFocus) then
			venyx:Notify("ERROR", "player not found")

		else
			spawn(function()
				bring(game.Players.LocalPlayer, game:GetService("Players"):FindFirstChild(tpPlayerFocus).Character, false)
			end)
		end

	end)





	TeleportPage:addButton("Spectate", function()
		local success = pcall(function() game.Workspace.CurrentCamera.CameraSubject = game.Players:FindFirstChild(tpPlayerFocus).Character.Humanoid end)
		if not success then
			venyx:Notify("ERROR", "player not found")
		end
	end)

	TeleportPage:addButton("Unspectate", function()
		game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	end)



	--BotPage:addTextbox("Bot", "player name", function(value, focusLost)
	--	if focusLost then
	--		BotFocus = value
	--	end
	--end)

	--BotPage:addButton("Folow player", function()
	--	if FollowBot == false then
	--		FollowBot = true
	--	end
	--end)

	--BotPage:addButton("Stop bot", function()
	--	FollowBot = false
	--end)




	FunPage:addButton("Sit", function()
		pcall(function() game.Players.LocalPlayer.Character.Humanoid.Sit = true end)
	end)

	FunPage:addButton("Delete animation", function()

		pcall(function() game.Players.LocalPlayer.Character.Humanoid.Animator:Destroy() end)
	end)

	FunPage:addButton("Special reset character", function()
		pcall(function() game.Players.LocalPlayer.Character.Humanoid:Destroy() end)
	end)

	FunPage:addButton("AMOGUS", function()
		local args = {
			[1] = "AMOGUS",
			[2] = "All"
		}

		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
	end)


	GameAddonPage:addToggle("Shift to sprint", nil, function(value)
		shiftToSprint = value
	end)

	GameAddonPage:addSlider("Sprint speed", 20, 0, 300, function(value)
		sprintSpeed = value
	end)

	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftShift and shiftToSprint then
			player.Character.Humanoid.WalkSpeed = sprintSpeed
			game:GetService("TweenService"):Create(workspace.Camera, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {FieldOfView = 85}):Play()
		end
	end)

	UserInputService.InputEnded:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.LeftShift and shiftToSprint then
			player.Character.Humanoid.WalkSpeed = baseSpeed
			game:GetService("TweenService"):Create(workspace.Camera, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {FieldOfView = 70}):Play()
		end
	end)

	venyx:SelectPage(venyx.pages[1], true)

	game:GetService("RunService").RenderStepped:Wait()









	-- Visual
	local page = venyx:addPage("Visual", 8988759357)
	local CameraPage = page:addSection("Camera")
	local LightingPage = page:addSection("Lighting")
	local GuiPage = page:addSection("Gui")


	CameraPage:addToggle("Camera noclip", nil, function(value)
		if value then
			game.Players.LocalPlayer.DevCameraOcclusionMode = 1
		else
			game.Players.LocalPlayer.DevCameraOcclusionMode = 0
		end
	end)

	CameraPage:addToggle("Unlock Camera max zoom distance", nil, function(value)
		if value then
			game.Players.LocalPlayer.CameraMaxZoomDistance = 100000
		else
			game.Players.LocalPlayer.CameraMaxZoomDistance = oldMaxZoom
		end
	end)



	CameraPage:addSlider("FOV", 70, 0, 120, function(value)
		game.Workspace.Camera.FieldOfView = value
	end)

	CameraPage:addButton("Reset fov", function()
		game.Workspace.Camera.FieldOfView = 70
	end)

	CameraPage:addToggle("Freeze cam", nil, function(value)
		if value then
			game.Workspace.Camera.CameraType = "Scriptable"
		else
			game.Workspace.Camera.CameraType = "Custom"
		end
	end)


	CameraPage:addKeybind("Freecam", nil, function()
		ToggleFreecam()
	end)



	LightingPage:addSlider("Brightness", 2, 0, 120, function(value)
		game.Lighting.Brightness = value
	end)

	LightingPage:addToggle("HideGlobalShadows", nil, function(value)
		game.Lighting.GlobalShadows = not value
	end)

	local objInstance = {}
	local Texture = {}
	local textureMoving = false
	CameraPage:addToggle("Remove texture (Freeze warning)", nil, function(value)
		if textureMoving == false then
			textureMoving = true
			if value then
				local num = 0
				for i, v in pairs(workspace:GetDescendants()) do

					if v:IsA("Part") or v:IsA("WedgePart") or v:IsA("MeshPart") then
						table.insert(objInstance, 1, v)
						table.insert(Texture, 1, v.Material)
						v.Material = Enum.Material.SmoothPlastic
						num += 1
					end

					if v:IsA("Texture") then
						table.insert(objInstance, 1, v)
						table.insert(Texture, 1, v.Texture)
						v.Texture = ""
						num += 1
					end

					if num >= 500 then
						num = 0
						game:GetService("RunService").RenderStepped:Wait()
					end
				end
			else
				local num = 0
				for i, v in pairs(objInstance) do
					if v then
						if v:IsA("Part") or v:IsA("WedgePart") or v:IsA("MeshPart") then
							v.Material = Texture[i]
							num += 1
						end

						if v:IsA("Texture") then
							v.Texture = Texture[i]
							num += 1
						end

						if num >= 500 then
							num = 0
							game:GetService("RunService").RenderStepped:Wait()
						end
					end
				end
			end
			textureMoving = false
			CameraPage:updateToggle("Remove texture (Freeze warning)", nil, value)
		end
	end)

	CameraPage:addToggle("Show invisible walls", nil, function(value)
		toggleInvisibleWall()
	end)

	local HidedMenuToggle = {}
	GuiPage:addToggle("HideMenu", nil, function(value)
		if value then
			for i, v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
				if v:IsA("ScreenGui") then
					table.insert(HidedMenuToggle, v)
					v.Enabled = false
				end
			end
		else
			for i, v in pairs(HidedMenuToggle) do
				if v then
					v.Enabled = true
				end
			end
			HidedMenuToggle = {}
		end
	end)


	game:GetService("RunService").RenderStepped:Wait()






	-- BasicTp
	local page = venyx:addPage("Custom tp", 8988776454)
	local locationcreator = page:addSection("create a location")

	locationcreator:addTextbox("CustomTp", "location name", function(value, focusLost)
		if focusLost then
			customTpName = value
		end
	end)

	locationcreator:addButton("Create location", function()
		if customTpName ~= nil then
			if game.CoreGui:FindFirstChild(name).Main:FindFirstChild("Custom tp"):FindFirstChild(customTpName) then
				venyx:Notify("Error", "Incorect name")
			else
				local pageName = customTpName
				local tppage = page:addSection(customTpName)
				local buttonPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				tppage:addButton("Tp boutton", function()
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(buttonPosition)
				end)

				tppage:addKeybind("TP keybind : ", nil, function()
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(buttonPosition)
				end)

				tppage:addButton("Delete location", function()
					utility:Tween(ScreenGui.Main["Custom tp"][pageName], {Size = UDim2.new(ScreenGui.Main["Custom tp"][pageName].Size.X, 0, 0)}, 0.5)
					wait(.5)
					table.remove(page.sections, table.find(page.sections, tppage))
					ScreenGui.Main["Custom tp"][pageName]:Destroy()
				end)

				venyx:SelectPage(venyx.pages[1], true)
				venyx:SelectPage(venyx.pages[3], true)
			end
		else
			venyx:Notify("Error", "Incorect name")
		end
	end)

	game:GetService("RunService").RenderStepped:Wait()




	-- Emotes
	local page = venyx:addPage("Emotes", 10615199280)
	local bruhSection = page:addSection("Sorry i dont have the time for this")


	--bruhSection:addText("   Sorry i dont have the time for this")
	bruhSection:addButton("Check this script (click)", function()
		loadstring(game:HttpGet("https://gitlab.com/Tsuniox/lua-stuff/-/raw/master/R15GUI.lua"))()
	end)

	--local StopEmoteSection = page:addSection("Stop emote")
	----local R6Section = page:addSection("R6 Emotes list")
	--local R15Section = page:addSection("R15 Emotes list")
	--local CustomEmoteSection = page:addSection("Custom emote")

	--StopEmoteSection:addButton("Remove emote", function()
	--	trackEmote:Stop()
	--end)

	--R15Section:addButton("Applaud", function()
	--	StartEmote(5915779043, true)
	--end)

	--R15Section:addButton("Sidekicks - George Ezra", function()
	--	StartEmote(10370922566, true)
	--end)

	--R15Section:addButton("Applaud", function()
	--	StartEmote(5915779043, true)
	--end)

	--R15Section:addButton("Happy", function()
	--	StartEmote(4849499887, true)
	--end)

	--R15Section:addText(" More comming soon")

	--local CustomEmoteID
	--CustomEmoteSection:addTextbox("Music id", "Put id here", function(value, focusLost)
	--	if focusLost then
	--		CustomEmoteID = value
	--	end
	--end)

	--R15Section:addButton("Start emote", function()
	--	StartEmote(CustomEmoteID, true)
	--end)



	game:GetService("RunService").RenderStepped:Wait()





	-- ESP / Aimbot
	local page = venyx:addPage("ESP / Aimbot", 10630306183)
	local ESPSection = page:addSection("ESP")
	local TracerSettingsSection = page:addSection("Tracer Settings")
	local SilentAimSection = page:addSection("Silent Aim")
	local AimbotSection = page:addSection("Aimbot")

	ESPSection:addToggle("Show Names", EspSettings.NamesEnabled, function(Callback)
		EspSettings.NamesEnabled = Callback
	end)

	ESPSection:addToggle("Show Health", EspSettings.HealthEnabled, function(Callback)
		EspSettings.HealthEnabled = Callback
	end)

	ESPSection:addToggle("Show Distance", EspSettings.DistanceEnabled, function(Callback)
		EspSettings.DistanceEnabled = Callback
	end)

	ESPSection:addToggle("Box Esp", EspSettings.BoxEsp, function(Callback)
		EspSettings.BoxEsp = Callback
		SetProperties({ Box = { Visible = Callback } });
	end)

	ESPSection:addSlider("Render Distance", math.clamp(EspSettings.RenderDistance, 0, 50000), 0, 50000, function(Callback)
		EspSettings.RenderDistance = Callback
	end)

	ESPSection:addSlider("Esp Size", EspSettings.Size, 0, 30, function(Callback)
		EspSettings.Size = Callback
		SetProperties({ Text = { Size = Callback } });
	end)

	ESPSection:addColorPicker("Esp Color", EspSettings.Color, function(Callback)
		EspSettings.TeamColors = false
		EspSettings.Color = Callback
		SetProperties({ Box = { Color = Callback }, Text = { Color = Callback }, Tracer = { Color = Callback } });
	end)

	ESPSection:addToggle("Team Colors", EspSettings.TeamColors, function(Callback)
		EspSettings.TeamColors = Callback
		if (not Callback) then
			SetProperties({ Tracer = { Color = EspSettings.Color }; Box = { Color = EspSettings.Color }; Text = { Color = EspSettings.Color }  })
		end
	end)

	ESPSection:addDropdown("Teams", {"Allies", "Enemies", "All"}, function(Callback)
		table.clear(EspSettings.BlacklistedTeams);
		if (Callback == "Enemies") then
			table.insert(EspSettings.BlacklistedTeams, Teams.Team);
		end
		if (Callback == "Allies") then
			local AllTeams = Teams:GetTeams();
			table.remove(AllTeams, table.find(AllTeams, ThePlayer.Team));
			EspSettings.BlacklistedTeams = AllTeams
		end
	end)

	ESPSection:addToggle("old ESP", nil, function(value)
		ESPToggle = value
		if value then
			openESP()
		else
			closeESP()
		end
	end)

	ESPSection:addKeybind("old ESP keybind : ", nil, function()
		ESPSection:updateToggle("ESP", "ESP", not ESPToggle)
		ESPToggle = not ESPToggle
		if ESPToggle then
			openESP()
		else
			closeESP()
		end
	end)


	TracerSettingsSection:addToggle("Enable Tracers", EspSettings.TracersEnabled, function(Callback)
		EspSettings.TracersEnabled = Callback
		SetProperties({ Tracer = { Visible = Callback } });
	end)

	--TracerSettingsSection:addDropdown("To", {"Head", "Torso"}, function(Callback)
	--	AimbotSettings.Aimlock = Callback == "Torso" and "HumanoidRootPart" or Callback
	--end)

	--TracerSettingsSection:addDropdown("From", {"Top", "Bottom", "Left", "Right"}, function(Callback)
	--	local ViewportSize = workspace.CurrentCamera.ViewportSize
	--	local From = Callback == "Top" and Vector2.new(ViewportSize.X / 2, ViewportSize.Y - ViewportSize.Y) or Callback == "Bottom" and Vector2.new(ViewportSize.X / 2, ViewportSize.Y) or Callback == "Left" and Vector2.new(ViewportSize.X - ViewportSize.X, ViewportSize.Y / 2) or Callback == "Right" and Vector2.new(ViewportSize.X, ViewportSize.Y / 2);
	--	EspSettings.TracerFrom = From
	--	SetProperties({ Tracer = { From = From } });
	--end)

	TracerSettingsSection:addSlider("Tracer Transparency", EspSettings.TracerTrancparency * 10, 0, 10, function(Callback)
		EspSettings.TracerTrancparency = Callback / 10
		SetProperties({ Tracer = { Transparency = Callback / 10 } });
	end)

	TracerSettingsSection:addSlider("Tracer Thickness", EspSettings.TracerThickness * 10, 0, 20, function(Callback)
		EspSettings.TracerThickness = Callback / 10
		SetProperties({ Tracer = { Thickness = Callback / 10 } });
	end)





	SilentAimSection:addToggle("Silent Aim", AimbotSettings.SilentAim, function(Callback)
		AimbotSettings.SilentAim = Callback
	end)

	SilentAimSection:addToggle("Wall shoot", AimbotSettings.Wallbang, function(Callback)
		AimbotSettings.Wallbang = Callback
	end)

	SilentAimSection:addDropdown("Aim", {"Head", "Torso"}, function(Callback)
		AimbotSettings.SilentAimRedirect = Callback
	end)

	--SilentAimSection:addSlider("Hit Chance", AimbotSettings.SilentAimHitChance, 0, 100, function(Callback)
	--	AimbotSettings.SilentAimHitChance = Callback
	--end)

	SilentAimSection:addDropdown("Aim Type", {"Closest Cursor", "Closest Player"}, function(Callback)
		if (Callback == "Closest Cursor") then
			AimbotSettings.ClosestCharacter = false
			AimbotSettings.ClosestCursor = true
		else
			AimbotSettings.ClosestCharacter = true
			AimbotSettings.ClosestCursor = false
		end
	end)

	SilentAimSection:addToggle("Show Fov", AimbotSettings.ShowFov, function(Callback)
		AimbotSettings.ShowFov = Callback
		FOV.Visible = Callback
	end)

	SilentAimSection:addColorPicker("Fov Color", AimbotSettings.FovColor, function(Callback)
		AimbotSettings.FovColor = Callback
		FOV.Color = Callback
		Snaplines.Color = Callback
	end)

	SilentAimSection:addSlider("Fov Size", AimbotSettings.FovSize / 10, 7, 50, function(Callback)
		AimbotSettings.FovSize = Callback * 10
		FOV.Radius = Callback * 10
	end)

	SilentAimSection:addToggle("Enable Snaplines", AimbotSettings.Snaplines, function(Callback)
		AimbotSettings.Snaplines = Callback
	end)






	AimbotSection:addToggle("Aimbot (M2)", AimbotSettings.Enabled, function(Callback)
		AimbotSettings.Enabled = Callback
		if (not AimbotSettings.FirstPerson and not AimbotSettings.ThirdPerson) then
			AimbotSettings.FirstPerson = true
		end
	end)

	AimbotSection:addSlider("Aimbot Smoothness", AimbotSettings.Smoothness, 1, 10, function(Callback)
		AimbotSettings.Smoothness = Callback
	end)

	local sortTeams = function(Callback)
		table.clear(AimbotSettings.BlacklistedTeams);
		if (Callback == "Enemies") then
			table.insert(AimbotSettings.BlacklistedTeams, ThePlayer.Team);
		end
		if (Callback == "Allies") then
			local AllTeams = Teams:GetTeams();
			table.remove(AllTeams, table.find(AllTeams, ThePlayer.Team));
			AimbotSettings.BlacklistedTeams = AllTeams
		end
	end

	AimbotSection:addDropdown("Team Target", {"Allies", "Enemies", "All"}, sortTeams)
	sortTeams("Enemies")

	AimbotSection:addDropdown("Aimlock Type", {"Third Person", "First Person"}, function(callback)
		if (callback == "Third Person") then
			AimbotSettings.ThirdPerson = true
			AimbotSettings.FirstPerson = false
		else
			AimbotSettings.ThirdPerson = false
			AimbotSettings.FirstPerson = true
		end
	end)





	game:GetService("RunService").RenderStepped:Wait()






	--Custom Map
	local page = venyx:addPage("Custom world", 8988796619)
	local SkyPage = page:addSection("Sky")
	local TimePage = page:addSection("Time")
	local MusicPage = page:addSection("Local music")

	SkyPage:addButton("Default game sky", function()
		if DefaultSky then
			DefaultSky.CelestialBodiesShown = DefaultSkyStat[1]
			DefaultSky.MoonAngularSize = DefaultSkyStat[2]
			DefaultSky.MoonTextureId = DefaultSkyStat[3]
			DefaultSky.SkyboxBk = DefaultSkyStat[4]
			DefaultSky.SkyboxDn = DefaultSkyStat[5]
			DefaultSky.SkyboxFt = DefaultSkyStat[6]
			DefaultSky.SkyboxLf = DefaultSkyStat[7]
			DefaultSky.SkyboxRt = DefaultSkyStat[8]
			DefaultSky.SkyboxUp = DefaultSkyStat[9]
			DefaultSky.StarCount = DefaultSkyStat[10]
			DefaultSky.SunAngularSize = DefaultSkyStat[11]
			DefaultSky.SunTextureId = DefaultSkyStat[12]
		end
	end)

	SkyPage:addButton("Realistic sky", function()
		local ThePresetSky = presetsSky["Realistic sky"]

		DefaultSky.CelestialBodiesShown = ThePresetSky[1]
		DefaultSky.MoonAngularSize = ThePresetSky[2]
		DefaultSky.MoonTextureId = ThePresetSky[3]
		DefaultSky.SkyboxBk = ThePresetSky[4]
		DefaultSky.SkyboxDn = ThePresetSky[5]
		DefaultSky.SkyboxFt = ThePresetSky[6]
		DefaultSky.SkyboxLf = ThePresetSky[7]
		DefaultSky.SkyboxRt = ThePresetSky[8]
		DefaultSky.SkyboxUp = ThePresetSky[9]
		DefaultSky.StarCount = ThePresetSky[10]
		DefaultSky.SunAngularSize = ThePresetSky[11]
		DefaultSky.SunTextureId = ThePresetSky[12]
	end)

	SkyPage:addButton("Cartoon sky", function()
		local ThePresetSky = presetsSky["Cartoon sky"]

		DefaultSky.CelestialBodiesShown = ThePresetSky[1]
		DefaultSky.MoonAngularSize = ThePresetSky[2]
		DefaultSky.MoonTextureId = ThePresetSky[3]
		DefaultSky.SkyboxBk = ThePresetSky[4]
		DefaultSky.SkyboxDn = ThePresetSky[5]
		DefaultSky.SkyboxFt = ThePresetSky[6]
		DefaultSky.SkyboxLf = ThePresetSky[7]
		DefaultSky.SkyboxRt = ThePresetSky[8]
		DefaultSky.SkyboxUp = ThePresetSky[9]
		DefaultSky.StarCount = ThePresetSky[10]
		DefaultSky.SunAngularSize = ThePresetSky[11]
		DefaultSky.SunTextureId = ThePresetSky[12]
	end)

	SkyPage:addButton("Pink sky", function()
		local ThePresetSky = presetsSky["Pink sky"]

		DefaultSky.CelestialBodiesShown = ThePresetSky[1]
		DefaultSky.MoonAngularSize = ThePresetSky[2]
		DefaultSky.MoonTextureId = ThePresetSky[3]
		DefaultSky.SkyboxBk = ThePresetSky[4]
		DefaultSky.SkyboxDn = ThePresetSky[5]
		DefaultSky.SkyboxFt = ThePresetSky[6]
		DefaultSky.SkyboxLf = ThePresetSky[7]
		DefaultSky.SkyboxRt = ThePresetSky[8]
		DefaultSky.SkyboxUp = ThePresetSky[9]
		DefaultSky.StarCount = ThePresetSky[10]
		DefaultSky.SunAngularSize = ThePresetSky[11]
		DefaultSky.SunTextureId = ThePresetSky[12]
	end)

	SkyPage:addButton("Island theme sky", function()
		local ThePresetSky = presetsSky["Island theme sky"]

		DefaultSky.CelestialBodiesShown = ThePresetSky[1]
		DefaultSky.MoonAngularSize = ThePresetSky[2]
		DefaultSky.MoonTextureId = ThePresetSky[3]
		DefaultSky.SkyboxBk = ThePresetSky[4]
		DefaultSky.SkyboxDn = ThePresetSky[5]
		DefaultSky.SkyboxFt = ThePresetSky[6]
		DefaultSky.SkyboxLf = ThePresetSky[7]
		DefaultSky.SkyboxRt = ThePresetSky[8]
		DefaultSky.SkyboxUp = ThePresetSky[9]
		DefaultSky.StarCount = ThePresetSky[10]
		DefaultSky.SunAngularSize = ThePresetSky[11]
		DefaultSky.SunTextureId = ThePresetSky[12]
	end)

	SkyPage:addButton("Galaxy sky", function()
		local ThePresetSky = presetsSky["Galaxy sky"]

		DefaultSky.CelestialBodiesShown = ThePresetSky[1]
		DefaultSky.MoonAngularSize = ThePresetSky[2]
		DefaultSky.MoonTextureId = ThePresetSky[3]
		DefaultSky.SkyboxBk = ThePresetSky[4]
		DefaultSky.SkyboxDn = ThePresetSky[5]
		DefaultSky.SkyboxFt = ThePresetSky[6]
		DefaultSky.SkyboxLf = ThePresetSky[7]
		DefaultSky.SkyboxRt = ThePresetSky[8]
		DefaultSky.SkyboxUp = ThePresetSky[9]
		DefaultSky.StarCount = ThePresetSky[10]
		DefaultSky.SunAngularSize = ThePresetSky[11]
		DefaultSky.SunTextureId = ThePresetSky[12]
	end)

	SkyPage:addButton("Night time sky", function()
		local ThePresetSky = presetsSky["Night time sky"]

		DefaultSky.CelestialBodiesShown = ThePresetSky[1]
		DefaultSky.MoonAngularSize = ThePresetSky[2]
		DefaultSky.MoonTextureId = ThePresetSky[3]
		DefaultSky.SkyboxBk = ThePresetSky[4]
		DefaultSky.SkyboxDn = ThePresetSky[5]
		DefaultSky.SkyboxFt = ThePresetSky[6]
		DefaultSky.SkyboxLf = ThePresetSky[7]
		DefaultSky.SkyboxRt = ThePresetSky[8]
		DefaultSky.SkyboxUp = ThePresetSky[9]
		DefaultSky.StarCount = ThePresetSky[10]
		DefaultSky.SunAngularSize = ThePresetSky[11]
		DefaultSky.SunTextureId = ThePresetSky[12]
	end)

	SkyPage:addButton("Night City sky", function()
		local ThePresetSky = presetsSky["Night City sky"]

		DefaultSky.CelestialBodiesShown = ThePresetSky[1]
		DefaultSky.MoonAngularSize = ThePresetSky[2]
		DefaultSky.MoonTextureId = ThePresetSky[3]
		DefaultSky.SkyboxBk = ThePresetSky[4]
		DefaultSky.SkyboxDn = ThePresetSky[5]
		DefaultSky.SkyboxFt = ThePresetSky[6]
		DefaultSky.SkyboxLf = ThePresetSky[7]
		DefaultSky.SkyboxRt = ThePresetSky[8]
		DefaultSky.SkyboxUp = ThePresetSky[9]
		DefaultSky.StarCount = ThePresetSky[10]
		DefaultSky.SunAngularSize = ThePresetSky[11]
		DefaultSky.SunTextureId = ThePresetSky[12]
	end)



	TimePage:addToggle("Always day", nil, function(value)
		alwaysDay = value
	end)

	TimePage:addToggle("Always night", nil, function(value)
		alwaysNight = value
	end)

	MusicPage:addTextbox("Music id", "Put id here", function(value, focusLost)
		if focusLost then
			pcall(function() MusicIdToPlay.SoundId = "rbxassetid://" ..value MusicIdToPlay:Stop() end) 

			local times = 0
			repeat
				wait(0.3)
				times += 1
			until MusicIdToPlay.IsLoaded or times == 3

			if not MusicIdToPlay.IsLoaded then
				venyx:Notify("Error", "Music not found")
			end
		end
	end)

	MusicPage:addButton("Play music", function()
		MusicIdToPlay:Play()
		MusicIdToPlay:Resume()
		MusicPage:updateToggle("Pause music", "Pause music", false)
		MusicPage:updateSlider("Time", nil, math.floor(MusicIdToPlay.TimePosition), 0, math.floor(MusicIdToPlay.TimeLength), 0)
	end)

	MusicPage:addButton("Stop music", function()
		MusicIdToPlay:Stop()
		MusicIdToPlay:Pause()
	end)

	MusicPage:addToggle("Pause music", nil, function(value)
		if value then
			MusicIdToPlay:Pause()
		else
			MusicIdToPlay:Resume()
		end
	end)

	MusicPage:addSlider("Volume", 15, 0, 90, function(value)
		MusicIdToPlay.Volume = value / 30
	end)


	MusicPage:addSlider("Music speed (20 = normal)", 20, 0, 60, function(value)
		MusicIdToPlay.PlaybackSpeed = value / 20
	end)

	MusicPage:addSlider("Time", 0, 0, 100, function(value)
		--if math.floor(value * math.floor(MusicIdToPlay.TimeLength) / 100 ) + 1  ~= math.floor(MusicIdToPlay.TimePosition) and math.floor(value * math.floor(MusicIdToPlay.TimeLength) / 100 ) + 2  ~= math.floor(MusicIdToPlay.TimePosition) then

		--	print("timePositionValue : " ..timePositionValue)
		--	print("value : " .. math.floor(value * math.floor(MusicIdToPlay.TimeLength) / 100 ) + 1)
		--	print("MusicIdToPlay : " ..math.floor(MusicIdToPlay.TimePosition))
		--	MusicIdToPlay.TimePosition = math.floor(value * math.floor(MusicIdToPlay.TimeLength) / 100 ) + 1

		--end
		timePositionValue = value


	end)

	local function countSecond()
		while wait(0.1) do
			if MusicIdToPlay.Playing and MusicIdToPlay.TimeLength > 0 and math.floor(MusicIdToPlay.TimePosition) ~= timePositionValue then
				MusicPage:updateSlider("Time", nil, math.floor(MusicIdToPlay.TimePosition), 0, math.floor(MusicIdToPlay.TimeLength), 0)
			end
		end
	end

	spawn(countSecond)



	game:GetService("RunService").RenderStepped:Wait()


	--Robeats
	if game.PlaceId == 698448212 then
		local page = venyx:addPage("Robeats", 9667400753)

		local NormalPage = page:addSection("AutoPlay")

		NormalPage:addToggle("Auto play", nil, function(value)
			RobeatsAutoplayToggle = value
		end)

		NormalPage:addSlider("Random", 0, 0, 80, function(value)
			Autoplayer.distanceLowerBound = 0.4 - value / 10
			Autoplayer.distanceUpperBound = 0.6 + value / 10
		end)

		NormalPage:addSlider("Spam level", 20, 1, 20, function(value)
			Autoplayer.delayLowerBound = 0.05 * 20 / value
			Autoplayer.delayUpperBound = 0.1 * 20 / value
			Autoplayer.sliderDebounce = 0.08 * 20 / value
		end)
	end





	game:GetService("RunService").RenderStepped:Wait()


	--Base raider
	if game.PlaceId == 1696916806 then
		local page = venyx:addPage("Base raider", 10652921362)

		local VaultPage = page:addSection("Bank Vault")


		--Func
		local function ClaimAllVault()
			local MyTycoon = nil

			for i, v in pairs(workspace.Tycoons:GetChildren()) do
				if v.Owner.Value == game.Players.LocalPlayer.Name then
					MyTycoon = v
				end
			end


			for i, v in pairs(MyTycoon.PlacedContent:GetChildren()) do
				if v.Name == "Bank Vault" then
					fireclickdetector(v.Model.Detector.ClickDetector)
				end
			end
		end


		VaultPage:addButton("Claim all Bank Vault", function()
			ClaimAllVault()
		end)

		local AutoVaultCooldown = 10
		local AutoVault = false
		spawn(function()
			local tempTime = 0
			while true do
				repeat 
					wait(1)
					tempTime += 1
				until tempTime >= AutoVaultCooldown

				tempTime = 0

				if AutoVault then
					ClaimAllVault()
				end
			end
		end)

		VaultPage:addToggle("Auto collect bank Vault", nil, function(value)
			AutoVault = value
		end)

		VaultPage:addSlider("Auto collect cooldown (in second)", AutoVaultCooldown, 1, 100, function(value)
			AutoVaultCooldown = value
		end)

	end



	game:GetService("RunService").RenderStepped:Wait()


	--Transfur outbreak
	if game.PlaceId == 5987922834 then
		local page = venyx:addPage("Transfur outbreak", 10517320477)

		local UtilityPage = page:addSection("Utility")
		local LatexPage = page:addSection("Latex")

		UtilityPage:addButton("Reset", function()
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
				game.Players.LocalPlayer.Character.Humanoid.Health = 0
			end
		end)


		LatexPage:addButton("Red speed", function()
			if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-947, 170, 298)
			end
		end)
	end







	game:GetService("RunService").RenderStepped:Wait()

	--Starving artist
	if game.PlaceId == 8916037983 then
		local page = venyx:addPage("Starving artist", 9460743904)

		local NormalPage = page:addSection("Copy art")



		NormalPage:addTextbox("Player to copy", "player name", function(value, focusLost)
			if focusLost then
				if game.Players:FindFirstChild(value) then
					ArtistToCopyName = value
				else
					venyx:Notify("Error", "Player not found")
				end
			end
		end)

		NormalPage:addTextbox("Art number", "Enter number", function(value, focusLost)
			if focusLost then
				ArtistPlotNum = value
			end
		end)

		NormalPage:addSlider("Paint speed", 5, 1, 20, function(value)
			PaintSpeed = (20 - value) / 35
		end)

		NormalPage:addButton("Preview paint", function()
			local imageBytes = {}
			local IDPAINT = PaintID


			for i=1,1024 do
				table.insert(imageBytes, i, workspace.Plots[ArtistToCopyName].Easels[ArtistPlotNum].Canvas.SurfaceGui.Grid[i].BackgroundColor3)
			end


			local UI = game.Players.LocalPlayer.PlayerGui.MainGui.PaintFrame.GridHolder.Grid
			for i,v in pairs(imageBytes) do
				UI[i].BackgroundColor3  = v
				if PaintID ~= IDPAINT then
					break
				end
			end


			local function color_pixel(index,color)
				local connection = (getconnections(UI[tostring(index)].MouseButton1Click))[1]
				setupvalue(connection.Function,9,color)
				connection.Function()
			end
			local low_quality = 25

			lq=low_quality
			for i=1,1024 do
				v=imageBytes[i]
				if not v  or not v.R or not v.G or not v.B then continue end
				if v.R == 0 and v.G == 0 and v.B == 0 then v = {R=255,G=255,B=255} end
				local r,g,b = v.R or 0,v.G or 0,v.B or 0
				print(i, r-(r%lq),g-(g%lq),b-(b%lq))
				color_pixel(i,Color3.fromRGB(r-(r%lq),g-(g%lq),b-(b%lq)))
			end

			wait(0.5)

			local imageBytes = {}
			local IDPAINT = PaintID


			for i=1,1024 do
				table.insert(imageBytes, i, Color3.new(1, 1, 1))
			end


			local UI = game.Players.LocalPlayer.PlayerGui.MainGui.PaintFrame.GridHolder.Grid
			for i,v in pairs(imageBytes) do
				UI[i].BackgroundColor3  = v
				if PaintID ~= IDPAINT then
					break
				end
			end


			local function color_pixel(index,color)
				local connection = (getconnections(UI[tostring(index)].MouseButton1Click))[1]
				setupvalue(connection.Function,9,color)
				connection.Function()
			end
			local low_quality = 25

			lq=low_quality
			for i=1,1024 do
				v=imageBytes[i]
				if not v  or not v.R or not v.G or not v.B then continue end
				if v.R == 0 and v.G == 0 and v.B == 0 then v = {R=255,G=255,B=255} end
				local r,g,b = v.R or 0,v.G or 0,v.B or 0
				color_pixel(i,Color3.fromRGB(r-(r%lq),g-(g%lq),b-(b%lq)))
			end
		end)

		NormalPage:addButton("Start paint", function()
			PaintID += 1

			local imageBytes = {}
			local IDPAINT = PaintID


			for i=1,1024 do
				table.insert(imageBytes, i, workspace.Plots[ArtistToCopyName].Easels[ArtistPlotNum].Canvas.SurfaceGui.Grid[i].BackgroundColor3)
			end


			local UI = game.Players.LocalPlayer.PlayerGui.MainGui.PaintFrame.GridHolder.Grid
			for i,v in pairs(imageBytes) do
				UI[i].BackgroundColor3  = v
				wait(PaintSpeed)
				if PaintID ~= IDPAINT then
					break
				end
			end


			local function color_pixel(index,color)
				local connection = (getconnections(UI[tostring(index)].MouseButton1Click))[1]
				setupvalue(connection.Function,9,color)
				connection.Function()
			end
			local low_quality = 25

			lq=low_quality
			for i=1,1024 do
				v=imageBytes[i]
				if not v  or not v.R or not v.G or not v.B then continue end
				if v.R == 0 and v.G == 0 and v.B == 0 then v = {R=255,G=255,B=255} end
				local r,g,b = v.R or 0,v.G or 0,v.B or 0
				color_pixel(i,Color3.fromRGB(r-(r%lq),g-(g%lq),b-(b%lq)))
			end
		end)

		NormalPage:addButton("Stop paint", function()
			PaintID += 1
		end)

		NormalPage:addButton("Show art number", function()
			for i, v in pairs(workspace.Plots:GetChildren()) do
				for i, b in pairs(v.Easels:GetChildren()) do
					local ArtInfo = b.ArtInfo:Clone()
					ArtInfo.Parent = b.Canvas
					ArtInfo.AlwaysOnTop = true
					ArtInfo.StudsOffset = Vector3.new(0, 0, 0)
					ArtInfo.MaxDistance = 50

					for i, c in pairs(ArtInfo.Frame.Info:GetChildren()) do
						if c.Name ~= "ArtName" and c.Name ~= "UIListLayout" then
							c:Destroy()
						end
					end

					ArtInfo.Frame.Info.ArtName.Text = "Art number : " ..b.Name

					game:GetService("Debris"):AddItem(ArtInfo, 3)
				end
			end
		end)


		NormalPage:addButton("Copy script to clipboard", function()

			local imageBytes = {}


			for i=1,1024 do
				table.insert(imageBytes, i, workspace.Plots[ArtistToCopyName].Easels[ArtistPlotNum].Canvas.SurfaceGui.Grid[i].BackgroundColor3)
			end

			local afterScript = [[
		local UI = game.Players.LocalPlayer.PlayerGui.MainGui.PaintFrame.GridHolder.Grid
		for i,v in pairs(imageBytes) do
			UI[i].BackgroundColor3  = v
			wait(0.3)
		end


		local function color_pixel(index,color)
			local connection = (getconnections(UI[tostring(index)].MouseButton1Click))[1]
			setupvalue(connection.Function,9,color)
			connection.Function()
		end
		local low_quality = 25

		lq=low_quality
		for i=1,1024 do
			v=imageBytes[i]
			if not v  or not v.R or not v.G or not v.B then continue end
			if v.R == 0 and v.G == 0 and v.B == 0 then v = {R=255,G=255,B=255} end
			local r,g,b = v.R or 0,v.G or 0,v.B or 0
			color_pixel(i,Color3.fromRGB(r-(r%lq),g-(g%lq),b-(b%lq)))
			end
			]] 


			local newbyte = ""

			for i, v in pairs(imageBytes) do		
				newbyte = newbyte.. "Color3.new(" ..tostring(v) ..") ,"
			end


			local byte = "local imageBytes = {" ..newbyte .."}"

			setclipboard(byte .."\n" ..afterScript)
		end)
	end



	game:GetService("RunService").RenderStepped:Wait()


	--LagTester
	if game.PlaceId == 6356806222 then
		local page = venyx:addPage("Lag tester", 8998677319)

		local NormalPage = page:addSection("Basic")

		NormalPage:addToggle("Auto Delete Part", nil, function(value)
			if value then
				for i, v in pairs(workspace.Parts:GetChildren()) do
					v:Destroy()
				end
			end
			autoDeletePart = value
		end)

		if workspace:FindFirstChild("Parts") then
			workspace.Parts.ChildAdded:Connect(function(child)
				if autoDeletePart and alive then
					game:GetService("RunService").RenderStepped:Wait()
					child:Destroy()
				end
			end)
		end
	end

	game:GetService("RunService").RenderStepped:Wait()



	--Farming and friends
	if game.PlaceId == 2772610559 then
		local page = venyx:addPage("Farming and friends", 9027120450)

		local NormalPage = page:addSection("Basic")


		NormalPage:addToggle("Show prices", nil, function(value)
			showFarmOffer = value
			local hostFrame = nil

			if value then
				hostFrame = Instance.new("Frame")
				hostFrame.Parent = game.CoreGui:FindFirstChild(name)
				hostFrame.Name = "Price"
				hostFrame.BackgroundTransparency = 1
				hostFrame.Size = UDim2.new(0.15, 0, 0.7, 0)
				hostFrame.Position = UDim2.new(0.82, 0, 0.03, 0)

				PriceFrame = workspace.SellValues.SellValues.SurfaceGui.Frame:Clone()
				PriceFrame.Parent = hostFrame
				PriceFrame.Size = UDim2.new(1, 0, 1, 0)

				while true do
					wait(1)

					if not PriceFrame then
						break
					end

					PriceFrame:Destroy()
					PriceFrame = workspace.SellValues.SellValues.SurfaceGui.Frame:Clone()
					PriceFrame.Parent = hostFrame
					PriceFrame.Size = UDim2.new(1, 0, 1, 0)

				end
			else
				hostFrame:Destroy()
			end
		end)

		if workspace:FindFirstChild("Parts") then
			workspace.Parts.ChildAdded:Connect(function(child)
				if autoDeletePart and alive then
					game:GetService("RunService").RenderStepped:Wait()
					child:Destroy()
				end
			end)
		end

		NormalPage:addButton("Sell egg", function()
			local root = game.Players.LocalPlayer.Character.HumanoidRootPart
			local basePos = root.CFrame

			root.CFrame = CFrame.new(-388, 14, 1427)
			wait(0.2)
			root.CFrame = basePos
		end)

		NormalPage:addButton("Refresh seed", function()
			local root = game.Players.LocalPlayer.Character.HumanoidRootPart
			local basePos = root.CFrame

			root.CFrame = CFrame.new(-388, -30000, 1427)
			VirtualInputManager:SendKeyEvent(true, "F", false, game)
			wait(0.1)
			VirtualInputManager:SendKeyEvent(false, "F", false, game)
			wait(0.5)
			root.CFrame = basePos
		end)

	end


	game:GetService("RunService").RenderStepped:Wait()

	-- ANIMAL SIMULATOR

	if game.GameId == 2023680558 then
		local page = venyx:addPage("Animal simulator", 8988803597)

		local ChestPage = page:addSection("Chest")
		local packPage = page:addSection("Pack and Name")
		local BossPage = page:addSection("Boss (beta)")
		local trollPage = page:addSection("Troll")
		local OtherPage = page:addSection("Other")

		ChestPage:addToggle("farm bot", nil, function(value)
			bot = value
			if bot then
				loadstring(game:HttpGet("https://pastebin.com/raw/Q37wgSjN", true))()
			else
				game.Players.LocalPlayer.Character.Humanoid.Name = "a"
				wait(0.2)
				game.Players.LocalPlayer.Character.a.Name = "Humanoid"
			end
		end)

		ChestPage:addToggle("bring chest", nil, function(value)
			bringChest = value
		end)

		ChestPage:addToggle("tp to chest", nil, function(value)
			toChest = value
		end)

		ChestPage:addToggle("autocollect", nil, function(value)
			autocollect = value
		end)

		ChestPage:addToggle("autocollect egg", nil, function(value)
			autocollectEgg = value
		end)

		ChestPage:addSlider("autocollect egg speed", 10, 0, 10, function(value)
			autocollectEggSpeed = value
		end)


		ChestPage:addToggle("Hide chest reward", nil, function(value)
			HideReward = value
		end)





		packPage:addButton("Create invisible pack", function()
			game:GetService("Players").LocalPlayer.PlayerGui.TeamGUI.noTeamFrame.teamInfo.createBtn.createTeamEvent:FireServer(nil)
			game:GetService("Players").LocalPlayer.PlayerGui.TeamGUI.Enabled = true
		end)

		packPage:addButton("Remove name caracter limit", function()
			game.Players.LocalPlayer.PlayerGui.RolePlayName.Frame.NameTB.limit:Destroy()
		end)




		BossPage:addToggle("Killaura lava gorilla", nil, function(value)
			_G.BossGorillaFarm = value
		end)

		BossPage:addButton("tp to Gorilla", function()
			if game.Workspace.NPC:findFirstChild("LavaGorilla") and game.Workspace.NPC.LavaGorilla:findFirstChild("HumanoidRootPart") then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.NPC.LavaGorilla.HumanoidRootPart.Position)
			else
				venyx:Notify("ERROR", "gorilla is death !")
			end
		end)

		BossPage:addToggle("Killaura cerbus", nil, function(value)
			_G.BossCerberFarm = value
		end)

		BossPage:addButton("tp to cerber", function()
			if game.Workspace.NPC:findFirstChild("Trex") and game.Workspace.NPC.Trex:findFirstChild("HumanoidRootPart") then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.NPC.Trex.HumanoidRootPart.Position)
			else
				venyx:Notify("ERROR", "cerber is death !")
			end
		end)

		BossPage:addToggle("Killaura drake", nil, function(value)
			_G.BossDrakeFarm = value
		end)

		BossPage:addButton("tp to drake", function()
			if game.Workspace.NPC:findFirstChild("Drake") and game.Workspace.NPC.Drake:findFirstChild("HumanoidRootPart") then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.NPC.Drake.HumanoidRootPart.Position)
			else
				venyx:Notify("ERROR", "drake is death !")
			end
		end)

		BossPage:addToggle("DragonSlayer", nil, function(value)
			_G.BossDragonSlayerFarm = value
		end)

		BossPage:addButton("tp to DragonSlayer", function()
			if game.Workspace.NPC:findFirstChild("DragonSlayer") and game.Workspace.NPC.DragonSlayer:findFirstChild("HumanoidRootPart") then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.NPC.DragonSlayer.HumanoidRootPart.Position)
			else
				venyx:Notify("ERROR", "DragonSlayer is death !")
			end
		end)



		trollPage:addButton("Drop head (animal)", function()
			game.Players.LocalPlayer.Character.Neck.Motor6D:Destroy()
		end)


		OtherPage:addToggle("Show player Username", nil, function(value)
			if value then
				game.Players.LocalPlayer.NameDisplayDistance = 100000
			else
				game.Players.LocalPlayer.NameDisplayDistance = 0
			end
		end)









		---- TP
		--local page = venyx:addPage("TP", 8988803597)

		--local TpPage = page:addSection("Teleport")


		--TpPage:addButton("Safe zone", function()
		--	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-559, -408, 2489)
		--end)

		--TpPage:addButton("DJ", function()
		--	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-819, -403, 2486)
		--end)

		--TpPage:addButton("Gorrila spawn", function()
		--	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(516, -337, 2092)
		--end)

		--TpPage:addButton("Cerber spawn", function()
		--	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-254, -424, 3321)
		--end)

		--TpPage:addButton("Secret base", function()
		--	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-636, -410, 3012)
		--end)






		-- PVP
		local page = venyx:addPage("PVP", 10609187462)

		local keyboardPage = page:addSection("Autokeyboard")
		--local ItemPage = page:addSection("GiveItem")
		local zombiePage = page:addSection("Zombie Kill aura")
		local KillAuraPage = page:addSection("Kill aura")
		local KillAuraPage1 = page:addSection("Kill aura1")
		local KillAuraPage2 = page:addSection("Kill aura2")
		local KillAuraPage3 = page:addSection("Kill aura3")
		local KillAuraPage4 = page:addSection("Kill aura4")

		keyboardPage:addToggle("auto hit", nil, function(value)
			autoHit = value
		end)

		keyboardPage:addToggle("auto eat (unstable)", nil, function(value)
			autoEat = value
		end)



		--ItemPage:addButton("Give fireball", function()
		--	local FireFounded = false
		--	for i, v in pairs(game.Players:GetDescendants()) do
		--		if v.Name == "Fireball" and v:FindFirstChild("FireballEvent") then
		--			v.Parent = game.Players.LocalPlayer.Backpack
		--			FireFounded = true
		--		end
		--	end
		--	if not FireFounded then
		--		venyx:Notify("Error", "No fire found :c")
		--	end
		--end)


		zombiePage:addToggle("Zombie kill aura", nil, function(value)
			ZombieKillAura = value
		end)





		KillAuraPage:addToggle("Kill aura", nil, function(value)
			KillAura = value
		end)

		KillAuraPage:addKeybind("Kill aura keybind", nil, function()
			KillAura = not KillAura
			KillAuraPage:updateToggle("Kill aura", "Kill aura", KillAura)
		end)






		KillAuraPage1:addTextbox("kill aura target", "player name", function(value, focusLost)
			if focusLost then
				killAuraTarget1 = value
			end
		end)

		KillAuraPage1:addKeybind("Hit this player : ", Enum.KeyCode.E, function()
			if game.Players:FindFirstChild(killAuraTarget1) then
				game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game.Players:FindFirstChild(killAuraTarget1).Character.Humanoid)
			end
		end)

		KillAuraPage1:addToggle("spam hit", nil, function(value)
			spamHit1 = value
		end)






		KillAuraPage2:addTextbox("kill aura target", "player name", function(value, focusLost)
			if focusLost then
				killAuraTarget2 = value
			end
		end)

		KillAuraPage2:addKeybind("Hit this player : ", Enum.KeyCode.E, function()
			if game.Players:FindFirstChild(killAuraTarget1) then
				game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game.Players:FindFirstChild(killAuraTarget1).Character.Humanoid)
			end
		end)

		KillAuraPage2:addToggle("spam hit", nil, function(value)
			spamHit2 = value
		end)






		KillAuraPage3:addTextbox("kill aura target", "player name", function(value, focusLost)
			if focusLost then
				killAuraTarget3 = value
			end
		end)

		KillAuraPage3:addKeybind("Hit this player : ", Enum.KeyCode.E, function()
			if game.Players:FindFirstChild(killAuraTarget1) then
				game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game.Players:FindFirstChild(killAuraTarget1).Character.Humanoid)
			end
		end)

		KillAuraPage3:addToggle("spam hit", nil, function(value)
			spamHit3 = value
		end)






		KillAuraPage4:addTextbox("kill aura target", "player name", function(value, focusLost)
			if focusLost then
				killAuraTarget4 = value
			end
		end)

		KillAuraPage4:addKeybind("Hit this player : ", Enum.KeyCode.E, function()
			if game.Players:FindFirstChild(killAuraTarget1) then
				game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game.Players:FindFirstChild(killAuraTarget1).Character.Humanoid)
			end
		end)

		KillAuraPage4:addToggle("spam hit", nil, function(value)
			spamHit4 = value
		end)












		---- Autofarm
		--local page = venyx:addPage("Autofarm", 8988803597)

		--local onlineAutofarmPage = page:addSection("Online autofarm")
		--local afkAutofarmPage = page:addSection("afk autofarm")


		--onlineAutofarmPage:addToggle("boss kill farm", nil, function(value)
		--	BossKillFarm = value
		--end)



		--afkAutofarmPage:addToggle("training area farm", nil, function(value)
		--	autofarm = value
		--	if value then
		--		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-562 , -409, 2531)
		--		for i, v in pairs(game.Workspace.pleaseno:GetChildren()) do
		--			if i == 7 then
		--				v.Name = "farm"
		--			end
		--		end
		--	else

		--	end
		--end)


		--afkAutofarmPage:addToggle("boss kill farm fix", nil, function(value)
		--	if value then
		--		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(129, -70, 2443)
		--		vu:SetKeyDown("t")
		--		vu:SetKeyUp("t")
		--	else
		--		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(259.826, -12.396, 3053.77)
		--	end
		--	BossKillFarmFix = value
		--end)


		--afkAutofarmPage:addToggle("Zombie Autofarm", nil, function(value)
		--	ZombieAutofarm = value
		--	if value then

		--	else
		--		game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = false
		--		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(259.826, -12.396, 3053.77)
		--	end
		--end)
	end


	game:GetService("RunService").RenderStepped:Wait()
	----------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------Pizza place-------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------
	print(game.GameId)
	if game.GameId == 47545 then
		local page = venyx:addPage("Pizza place", 8988812453)

		local AutoworkPage = page:addSection("Autowork")


		AutoworkPage:addToggle("Cashier", nil, function(value)
			doCashier = value
		end)

		AutoworkPage:addToggle("Cook", nil, function(value)
			doCook = value
		end)

		AutoworkPage:addToggle("Boxer", nil, function(value)
			doBoxer = value
		end)

		AutoworkPage:addToggle("Delivrery", nil, function(value)
			doDelivery = value
		end)

		AutoworkPage:addToggle("Supplier", nil, function(value)
			doSupplier = value
		end)

	end


	game:GetService("RunService").RenderStepped:Wait()
	----------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------BUILD A BOAT------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------

	if game.GameId == 210851291 then
		local page = venyx:addPage("Build a boat", 8988823793)

		local AutofarmPage = page:addSection("Autofarm")
		local MiscPage = page:addSection("Misc")
		local Transform = page:addSection("Transform")
		local Utility = page:addSection("Utility")


		AutofarmPage:addToggle("fast autofarm", nil, function(value)
			BABFastAutofarm = value
			if value then
				autoFarmBAB()
			else

			end
		end)

		AutofarmPage:addSlider("Autofarm speed", 4, 1, 5, function(value)
			BABAutofarmSpeed = 6 - value
		end)

		MiscPage:addButton("Water Godmode", function()
			LocalPlayerName = game:GetService("Players").LocalPlayer.Name
			LocalPlayerWorkspace = game:GetService("Workspace")[LocalPlayerName]
			LocalPlayerWorkspace.WaterDetector:Destroy()
		end)



		Transform:addButton("Fox Character", function()
			game.Workspace.ChangeCharacter:FireServer("FoxCharacter")
		end)
		Transform:addButton("Chicken Character", function()
			game.Workspace.ChangeCharacter:FireServer("ChickenCharacter")
		end)
		Transform:addButton("Penguin Character", function()
			game.Workspace.ChangeCharacter:FireServer("PenguinCharacter")
		end)


		Utility:addToggle("Anti Portal Abuse", nil, function(value)
			antiPortalAbuse = value
		end)

		Utility:addTextbox("slot", "slot number", function(value, focusLost)
			if focusLost then
				SlotNumber = value
			end
		end)

		Utility:addButton("Load slot", function()
			local args = {
				[1] = SlotNumber,
				[2] = 0
			}

			workspace.LoadBoatData:FireServer(unpack(args))

		end)

		Utility:addButton("Clear all", function()
			workspace.ClearAllPlayersBoatParts:FireServer()
		end)

		Utility:addButton("Buy 50 wood", function()
			local args = {
				[1] = "WoodBlock",
				[2] = 1
			}

			workspace.ItemBoughtFromShop:InvokeServer(unpack(args))
		end)

		Utility:addButton("Hide menu", function()
			game.Players.LocalPlayer.PlayerGui.ShopGui.SideFrame.MenuButton.Visible = false
			game.Players.LocalPlayer.PlayerGui.GoldGui.Frame.Visible = false
			game.Players.LocalPlayer.PlayerGui.LaunchBoatGui.LaunchFrame.Visible = false
			game.Players.LocalPlayer.PlayerGui.PlayerListGui.Frame.Visible = false

			for i, Item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
				Item:Destroy()
			end
		end)
	end











	game:GetService("RunService").RenderStepped:Wait()
	----------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------ISLAND------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------

	if game.GameId == 1659645941 then
		--Func
		local function getItem(itemName)
			if itemName then
				local item
				if game.Players.LocalPlayer.Backpack:FindFirstChild(itemName) then
					item = game.Players.LocalPlayer.Backpack:FindFirstChild(itemName) 
				else
					item = game.Players.LocalPlayer.Character:FindFirstChildOfClass(itemName)
				end

				return item
			end
		end


		--Vars
		local debugMode = false
		local CropList = {"wheat", "tomato", "carrot", "berryBush"}
		local OreList = {"rockIron", "rockCoal", "rockStone", "rockDiorite", "rockCopper", "rockGranite", "rockAndesite", "rockGold", "marinePlant1", "marinePlant2", "marinePlant3", "marinePlant4", "marinePlant5", "marinePlant6", "rockSandstone", "rockPrismarine", "rockSlate", "bamboo", "acorn", "horseradish", "tomato", "flowerCrocus", "flowerDaffodil", "rockElectrite", "rockMarble", "mushroomRed", "rockBasalt", "rockSandstoneRed", "rockDiamond"}
		local SickleList = {"sickleIron"}




		local page = venyx:addPage("Farm", 10771926797)


		local OrePage = page:addSection("Ore")

		local OreKillAura
		OrePage:addToggle("Ore killaura", nil, function(value)
			OreKillAura = value

			while OreKillAura do
				wait()
				local success = pcall(function()
					local Ore = OreList

					local part
					local block
					local maxDistance = 30
					for i, v in pairs(workspace.WildernessBlocks:GetChildren()) do
						if (v:FindFirstChild("Targettable") or v:FindFirstChild("Health")) and table.find(Ore, v.Name) then
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < maxDistance then
								part = v
								block = part:FindFirstChildOfClass("MeshPart")
								maxDistance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
							end
						end
					end


					for i, v in pairs(workspace.Islands:GetChildren()) do
						for i, v in pairs(v.Blocks:GetChildren()) do
							if v:FindFirstChild("Targettable") and table.find(Ore, v.Name) then
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < maxDistance then
									part = v
									block = part:FindFirstChildOfClass("MeshPart")
									maxDistance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
								end
							end
						end
					end

					if not part then game.foijehjgqhigeshgjhe:Destroy() end

					if debugMode and part then
						part.Transparency = 0
						spawn(function()
							wait(1)
							part.Transparency = 1
						end)

					end

					local args = {
						[1] = {
							["player_tracking_category"] = "join_from_web",
							["part"] = block,
							["block"] = part,
							["norm"] = part.Position + Vector3.new(math.random(-1000000, 1000000) / 1000000, math.random(-1000000, 1000000) / 1000000, math.random(-1000000, 1000000) / 1000000),
							["pos"] = Vector3.new(-0.0819238245487213, 0.0216049909591675, -0.06912681460380554)
						}
					}

					game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
				end)

				if not success then
					wait(0.5)
				end
			end
		end)



		local TreePage = page:addSection("Tree")
		local TreeKillAura
		TreePage:addToggle("Tree killaura", nil, function(value)
			TreeKillAura = value

			while TreeKillAura do
				wait()
				local success = pcall(function()

					local part
					local block

					for i, v in pairs(workspace.Islands:GetChildren()) do
						for i, v in pairs(v.Blocks:GetChildren()) do
							if v:FindFirstChild("Targettable") and v:FindFirstChild("trunk") then
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 30 then
									part = v
									block = part:FindFirstChildOfClass("MeshPart")
								end
							end
						end
					end



					if not part then game.foijehjgqhigeshgjhe:Destroy() end

					if debugMode and part then
						part.Transparency = 0
						spawn(function()
							wait(1)
							part.Transparency = 1
						end)

					end

					local args = {
						[1] = {
							["player_tracking_category"] = "join_from_web",
							["part"] = block,
							["block"] = part,
							["norm"] = part.Position + Vector3.new(math.random(-1000000, 1000000) / 1000000, math.random(-1000000, 1000000) / 1000000, math.random(-1000000, 1000000) / 1000000),
							["pos"] = Vector3.new(-0.0819238245487213, 0.0216049909591675, -0.06912681460380554)
						}
					}

					game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
				end)

				if not success then
					wait(0.5)
				end
			end
		end)




		local CropPage = page:addSection("Crop")

		local SeedType = nil
		CropPage:addDropdown("Seed type", CropList, function(value)
			SeedType = value
		end)

		local AutoPlant
		CropPage:addToggle("AutoPlant seed", nil, function(value)

			AutoPlant = value
		end)


		local ignored = {}
		spawn(function()
			while true do
				wait()
				if AutoPlant then
					spawn(function()
						local part
						local maxDistance = 10

						for i, v in pairs(workspace.Islands:GetChildren()) do
							for i, v in pairs(v.Blocks:GetChildren()) do
								if v.Name == "soil" then
									if not table.find(ignored, v.Position) and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < maxDistance then
										maxDistance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
										part = v
									end
								end
							end
						end

						if not part then return end

						table.insert(ignored, part.Position)

						-- Script generated by SimpleSpy - credits to exx#9394

						local args = {
							[1] = {
								["upperBlock"] = false,
								["cframe"] = CFrame.new(part.Position + Vector3.new(0, 3, 0)),
								["player_tracking_category"] = "join_from_web",
								["blockType"] = SeedType
							}
						}

						game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_PLACE_REQUEST:InvokeServer(unpack(args))

						wait(30)
						if part then
							table.remove(ignored, table.find(ignored, part.Position))
						end
					end)
				end
			end
		end)






		local CollectCropPage = page:addSection("Collect Crop")

		local CropType = nil
		local SickleType = "sickleIron"
		CollectCropPage:addDropdown("Crop type", CropList, function(value)
			CropType = value
		end)

		CollectCropPage:addDropdown("sickleIron", SickleList, function(value)
			SickleType = value
		end)



		CollectCropPage:addButton("Autocollect crop (1 time)", function()



			local CropTable = {}
			local maxDistance = 30

			for i, v in pairs(workspace.Islands:GetChildren()) do
				for i, v in pairs(v.Blocks:GetChildren()) do
					if v.Name == CropType and v:FindFirstChildOfClass("MeshPart")--[[.Harvestable.Value]] then
						--if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < maxDistance then
						table.insert(CropTable, v)
						--end
					end
				end
			end

			local args = {
				[1] = SickleType,
				[2] = CropTable
			}

			game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.SwingSickle:InvokeServer(unpack(args))
		end)



		local AutocollectCrop
		CollectCropPage:addToggle("Autocollect crop", nil, function(value)

			AutocollectCrop = value

			while true do

				if AutocollectCrop then
					spawn(function()
						local CropTable = {}
						local maxDistance = 30

						for i, v in pairs(workspace.Islands:GetChildren()) do
							for i, v in pairs(v.Blocks:GetChildren()) do
								if v.Name == CropType and v:FindFirstChildOfClass("MeshPart")--[[.Harvestable.Value]] then
									--if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < maxDistance then
									table.insert(CropTable, v)
									--end
								end
							end
						end

						local args = {
							[1] = SickleType,
							[2] = CropTable
						}

						local test = game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.SwingSickle:InvokeServer(unpack(args))
						print(test)
					end)
				end
				wait(5)
			end
		end)













		local page = venyx:addPage("Mobs", 10609187462)
		local KillauraPage = page:addSection("Killaura")

		local KillAura
		KillauraPage:addToggle("Mob killaura", nil, function(value)
			KillAura = value

			while KillAura do
				wait()
				spawn(function()
					local mob
					local maxDistance = 25
					for i, v in pairs(workspace.WildernessIsland.Entities:GetChildren()) do
						if v:FindFirstChild("HumanoidRootPart") then
							if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude < maxDistance then
								mob = v
								maxDistance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
							end
						end
					end

					if not mob then return end


					if debugMode and mob then
						mob.HumanoidRootPart.Transparency = 0
						spawn(function()
							wait(1)
							mob.HumanoidRootPart.Transparency = 1
						end)

					end

					local args = {
						[1] = mob.EntityUUID.Value,
						[2] = {
							[1] = {
								["crit"] = true,
								["hitUnit"] = mob
							}
						}
					}

					game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged:FindFirstChild("terrcshoq/umrlwcamfgjXqitufk"):FireServer(unpack(args))


					local test = game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_HIT_REQUEST:InvokeServer(unpack(args))
					for i, v in pairs(test) do
					end
				end)
			end
		end)



		local FishPage = page:addSection("Fish")



		local AutoFish
		FishPage:addToggle("AutoFish", nil, function(value)
			AutoFish = value

			while AutoFish do



				local args = {
					[1] = "355FC045-DDBC-4674-AE7F-0C7B2F5554B5",
					[2] = {
						[1] = {
							["playerLocation"] = Vector3.new(849.4759521484375, 167.7027587890625, -192.07177734375),
							["direction"] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.LookVector,
							["strength"] = .1
						}
					}
				}

				game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged:FindFirstChild("DvosejhsednqzobbdtGxlnmmhbb/qKhpcuifvhy"):FireServer(unpack(args))
				local count = 0
				repeat
					wait(0.1)
					count += 1
				until game:GetService("Players").LocalPlayer.PlayerGui.ActionBarScreenGui.ActionBar:FindFirstChild("RoactTree") or count >= 150
				wait()
				local args2 = {
					[1] = {
						["success"] = true
					}
				}

				game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged:FindFirstChild("DvosejhsednqzobbdtGxlnmmhbb/Ukpyunbwugyb"):FireServer(unpack(args2))
				wait(0.3)
				game.Players.LocalPlayer.Character.Humanoid.Jump = true
				wait(1)
			end
		end)







		local page = venyx:addPage("Machine", 10772145727)
		local AutofillPage = page:addSection("Autofill")

		local KillAura
		AutofillPage:addToggle("Autofill steel mill", nil, function(value)
			KillAura = value

			while KillAura do
				wait(0.5)
				spawn(function()
					-- Script generated by SimpleSpy - credits to exx#9394
					local item
					local itemToPut
					local maxDistance = 25
					local items = {"steelMill"}
					for i, v in pairs(workspace.Islands:GetChildren()) do
						for i, v in pairs(v.Blocks:GetChildren()) do
							if table.find(items, v.Name) then
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < maxDistance then
									local TempItemToPut

									if not v.Working.Value then
										TempItemToPut = "iron"
									end
									if #v.WorkerFuel:GetChildren() < 3 then
										print(#v.WorkerFuel:GetChildren())
										TempItemToPut = "coal"
									end
									if TempItemToPut then
										item = v
										itemToPut = TempItemToPut
										maxDistance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
									end
								end
							end
						end
					end

					if not item then return end

					if debugMode and item then
						item.Transparency = 0
						spawn(function()
							wait(1)
							item.Transparency = 1
						end)
						print(itemToPut)
					end

					local args = {
						[1] = {
							["amount"] = 1,
							["block"] = item,
							["player_tracking_category"] = "join_from_web",
							["toolName"] = itemToPut
						}
					}

					game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_WORKER_DEPOSIT_TOOL_REQUEST:InvokeServer(unpack(args))
				end)
			end
		end)



		local AutoSmellPage = page:addSection("Auto Smelting")

		local Autosmell
		local AutosmellItem
		AutoSmellPage:addDropdown("Item", {"ironOre", "goldOre"}, function(value)
			AutosmellItem = value
		end)

		AutoSmellPage:addToggle("Autosmell", nil, function(value)
			Autosmell = value

			while Autosmell do
				wait()

				local success = pcall(function()
					local item
					local itemToPut
					local maxDistance = 25
					local items = {"smallFurnace"}
					local collect = false
					for i, v in pairs(workspace.Islands:GetChildren()) do
						for i, v in pairs(v.Blocks:GetChildren()) do
							if table.find(items, v.Name) then
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < maxDistance then
									local tempItemToPut 
									local tempCollect = false



									if not v.WorkerFuel:FindFirstChild("coal") or (v.WorkerFuel:FindFirstChild("coal") and v.WorkerFuel.coal.Amount.Value < v.WorkerMaxFuel.Value) then

										--print(v.WorkerFuel:FindFirstChildOfClass("Tool").Amount.Value)
										tempItemToPut = "coal"
									end
									if not v.WorkerContents:FindFirstChild(AutosmellItem) or (v.WorkerContents:FindFirstChild(AutosmellItem) and v.WorkerContents[AutosmellItem].Amount.Value < v.WorkerMaxContents.Value) then
										tempItemToPut = AutosmellItem
									end
									if v.WorkerOutputContents:FindFirstChildOfClass("Tool") then
										tempCollect = true
									end

									local Tool = getItem(tempItemToPut)
									if (tempItemToPut and Tool and Tool.Amount.Value > 0) or tempCollect ~= false then
										itemToPut = tempItemToPut
										collect = tempCollect
										item = v
										maxDistance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude

									end		
								end
							end
						end
					end

					if debugMode and item then
						item.Transparency = 0
						spawn(function()
							wait(1)
							item.Transparency = 1
						end)

					end


					if not collect then
						if itemToPut then
							local Tool = getItem(itemToPut)

							if item then
								local args = {
									[1] = {
										["amount"] = Tool.Amount.Value,
										["block"] = item,
										["player_tracking_category"] = "join_from_web",
										["toolName"] = itemToPut
									}
								}

								game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_BLOCK_WORKER_DEPOSIT_TOOL_REQUEST:InvokeServer(unpack(args))
							end	
						else
							game.zkqjigfjzqifj:Destroy()
						end
					else


						local args = {
							[1] = {
								["tool"] = item.WorkerOutputContents:FindFirstChildOfClass("Tool"),
								["player_tracking_category"] = "join_from_web"
							}
						}

						game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_TOOL_PICKUP_REQUEST:InvokeServer(unpack(args))

					end	
				end)

				if not success then
					wait(2)
					print("test")
				end
			end
		end)







		local page = venyx:addPage("Misc", 10771886383)
		local chestPage = page:addSection("Collect chest")

		local ChestAutocollect
		chestPage:addToggle("Autocollect near chest", nil, function(value)
			ChestAutocollect = value

			while ChestAutocollect do
				wait()
				local success = pcall(function()

					local item
					local maxDistance = 25
					local items = {"chestMediumIndustrial", "chestMediumIndustrialIO"}
					for i, v in pairs(workspace.Islands:GetChildren()) do
						for i, v in pairs(v.Blocks:GetChildren()) do
							if table.find(items, v.Name) and v.Contents:FindFirstChildOfClass("Tool") then
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < maxDistance then
									item = v
									maxDistance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
								end
							end
						end
					end

					if not item then game.fkjzhfjsh:Destroy() end

					if debugMode and item then
						item.Transparency = 0
						spawn(function()
							wait(1)
							item.Transparency = 1
						end)

					end

					local args = {
						[1] = {
							["chest"] = item,
							["player_tracking_category"] = "join_from_web",
							["amount"] = item.Contents:FindFirstChildOfClass("Tool").Amount.Value,
							["tool"] = item.Contents:FindFirstChildOfClass("Tool"),
							["action"] = "withdraw"
						}
					}

					game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_CHEST_TRANSACTION:InvokeServer(unpack(args))

				end)

				if not success then
					wait(1)
				end
			end
		end)




		local CharacterPage = page:addSection("Character")


		CharacterPage:addButton("God mode", function()
			game.Players.LocalPlayer.Character.CurrentHealth:Destroy()
		end)

		local IslandSpeed = false
		CharacterPage:addToggle("Speed", nil, function(value)
			IslandSpeed = value
		end)

		local function SetCharSpeed(char)
			char:WaitForChild("Humanoid").Changed:Connect(function()
				if IslandSpeed then
					char.Humanoid.WalkSpeed = 25
				end
			end)
		end

		game.Players.LocalPlayer.CharacterAdded:Connect(SetCharSpeed)
		SetCharSpeed(game.Players.LocalPlayer.Character)





		local AutobuyPage = page:addSection("Autobuy")

		local ItemAmount = 1
		local buyID = 101
		local merchant = "general"
		AutobuyPage:addTextbox("Item count", 1, function(value, focuslost)
			if focuslost then
				ItemAmount = tonumber(value)
			end
		end)

		AutobuyPage:addDropdown("Dirt", {"Dirt", "Glass block", "Sand", "Iron totem", "Coal totem"}, function(value)

			if value == "Dirt" then
				buyID = 101
				merchant = "general"
			end

			if value == "Glass block" then
				buyID = 105
				merchant = "general"
			end

			if value == "Sand" then
				buyID = 102
				merchant = "general"
			end



			if value == "Iron totem" then
				buyID = 2
				merchant = "totems"
			end

			if value == "Coal totem" then
				buyID = 3
				merchant = "totems"
			end


		end)

		AutobuyPage:addButton("Buy", function()
			local args = {
				[1] = {
					["merchant"] = "general",
					["offerId"] = buyID,
					["amount"] = ItemAmount
				}
			}

			game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_MERCHANT_ORDER_REQUEST:InvokeServer(unpack(args))

		end)







		local AutosellPage = page:addSection("Autosell")

		local ItemAmount = 1
		local sellID = 1
		AutosellPage:addTextbox("Item count", 1, function(value, focuslost)
			if focuslost then
				ItemAmount = tonumber(value)
			end
		end)

		AutosellPage:addDropdown("Wheat", {"Wheat", "Tomato", "Carrot", "Orange"}, function(value)

			if value == "Wheat" then
				sellID = 1
			end

			if value == "Tomato" then
				sellID = 5
			end

			if value == "Carrot" then
				sellID = 2
			end

			if value == "Orange" then
				sellID = 201
			end


		end)

		AutosellPage:addButton("Sell", function()

			local args = {
				[1] = {
					["merchant"] = "cropSell",
					["offerId"] = sellID,
					["amount"] = ItemAmount
				}
			}

			game:GetService("ReplicatedStorage").rbxts_include.node_modules.net.out._NetManaged.CLIENT_MERCHANT_ORDER_REQUEST:InvokeServer(unpack(args))

		end)






		local SettingPage = page:addSection("Setting")

		local ChestAutocollect
		SettingPage:addToggle("Debug mode", nil, function(value)
			debugMode = value
		end)
	end








	----------------------------------------------------------------------------------------------------------------------------
	----------------------------------------------TEST ZONE---------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------
	--local page = venyx:addPage("Test zone", 5012544693)

	--local testPage = page:addSection("Test")

	--testPage:addTextbox("Notification", "Default", function(value, focusLost)
	--	if focusLost then
	--		venyx:Notify("Title", "text")
	--	end
	--end)

	----local plrs = {}
	----for i, v in pairs(game.Players:GetPlayers()) do
	----	table.insert(plrs, 1, v.Name)
	----end
	----testPage:addDropdown("Dropdown", plrs, function(text)
	----	print("Selected", text)
	----end)

	--BasicHack:addKeybind("test", Enum.KeyCode.E, function(value)
	--	print(value)
	--end)

	--testPage:addKeybind("BasePrint", nil, function(value)
	--	print(value)
	--end)



	--testPage:addSlider("test", testSpeedValue, 1, 1000, function(value)

	--end)

	-- Saved script
	--local setting = venyx:addPage("Games supported", 10772550465)
	--local GamesList = setting:addSection("games (click to teleport)")


	game:GetService("RunService").RenderStepped:Wait()
	-- THEME
	local theme = venyx:addPage("Theme", 8988837477)
	local ThemePresets = theme:addSection("Theme Presets")
	local colors = theme:addSection("Colors")


	ThemePresets:addButton("Copy theme", function()
		local stringText = [[themes = {
	]]

		for i, v in pairs(themes) do
			stringText = stringText ..i .. " = Color3.new(" ..tostring(v) ..[[),
		]]
		end

		stringText = stringText ..[[
	}]]

		setclipboard(stringText)
	end)

	ThemePresets:addButton("Copy base theme", function()
		setclipboard([[themes = {
		NotToggledColor =  Color3.fromRGB(255, 100, 89),
		Background = Color3.fromRGB(25,25,25),
		Glow = Color3.fromRGB(0,0,0),
		Accent = Color3.fromRGB(255, 113, 51),
		LightContrast = Color3.fromRGB(40,40,40),
		DarkContrast = Color3.fromRGB(30,30,30),
		TextColor = Color3.fromRGB(255, 255, 255),
		ButtonColor = Color3.fromRGB(62, 62, 62),
		ToggledColor = Color3.fromRGB(255, 113, 51),
		SliderColor = Color3.fromRGB(255, 113, 51),
		TopBarColor = Color3.fromRGB(35,35,35),
		}]])
	end)

	for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
		colors:addColorPicker(theme, color, function(color3)
			venyx:setTheme(theme, color3)
		end)
	end


	game:GetService("RunService").RenderStepped:Wait()
	-- SETTING
	local setting = venyx:addPage("Core", 8988843992)
	local BasicSetting = setting:addSection("Basic setting")
	local OtherGui = setting:addSection("Other Gui")

	BasicSetting:addKeybind("Toggle Keybind", Enum.KeyCode.RightShift, function()
		venyx:toggle()
	end)

	BasicSetting:addButton("Refresh Gui", function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/oxilegeek/oxi-cheats/main/oxi%20script", true))()
	end)

	BasicSetting:addButton("Rejoin Game", function()
		game:GetService("TeleportService"):Teleport(game.PlaceId , game.Players.LocalPlayer)
	end)

	BasicSetting:addButton("Delete Gui", function()
		deleteGui()
		coroutine.close(TheScript)
	end)


	OtherGui:addButton("Dex explorer", function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
	end)

	OtherGui:addButton("Simple spy", function()
		loadstring(game:HttpGet("https://github.com/exxtremestuffs/SimpleSpySource/raw/master/SimpleSpy.lua"))()
	end)


	game:GetService("RunService").RenderStepped:Wait()




	-- Gamelist
	local setting = venyx:addPage("Games supported", 10772550465)
	local GamesList = setting:addSection("games (click to teleport)")

	GamesList:addButton("Animal sim", function()
		game:GetService("TeleportService"):Teleport(5712833750 , game.Players.LocalPlayer)
	end)

	GamesList:addButton("Build a boat", function()
		game:GetService("TeleportService"):Teleport(537413528 , game.Players.LocalPlayer)
	end)

	GamesList:addButton("Work at a Pizza Place", function()
		game:GetService("TeleportService"):Teleport(192800 , game.Players.LocalPlayer)
	end)

	GamesList:addButton("Starving artist", function()
		game:GetService("TeleportService"):Teleport(8916037983 , game.Players.LocalPlayer)
	end)

	GamesList:addButton("Farming and friends", function()
		game:GetService("TeleportService"):Teleport(2772610559 , game.Players.LocalPlayer)
	end)

	GamesList:addButton("Robeats", function()
		game:GetService("TeleportService"):Teleport(698448212 , game.Players.LocalPlayer)
	end)

	GamesList:addButton("Island", function()
		game:GetService("TeleportService"):Teleport(4872321990 , game.Players.LocalPlayer)
	end)

	GamesList:addButton("Transfur oubreak", function()
		game:GetService("TeleportService"):Teleport(5987922834 , game.Players.LocalPlayer)
	end)

	GamesList:addButton("Lag test 2021", function()
		game:GetService("TeleportService"):Teleport(6356806222 , game.Players.LocalPlayer)
	end)

	GamesList:addButton("Base raider", function()
		game:GetService("TeleportService"):Teleport(6356806222 , game.Players.LocalPlayer)
	end)


	-- Changelog
	local changelog = venyx:addPage("Changelog", 10598702721)
	local changelogSection = changelog:addSection("Changelog")

	changelogSection:addText(' [=] Fixed dropdown')
	changelogSection:addText(' [+] Added some island autofarm')
	changelogSection:addText("--------------------------------------------")
	changelogSection:addText(' [=] Fixed delete location in custom tp')
	changelogSection:addText(' [+] Added Kill player (tp to void)')
	changelogSection:addText(' [+] Added "Supported games" tab')
	changelogSection:addText(' [+] Added island cheat')
	changelogSection:addText(' [+] Added gravity gun')
	changelogSection:addText(' [=] Player name now need minimum 1 letter to work')
	changelogSection:addText(' [=] Fixed coroutine')
	changelogSection:addText(' [+] Added Resize button')
	changelogSection:addText("--------------------------------------------")
	changelogSection:addText(' [+] Added Respawn button')
	changelogSection:addText(' [+] Added give btools button')
	changelogSection:addText(' [+] Added a page for base raider')
	changelogSection:addText(' [+] Added fling in player utility')
	changelogSection:addText(' [=] Renamed "Teleport and spectate" to "player utility"')
	changelogSection:addText("--------------------------------------------")
	changelogSection:addText(' [=] Changed base position')
	changelogSection:addText(' [+] New ESP / Aimbot page')
	changelogSection:addText(' [+] New Emotes page')
	changelogSection:addText(' [=] Fixed keybind continue working on menu refresh/destroy')
	changelogSection:addText(' [=] Fixed keybind not execute when typing text')
	changelogSection:addText(" [+] Added speed bar for autocollectEgg in animal sim")
	changelogSection:addText("--------------------------------------------")
	changelogSection:addText(' [=] Fixed "Hide gui"')
	changelogSection:addText(" [+] Added invisible in character")
	changelogSection:addText(" [+] Added freecam in visual")
	changelogSection:addText(" [+] Added Jetpack in character")
	changelogSection:addText(" [+] Added Follow player toggle in teleport and spectate")
	changelogSection:addText(" [+] Added keybind for killaura in animal sim")
	changelogSection:addText("--------------------------------------------")
	changelogSection:addText(" [=] Page icon are bigger")
	changelogSection:addText(" [=] Improved page change visual")
	changelogSection:addText(" [=] Textbox now not clear text on focus")
	changelogSection:addText(" [=] Fix button broke on error")
	changelogSection:addText(" [=] Changed button animation")
	changelogSection:addText(" [+] Added changelog")

	-- cheat engine

	-- infini Jump
	--UserInputService.InputBegan:Connect(function(input)
	--	if input.KeyCode == Enum.KeyCode.Space then
	--		if infiniJump == true then
	--			game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	--			print(infiniJump)
	--		end
	--	end
	--end)

	local page = venyx:addPage("Bruh, this is", 10779535503)
	local SectionTest = page:addSection("Bruh")
	SectionTest:addButton("Get a life", function()
		game.Players.LocalPlayer:Kick("I gave you a life ^^")
	end)
	
	local page = venyx:addPage("a secret page", 10779535503)
	local SectionTest2 = page:addSection("Bruuh")
	SectionTest2:addButton("Get a life", function()
		game.Players.LocalPlayer:Kick("I gave you a life ^^")
	end)

	function Action(Object, Function) if Object ~= nil then Function(Object); end end

	UIS.InputBegan:connect(function(UserInput)
		if infiniJump and UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
			Action(game.Players.LocalPlayer.Character.Humanoid, function(self)
				if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
					Action(self.Parent.HumanoidRootPart, function(self)
						self.Velocity = Vector3.new(self.Velocity.X, math.random(49000000, 50000000) / 1000000, self.Velocity.Z);
					end)
				end
			end)
		end
	end)

	local spaceEnabled = false
	UIS.InputBegan:connect(function(UserInput)
		if jetpack and UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then

			spaceEnabled = true
			while spaceEnabled do
				game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(	game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity.X, math.random(49000000, 50000000) / 1000000, 	game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity.Z);
				--if not spaceEnabled then
				--	break
				--end
				game:GetService("RunService").RenderStepped:Wait()
			end
		end
	end)

	UIS.InputEnded:connect(function(UserInput)
		if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space then
			spaceEnabled = false
		end
	end)




	game:GetService("RunService").RenderStepped:Wait()
	----------------------------------------------------------------------------------------------------------------------------
	---------------------------------------------------BOUCLE-------------------------------------------------------------------
	----------------------------------------------------------------------------------------------------------------------------
	local autocollectEggCount = 0

	runservice.Stepped:Connect(function()
		if alive then
			--Character

			if noclip == true then
				for a, b in pairs(workspace:GetChildren()) do
					if b.Name == game.Players.LocalPlayer.Name then
						for i, v in pairs(workspace[game.Players.LocalPlayer.Name]:GetChildren()) do
							if v:IsA("BasePart") then
								v.CanCollide = false
							end end end end
			else

			end


			if ShowPosition then
				game.CoreGui.PositionGui.Pos.Text = "X : " ..math.floor(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X) .."  Y : " ..math.floor(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y) .."  Z : " ..math.floor(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z)
			end

			if autoSetSpeed then
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = basicSpeed
				game.Players.LocalPlayer.Character.Humanoid.JumpPower = basicJump
				game.Workspace.Gravity = basicGravity
				game.Players.LocalPlayer.Character.Humanoid.HipHeight = math.floor(basicLevitation / 10) 
			end

			if alwaysDay then
				game.Lighting.ClockTime = 12
			end

			if alwaysNight then
				game.Lighting.ClockTime = 0
			end


			if focusTpPlayer then
				spawn(function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players:FindFirstChild(tpPlayerFocus).Character.HumanoidRootPart.CFrame end)
			end


			if flingEnabled then
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Players:FindFirstChild(tpPlayerFocus).Character.HumanoidRootPart.CFrame * game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Rotation
				game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new()

			end








			--Animal simulator
			if game.GameId == 2023680558 then

				if slowloop >= 10 then
					slowloop = 1
				end
				slowloop = slowloop + 1


				if bringChest then
					game.Workspace.Treasures.Treasure1.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
				end

				if toChest then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.Treasures.Treasure5.Position)
				end

				if autocollect then
					game.ReplicatedStorage.TreasureEvent:FireServer()
				end

				autocollectEggCount += 1

				if autocollectEgg and autocollectEggCount >= 10 - autocollectEggSpeed then
					local args = {
						[1] = workspace.Eggs.Egg1
					}

					game:GetService("ReplicatedStorage").EggEvent:FireServer(unpack(args))

					autocollectEggCount = 0
				end

				pcall(function()
					if HideReward and game.Players.LocalPlayer.PlayerGui:FindFirstChild("newRewardGui") then
						game.Players.LocalPlayer.PlayerGui.newRewardGui.Enabled = false
					else
						game.Players.LocalPlayer.PlayerGui.newRewardGui.Enabled = true
					end
				end)


				if spamHit1 then
					game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game.Players:FindFirstChild(killAuraTarget1).Character.Humanoid)
				end

				if spamHit2 then
					game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game.Players:FindFirstChild(killAuraTarget2).Character.Humanoid)
				end

				if spamHit3 then
					game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game.Players:FindFirstChild(killAuraTarget3).Character.Humanoid)
				end

				if spamHit4 then
					game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game.Players:FindFirstChild(killAuraTarget4).Character.Humanoid)
				end

				if ZombieKillAura then
					if slowloop >= 10 then
						local hit = findNearestZombieTorso(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
						game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(hit.Parent.Humanoid)
					end
				end
				local function tpZombie()
					if ZombieAutofarm then
						if slowloop >= 10 then
							local hit = findNearestZombieTorso(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
							game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored = true
							game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(hit.Parent.Humanoid)
							wait(0.5)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(hit.Position.X, hit.Position.Y + 20, hit.Position.Z)
						end
					end
				end
				spawn(tpZombie)

				if KillAura then
					if slowloop >= 10 then
						local hit = findNearestTorso(game.Players.LocalPlayer.Character.HumanoidRootPart.Position)
						game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(hit.Parent.Humanoid)
					end
				end

				if autoHit then
					vu:SetKeyDown("q")
					vu:SetKeyUp("q")
				end

				if autoEat then
					if cooldownEat >= 10 then
						cooldownEat = 0
						if game.Players.LocalPlayer.Character.Humanoid.Health < game.Players.LocalPlayer.Character.Humanoid.MaxHealth then
							vu:ClickButton1(Vector2.new(0.0))
							game.Players.LocalPlayer.Backpack.Food.Parent = game.Players.LocalPlayer.Character
						end
					else
						cooldownEat = cooldownEat + 1
					end
				end

				if autofarm then
					game.ReplicatedStorage.jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game.Workspace.pleaseno.farm.Humanoid,1)
				end

				if _G.BossGorillaFarm then
					if game:GetService("Workspace").NPC:FindFirstChild("LavaGorilla") then
						game:GetService("ReplicatedStorage").jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game:GetService("Workspace").NPC.LavaGorilla.Humanoid)
					end
				end

				if _G.BossCerberFarm then
					if game:GetService("Workspace").NPC:FindFirstChild("Trex") then
						game:GetService("ReplicatedStorage").jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game:GetService("Workspace").NPC.Trex.Humanoid)
					end
				end

				if _G.BossDrakeFarm then
					if game:GetService("Workspace").NPC:FindFirstChild("Drake") then
						game:GetService("ReplicatedStorage").jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game:GetService("Workspace").NPC.Drake.Humanoid)
					end
				end

				if _G.BossDragonSlayerFarm then
					if game:GetService("Workspace").NPC:FindFirstChild("DragonSlayer") then
						game:GetService("ReplicatedStorage").jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game:GetService("Workspace").NPC.DragonSlayer.Humanoid)
					end
				end



				-- AUTOFARM
				if BossKillFarm then

					if game:GetService("Workspace").NPC:FindFirstChild("LavaGorilla") then
						game:GetService("ReplicatedStorage").jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game:GetService("Workspace").NPC.LavaGorilla.Humanoid)
					end

					if game:GetService("Workspace").NPC:FindFirstChild("Trex") then
						game:GetService("ReplicatedStorage").jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game:GetService("Workspace").NPC.Trex.Humanoid)
					end
				end



				if BossKillFarmFix then
					game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)

					if game:GetService("Workspace").NPC:FindFirstChild("Trex") then
						if game:GetService("Workspace").NPC:FindFirstChild("LavaGorilla") then
							if game:GetService("Workspace").NPC:FindFirstChild("Trex").Humanoid.Health >= game:GetService("Workspace").NPC:FindFirstChild("LavaGorilla").Humanoid.Health then
								if BossKillFarmFixFocus == "LavaGorilla" then
									BossKillFarmFixFocus = "Trex"
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-254, -438, 3390)
								end
							else
								if BossKillFarmFixFocus == "Trex" then
									BossKillFarmFixFocus = "LavaGorilla"
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(588, -347, 2098)
								end
							end
						else
							if BossKillFarmFixFocus == "LavaGorilla" then
								BossKillFarmFixFocus = "Trex"
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-254, -438, 3390)
							end
						end
					else
						if BossKillFarmFixFocus == "Trex" then
							BossKillFarmFixFocus = "LavaGorilla"
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(588, -347, 2098)
						end
					end


					if game:GetService("Workspace").NPC:FindFirstChild("Trex") then
						game:GetService("ReplicatedStorage").jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game:GetService("Workspace").NPC.Trex.Humanoid)
					end

					if game:GetService("Workspace").NPC:FindFirstChild("LavaGorilla") then
						game:GetService("ReplicatedStorage").jdskhfsIIIllliiIIIdchgdIiIIIlIlIli:FireServer(game:GetService("Workspace").NPC.LavaGorilla.Humanoid)
					end
				end
			end
		end
		--------- END ANIMAL







		-- Build a boat
		if game.GameId == 210851291 then
			if BABFastAutofarm then
				if TheEnd then

				else

				end
			end

			if game.Players.LocalPlayer.PlayerGui.RiverResultsGui.Frame.Visible == true then
				if TheEnd then
					TheEnd = false
					autoFarmBAB()
				end
			end

			if antiPortalAbuse then
				if game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Y < -25 then
					if game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z < 900 then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X, 5, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z)
					end
				end
			end
		end
	end)


	--pizza place custom loop
	local function customloopPizza()
		if game.GameId == 47545 then
			while alive do
				wait(0.3)
				if doCashier then
					local num = 0
					repeat
						wait()
						num += 1
						local c = FindFirstCustomer()
						if c then
							local dialog = c.Head.Dialog.Correct.ResponseDialog or ''
							local rootMoved = false
							if (root.Position-Vector3.new(46.34, 3.80, 82.02)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(46.34, 3.80, 82.02) wait(.1) end
							local order = "MountainDew"
							if dialog:sub(-8)=="instead." then
								dialog = dialog:sub(-30)
							end
							if dialog:find("pepperoni",1,true) then
								order = "PepperoniPizza"
							elseif dialog:find("sausage",1,true) then
								order = "SausagePizza"
							elseif dialog:find("cheese",1,true) then
								order = "CheesePizza"
							end

							network:FireServer("OrderComplete", c, order, workspace.Register3)
							if rootMoved then wait(.1) end
						end
					until num == 8
				end



				if doCook then
					local order = getOrders()[1]
					local topping
					if order=="Pepperoni" or order=="Sausage" then topping=order end
					local cookD = FindFirstDew()
					local raw,cookP,trash
					if topping then
						--pepperoni order avoids sausage dough and vice verca
						raw,cookP,trash = FindDoughAndWithout(topping=="Pepperoni" and "Sausage" or "Pepperoni")
					else
						raw,cookP,trash = FindDoughAndWithout()
					end
					local rootMoved = false
					local ovens = workspace.Ovens:GetChildren()
					for i = #ovens, 2, -1 do --shuffle
						local j = RNG:NextInteger(1, i)
						ovens[j], ovens[i] = ovens[i], ovens[j]
					end
					--move final pizza
					if cookP and tick()-cookPtick>0.8 then
						local oven = getOvenNear(cookP.Position)
						if oven==nil or oven.IsOpen.Value then
							cookPtick=tick()
							if (root.Position-Vector3.new(44.63, 6.60, 45.20)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(44.63, 6.60, 45.20) wait(.1) end
							network:FireServer("UpdateProperty", cookP, "CFrame", CFrame.new(56,4.1,38))
						end
					end
					if order then
						if order=="Dew" and cookD and tick()-cookDtick>0.8 then
							--move dew if ordered
							if cookD:FindFirstChild("IsBurned") and not cookD.IsBurned.Value then
								cookDtick=tick()
								if (root.Position-Vector3.new(44.63, 6.60, 45.20)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(44.63, 6.60, 45.20) wait(.1) end
								network:FireServer("UpdateProperty", cookD, "CFrame", CFrame.new(53,4.68,36.5))
							end
						elseif order~="Dew" and raw and raw.Parent and supplyCounts[order]>0 and supplyCounts.TomatoSauce>0 and supplyCounts.Cheese>0 then
							--make pizza
							if raw.Mesh.Scale.Y>1.5 then
								if (root.Position-Vector3.new(44.63, 6.60, 45.20)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(44.63, 6.60, 45.20) wait(.1) end
								network:FireServer("UpdateProperty", raw, "CFrame", CFrame.new(RNG:NextNumber(29.6,44.6),3.7,RNG:NextNumber(42.5,48.5)))
								wait()
								network:FireServer("SquishDough", raw)
							else
								--make sure it will have an oven
								local oven
								for _,o in ipairs(ovens) do
									if isFullyOpen(o) then
										local other = getDoughNear(o.Bottom.Position)
										if other==nil or not (other.BrickColor.Name=="Bright orange" and ffc(other.SG.Frame,"TomatoSauce") and ffc(other.SG.Frame,"MeltedCheese")) then
											if other then
												--replace mistaken dough
												if (root.Position-Vector3.new(44.63, 6.60, 45.20)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(44.63, 6.60, 45.20) wait(.1) end
												network:FireServer("UpdateProperty", other, "CFrame", CFrame.new(RNG:NextNumber(29.6,44.6),3.7,RNG:NextNumber(42.5,48.5)))
												wait()
											end
											oven=o
											break
										end
									end
								end
								if oven and raw.Parent==workspace.AllDough then
									--make
									if (root.Position-Vector3.new(44.63, 6.60, 45.20)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(44.63, 6.60, 45.20) wait(.1) end
									network:FireServer("AddIngredientToPizza", raw,"TomatoSauce")
									network:FireServer("AddIngredientToPizza", raw,"Cheese")
									network:FireServer("AddIngredientToPizza", raw,topping)
									network:FireServer("UpdateProperty", raw, "CFrame", oven.Bottom.CFrame+Vector3.new(0,0.7,0))
									oven.Door.ClickDetector.Detector:FireServer()
									--mark as cooking
									cookingDict[order]=cookingDict[order]+1
									local revoked=false
									spawn(function()
										raw.AncestryChanged:Wait()
										if not revoked then
											cookingDict[order]=cookingDict[order]-1
											revoked=true
										end
									end)
									delay(40, function()
										if not revoked then
											cookingDict[order]=cookingDict[order]-1
											revoked=true
										end
									end)
								end
							end
						end
					end
					--open unnecessarily closed ovens
					for _,o in ipairs(ovens) do
						local bar = o.Door.Meter.SurfaceGui.ProgressBar.Bar
						if o.IsOpen.Value==false and (o.IsCooking.Value==false or (Vector3.new(bar.ImageColor3.r,bar.ImageColor3.g,bar.ImageColor3.b)-Vector3.new(.871,.518,.224)).magnitude>.1) then
							if (root.Position-Vector3.new(44.63, 6.60, 45.20)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(44.63, 6.60, 45.20) wait(.1) end
							o.Door.ClickDetector.Detector:FireServer()
							break
						end
					end
					--trash
					if trash and (trash.IsBurned.Value==false or getOvenNear(trash.Position)==nil or getOvenNear(trash.Position).IsOpen.Value) then
						--closed oven breaks if you take burnt out of it
						if (root.Position-Vector3.new(44.63, 6.60, 45.20)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(44.63, 6.60, 45.20) wait(.1) end
						network:FireServer("UpdateProperty", trash, "CFrame", CFrame.new(47.9,RNG:NextNumber(-10,-30),72.5))
					end
					if rootMoved then wait(.1) end
				end


				if doBoxer then
					local boxP,boxD = FindBoxingFoods()
					local closedBox,openBox,fullBox = FindBoxes()
					local rootMoved = false
					if boxD and tick()-boxDtick>0.8 then
						boxDtick=tick()
						if (root.Position-Vector3.new(54.09, 3.80, 23.150)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(54.09, 3.80, 23.15) wait(.1) end
						network:FireServer("UpdateProperty", boxD, "CFrame", CFrame.new(63,4.9,-1,-1,0,0,0,1,0,0,0,-1))
					end
					if fullBox then
						if fullBox.Name=="BoxOpen" then
							if (root.Position-Vector3.new(54.09, 3.80, 23.150)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(54.09, 3.80, 23.15) wait(.1) end
							network:FireServer("CloseBox", fullBox)
							--will be moved next loop
						elseif tick()-boxPtick>0.8 then
							if (root.Position-Vector3.new(54.09, 3.80, 23.150)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(54.09, 3.80, 23.15) wait(.1) end
							network:FireServer("UpdateProperty", fullBox, "CFrame", CFrame.new(68.2,4.4,-1,-1,0,0,0,1,0,0,0,-1))
							boxPtick=tick()
						end
					end
					if closedBox and not openBox then
						if (root.Position-Vector3.new(54.09, 3.80, 23.150)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(54.09, 3.80, 23.15) wait(.1) end
						network:FireServer("UpdateProperty", closedBox, "CFrame", CFrame.new(RNG:NextNumber(62.5,70.5),3.5,RNG:NextNumber(11,25)))
						wait()
						network:FireServer("OpenBox", closedBox)
					end
					if openBox and boxP then
						if (root.Position-Vector3.new(54.09, 3.80, 23.150)).magnitude>9 then rootMoved = true root.CFrame = CFrame.new(54.09, 3.80, 23.15) wait(.1) end
						network:FireServer("UpdateProperty", boxP, "Anchored", true)
						network:FireServer("UpdateProperty", openBox, "Anchored", true)
						wait()
						network:FireServer("UpdateProperty", boxP, "CFrame", openBox.CFrame+Vector3.new(0,-2,0))
						wait()
						network:FireServer("AssignPizzaToBox", openBox, boxP)
					end
					if rootMoved then wait(.1) end
				end

				if doDelivery then
					local del = FindFirstDeliveryTool()
					if delTool==nil then
						--get tool
						local invTool = false

						for i, v in pairs(player.Backpack:GetChildren()) do
							if v.ClassName=="Tool" and v.Name:match("^%u%d$") and ffc(v,"House") and ffc(v,"Handle") and ffc(v,"Order") and v.Order.Value:match("%a") then
								invTool = true
								v.Parent = character
								wait(0.2)
								v.Parent = workspace
							end
						end

						if not invTool and del then
							delTool=del


							if (root.Position-delTool.Handle.Position).magnitude>19 then
								root.CFrame = CFrame.new(delTool.Handle.Position+Vector3.new(0,1,-15)) 
							end
							delTool.Handle.CanCollide=false
							delTool.Handle.CFrame = root.CFrame
							wait(0.9)
							delay(6,forgetDeliveryTool)
						end
					elseif delTool and delTool.Parent==character and delTouched==false then
						--deliver to house
						local housePart = getHousePart(delTool.Name)
						if housePart then
							delTouched=true
							root.CFrame = housePart.CFrame+Vector3.new(0,6,0)
							wait(5)
							delTool = nil
							delTouched=false
						end
					end
				end





				if doSupplier then
					local refill=false
					for s,c in pairs(supplyCounts) do
						if c <= 70 then
							refill=true
							break
						end
					end
					if refill then
						local oldcf = root.CFrame
						local alt=0
						local waiting = false
						local waitingTick = 0
						local lastBox
						while doSupplier do
							--check if refill is done otherwise hit buttons
							local fulfilled=true
							local boxes = workspace.AllSupplyBoxes:GetChildren()
							for s,c in pairs(supplyCounts) do
								if c < 95 then
									fulfilled=false
									local count = 0
									if #boxes > 30 then
										for i=1,#boxes do
											local box = boxes[i]
											if bcolorToSupply[box.BrickColor.Name]==s and box.Anchored==false and box.Position.Z < -940 then
												count=count+1
											end
										end
									end
									if count < 10 then
										simTouch(supplyButtons[s])
										break
									end
									wait(1.5)
									--check if can finish waiting for boxes to move
									if waiting and (lastBox.Position.X>42 or tick()-waitingTick>5) then
										waiting=false
										if lastBox.Position.X<42 then
											--clear boxes if stuck
											root.CFrame=CFrame.new(20.5,8,-35)
											wait()
											local boxes = workspace.AllSupplyBoxes:GetChildren()
											for i=1,#boxes do
												local box = boxes[i]
												if box.Anchored==false and box.Position.Z>-55 then
													network:FireServer("UpdateProperty", box, "CFrame", CFrame.new(RNG:NextNumber(0,40),RNG:NextNumber(-10,-30),-70))
													wait()
												end
											end
											wait()
										end
									end
									if not waiting then
										--move boxes
										root.CFrame=CFrame.new(8,12.4,-1020)
										wait()
										alt=1-alt
										lastBox=nil
										local j=0
										local boxes = workspace.AllSupplyBoxes:GetChildren()
										for i=1,#boxes do
											local box = boxes[i]
											if box.Anchored==false and box.Position.Z < -940 and bcolorToSupply[box.BrickColor.Name] and supplyCounts[bcolorToSupply[box.BrickColor.Name]]<95 then
												box.CFrame = CFrame.new(38-4*j,5,-7-5*alt)
												network:FireServer("UpdateProperty", box, "CFrame", box.CFrame)
												lastBox=box
												j=j+1
												if j>8 then break end
											end
										end
										if alt==0 and lastBox then
											waiting=true
											waitingTick=tick()
										end
									end
								end
								root.CFrame=oldcf
							end
						end

					end

					--------- END ANIMAL
				end
			end

			spawn(customloopPizza)

			local function RobeatsAutoplayAsync()
				Autoplayer = {
					noteY = 3879,
					sliderY = 3878,
					laneDistanceThreshold = 25,
					distanceLowerBound = 0.4,
					distanceUpperBound = 0.6,
					delayLowerBound = 0.05,
					delayUpperBound = 0.1,
					sliderDebounce = 0.08,
					random = Random.new(),
					pressedLanes = {},
					heldLanes = {},
					currentLanePositionsIndex = nil,
					lanePositions = {
						{
							Vector3.new(-309.00, 387.70, -181.09),
							Vector3.new(-306.87, 387.70, -178.56),
							Vector3.new(-304.53, 387.70, -176.21),
							Vector3.new(-301.99, 387.70, -174.08)
						},

						{
							Vector3.new(-301.99, 387.70, -235.64),
							Vector3.new(-304.53, 387.70, -233.51),
							Vector3.new(-306.87, 387.70, -231.16),
							Vector3.new(-309.00, 387.70, -228.60)
						},

						{
							Vector3.new(-247.44, 387.70, -228.63),
							Vector3.new(-249.57, 387.70, -231.16),
							Vector3.new(-251.92, 387.70, -233.51),
							Vector3.new(-254.46, 387.70, -235.64)
						},

						{
							Vector3.new(-254.46, 387.70, -174.08),
							Vector3.new(-251.92, 387.70, -176.21),
							Vector3.new(-249.57, 387.70, -178.56),
							Vector3.new(-247.44, 387.70, -181.09)
						}
					}
				}

				--robeats func
				if game.PlaceId == 698448212 then
					function UpdateLanePositions() -- table.sort cant be used here
						local nearestDistance = Autoplayer.laneDistanceThreshold
						local nearestGroupIndex

						for groupIndex, groupPositions in next, Autoplayer.lanePositions do
							local distance = (groupPositions[1] - camera.CFrame.Position).Magnitude

							if distance < nearestDistance then
								nearestDistance = distance
								nearestGroupIndex = groupIndex
							end
						end

						Autoplayer.currentLanePositionsIndex = nearestGroupIndex
					end

					function GetNearestLane(position) -- table.sort cant be used here
						UpdateLanePositions()

						local nearestDistance = Autoplayer.laneDistanceThreshold
						local nearestLane

						for laneIndex, lanePosition in next, Autoplayer.lanePositions[Autoplayer.currentLanePositionsIndex] do
							local distance = (lanePosition - position).Magnitude

							if distance < nearestDistance then
								nearestDistance = distance
								nearestLane = {laneIndex, lanePosition}
							end
						end

						if not nearestLane then 
							return
						end

						return nearestLane[1], nearestLane[2]
					end
				end
	--[[while true do 
		local breaked = false
		wait(5)

		spawn(function()
			wait(30)
			breaked = true
		end)]]
				for index, instance in next, workspace:GetDescendants() do
					if instance.ClassName == "CylinderHandleAdornment" then
						wait()
						instance:GetPropertyChangedSignal("CFrame"):Connect(function()
							if RobeatsAutoplayToggle and alive and not breaked then
								if instance.Transparency == 0 and math.floor(instance.CFrame.Y * 10) == Autoplayer.noteY then
									local noteLane, lanePosition = GetNearestLane(instance.CFrame.Position)

									if noteLane then
										local randomDistance = Autoplayer.random:NextNumber(Autoplayer.distanceLowerBound, Autoplayer.distanceUpperBound)
										local distance = instance.CFrame.Position.X - lanePosition.X

										if Autoplayer.currentLanePositionsIndex > 2 then 
											distance = math.abs(distance)
										end

										if not Autoplayer.pressedLanes[noteLane] and distance <= randomDistance then
											Autoplayer.pressedLanes[noteLane] = true

											VirtualInputManager:SendKeyEvent(true, keys[noteLane], false, game)
											task.wait(Autoplayer.random:NextNumber(Autoplayer.delayLowerBound, Autoplayer.delayUpperBound))
											VirtualInputManager:SendKeyEvent(false, keys[noteLane], false, game)

											Autoplayer.pressedLanes[noteLane] = false
										end
									end
								elseif instance.Transparency < 1 and instance.Height > 0.2 and math.floor(instance.CFrame.Y * 10) == Autoplayer.sliderY then
									local noteLane, lanePosition = GetNearestLane(instance.CFrame.Position)

									if noteLane then
										local randomDistance = Autoplayer.random:NextNumber(Autoplayer.distanceLowerBound, Autoplayer.distanceUpperBound)
										local distance = (instance.CFrame - instance.CFrame.LookVector * instance.Height / 2).X - lanePosition.X

										if Autoplayer.currentLanePositionsIndex > 2 then 
											distance = math.abs(distance)
										end

										if not Autoplayer.heldLanes[noteLane] and distance <= randomDistance then
											Autoplayer.heldLanes[noteLane] = true

											VirtualInputManager:SendKeyEvent(true, keys[noteLane], false, game)

											repeat
												task.wait() -- ugly but whatever
											until (Autoplayer.currentLanePositionsIndex > 2 and math.abs((instance.CFrame + instance.CFrame.LookVector * instance.Height / 2).X - lanePosition.X) or (instance.CFrame + instance.CFrame.LookVector * instance.Height / 2).X - lanePosition.X) <= randomDistance

											VirtualInputManager:SendKeyEvent(false, keys[noteLane], false, game)

											task.wait(Autoplayer.sliderDebounce)

											Autoplayer.heldLanes[noteLane] = false
										end
									end
								end
							end	
						end)
					end
				end
				--end
			end

			spawn(RobeatsAutoplayAsync)







			-- load
			--venyx:SelectPage(venyx.pages[1], true)
			--for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
			--	venyx:setTheme(theme, color)
			--end

			while wait() do
				if not alive then
					wait(1)
					coroutine.yield(TheScript)
				end
			end

			return library
		end
	end

