local library = {};

if game:GetService("CoreGui"):FindFirstChild("LibraryUI") then
	game:GetService("CoreGui"):FindFirstChild("LibraryUI"):Destroy()
end

local AlohaUI = Instance.new("ScreenGui")

AlohaUI.Name = "LibraryUI"
AlohaUI.Parent = game:GetService("CoreGui")
AlohaUI.ResetOnSpawn = false
AlohaUI.DisplayOrder = 1

game:GetService("UserInputService").InputBegan:Connect(function(I)
	if I.KeyCode == Enum.KeyCode.RightShift then
		local LibraryUI = game:GetService("CoreGui"):FindFirstChild("LibraryUI")
		LibraryUI.Enabled = not LibraryUI.Enabled
	end
end)

function library.new(name)
	local UI = {};
	local Main = Instance.new("ImageLabel")
	local Holder = Instance.new("Frame")
	local UIGradient = Instance.new("UIGradient")
	local TabHolder = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local underline = Instance.new("Frame")
	local UIGradient_2 = Instance.new("UIGradient")
	local Title = Instance.new("TextLabel")
	local UIPadding_2 = Instance.new("UIPadding")

	Main.Name = "Main"
	Main.Parent = AlohaUI
	Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Main.BackgroundTransparency = 1.000
	Main.Position = UDim2.new(0.106694564, 0, 0.270889491, 0)
	Main.Size = UDim2.new(0, 577, 0, 32)
	Main.Image = "rbxassetid://3570695787"
	Main.ScaleType = Enum.ScaleType.Slice
	Main.SliceCenter = Rect.new(100, 100, 100, 100)
	Main.SliceScale = 0.030

	Holder.Name = "Holder"
	Holder.Parent = Main
	Holder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Holder.BackgroundTransparency = 0.080
	Holder.BorderSizePixel = 0
	Holder.Position = UDim2.new(0, 0, 1.03125, 0)
	Holder.Size = UDim2.new(0, 577, 0, 343)

	UIGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 30)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(26, 26, 26))
	}
	UIGradient.Parent = Main

	TabHolder.Name = "TabHolder"
	TabHolder.Parent = Main
	TabHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	TabHolder.BackgroundTransparency = 1.000
	TabHolder.BorderSizePixel = 0
	TabHolder.Position = UDim2.new(0.211438477, 0, -4.76837158e-07, 0)
	TabHolder.Size = UDim2.new(0, 455, 0, 32)
	TabHolder.Visible = true
	TabHolder.ZIndex = 2

	UIPadding.Parent = TabHolder
	UIPadding.PaddingLeft = UDim.new(0, 3)
	UIPadding.PaddingTop = UDim.new(0, 7)

	UIListLayout.Parent = TabHolder
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
	UIListLayout.Padding = UDim.new(0, 5)

	underline.Name = "underline"
	underline.Parent = Main
	underline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	underline.BorderSizePixel = 0
	underline.Position = UDim2.new(0, 0, 0.8125, 0)
	underline.Size = UDim2.new(0, 577, 0, 7)

	UIGradient_2.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 30)),
		ColorSequenceKeypoint.new(1.00, Color3.fromRGB(26, 26, 26))
	}
	UIGradient_2.Parent = underline

	Title.Name = "Title"
	Title.Parent = Main
	Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title.BackgroundTransparency = 1.000
	Title.BorderSizePixel = 0
	Title.Size = UDim2.new(0, 122, 0, 33)
	Title.ZIndex = 8
	Title.Font = Enum.Font.SourceSansSemibold
	Title.Text = name
	Title.TextColor3 = Color3.fromRGB(252, 252, 252)
	Title.TextSize = 15.000
	Title.TextXAlignment = Enum.TextXAlignment.Left

	UIPadding_2.Parent = Title
	UIPadding_2.PaddingBottom = UDim.new(0, 1)
	UIPadding_2.PaddingLeft = UDim.new(0, 6)

	local players = game:service('Players');
	local player = players.LocalPlayer;
	local mouse = player:GetMouse();
	local run = game:service('RunService');
	local stepped = run.Stepped;
	draggable = function(obj)
		spawn(function()
			obj.Active = true;
			local minitial;
			local initial;
			local isdragging;
			obj.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					isdragging = true;
					minitial = input.Position;
					initial = obj.Position;
					local con;
					con = stepped:Connect(function()
						if isdragging then
							local delta = Vector3.new(mouse.X, mouse.Y, 0) - minitial;
							obj.Position = UDim2.new(initial.X.Scale, initial.X.Offset + delta.X, initial.Y.Scale, initial.Y.Offset + delta.Y);
						else
							con:Disconnect();
						end;
					end);
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							isdragging = false;
						end;
					end);
				end;
			end);
		end)
	end;

	draggable(Main)

	function UI.WindowTab(name)
		local UITabs = {};
		local Window = Instance.new("TextButton")
		local Container = Instance.new("Frame")
		local SideTabs = Instance.new("Frame")
		local UIPadding = Instance.new("UIPadding")
		local UIListLayout = Instance.new("UIListLayout")

		Window.Name = name
		Window.Parent = TabHolder
		Window.BackgroundColor3 = Color3.fromRGB(102, 0, 204)
		Window.BackgroundTransparency = 0.500
		Window.BorderColor3 = Color3.fromRGB(90, 44, 144)
		Window.Position = UDim2.new(0.00659340667, 0, 0.296875, 0)
		Window.Size = UDim2.new(0, 108, 0, 20)
		Window.ZIndex = 2
		Window.AutoButtonColor = false
		Window.Font = Enum.Font.SourceSans
		Window.Text = name
		Window.TextColor3 = Color3.fromRGB(240, 240, 240)
		Window.TextSize = 14.000

		Container.Name = "Container"
		Container.Parent = Holder
		Container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Container.BackgroundTransparency = 0.080
		Container.BorderSizePixel = 0
		Container.Size = UDim2.new(0, 577, 0, 343)
		Container.Visible = false

		SideTabs.Name = "SideTabs"
		SideTabs.Parent = Container
		SideTabs.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		SideTabs.BackgroundTransparency = 0.700
		SideTabs.BorderSizePixel = 0
		SideTabs.Position = UDim2.new(0.00173310225, 0, 0, 0)
		SideTabs.Size = UDim2.new(0, 122, 0, 342)
		SideTabs.ZIndex = 2
		SideTabs.Visible = false

		UIPadding.Parent = SideTabs
		UIPadding.PaddingLeft = UDim.new(0, 6)
		UIPadding.PaddingTop = UDim.new(0, 5)

		UIListLayout.Parent = SideTabs
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 4)

		function UITabs.ShowWindow()
			Container.Visible = true
			SideTabs.Visible = true
			Window.BackgroundTransparency = .32
			Window.Size = UDim2.new(0, 108, 0, 23)
			Window.TextSize = 15
		end

		local NewHolder = Holder

		Window.MouseButton1Click:Connect(function()
			for i, v in pairs(NewHolder:GetChildren()) do
				if v:IsA("Frame") then
					v.Visible = false
				end
			end
			for i, v in pairs(TabHolder:GetChildren()) do
				if v:IsA('TextButton') then
					v.BackgroundTransparency = .5
					v.Size = UDim2.new(0, 108, 0, 20)
					v.TextSize = 14
				end
			end
			Container.Visible = true
			SideTabs.Visible = true
			Window.BackgroundTransparency = .32
			Window.Size = UDim2.new(0, 108, 0, 23)
			Window.TextSize = 15
		end)

		function UITabs.SideTab(name)
			local SideTabUI = {};
			local TabButton = Instance.new("TextButton")
			local Frame = Instance.new("Frame")
			local Tab = Instance.new("ScrollingFrame")
			local UIListLayout = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")

			TabButton.Name = name
			TabButton.Parent = SideTabs
			TabButton.BackgroundColor3 = Color3.fromRGB(48, 48, 48)
			TabButton.BackgroundTransparency = 1.000
			TabButton.BorderColor3 = Color3.fromRGB(63, 63, 63)
			TabButton.LayoutOrder = 1
			TabButton.Position = UDim2.new(0, 0, 0.171875, 0)
			TabButton.Size = UDim2.new(0, 110, 0, 20)
			TabButton.ZIndex = 2
			TabButton.AutoButtonColor = false
			TabButton.Font = Enum.Font.SourceSans
			TabButton.Text = name
			TabButton.TextColor3 = Color3.fromRGB(240, 240, 240)
			TabButton.TextSize = 14.000

			Frame.Parent = TabButton
			Frame.BackgroundColor3 = Color3.fromRGB(127, 0, 255)
			Frame.BorderSizePixel = 0
			Frame.Size = UDim2.new(0.0350000001, 0, 0, 20)
			Frame.Visible = false

			function SideTabUI.ShowTab()
				TabButton.TextSize = 15
				TabButton.BackgroundTransparency = .5
				Frame.Visible = true
				Tab.Visible = true
			end

			Tab.Name = "Tabs"
			Tab.Parent = Container
			Tab.Active = true
			Tab.BackgroundColor3 = Color3.fromRGB(31, 35, 37)
			Tab.BackgroundTransparency = 1.000
			Tab.BorderColor3 = Color3.fromRGB(27, 42, 53)
			Tab.BorderSizePixel = 0
			Tab.Position = UDim2.new(0.216637775, 0, 0.00290708849, 0)
			Tab.Size = UDim2.new(0, 450, 0, 342)
			Tab.ZIndex = 2
			Tab.CanvasSize = UDim2.new(0, 0, 3, 0)
			Tab.ScrollBarThickness = 5
			Tab.Visible = false

			UIListLayout.Parent = Tab
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)

			UIPadding.Parent = Tab
			UIPadding.PaddingBottom = UDim.new(0, 2)
			UIPadding.PaddingLeft = UDim.new(0, 2)
			UIPadding.PaddingTop = UDim.new(0, 5)

			TabButton.MouseButton1Click:Connect(function()
				for i, v in pairs(Container:GetChildren()) do
					if v.Name == "Tabs" then
						v.Visible = false
					end
				end
				for i, v in pairs(SideTabs:GetChildren()) do
					if v:IsA("TextButton") then
						v.TextSize = 14
						v.BackgroundTransparency = 1
						v.Frame.Visible = false
					end
				end
				Tab.Visible = true
				TabButton.TextSize = 15
				TabButton.BackgroundTransparency = .5
				TabButton.Frame.Visible = true
			end)

			function SideTabUI.Section(name)
				local SectionUI = {};
				local Section = Instance.new("Frame")
				local SectionTitle = Instance.new("TextLabel")
				local Underline = Instance.new("ImageLabel")

				Section.Name = name
				Section.Parent = Tab
				Section.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
				Section.BorderSizePixel = 0
				Section.Position = UDim2.new(0.00447427295, 0, 0.0146198831, 0)
				Section.Size = UDim2.new(0, 438, 0, 200)

				SectionTitle.Name = "SectionName"
				SectionTitle.Parent = Section
				SectionTitle.Active = true
				SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SectionTitle.BackgroundTransparency = 1.000
				SectionTitle.BorderSizePixel = 0
				SectionTitle.LayoutOrder = 1
				SectionTitle.Size = UDim2.new(0, 442, 0, 23)
				SectionTitle.ZIndex = 3
				SectionTitle.Font = Enum.Font.SourceSans
				SectionTitle.Text = name
				SectionTitle.TextColor3 = Color3.fromRGB(198, 198, 198)
				SectionTitle.TextSize = 22.000
				SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

				local UIPadding = Instance.new("UIPadding")
				UIPadding.Parent = SectionTitle
				UIPadding.PaddingBottom = UDim.new(0, 2)
				UIPadding.PaddingLeft = UDim.new(0, 5)

				Underline.Name = "Underline"
				Underline.Parent = Section
				Underline.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Underline.BackgroundTransparency = 1.000
				Underline.LayoutOrder = 2
				Underline.Position = UDim2.new(0.00894965976, 0, 0.100877196, 0)
				Underline.Size = UDim2.new(0, 433, 0, 3)
				Underline.ZIndex = 4
				Underline.Image = "rbxassetid://3570695787"
				Underline.ImageColor3 = Color3.fromRGB(59, 59, 59)
				Underline.ScaleType = Enum.ScaleType.Slice
				Underline.SliceCenter = Rect.new(100, 100, 100, 100)
				Underline.SliceScale = 0.120

				local UIListLayout2 = Instance.new("UIListLayout")
				UIListLayout2.Parent = Section
				UIListLayout2.HorizontalAlignment = Enum.HorizontalAlignment.Center
				UIListLayout2.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout2.Padding = UDim.new(0, 2)

				local y = 0
				for i, v in pairs(Section:GetChildren()) do
					if (not v:IsA("UIListLayout") and not v:IsA("UIPadding")) then
						y = y + v.AbsoluteSize.Y + 2;
					end
				end
				Section.Size = UDim2.new(0, 438, 0, y)

				function SectionUI:Resize()
					local y = 0
					for i, v in pairs(Section:GetChildren()) do
						if (not v:IsA("UIListLayout") and not v:IsA("UIPadding")) then
							y = y + v.AbsoluteSize.Y + 2;
						end
					end
					Section.Size = UDim2.new(0, 438, 0, y)
				end

				SectionUI:Resize()
				function SectionUI.Label(name)
					local label = {}
					local LabelHolder = Instance.new("Frame")
					local Label = Instance.new("TextLabel")

					LabelHolder.Name = "LabelHolder"
					LabelHolder.Parent = Section
					LabelHolder.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
					LabelHolder.BackgroundTransparency = 1.000
					LabelHolder.BorderSizePixel = 0
					LabelHolder.LayoutOrder = 3
					LabelHolder.Position = UDim2.new(0.00570776267, 0, 0.220588237, 0)
					LabelHolder.Size = UDim2.new(0, 432, 0, 30)

					Label.Name = "Label"
					Label.Parent = LabelHolder
					Label.AnchorPoint = Vector2.new(0, 0.00999999978)
					Label.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
					Label.BorderColor3 = Color3.fromRGB(58, 58, 58)
					Label.Position = UDim2.new(0.00499999989, 0, 0.0700000003, 0)
					Label.Size = UDim2.new(0.987999976, 1, 0.829999983, 1)
					Label.Font = Enum.Font.SourceSans
					Label.LineHeight = 1.1
					Label.Text = name
					Label.TextColor3 = Color3.fromRGB(194, 194, 194)
					Label.TextSize = 20.000
					SectionUI:Resize()
					function label:Delete()
						Label:Destroy()
						LabelHolder:Destroy()
					end
					return label
				end

				function SectionUI.Button(name, callback)
					local ButtonHolder = Instance.new("Frame")
					local Button = Instance.new("TextButton")
					local Circle = Instance.new("ImageLabel")

					ButtonHolder.Name = "ButtonHolder"
					ButtonHolder.Parent = Section
					ButtonHolder.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
					ButtonHolder.BorderSizePixel = 0
					ButtonHolder.LayoutOrder = 3
					ButtonHolder.Position = UDim2.new(0.008, 0, 0.221, 0)
					ButtonHolder.Size = UDim2.new(0, 432, 0, 30)

					Button.Name = "Button"
					Button.Parent = ButtonHolder
					Button.AnchorPoint = Vector2.new(0, 0.01)
					Button.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
					Button.BorderSizePixel = 0
					Button.ClipsDescendants = true
					Button.Position = UDim2.new(0.004, 0, 0.08, 0)
					Button.Size = UDim2.new(0.989, 1, 0.83, 1)
					Button.AutoButtonColor = false
					Button.Text = name
					Button.Font = Enum.Font.SourceSans
					Button.TextColor3 = Color3.fromRGB(166, 166, 166)
					Button.TextSize = 20.000

					Circle.Name = "Circle"
					Circle.Parent = game:GetService("CoreGui")
					Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Circle.BackgroundTransparency = 1.000
					Circle.ZIndex = 10
					Circle.Image = "http://www.roblox.com/asset/?id=33112574"
					Circle.ImageColor3 = Color3.fromRGB(126, 126, 126)
					Circle.ImageTransparency = 0.700

					function CircleClick(Button, X, Y)
						coroutine.resume(coroutine.create(function()
							local Circle = game:GetService("CoreGui"):WaitForChild("Circle"):Clone()
							Circle.Parent = Button
							local NewX = X - Circle.AbsolutePosition.X
							local NewY = Y - Circle.AbsolutePosition.Y
							Circle.Position = UDim2.new(0, NewX, 0, NewY)
							local Size = 0
							if Button.AbsoluteSize.X > Button.AbsoluteSize.Y then
								Size = Button.AbsoluteSize.X * 1.5
							elseif Button.AbsoluteSize.X < Button.AbsoluteSize.Y then
								Size = Button.AbsoluteSize.Y * 1.5
							elseif Button.AbsoluteSize.X == Button.AbsoluteSize.Y then
								Size = Button.AbsoluteSize.X * 1.5
							end
							local Time = 0.5
							Circle:TweenSizeAndPosition(UDim2.new(0, Size, 0, Size), UDim2.new(0.5, -Size / 2, 0.5, -Size / 2), "Out", "Quad", Time, false, nil)
							for i = 1, 10 do
								Circle.ImageTransparency = Circle.ImageTransparency + 0.03
								wait(Time / 10)
							end
							Circle:Destroy()
						end))
					end

					local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
					Button.MouseButton1Click:Connect(function()
						callback()
						CircleClick(Button, Mouse.X, Mouse.Y)
					end)
					SectionUI:Resize()
				end

				function SectionUI.KeyBind(name, callback)
					local KeybindHolder = Instance.new("Frame")
					local KeyBindText = Instance.new("TextLabel")
					local UIPadding = Instance.new("UIPadding")
					local KeybindButton = Instance.new("TextButton")

					KeybindHolder.Name = "KeybindHolder"
					KeybindHolder.Parent = Section
					KeybindHolder.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
					KeybindHolder.BorderSizePixel = 0
					KeybindHolder.LayoutOrder = 3
					KeybindHolder.Position = UDim2.new(0.00570776267, 0, 0.220588237, 0)
					KeybindHolder.Size = UDim2.new(0, 432, 0, 30)

					KeyBindText.Name = "KeyBindText"
					KeyBindText.Parent = KeybindHolder
					KeyBindText.Active = true
					KeyBindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					KeyBindText.BackgroundTransparency = 1.000
					KeyBindText.BorderSizePixel = 0
					KeyBindText.Size = UDim2.new(0, 431, 0, 30)
					KeyBindText.Font = Enum.Font.SourceSans
					KeyBindText.Text = name
					KeyBindText.TextColor3 = Color3.fromRGB(198, 198, 198)
					KeyBindText.TextSize = 18.000
					KeyBindText.TextXAlignment = Enum.TextXAlignment.Left

					UIPadding.Parent = KeyBindText
					UIPadding.PaddingBottom = UDim.new(0, 3)
					UIPadding.PaddingLeft = UDim.new(0, 5)

					KeybindButton.Name = "KeybindButton"
					KeybindButton.Parent = KeybindHolder
					KeybindButton.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
					KeybindButton.BorderSizePixel = 0
					KeybindButton.Position = UDim2.new(0.810000002, 0, 0.100000001, 0)
					KeybindButton.Size = UDim2.new(0, 79, 0, 24)
					KeybindButton.AutoButtonColor = false
					KeybindButton.Font = Enum.Font.SourceSans
					KeybindButton.Text = ""
					KeybindButton.TextColor3 = Color3.fromRGB(166, 166, 166)
					KeybindButton.TextSize = 15.000

					local userInputService = game:GetService("UserInputService")
					local waitingForKeyPress, currentKey
					KeybindButton.Text = "Set Bind"

					KeybindButton.MouseButton1Click:Connect(function()
						KeybindButton.Text = "..."
						waitingForKeyPress = true
					end)

					local Blacklisted = {[Enum.KeyCode.Space] = "Space";[Enum.KeyCode.RightShift] = "RightShift";[Enum.KeyCode.F1] = "F1";[Enum.KeyCode.F2] = "F2";[Enum.KeyCode.F3] = "F3";[Enum.KeyCode.F4] = "F4";[Enum.KeyCode.F5] = "F5";[Enum.KeyCode.F6] = "F6";[Enum.KeyCode.F7] = "F7";[Enum.KeyCode.F8] = "F8";[Enum.KeyCode.F9] = "F9";[Enum.KeyCode.F10] = "F10";[Enum.KeyCode.F11] = "F11";[Enum.KeyCode.F12] = "F12";[Enum.KeyCode.Escape] = "Escape";[Enum.KeyCode.CapsLock] = "CapsLock";[Enum.KeyCode.Print] = "Print";[Enum.KeyCode.Tab] = "Tab";[Enum.KeyCode.NumLock] = "NumLock";[Enum.KeyCode.PageDown] = "PageDown";[Enum.KeyCode.PageUp] = "PageUp";[Enum.KeyCode.Home] = "Home";[Enum.KeyCode.End] = "End";[Enum.KeyCode.Delete] = "Delete";[Enum.KeyCode.Insert] = "Insert";[Enum.KeyCode.Backquote] = "Backquote";[Enum.KeyCode.Pause] = "Pause";[Enum.KeyCode.ScrollLock] = "ScrollLock";[Enum.KeyCode.Up] = "Up";[Enum.KeyCode.Right] = "Right";[Enum.KeyCode.Left] = "Left";[Enum.KeyCode.Down] = "Down";[Enum.KeyCode.W] = "W";[Enum.KeyCode.A] = "A";[Enum.KeyCode.S] = "S";[Enum.KeyCode.D] = "D";}

					userInputService.InputBegan:Connect(function(Input)
						local keyName = string.split(tostring(Input.KeyCode), ".")[3]
						local BlacklistedKeys = Blacklisted[Input.KeyCode]
						if waitingForKeyPress and keyName ~= "Unknown" and keyName ~= BlacklistedKeys then
							KeybindButton.Text = keyName
							currentKey = Input.KeyCode
							waitingForKeyPress = false
						end
						if not waitingForKeyPress and currentKey and Input.KeyCode == currentKey then
							callback(keyName)
						end
					end)
					SectionUI:Resize()
				end

				function SectionUI.Toggle(name, callback, default)
					local ToggleHolder = Instance.new("Frame")
					local ToggleText = Instance.new("TextLabel")
					local UIPadding = Instance.new("UIPadding")
					local ToggleButton = Instance.new("TextButton")

					ToggleHolder.Name = "ToggleHolder"
					ToggleHolder.Parent = Section
					ToggleHolder.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
					ToggleHolder.BorderSizePixel = 0
					ToggleHolder.LayoutOrder = 3
					ToggleHolder.Position = UDim2.new(0.00570776267, 0, 0.220588237, 0)
					ToggleHolder.Size = UDim2.new(0, 432, 0, 30)

					ToggleText.Name = "ToggleText"
					ToggleText.Parent = ToggleHolder
					ToggleText.Active = true
					ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ToggleText.BackgroundTransparency = 1.000
					ToggleText.BorderSizePixel = 0
					ToggleText.Size = UDim2.new(0, 431, 0, 30)
					ToggleText.Font = Enum.Font.SourceSans
					ToggleText.Text = name
					ToggleText.TextColor3 = Color3.fromRGB(198, 198, 198)
					ToggleText.TextSize = 18.000
					ToggleText.TextXAlignment = Enum.TextXAlignment.Left

					UIPadding.Parent = ToggleText
					UIPadding.PaddingBottom = UDim.new(0, 3)
					UIPadding.PaddingLeft = UDim.new(0, 5)

					ToggleButton.Name = "ToggleButton"
					ToggleButton.Parent = ToggleHolder
					ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
					ToggleButton.BorderColor3 = Color3.fromRGB(40, 40, 40)
					ToggleButton.Position = UDim2.new(0.935000002, 0, 0.100000001, 0)
					ToggleButton.Size = UDim2.new(0, 24, 0, 24)
					ToggleButton.AutoButtonColor = false
					ToggleButton.Font = Enum.Font.SourceSans
					ToggleButton.Text = "X"
					ToggleButton.TextColor3 = Color3.fromRGB(197, 197, 197)
					ToggleButton.TextSize = 25.000
					ToggleButton.TextTransparency = 1.000

					local Toggled = false;

					if default ~= nil then
						Toggled = default
						local Transparency = default and 0 or 1
						ToggleButton.TextTransparency = Transparency
					end

					local tweenInfo = TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)

					ToggleButton.MouseButton1Click:Connect(function()
						Toggled = not Toggled
						callback(Toggled)
						local Transparency = Toggled and 0 or 1
						game:GetService("TweenService"):Create(ToggleButton, tweenInfo, {
							TextTransparency = Transparency
						}):Play()
					end)
					SectionUI:Resize()
				end

				function SectionUI.Slider(name, min, max, default, callback)
					local SliderHolder = Instance.new("Frame")
					local Slider = Instance.new("TextButton")
					local Fill = Instance.new("Frame")
					local UIGradient = Instance.new("UIGradient")
					local ValueSlider = Instance.new("TextLabel")
					local UIPadding = Instance.new("UIPadding")
					local SliderText = Instance.new("TextLabel")
					local UIPadding_2 = Instance.new("UIPadding")
					local SetSlider = Instance.new("TextBox")

					SliderHolder.Name = "SliderHolder"
					SliderHolder.Parent = Section
					SliderHolder.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
					SliderHolder.BorderSizePixel = 0
					SliderHolder.LayoutOrder = 3
					SliderHolder.Position = UDim2.new(0.00570776267, 0, 0.455882341, 0)
					SliderHolder.Size = UDim2.new(0, 432, 0, 40)

					Slider.Name = "Slider"
					Slider.Parent = SliderHolder
					Slider.BackgroundColor3 = Color3.fromRGB(79, 79, 79)
					Slider.BorderSizePixel = 0
					Slider.Position = UDim2.new(0.0189999994, 0, 0.680000007, 0)
					Slider.Size = UDim2.new(0, 415, 0, 4)
					Slider.AutoButtonColor = false
					Slider.Font = Enum.Font.SourceSans
					Slider.Text = ""
					Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
					Slider.TextSize = 14.000

					Fill.Name = "Fill"
					Fill.Parent = Slider
					Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Fill.BorderSizePixel = 0
					Fill.LayoutOrder = 3
					Fill.Size = UDim2.new(0, 0, 0, 4)

					UIGradient.Color = ColorSequence.new{
						ColorSequenceKeypoint.new(0.00, Color3.fromRGB(74, 32, 159)),
						ColorSequenceKeypoint.new(1.00, Color3.fromRGB(143, 42, 164))
					}
					UIGradient.Parent = Fill

					ValueSlider.Name = "ValueSlider"
					ValueSlider.Parent = Slider
					ValueSlider.Active = true
					ValueSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ValueSlider.BackgroundTransparency = 1.000
					ValueSlider.BorderSizePixel = 0
					ValueSlider.Position = UDim2.new(-0.0186192524, 0, -6.80000305, 0)
					ValueSlider.Size = UDim2.new(0, 431, 0, 22)
					ValueSlider.Font = Enum.Font.SourceSans
					ValueSlider.Text = "Minimum/Maximum"
					ValueSlider.TextColor3 = Color3.fromRGB(198, 198, 198)
					ValueSlider.TextSize = 14.000

					UIPadding.Parent = ValueSlider
					UIPadding.PaddingBottom = UDim.new(0, 4)

					SliderText.Name = "SliderText"
					SliderText.Parent = SliderHolder
					SliderText.Active = true
					SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SliderText.BackgroundTransparency = 1.000
					SliderText.BorderSizePixel = 0
					SliderText.Position = UDim2.new(0.018999977, 0, 0, 0)
					SliderText.Size = UDim2.new(0, 415, 0, 22)
					SliderText.Font = Enum.Font.SourceSans
					SliderText.Text = name
					SliderText.TextColor3 = Color3.fromRGB(198, 198, 198)
					SliderText.TextSize = 16.000
					SliderText.TextXAlignment = Enum.TextXAlignment.Left

					UIPadding_2.Parent = SliderText
					UIPadding_2.PaddingBottom = UDim.new(0, 2)

					SetSlider.Name = "SetSlider"
					SetSlider.Parent = SliderHolder
					SetSlider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
					SetSlider.BackgroundTransparency = 1.000
					SetSlider.BorderColor3 = Color3.fromRGB(58, 58, 58)
					SetSlider.Position = UDim2.new(0.858524144, 0, 0.0500000007, 0)
					SetSlider.Size = UDim2.new(0, 51, 0, 16)
					SetSlider.Font = Enum.Font.SourceSans
					SetSlider.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
					SetSlider.PlaceholderText = "Slider Int"
					SetSlider.Text = ""
					SetSlider.TextColor3 = Color3.fromRGB(178, 178, 178)
					SetSlider.TextSize = 14.000
					SetSlider.TextXAlignment = Enum.TextXAlignment.Right

					local Connection;
					local RunService = game:GetService("RunService");
					local UIS = game:GetService("UserInputService");

					local tweenInfo = TweenInfo.new(.05, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)

					local function Fade(Object, Number)
						game:GetService("TweenService"):Create(Object, tweenInfo, {
							TextTransparency = tonumber(Number)
						}):Play()
					end

					UIS.InputEnded:Connect(function(Input)
						if Input.UserInputType == Enum.UserInputType.MouseButton1 then
							if (Connection) then
								Connection:Disconnect();
								Connection = nil;
								Fade(ValueSlider, 1)
							end;
						end;
					end);

					local Vals = {
						["Minimum"] = min,
						["Maximum"] = max
					}

					ValueSlider.Text = Vals.Minimum .. "/" .. Vals.Maximum

					Slider.MouseButton1Down:Connect(function()
						if (Connection) then
							Connection:Disconnect();
						end;

						Connection = RunService.Stepped:Connect(function()
							local Mouse = UIS:GetMouseLocation();
							local Percentage = math.clamp((Mouse.X - Slider.AbsolutePosition.X) / (Slider.AbsoluteSize.X), 0, 1)
							local ValueToNumber = Vals.Minimum + (Vals.Maximum - Vals.Minimum) * Percentage

							ValueToNumber = math.floor(ValueToNumber)

							ValueSlider.Text = ValueToNumber .. "/" .. Vals.Maximum

							game:GetService("TweenService"):Create(Fill, tweenInfo, {
								Size = UDim2.new(Percentage, 0, 0, 4)
							}):Play()
							Fade(ValueSlider, 0)
							callback(tonumber(ValueToNumber))
							SetSlider.Text = ValueToNumber
						end);
					end);

					local function SetValue(value)
						local percent = 1 - ((Vals.Maximum - value) / (Vals.Maximum - Vals.Minimum))
						local Number = value

						Number = math.floor(Number)

						game:GetService("TweenService"):Create(Fill, tweenInfo, {
							Size = UDim2.new(percent, 0, 0, 4)
						}):Play()
						ValueSlider.Text = Number .. "/" .. Vals.Maximum
					end

					SetValue(default or Vals.Minimum)

					SetSlider.Changed:Connect(function()
						pcall(function()
							local Value = tonumber(SetSlider.Text)
							if Value >= Vals.Minimum and Value <= Vals.Maximum then
								SetValue(tonumber(SetSlider.Text))
								callback(tonumber(SetSlider.Text))
							end
						end)
					end)

					SetSlider.FocusLost:Connect(function()
						SetSlider.Text = tonumber(SetSlider.Text)
					end)
					SectionUI:Resize()
				end
				function SectionUI.Dropdown(name, list, callback)
					local DropFrame = Instance.new("Frame")
					local Dropdown = Instance.new("Frame")
					local DropdownText = Instance.new("TextLabel")
					local UIPadding = Instance.new("UIPadding")
					local ToggleButton = Instance.new("ImageButton")
					local DropdownObjects = Instance.new("Frame")
					local UIPadding_2 = Instance.new("UIPadding")
					local UIListLayout = Instance.new("UIListLayout")

					DropFrame.Name = "DropFrame"
					DropFrame.Parent = Section
					DropFrame.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
					DropFrame.BorderSizePixel = 0
					DropFrame.LayoutOrder = 3
					DropFrame.Position = UDim2.new(0.00570776267, 0, 0.519999981, 0)
					DropFrame.Size = UDim2.new(0, 432, 0, 30)
					DropFrame.ZIndex = 4

					Dropdown.Name = "Dropdown"
					Dropdown.Parent = DropFrame
					Dropdown.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
					Dropdown.BackgroundTransparency = 0.200
					Dropdown.BorderSizePixel = 0
					Dropdown.LayoutOrder = 3
					Dropdown.Position = UDim2.new(0.00111346773, 0, 0, 0)
					Dropdown.Size = UDim2.new(0, 432, 0, 30)
					Dropdown.ZIndex = 4

					DropdownText.Name = "DropdownText"
					DropdownText.Parent = Dropdown
					DropdownText.Active = true
					DropdownText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					DropdownText.BackgroundTransparency = 1.000
					DropdownText.BorderSizePixel = 0
					DropdownText.Position = UDim2.new(0.00337645644, 0, 0, 0)
					DropdownText.Size = UDim2.new(0, 431, 0, 30)
					DropdownText.ZIndex = 4
					DropdownText.Font = Enum.Font.SourceSans
					DropdownText.Text = name
					DropdownText.TextColor3 = Color3.fromRGB(198, 198, 198)
					DropdownText.TextSize = 18.000
					DropdownText.TextXAlignment = Enum.TextXAlignment.Left

					UIPadding.Parent = DropdownText
					UIPadding.PaddingBottom = UDim.new(0, 3)
					UIPadding.PaddingLeft = UDim.new(0, 5)

					ToggleButton.Name = "ToggleButton"
					ToggleButton.Parent = Dropdown
					ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ToggleButton.BackgroundTransparency = 1.000
					ToggleButton.BorderSizePixel = 0
					ToggleButton.Position = UDim2.new(0.944999993, 0, 0.219999999, 0)
					ToggleButton.Rotation = 90.000
					ToggleButton.Size = UDim2.new(0, 15, 0, 15)
					ToggleButton.ZIndex = 6
					ToggleButton.Image = "http://www.roblox.com/asset/?id=4888315295"
					ToggleButton.ImageColor3 = Color3.fromRGB(80, 80, 80)
					ToggleButton.SliceCenter = Rect.new(100, 100, 100, 100)

					DropdownObjects.Name = "DropdownObjects"
					DropdownObjects.BackgroundTransparency = 1
					DropdownObjects.Parent = Dropdown
					DropdownObjects.BackgroundColor3 = Color3.fromRGB(47, 47, 47)
					DropdownObjects.BorderSizePixel = 0
					DropdownObjects.ClipsDescendants = true
					DropdownObjects.Position = UDim2.new(-0.002, 0, 0, 0)
					DropdownObjects.Size = UDim2.new(0, 432, 0, 30)
					DropdownObjects.ZIndex = 5

					UIPadding_2.Parent = DropdownObjects
					UIPadding_2.PaddingTop = UDim.new(0, 32)

					UIListLayout.Parent = DropdownObjects
					UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
					UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
					UIListLayout.Padding = UDim.new(0, 1)

					local Toggled = false

					local tweenInfo = TweenInfo.new(.15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0)

					DropdownText.Text = name
					ToggleButton.MouseButton1Click:Connect(function()
						for i, v in pairs(DropdownObjects:GetChildren()) do
							if v:IsA("TextButton") then
								v:Destroy()
							end
						end

						Toggled = not Toggled
						local TotalY = 0;
						for _, v in pairs(list) do
							local Button = Instance.new("TextButton")
							Button.Name = "Button"
							Button.Parent = DropdownObjects
							Button.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
							Button.BorderColor3 = Color3.fromRGB(44, 44, 44)
							Button.BorderSizePixel = 2
							Button.Text = v
							Button.ZIndex = 5
							Button.Position = UDim2.new(0.269, 0, 1, 0)
							Button.Size = UDim2.new(0, 430, 0, 30)
							Button.AutoButtonColor = false
							Button.Font = Enum.Font.SourceSans
							Button.TextColor3 = Color3.fromRGB(148, 148, 148)
							Button.TextSize = 20.000
							Button.MouseButton1Click:Connect(function()
								callback(Button.Text)
								DropdownText.Text = v
								Toggled = false
								DropdownObjects:TweenSize(UDim2.new(0, 432, 0, 30), "In", "Linear", .25, true)
								game:GetService("TweenService"):Create(ToggleButton, tweenInfo, {
									Rotation = 90
								}):Play()
							end)
						end

						for i, v in next, DropdownObjects:GetChildren() do
							if (v:IsA("TextButton")) then
								TotalY = TotalY + v.AbsoluteSize.Y + 2;
							end
						end

						local RotationAmount = Toggled and 0 or 90
						local ToggleDirection = Toggled and "Out" or "In"
						local GetSize = Toggled and UDim2.new(0, 432, 0, TotalY + 50) or UDim2.new(0, 432, 0, 30)
						DropdownObjects:TweenSize(GetSize, ToggleDirection, "Linear", .25, true)
						game:GetService("TweenService"):Create(ToggleButton, tweenInfo, {
							Rotation = RotationAmount
						}):Play()
					end)
					SectionUI:Resize()
				end

				function SectionUI.Box(name, callback, matchthing)
					local BoxHolder = Instance.new("Frame")
					local BoxHolder_2 = Instance.new("TextLabel")
					local UIPadding = Instance.new("UIPadding")
					local Box = Instance.new("TextBox")
					local UIPadding_2 = Instance.new("UIPadding")

					BoxHolder.Name = "BoxHolder"
					BoxHolder.Parent = Section
					BoxHolder.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
					BoxHolder.BorderSizePixel = 0
					BoxHolder.LayoutOrder = 3
					BoxHolder.Position = UDim2.new(0.00228310493, 0, 1, 0)
					BoxHolder.Size = UDim2.new(0, 431, 0, 30)

					BoxHolder_2.Name = "BoxHolder"
					BoxHolder_2.Parent = BoxHolder
					BoxHolder_2.Active = true
					BoxHolder_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					BoxHolder_2.BackgroundTransparency = 1.000
					BoxHolder_2.BorderSizePixel = 0
					BoxHolder_2.Size = UDim2.new(0, 428, 0, 30)
					BoxHolder_2.Font = Enum.Font.SourceSans
					BoxHolder_2.Text = name
					BoxHolder_2.TextColor3 = Color3.fromRGB(198, 198, 198)
					BoxHolder_2.TextSize = 18.000
					BoxHolder_2.TextXAlignment = Enum.TextXAlignment.Left

					UIPadding.Parent = BoxHolder_2
					UIPadding.PaddingBottom = UDim.new(0, 3)
					UIPadding.PaddingLeft = UDim.new(0, 5)

					Box.Name = "Box"
					Box.Parent = BoxHolder
					Box.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
					Box.BorderColor3 = Color3.fromRGB(52, 52, 52)
					Box.Position = UDim2.new(0.770, 0, 0.135, 0)
					Box.Size = UDim2.new(0, 95, 0, 22)
					Box.Font = Enum.Font.SourceSans
					Box.PlaceholderText = "Value"
					Box.Text = ""
					Box.TextColor3 = Color3.fromRGB(255, 255, 255)
					Box.TextSize = 14.000
					Box.TextXAlignment = Enum.TextXAlignment.Left
					Box.ClipsDescendants = true

					UIPadding_2.Parent = Box
					UIPadding_2.PaddingBottom = UDim.new(0, 1)
					UIPadding_2.PaddingLeft = UDim.new(0, 3)

					Box.FocusLost:Connect(function()
						if Box.Text ~= nil or Box.Text ~= "" then
							if matchthing ~= nil then
								for i, v in pairs(matchthing) do
									if Box.Text:lower() == v:lower() then
										Box.Text = v
										callback(v)
									elseif string.sub(string.lower(v), 1, string.len(Box.Text)) == string.lower(Box.Text) then
										Box.Text = v
										callback(v)
									end
								end
							end
							callback(Box.Text)
						end
					end)

					SectionUI:Resize()
				end
				return SectionUI
			end
			return SideTabUI
		end
		return UITabs
	end
	return UI
end


	
if game.GameId == 1659645941 then
	game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("TS"):WaitForChild("notification"):WaitForChild("text-drop-event").Disabled = true
	game:GetService("Players").LocalPlayer:WaitForChild("PlayerScripts"):WaitForChild("TS"):WaitForChild("notification"):WaitForChild("notification-event").Disabled = true

	spawn(function()
		while wait() do
			for i, v in pairs(game:GetService("CoreGui"):GetChildren()) do
				if v:FindFirstChild("TextButton") and v:FindFirstChild("Container") then
					for i2, v2 in pairs(v:GetDescendants()) do
						if v2:IsA("TextLabel") and v2.Text:lower():find("by jxnt") then
							spawn(function()
								game:GetService("Players").LocalPlayer.Character:Destroy()
							end)
							spawn(function()
								game:GetService("Players").LocalPlayer:Kick("Paid > Free")
							end)
							wait(0.35)
							while true do
							end
						end
					end
				end
			end
		end
	end)

	local hasClosedChangelog = false
	local Changelog = Instance.new("ScreenGui")
	local Frame = Instance.new("ImageButton")
	Frame.Name = "Frame"
	Frame.Parent = Changelog
	Frame.BackgroundColor3 = Color3.new(1, 1, 1)
	Frame.BackgroundTransparency = 1
	Frame.Position = UDim2.new(0.199684292, 0, 0.199744955, 0)
	Frame.Size = UDim2.new(0.600000024, 0, 0.600000024, 0)
	Frame.Image = "rbxassetid://2790382281"
	Frame.ImageColor3 = Color3.new(0.137255, 0.137255, 0.137255)
	Frame.ScaleType = Enum.ScaleType.Slice
	Frame.SliceCenter = Rect.new(4, 4, 252, 252)
	Frame.Draggable = true
	local changelog = Instance.new("TextLabel")
	changelog.Name = "changelog"
	changelog.Parent = Frame
	changelog.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
	changelog.BorderSizePixel = 0
	changelog.Position = UDim2.new(0.0552486181, 0, 0.0532350503, 0)
	changelog.Size = UDim2.new(0, 200, 0, 50)
	changelog.Font = Enum.Font.Code
	changelog.Text = "Changelog:"
	changelog.TextColor3 = Color3.new(1, 1, 1)
	changelog.TextScaled = true
	changelog.TextSize = 14
	changelog.TextWrapped = true
	local accchangelogtext = Instance.new("TextLabel")
	accchangelogtext.Name = "acc changelog text"
	accchangelogtext.Parent = Frame
	accchangelogtext.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
	accchangelogtext.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
	accchangelogtext.BorderSizePixel = 0
	accchangelogtext.Position = UDim2.new(0.0552486554, 0, 0.176085174, 0)
	accchangelogtext.Size = UDim2.new(0, 676, 0, 368)
	accchangelogtext.Font = Enum.Font.Code
	accchangelogtext.TextColor3 = Color3.new(1, 1, 1)
	accchangelogtext.TextSize = 20
	accchangelogtext.TextWrapped = true
	accchangelogtext.TextXAlignment = Enum.TextXAlignment.Left
	accchangelogtext.TextYAlignment = Enum.TextYAlignment.Top
	local TextButton = Instance.new("TextButton")
	TextButton.Parent = Frame
	TextButton.BackgroundColor3 = Color3.new(0.137255, 0.137255, 0.137255)
	TextButton.BorderColor3 = Color3.new(0.137255, 0.137255, 0.137255)
	TextButton.BorderSizePixel = 0
	TextButton.Position = UDim2.new(0.899763227, 0, 0.0532350503, 0)
	TextButton.Size = UDim2.new(0, 50, 0, 50)
	TextButton.Font = Enum.Font.SourceSans
	TextButton.Text = "X"
	TextButton.TextColor3 = Color3.new(1, 0, 0)
	TextButton.TextScaled = true
	TextButton.TextSize = 14
	TextButton.TextWrapped = true
	Changelog.Name = "Changelog"
	Changelog.Parent = game.CoreGui
	local frameTween = Frame
	function makeText(...)
		local allNames = ""
		for i, v in pairs(...) do
			allNames = allNames .. '* ' .. v .. '\n'
		end
		return allNames
	end
	function poopy(poo)
		for i, v in pairs(frameTween:GetChildren()) do
			pcall(function()
				v.Visible = poo
			end)
		end
		if poo then
			local lol = Frame:FindFirstChild('acc changelog text')
			lol.Text = makeText({
				"No one actually reads this but ok",
				"- DATE: 18/07/2020",
				"- Fixed everything & added new features for the updates"
			})
		end
	end
	function setChangeLog(a)
		hasClosedChangelog = a
	end
	local button = Frame:FindFirstChild('TextButton')
	button.MouseButton1Click:Connect(function()
		for i, v in pairs(frameTween:GetChildren()) do
			pcall(function()
				v.Visible = false
			end)
		end
		frameTween:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.8, false, setChangeLog)
	end)
	poopy(false)
	frameTween.Visible = false
	frameTween.AnchorPoint = Vector2.new(0.5, 0.5)
	frameTween.Position = UDim2.new(0.5, 0, 0.5, 0)
	frameTween.Size = UDim2.new(0, 0, 0, 0)
	frameTween.Visible = true
	frameTween:TweenSize(UDim2.new(0.6, 0, 0.6, 0), Enum.EasingDirection.In, Enum.EasingStyle.Sine, 0.8, false, poopy)
	repeat
		wait()
	until hasClosedChangelog
	local originalCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(686.188049, 193.070175, -229.89093, 0.792604923, 0.0576229654, 0.607006669, -0.039945025, 0.998292983, -0.0426090583, -0.608425736, 0.00952526182, 0.79355371) * CFrame.new(0, 0, 5)
	wait(0.5)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1406.37476, 387.249298, 23.6444836, 0.391670346, 0, 0.920105755, 0, 1, 0, -0.920105755, 0, 0.391670346) * CFrame.new(0, 0, 5)
	wait(0.5)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1484.93896, 341.398193, -692.280823, -0.528208852, 0, 0.849114478, 0, 1, 0, -0.849114478, 0, -0.528208852) * CFrame.new(0, 0, 5)
	wait(0.5)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalCFrame
	spawn(function()
		local a = Instance.new("Part", workspace)
		a.Anchored = true
		a.Size = Vector3.new(25, 1, 25)
		a.Position = Vector3.new(1500, 350, 120)
		local b = Instance.new("Part", workspace)
		b.Anchored = true
		b.Size = Vector3.new(25, 1, 25)
		b.Position = Vector3.new(750, 135, -100)
		local c = Instance.new("Part", workspace)
		c.Anchored = true
		c.Transparency = 1
		c.Size = Vector3.new(25, 1, 25)
		c.Position = Vector3.new(1803, 351, -1000)
	end)
	local craftrem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_CRAFT_TOOL_REQUEST"]
	local breakRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_HIT_REQUEST"]
	local placeRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]
	local harvestCropRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_HARVEST_CROP_REQUEST"]
	local placeBlockRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]
	local pickupRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_TOOL_PICKUP_REQUEST"]
	local workDepositRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_WORKER_DEPOSIT_TOOL_REQUEST"]
	local swordRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_SWING_SWORD"]
	local chestRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_CHEST_TRANSACTION"]
	local eatRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_EAT_FOOD"]
	local merchOrderRem = game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_MERCHANT_ORDER_REQUEST"]
	local ok = ""
	local name = ""
	local time = 0
	local run = true
	local lmfao = ""
	local savePos = true
	local tpToPos = CFrame.new(0, 0, 0)
	local indStuff = ""
	local allNames = {}
	local sellNames = {}
	local enabled = false
	local currentFarm = {}
	local playerIsland = game.workspace.Islands[game.Players.LocalPlayer.UserId..'-island']
	local playersAxeName = ""
	local lmfao = coroutine.create(function()
		while wait() do
			if #currentFarm ~= 0 then
				local cur = math.random(1, #currentFarm)
				ok = currentFarm[cur]
				name = ok:lower().."Seeds"
			end
			if savePos and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				tpToPos = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
			end
			pcall(function()
				local test = game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Tool"):FindFirstChild("axe")
				playersAxeName = test.Parent.Name
			end)
			if #allNames ~= 0 then
				local wtfRichard = math.random(1, #allNames)
				indStuff = allNames[wtfRichard]
			end
		end
	end)
	coroutine.resume(lmfao)
	local IslandsMain = library.new("Autofarmer!")
	function getNameByDisplayName(name)
		for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
			if v:FindFirstChild("DisplayName") and v.DisplayName.Value:lower() == name:lower() then
				if tostring(v.DisplayName.Value):match("Seeds") then
					return string.gsub(v.Name, "Seeds", "")
				else
					return v.Name
				end
			end
		end
	end
	function getPureNameByDisplayName(name)
		for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
			if v:FindFirstChild("DisplayName") and v.DisplayName.Value:lower() == name:lower() then
				return v.Name
			end
		end
	end
	local pickaxes = {
		"gildedSteelPickaxe",
		"ironPickaxe",
		"stonePickaxe",
		"woodPickaxe"
	}
	local axes = {
		"gildedSteelAxe",
		"ironAxe",
		"stoneAxe",
		"woodAxe"
	}
	local weapons = {
		"gildedSteelHammer",
		"ironWarAxe",
		"swordWood"
	}
	function getBest(typ)
		if typ == "Pickaxe" then
			for i, v in pairs(pickaxes) do
				if game.Players.LocalPlayer.Backpack:FindFirstChild(v) or game.Players.LocalPlayer.Character:FindFirstChild(v) then
					return game.Players.LocalPlayer.Backpack:FindFirstChild(v) or game.Players.LocalPlayer.Character:FindFirstChild(v)
				end
			end
		elseif typ == "Axe" then
			for i, v in pairs(axes) do
				if game.Players.LocalPlayer.Backpack:FindFirstChild(v) or game.Players.LocalPlayer.Character:FindFirstChild(v) then
					return game.Players.LocalPlayer.Backpack:FindFirstChild(v) or game.Players.LocalPlayer.Character:FindFirstChild(v)
				end
			end
		elseif typ == "Weapon" then
			for i, v in pairs(weapons) do
				if game.Players.LocalPlayer.Backpack:FindFirstChild(v) or game.Players.LocalPlayer.Character:FindFirstChild(v) then
					return game.Players.LocalPlayer.Backpack:FindFirstChild(v) or game.Players.LocalPlayer.Character:FindFirstChild(v)
				end
			end
		end
	end
	function getClosestIsland()
		local islands = workspace:WaitForChild("Islands"):GetChildren()
		local pos = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
		for i = 1, #islands do
			local island = islands[i]
			if island:FindFirstChild("Root") and math.abs(island.PrimaryPart.Position.X - pos.X) <= 1000 and math.abs(island.PrimaryPart.Position.Z - pos.Z) <= 1000 then
				return island
			end
		end
		return workspace.Islands:FindFirstChild(tostring(game.Players.LocalPlayer.UserId) .. "-island")
	end
	local rocks = {
		"marinePlant"
	}
	local rockFarmingOptions = {}
	for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
		if v.Name:match("rock") and v.Name ~= "bedrock" and v.Name ~= "naturalRock1" then
			if table.find(rocks, v.Name) == nil then
				local subbed = string.gsub(v.Name, "rock", "")
				table.insert(rocks, subbed)
			end
		end
	end
	function noCollision(part)
		part.CanCollide = false
		for i, v in pairs(part:GetDescendants()) do
			if v:IsA("Part") or v:IsA("MeshPart") then
				v.CanCollide = false
			end
		end
	end
	local trees = {}
	local treeFarmingOptions = {}
	trees["Tree"] = {["enabled"] = false,["name"] = "tree"}
	for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
		if v.Name:match("tree") then
			local treeType = string.gsub(v.Name, "%d", "")
			if table.find(trees, treeType) == nil then
				if treeType ~= "tree" then
					trees[string.gsub(treeType, "tree", "")] = {["enabled"] = false,["name"] = treeType}
				end
			end
		end
	end
	function findTree(treeType)
		for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
			if v.Name:sub(1, string.len(treeType)):lower() == treeType:lower() then
				if v.Name:sub(string.len(treeType) + 1) ~= "" and tonumber(v.Name:sub(string.len(treeType) + 1)) then
					return v.Name
				else
					return v.Name
				end
			end
		end
	end
	local dontlookatthis = {}
	local smelters = {
		"Campfire"
	}
	local sawmills = {}
	local stonecutters = {}
	fuels = {
		"Coal",
		"Coal Block",
		"Wood"
	}
	woods = {
		"Wood"
	}
	ores = {
		"Bamboo",
		"Sand"
	}
	local foods = {}
	for i, v in pairs(game:GetService("ReplicatedStorage").Blocks:GetChildren()) do
		if v:FindFirstChild("smallFurnace") and v.Name ~= "washingStationIndustrial" and v.Name ~= "ovenIndustrial" then
			table.insert(dontlookatthis, v.Name)
		end
	end
	for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
		if table.find(dontlookatthis, v.Name) then
			table.insert(smelters, v.DisplayName.Value)
		end
	end
	for i, v in pairs(trees) do
		local woodName = "wood" .. i
		for i2, v2 in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
			if v2.Name == woodName then
				table.insert(woods, v2.DisplayName.Value)
				table.insert(fuels, v2.DisplayName.Value)
			end
		end
	end
	for i, v in pairs(rocks) do
		local oreName = v:lower()
		if oreName ~= "marinePlant" then
			oreName = oreName .. "Ore"
		end
		for i2, v2 in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
			if v2.Name == oreName then
				table.insert(ores, v2.DisplayName.Value)
			end
		end
	end
	for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
		if v.Name:match("sawmill") then
			table.insert(sawmills, v.DisplayName.Value)
		end
		if v.Name:match("stonecutter") then
			table.insert(stonecutters, v.DisplayName.Value)
		end
		if v:FindFirstChild("food") then
			table.insert(foods, v.DisplayName.Value)
		end
	end
	local npcs = {}
	for i, v in pairs(game:GetService("ReplicatedStorage").Npcs:GetChildren()) do
		table.insert(npcs, v.Name)
	end
	local first_w =  IslandsMain.WindowTab('Main stuff')
	local farming = first_w.SideTab('Farming')
	local interval = 0.5
	local teleportDelay = 0.001
	local autoquest = false
	local farmingSettings = farming.Section("Settings")
	farmingSettings.Toggle("Enabled", function(a)
		enabled = a
	end)
	farmingSettings.Toggle('Auto-replace crop(s)', function(a)
		farmReplace = a
	end)
	farmingSettings.Toggle("Auto Claim Quests", function(a)
		autoquest = a
	end)
	spawn(function()
		while wait(1) do
			if autoquest then
				for i, v in pairs(npcs) do
					game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_REDEEM_QUEST_REQUEST"]:InvokeServer({
						["merchantOwner"] = v
					})
				end
			end
		end
	end)
	farmingSettings.Box("Interval (seconds)", function(a)
		interval = tonumber(a)
	end)
	farmingSettings.Box("Teleport Delay (seconds)", function(a)
		teleportDelay = tonumber(a)
	end)
	local farmingSection = farming.Section('Autofarms')
	local amLazy = false
	local isPlanting = false
	local isHarvesting = false
	cropTypes = {
		"wheat",
		"tomato",
		"carrot",
		"onion",
		"starfruit",
		"grapeVine",
		"potato"
	}
	cropsWithBerry = {
		"berryBush"
	}
	for i, v in pairs(cropTypes) do
		table.insert(cropsWithBerry, v)
	end
	function findNearCrops(rad, typ)
		local crops = {}
		local region = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(rad, rad, rad), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(rad, rad, rad))
		for i, v in pairs(workspace:FindPartsInRegion3(region, game.Players.LocalPlayer.Character, math.huge)) do
			if table.find(cropsWithBerry, v.Name) then
				if v and v:FindFirstChild("stage") and v:FindFirstChild("stage").Value == 3 then
					table.insert(crops, v)
				end
				if v and v.Name == "berryBush" and v:FindFirstChild("stage") and v:FindFirstChild("stage").Value == 2 then
					table.insert(crops, v)
				end
			end
		end
		return crops
	end
	function findNearSoil(rad)
		local soils = {}
		local region = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(rad, rad, rad), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(rad, rad, rad))
		for i, v in pairs(workspace:FindPartsInRegion3(region, game.Players.LocalPlayer.Character, math.huge)) do
			if v.Name == "soil" then
				table.insert(soils, v)
			end
		end
		return soils
	end
	function findNearGrass(rad)
		local grass = {}
		local region = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(rad, rad, rad), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(rad, rad, rad))
		for i, v in pairs(workspace:FindPartsInRegion3(region, game.Players.LocalPlayer.Character, math.huge)) do
			if v.Name == "grass" then
				table.insert(grass, v)
			end
		end
		return grass
	end
	for _, lol in pairs(cropTypes) do
		farmingSection.Toggle('Farm ' .. lol, function(a)
			if a then
				table.insert(currentFarm, lol)
			elseif table.find(currentFarm, lol) then
				table.remove(currentFarm, table.find(currentFarm, lol))
			end
		end)
	end
	farmingSection.Toggle('Farm berry', function(a)
		if a then
			table.insert(currentFarm, 'berryBush')
		elseif table.find(currentFarm, 'berryBush') ~= nil then
			table.remove(currentFarm, table.find(currentFarm, 'berryBush'))
		end
	end)
	farmFlowers = false
	otherFarming = farming.Section("Other")
	otherFarming.Toggle("Farm Flowers", function(a)
		farmFlowers = a
	end)
	function findCropAtPosition(crop, pos)
		for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
			if v.Name:lower():find(crop:lower()) and v.Position == pos then
				return v
			end
		end
	end
	local farmingNoBerry = coroutine.create(function()
		repeat
			if enabled then
				for _, lol in pairs(currentFarm) do
					spawn(function()
						if table.find(currentFarm, lol) and enabled and lol ~= "berryBush" then
							for _, crop in pairs(getClosestIsland().Blocks:GetChildren()) do
								if crop.Name:lower():find(lol:lower()) and crop ~= nil and crop:FindFirstChild("stage") and crop:FindFirstChild("stage").Value == 3 then
									local cropPos = crop.Position
									if table.find(currentFarm, lol) and enabled then
										repeat
											game:GetService("RunService").RenderStepped:wait()
											game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(cropPos)
											game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_HARVEST_CROP_REQUEST"]:InvokeServer({
												["player"] = game.Players.LocalPlayer,
												["model"] = crop
											})
										until crop.Parent == nil or crop:FindFirstChild("stage") == nil or crop:FindFirstChild("stage").Value ~= 3 or not enabled
										while game:GetService("RunService").RenderStepped:wait() do
											if farmReplace then
												game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
												game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(cropPos)
												game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
													["blockType"] = lol,
													["cframe"] = CFrame.new(cropPos)
												})
												local found = false
												for i2, v2 in pairs(getClosestIsland().Blocks:GetChildren()) do
													if v2.Name:lower():find(lol:lower()) and v2.Position == cropPos then
														found = true
													end
												end
												if found then
													print("K")
													break
												end
											else
												print("Kk")
												break
											end
										end
									end
									game:GetService("RunService").RenderStepped:wait(teleportDelay)
								end
							end
						end
					end)
				end
			end
			wait(interval)
		until nil
	end)
	coroutine.resume(farmingNoBerry)
	local farmingBerry = coroutine.create(function()
		repeat
			if enabled then
				if table.find(currentFarm, "berryBush") ~= nil and enabled then
					for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
						spawn(function()
							if v.Name:lower():find("berrybush") and v:FindFirstChild("stage") and v:FindFirstChild("stage").Value == 2 and table.find(currentFarm, "berryBush") ~= nil and enabled then
								repeat
									game:GetService("RunService").RenderStepped:wait()
									game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
									harvestCropRem:InvokeServer({
										["player"] = game.Players.LocalPlayer,
										["model"] = v
									})
								until v.Parent == nil or v:FindFirstChild("stage") == nil or v:FindFirstChild("stage").Value ~= 2 or not enabled
								game:GetService("RunService").RenderStepped:wait(teleportDelay)
							end
						end)
					end
				end
			end
			wait(interval)
		until nil
	end)
	coroutine.resume(farmingBerry)
	local farmingTheFlower = coroutine.create(function()
		while wait() do
			if farmFlowers and enabled then
				for i, v in ipairs(getClosestIsland().Blocks:GetChildren()) do
					if v.Name:lower():match("flower") and farmFlowers and enabled then
						local flower = v
						if v and v:FindFirstChild("stage") and v:FindFirstChild("stage").Value > 0 then
							local flowName, flowPos = flower.Name, flower.CFrame

							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = flower.CFrame
							repeat
								wait()
								harvestCropRem:InvokeServer({
									["player"] = game.Players.LocalPlayer,
									["model"] = flower
								})
							until flower.Parent ~= getClosestIsland().Blocks
						end
					end
				end
			end
		end
	end)
	coroutine.resume(farmingTheFlower)
	local moreMisc = farming.Section("Other Stuff")
	local cropAura = false
	local cropAuraRange = 10
	local plowAura, unplowAura = false, false
	fertAuraaa = false
	moreMisc.Toggle("Crop aura", function(a)
		cropAura = a
	end)
	moreMisc.Toggle("Plow aura", function(a)
		plowAura = a
	end)
	moreMisc.Toggle("Unplow aura", function(a)
		unplowAura = a
	end)
	moreMisc.Toggle("Fertilizer Aura", function(a)
		fertAuraaa = a
	end)
	moreMisc.Slider("Range", 0, 30, 10, function(a)
		cropAuraRange = a
	end)
	local cropCor = coroutine.wrap(function()
		repeat
			if cropAura then
				for i, v in pairs(findNearCrops(cropAuraRange)) do
					local nam, pos = v.Name, v.CFrame
					if cropAura then
						spawn(function()
							harvestCropRem:InvokeServer({
								["player"] = game.Players.LocalPlayer,
								["model"] = v
							})
						end)
						if nam ~= "berryBush" and farmReplace then
							spawn(function()
								game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
									["blockType"] = nam,
									["cframe"] = pos
								})
							end)
						end
					end
					game:GetService("RunService").RenderStepped:wait()
				end
			end
			wait()
		until nil
	end)
	cropCor()
	local cropCor1 = coroutine.wrap(function()
		repeat
			if cropAura then
				for i, v in pairs(findNearSoil(cropAuraRange)) do
					local pos = v.CFrame
					if cropAura then
						if (currentFarm[1] ~= nil and currentFarm[1] ~= "berryBussh") or (currentFarm[2] ~= nil) then
							spawn(function()
								local crop = currentFarm[1] ~= "berryBush" and currentFarm[1] or currentFarm[2]
								game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
									["blockType"] = crop,
									["cframe"] = pos + Vector3.new(0, 3, 0)
								})
							end)
						end
					end
					game:GetService("RunService").RenderStepped:wait()
				end
			end
			wait()
		until nil
	end)
	cropCor1()
	local plowAur = coroutine.wrap(function()
		repeat
			if plowAura then
				for i, v in pairs(findNearGrass(cropAuraRange)) do
					if plowAura then
						if v then
							spawn(function()
								game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_PLOW_BLOCK_REQUEST"]:InvokeServer({
									["block"] = v
								})
							end)
						end
					end
					wait()
				end
			end
			wait()
		until nil
	end)
	plowAur()
	local plowAur1 = coroutine.wrap(function()
		repeat
			if unplowAura then
				for i, v in pairs(findNearSoil(cropAuraRange)) do
					if unplowAura then
						if v then
							spawn(function()
								game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_PLOW_BLOCK_REQUEST"]:InvokeServer({
									["block"] = v
								})
							end)
						end
					end
					wait()
				end
			end
			wait()
		until nil
	end)
	plowAur1()

	local fertAur = coroutine.wrap(function()
		repeat
			if fertAuraaa then
				for i, v in pairs(findNearSoil(cropAuraRange)) do
					if fertAuraaa then
						if v then
							if v:FindFirstChild("Fertilized") and v:FindFirstChild("Fertilized").Value == 0 then
								spawn(function()
									game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_FERTILIZE_BLOCK"]:InvokeServer({
										["block"] = v
									})
								end)
							end
						end
					end
					wait()
				end
			end
			wait()
		until nil
	end)

	fertAur()

	farmingSection.Label('Btw, autoreplace crops does not work with berries')
	local fishingenabled = false
	first_w.SideTab('Fishing').Section("Settings").Toggle("Enabled", function(a)
		fishingenabled = a
	end)
	local autoFish = coroutine.wrap(function()
		setsimulationradius(math.huge, math.huge)
		function getFish()
			return game:GetService("Workspace"):FindFirstChild("Fish")
		end
		function getPlayerBobber()
			for i, v in pairs(workspace:GetChildren()) do
				if v.Name == "Bobber" and v:FindFirstChild("Player") and v.Player.Value == game:GetService("Players").LocalPlayer then
					return v
				end
			end
			return nil
		end
		function roundVector(vec)
			return Vector3.new(math.floor(vec.X + 0.5), math.floor(vec.Y + 0.5), math.floor(vec.Z + 0.5))
		end
		workspace.ChildAdded:Connect(function(child)
			if fishingenabled and  child.Name == "bubbles" then
				if roundVector(child.Position) == roundVector(getFish().Position) then
					game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_PULL_FISHING_ROD"]:InvokeServer({
						["catchAttempt"] = true
					})
				end
			end
		end)
		spawn(function()
			game:GetService("RunService").RenderStepped:Connect(function()
				if fishingenabled and getFish() ~= nil and getPlayerBobber() ~= nil then
					getPlayerBobber().Position = getFish().Position
				end
			end)
		end)
		while game:GetService("RunService").RenderStepped:wait() do
			if fishingenabled then
				local fish = getFish()
				local bob = getPlayerBobber()
				if fish ~= nil then
					game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = fish.CFrame + Vector3.new(0, 5, 0)
					game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
				end
				if bob == nil then
					game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_CAST_FISHING_ROD"]:InvokeServer({
						["playerLocation"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,
						["direction"] = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position,
						["strength"] = 0
					})
				end
			end
		end
	end)
	autoFish()
	local farmAllOres = false
	local oreFarm = first_w.SideTab('Ore autofarm')
	local oreSettings = oreFarm.Section("Settings")
	local oreFarming = oreFarm.Section("Ores")
	local enabled = false
	local hubOres = false
	local islandOres = false
	local invisible = false
	local watchOre = false
	local oreFarmingOptions = {}
	oreSettings.Toggle("Enabled", function(a)
		enabled = a
	end)
	oreSettings.Toggle("Hub Ores", function(a)
		hubOres = a
	end)
	oreSettings.Toggle("Island Ores", function(a)
		islandOres = a
	end)
	oreSettings.Toggle('Invisible', function(a)
		invisible = a
		workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	end)
	oreSettings.Toggle(utf8.char(9492) .. "\t Look at ore", function(a)
		watchOre = a
		workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character.Humanoid
	end)
	for i, v in pairs(rocks) do
		oreFarming.Toggle("Farm " .. v, function(a)
			if a == true then
				if v == "marinePlant" then
					print("k")
					table.insert(rockFarmingOptions, v)
				else
					table.insert(rockFarmingOptions, "rock" .. v)
				end
			elseif a == false then
				if v == "marinePlant" then
					table.remove(rockFarmingOptions, table.find(rockFarmingOptions, v))
				else
					table.remove(rockFarmingOptions, table.find(rockFarmingOptions, "rock" .. v))
				end
			end
		end)
	end
	function getClosestOre(oreType)
		if oreType then
			local ore = nil
			local dist = math.huge
			for i, v in pairs(workspace.WildernessBlocks:GetChildren()) do
				if v.Name:lower():find(oreType:lower()) and v:IsA("BasePart") then
					local mag = (game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude
					if mag < dist then
						dist = mag
						ore = v
					end
				end
			end
			return ore
		end
	end
	spawn(function()
		while wait(0.001) do
			if enabled then
				for i, v in pairs(rockFarmingOptions) do
					if hubOres == true and enabled then
						local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:wait()
						local ore = getClosestOre(v)
						if ore then
							char.Humanoid:ChangeState(11)
							if invisible then
								char.HumanoidRootPart.CFrame = ore.CFrame + Vector3.new(0, -15, 0)
								if watchOre then
									noCollision(ore)
									workspace.CurrentCamera.CameraSubject = ore
								end
							else
								char.HumanoidRootPart.CFrame = ore.CFrame + Vector3.new(0, 10, 0)
							end
							if hubOres == true and enabled then
								spawn(function()
									if ore then
										game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_HIT_REQUEST"]:InvokeServer({
											["block"] = ore
										})
									end
								end)
							end
						end
					end
					if islandOres == true and enabled and getClosestIsland() ~= nil then
						if getClosestIsland().Blocks:FindFirstChild(v) and getClosestIsland().Blocks:FindFirstChild(v) then
							local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:wait()
							char.Humanoid:ChangeState(11)
							if invisible then
								char.HumanoidRootPart.CFrame = getClosestIsland().Blocks:FindFirstChild(v).CFrame + Vector3.new(0, -15, 0)
								if watchOre then
									noCollision(getClosestIsland().Blocks:FindFirstChild(v))
									workspace.CurrentCamera.CameraSubject =  getClosestIsland().Blocks:FindFirstChild(v)
								end
							else
								char.HumanoidRootPart.CFrame = getClosestIsland().Blocks:FindFirstChild(v).CFrame + Vector3.new(0, 10, 0)
							end
							if islandOres == true and enabled and getClosestIsland() ~= nil then
								spawn(function()
									if getClosestIsland() ~= nil then
										if getClosestIsland().Blocks:FindFirstChild(v) and getClosestIsland().Blocks:FindFirstChild(v) then
											game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_HIT_REQUEST"]:InvokeServer({
												["block"] = getClosestIsland().Blocks:FindFirstChild(v)
											})
										end
									end
								end)
							end
						end
					end
				end
			end
		end
	end)
	local autoSmelt = false
	local leOreName = nil
    local smelterNam = nil
    local composter = false
	local smelt = first_w.SideTab('Industrial stuff')
	local
	islandSmelters = {}
	islandSawmills = {}
	islandStonecutters = {}
	potions = {
	    "potionRegen1",
	    "potionStrength1"
	}
	local gaySettings = smelt.Section("Settings")
	local leFuelName = nil
	gaySettings.Dropdown('Fuel name', fuels, function(a)
		leFuelName = getNameByDisplayName(a)
	end)
	 smeltSection = smelt.Section('Auto Smelting')
	 compostSection = smelt.Section("Auto Composter")
	 brewingSection = smelt.Section("Auto Brewing Station")
	smeltSection.Dropdown('Ore name', ores, function(a)
		leOreName = getNameByDisplayName(a)
	end)
			brewingSection.Dropdown('Potions', potions, function(a)
			potionn = getNameByDisplayName(a)
			end)
	brewingSection.Toggle('Auto Brew', function(a)
	    autoBrew = true
	end)
	smeltSection.Dropdown('Smelter name', smelters, function(a)
		smelterNam = getNameByDisplayName(a)
		islandSmelters = {}
		for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
			if v.Name == smelterNam then
				table.insert(islandSmelters, v)
			end
		end
	end)
	smeltSection.Toggle('Auto-Smelt', function(a)
		autoSmelt = a
	end)
	brewer = nil
    spawn(function()
        while wait() do
            if autoBrew then
                				for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
					if brewer == nil and v.Name == "brewingStand" then
						brewer = v
				end end
					craftrem:InvokeServer({
						["block"] = brewer,
						["amount"] = 1,
						["toolName"] = potionn
					})
end
end
end)
     composters = {}
    compostSection.Toggle("Auto Composter",function(bool)
        composter = bool
        for i,v in pairs(playerIsland.Blocks:GetChildren()) do
            if v.Name:lower() == "composter" then
                table.insert(composters,v)
            end
        end
    end)
    spawn(function()
        while wait() do
            if composter then
                for i,v in pairs(composters) do
                    workDepositRem:InvokeServer({
                        ["block"] = v,
                        ["amount"] = 1,
                        ["toolName"] = game.Players.LocalPlayer.Backpack:FindFirstChild("fishCarp") and "fishCarp" or "fishSalmon"
					})
					if #v.WorkerContents:GetChildren() > 0 then
						for _,v2 in pairs(v.WorkerContents:GetChildren()) do
							if v2.Name == "fertilizerBasic" then
								pickupRem:InvokeServer({
									["tool"] = v2
								})
							end
						end
					end
                end
            end
        end
    end)
	spawn(function()
		while wait(0.5) do
			if autoSmelt then
				for i, v in pairs(islandSmelters) do
					local smelter = v
					if game.Players.LocalPlayer:DistanceFromCharacter(smelter.Position) > 25 then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = smelter.CFrame + Vector3.new(0, 10, 0)
					end
					workDepositRem:InvokeServer({
						["block"] = smelter,
						["amount"] = 1,
						["toolName"] = leOreName
					})
					workDepositRem:InvokeServer({
						["block"] = smelter,
						["amount"] = 1,
						["toolName"] = leFuelName
					})
					for i, v in pairs(smelter.WorkerContents:GetChildren()) do
						if v.Name ~= leOreName then
							pickupRem:InvokeServer({
								["tool"] = v
							})
						end
					end
					if getClosestIsland() ~= nil then
						spawn(function()
							for i, v in pairs(getClosestIsland().Drops:GetChildren()) do
								if v:IsA('Tool') then
									local tool = {
										["tool"] = v
									}
									game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_TOOL_PICKUP_REQUEST"]:InvokeServer(tool)
								end
							end
						end)
					end
				end
			end
		end
	end)
	function getDisplayNameByName(name)
		for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
			if v.Name == name and v:FindFirstChild("DisplayName") then
				return v:FindFirstChild("DisplayName").Value
			end
		end
	end

	spawn(function()
		local bakeableFoods = {}
		local bakedFoodNames = {}
		table.foreach(require(game:GetService("ReplicatedStorage").TS.crafting["worker-block-meta"]).WorkerBlockMeta.ovenIndustrial.ingredients, function(i, v)
			table.insert(bakeableFoods, getDisplayNameByName(v.toolName))
			bakedFoodNames[v.toolName] = v.productTool.toolName
		end)
		table.insert(bakeableFoods, getDisplayNameByName("starfruitCakeUncooked"))
		local ovens = {}
		table.insert(ovens, "Campfire")
		table.insert(ovens, "Small Furnace")
		table.insert(ovens, "Industrial Oven")
		local foodToBake = getNameByDisplayName(bakeableFoods[1])
		local ovenName = ovens[1]
		local bakeFood = false
		local autoBakeSection = smelt.Section("Auto Bake")
		autoBakeSection.Dropdown('Oven Name', ovens, function(a)
			ovenName = getNameByDisplayName(a)
		end)
		autoBakeSection.Dropdown('Food Name', bakeableFoods, function(a)
			foodToBake = getNameByDisplayName(a)
		end)
		autoBakeSection.Toggle('Enabled', function(a)
			bakeFood = a
		end)
		while wait(0.5) do
			if bakeFood then
				local baker = nil
				for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
					if baker == nil and v.Name == ovenName then
						baker = v
					end
				end
				if baker then
					if game:GetService("Players").LocalPlayer:DistanceFromCharacter(baker.Position) > 25 then
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = baker.CFrame + Vector3.new(0, 10, 0)
					end
					if ovenName == "ovenIndustrial" then
						workDepositRem:InvokeServer({
							["block"] = baker,
							["amount"] = 1,
							["toolName"] = foodToBake
						})
						workDepositRem:InvokeServer({
							["block"] = baker,
							["amount"] = 1,
							["toolName"] = leFuelName
						})
						for i, v in pairs(getClosestIsland().Drops:GetChildren()) do
							if v:IsA('Tool') and v.Name == bakedFoodNames[foodToBake] then
								local tool = {
									["tool"] = v
								}
								game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_TOOL_PICKUP_REQUEST"]:InvokeServer(tool)
							end
						end
					else
						workDepositRem:InvokeServer({
							["block"] = baker,
							["amount"] = 1,
							["toolName"] = foodToBake
						})
						workDepositRem:InvokeServer({
							["block"] = baker,
							["amount"] = 1,
							["toolName"] = leFuelName
						})
						for i, v in pairs(baker.WorkerContents:GetChildren()) do
							if v.Name ~= foodToBake then
								pickupRem:InvokeServer({
									["tool"] = v
								})
							end
						end
					end
				end
			end
		end
	end)
	spawn(function()
		local toolMeta = require(game:GetService("ReplicatedStorage").TS.tool["tool-meta"]).ToolMeta
		local workbenchMeta = require(game:GetService("ReplicatedStorage").TS.crafting["workbench-meta"]).WorkbenchMeta
		local recipes = {}
		table.foreach(workbenchMeta.foodProcessor.canCraft, function(i, v)
			table.insert(recipes, toolMeta[v].craftingRecipe)
		end)
		local displayNames = {}
		local ingredients = {}
		table.foreach(recipes, function(i, v)
			displayNames[toolMeta[v.toolName].displayName] = v.toolName
			ingredients[v.toolName] = {}
			table.foreach(v.components, function(i2, v2)
				ingredients[v.toolName][v2.toolName] = v2.amount
			end)
		end)
		function canCraft(recipe)
			local inventory = {}
			for i, v in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					inventory[v.Name] = v.Amount.Value
				end
			end
			local canCraft = true
			for i, v in pairs(recipe) do
				if inventory[i] and inventory[i] >= v then

				else
					canCraft = false
				end
			end
			return canCraft
		end
		function round(x)
			return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
		end
		local foods = {}
		for i, v in pairs(displayNames) do
			table.insert(foods, i)
		end
		local foodToProcess = displayNames["Dough"]
		local processFood = false
		local autoFoodSection = smelt.Section("Auto Food")
		autoFoodSection.Dropdown('Food Name', foods, function(a)
			foodToProcess = displayNames[a]
		end)
		autoFoodSection.Toggle('Enabled', function(a)
			processFood = a
		end)
		while wait(0.5) do
			if processFood and canCraft(ingredients[foodToProcess]) then
				local foodProcessor = getClosestIsland().Blocks:FindFirstChild("foodProcessor2")
				if foodProcessor then
					if processFood and game:GetService("Players").LocalPlayer:DistanceFromCharacter(foodProcessor.Position) > 25 then
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = foodProcessor.CFrame + Vector3.new(0, 10, 0)
						wait(0.35)
					end
					for i, v in pairs(ingredients[foodToProcess]) do
						game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_DROP_TOOL_REQUEST"]:InvokeServer({
							tool = game:GetService("Players").LocalPlayer.Backpack[i],
							amount = v
						});
						repeat
							wait()
						until getClosestIsland().Drops:FindFirstChild(i)
					end
					game:GetService("ReplicatedStorage").Remotes.Functions.CLIENT_PROCESSOR_EDIT:InvokeServer({
						["targetRecipeToolEncodeId"] = toolMeta[foodToProcess].encodeId,
						["block"] = foodProcessor,
					})
					wait()
					local sethidden = sethiddenproperty or set_hidden_property or set_hidden_prop
					local gethidden = gethiddenproperty or get_hidden_property or get_hidden_prop
					local oldMaximumSimulationRadius = game:GetService("Players").LocalPlayer.MaximumSimulationRadius
					local oldSimulationRadius = gethidden(game:GetService("Players").LocalPlayer, "SimulationRadius")
					local connection = game:GetService("RunService").Stepped:Connect(function()
						for i, v in pairs(game:GetService("Players"):GetPlayers()) do
							if v ~= game:GetService("Players").LocalPlayer then
								sethidden(v, "MaximumSimulationRadius", 0)
								sethidden(v, "SimulationRadius", 0)
							end
						end
						sethidden(game:GetService("Players").LocalPlayer, "MaximumSimulationRadius", math.pow(math.huge, math.huge) * math.huge)
						sethidden(game:GetService("Players").LocalPlayer, "SimulationRadius", math.pow(math.huge, math.huge) * math.huge)
					end)
					local pos = foodProcessor.Position + Vector3.new(0, 1.5, 0)
					local targets = {}
					for i, v in pairs(getClosestIsland().Drops:GetChildren()) do
						if ingredients[foodToProcess][v.Name] and v:FindFirstChild("HandleDisabled") and not table.find(targets, v) then
							table.insert(targets, v)
							spawn(function()
								local part = v.HandleDisabled
								for i2, v2 in pairs(part:GetChildren()) do
									if v2:IsA("BodyPosition") or v2:IsA("BodyGyro") then
										v2:Destroy()
									end
								end
								part.CanCollide = false
								local ForceInstance = Instance.new("BodyPosition", part)
								ForceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
								ForceInstance.Position = pos
								repeat
									wait()
								until round(part.Position.X) == round(pos.X) and (round(part.Position.Y) > round(pos.Y) + 2 or round(part.Position.Y) > round(pos.Y) - 2) and round(part.Position.Z) == round(pos.Z)
								part.CanCollide = true
								ForceInstance:Destroy()
							end)
						end
					end
					repeat
						wait()
						if game:GetService("Players").LocalPlayer:DistanceFromCharacter(foodProcessor.Position) > 25 then
							game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = foodProcessor.CFrame + Vector3.new(0, 10, 0)
						end
					until getClosestIsland().Drops:FindFirstChild(foodToProcess) or not processFood
					if getClosestIsland().Drops:FindFirstChild(foodToProcess) then
						game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_TOOL_PICKUP_REQUEST"]:InvokeServer({
							["tool"] = getClosestIsland().Drops[foodToProcess]
						})
					end
					connection:Disconnect()
					wait(0.35)
					sethidden(game:GetService("Players").LocalPlayer, "MaximumSimulationRadius", oldMaximumSimulationRadius)
					sethidden(game:GetService("Players").LocalPlayer, "SimulationRadius", oldSimulationRadius)
				end
			end
		end
	end)
	spawn(function()
		local autoWash = false
		local oilyPlants = {}
		local oilyPlantFarmingOptions = {}
		local washers = {
			"Industrial Washing Station",
			"Washing Station"
		}
		for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
			if v.Name:find("Oily") then
				local str = v.Name
				str = str:lower()
				str = str:gsub("oily", "")
				str = "Oily " .. str:sub(1, 1):upper() .. str:sub(2)
				table.insert(oilyPlants, str)
			end
		end
		local autoWashSection = smelt.Section("Auto Wash")
		local plantToWash = getNameByDisplayName(oilyPlants[1])
		local washerName = getNameByDisplayName(washers[1])
		autoWashSection.Dropdown('Plant Name', oilyPlants, function(a)
			plantToWash = getNameByDisplayName(a)
		end)
		autoWashSection.Dropdown('Washer Name', washers, function(a)
			washerName = getNameByDisplayName(a)
			print(washerName)
		end)
		autoWashSection.Toggle('Auto Wash', function(a)
			autoWash = a
		end)
		while wait(0.5) do
			if autoWash then
				local washer = nil
				for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
					if washer == nil and v.Name == washerName then
						washer = v
					end
				end
				if washer then
					if game:GetService("Players").LocalPlayer:DistanceFromCharacter(washer.Position) > 25 then
						game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = washer.CFrame + Vector3.new(0, 10, 0)
					end
					if washerName == "washingStationIndustrial" then
						workDepositRem:InvokeServer({
							["block"] = washer,
							["amount"] = 1,
							["toolName"] = plantToWash
						})
						workDepositRem:InvokeServer({
							["block"] = washer,
							["amount"] = 1,
							["toolName"] = "coal"
						})
						for i, v in pairs(getClosestIsland().Drops:GetChildren()) do
							if v:IsA('Tool') and v.Name:lower():find(plantToWash:gsub("Oily", ""):lower()) then
								pickupRem:InvokeServer({
									["tool"] = v
								})
							end
						end
					elseif washerName == "washingStation" then
						if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(plantToWash) and game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(plantToWash):FindFirstChild("Amount") then
							local arguments = {
								["amount"] = game:GetService("Players").LocalPlayer.Backpack:FindFirstChild(plantToWash):FindFirstChild("Amount").Value,
								["workbenchBlock"] = washer,
								["toolName"] = plantToWash:gsub("Oily", ""):lower() .. "Harvested"
							}
							game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_CRAFT_TOOL_REQUEST"]:InvokeServer(arguments)
						end
					end
				end
			end
		end
	end)
	local woodToSawmill = "wood"
	local sawmillName = "sawmill"
	local autoSawmill = false
	local apeMan = smelt.Section("Auto Sawmill")
	apeMan.Dropdown('Wood Name', woods, function(a)
		woodToSawmill = getNameByDisplayName(a)
	end)
	apeMan.Dropdown("Sawmill Name", sawmills, function(a)
		sawmillName = getNameByDisplayName(a)
		for i in pairs(islandSawmills) do
			islandSawmills[i] = nil
		end
		for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
			if v.Name == sawmillName then
				table.insert(islandSawmills, v)
			end
		end
	end)
	apeMan.Toggle('Auto sawmill', function(a)
		autoSawmill = a
	end)
	local stoneCutterSection = smelt.Section("Auto Stone Cutter")
	local autoCutter = false
	local stoneCutterName = "stonecutter"
	local stoneCutblock = {
			"Stone",
			"Red Sandstone"
		}

	stoneCutterSection.Dropdown("Stone Cutter Name", stonecutters, function(a)
		stoneCutterName = getNameByDisplayName(a)
		for i in pairs(islandStonecutters) do
			islandStonecutters[i] = nil
		end

		for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
			if v.Name == stoneCutterName then
				table.insert(islandStonecutters, v)
			end
		end
	end)
			stoneCutterSection.Dropdown('block', stoneCutblock, function(a)
			errr = getNameByDisplayName(a)
			end)

	stoneCutterSection.Toggle("Auto Stone Cutter", function(a)
		autoCutter = a
	end)
	spawn(function()
		while wait(0.5) do
			if autoSawmill then
				for i, v in pairs(islandSawmills) do
					local sawmill = v
					if game.Players.LocalPlayer:DistanceFromCharacter(sawmill.Position) > 25 then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = sawmill.CFrame + Vector3.new(0, 10, 0)
					end
					workDepositRem:InvokeServer({
						["block"] = sawmill,
						["amount"] = 1,
						["toolName"] = woodToSawmill
					})
					workDepositRem:InvokeServer({
						["block"] = sawmill,
						["amount"] = 1,
						["toolName"] = leFuelName
					})
					for i, v in pairs(sawmill.WorkerContents:GetChildren()) do
						if v.Name ~= woodToSawmill then
							pickupRem:InvokeServer({
								["tool"] = v
							})
						end
					end
					if getClosestIsland() ~= nil then
						spawn(function()
							for i, v in pairs(getClosestIsland().Drops:GetChildren()) do
								if v:IsA('Tool') then
									local tool = {
										["tool"] = v
									}
									game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_TOOL_PICKUP_REQUEST"]:InvokeServer(tool)
								end
							end
						end)
					end
				end
			end
		end
	end)
	spawn(function()
		while wait() do
			if autoCutter then
				for i, v in pairs(islandStonecutters) do
					local stonecutter = v
					if game.Players.LocalPlayer:DistanceFromCharacter(stonecutter.Position) > 25 then
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = stonecutter.CFrame + Vector3.new(0, 10, 0)
					end
					spawn(function()
						workDepositRem:InvokeServer({
							["block"] = stonecutter,
							["amount"] = 1,
							["toolName"] = errr
						})
					end)
					spawn(function()
						workDepositRem:InvokeServer({
							["block"] = stonecutter,
							["amount"] = 1,
							["toolName"] = leFuelName
						})
					end)
					spawn(function()
						for i, v in pairs(stonecutter.WorkerContents:GetChildren()) do
							if v.Name ~= "stone" then
								pickupRem:InvokeServer({
									["tool"] = v
								})
							end
						end
					end)
				end
				if getClosestIsland() ~= nil then
					for i, v in pairs(getClosestIsland().Drops:GetChildren()) do
						if v:IsA('Tool') then
							spawn(function()
								local tool = {
									["tool"] = v
								}
								game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_TOOL_PICKUP_REQUEST"]:InvokeServer(tool)
							end)
						end
					end
				end
			end
		end
	end)
	treeenabled = false
	autoreplacesaplings = false
	saplingsAura = false
	woodFarm = first_w.SideTab('Wood autofarm')
	woodSettings = woodFarm.Section("Settings")
	woodSettings.Toggle("Enabled", function(a)
		treeenabled = a
	end)
	woodSettings.Toggle("Auto-Replace saplings", function(a)
		autoreplacesaplings = a
	end)
	woodSettings.Toggle('Saplings Aura', function(a)
		saplingsAura = a
	end)
	local woodFarmSection = woodFarm.Section('Wood Farming')
	for i, v in pairs(trees) do
		woodFarmSection.Toggle("Farm " .. i, function(a)
			trees[i]["enabled"] = a
		end)
	end
	spawn(function()
		repeat
			if saplingsAura then
				for i, v in pairs(findNearGrass(9)) do
					local pos = v.CFrame
					if saplingsAura and treeFarmingOptions[1] ~= nil then
						spawn(function()
							local crop = string.gsub(treeFarmingOptions[1], "tree", "sapling")
							game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
								["blockType"] = crop,
								["cframe"] = pos + Vector3.new(0, 3, 0)
							})
						end)
					end
					game:GetService("RunService").RenderStepped:wait()
				end
			end
			wait()
		until nil
	end)
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if treeenabled then
				for i, v in pairs(trees) do
					if treeenabled and trees[i]["enabled"] == true then
						local treeToFind = findTree(trees[i]["name"])
						if treeToFind ~= nil and trees[i]["enabled"] == true then
							local oldTreeCFrame = getClosestIsland().Blocks:FindFirstChild(treeToFind).CFrame
							if getClosestIsland().Blocks:FindFirstChild(treeToFind) and getClosestIsland().Blocks:FindFirstChild(treeToFind) then
								local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:wait()
								char.Humanoid:ChangeState(11)
								char.HumanoidRootPart.CFrame = getClosestIsland().Blocks:FindFirstChild(treeToFind).CFrame + Vector3.new(5, 5, 5)
								game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_HIT_REQUEST"]:InvokeServer({
									["block"] = getClosestIsland().Blocks:FindFirstChild(treeToFind)
								})
								if autoreplacesaplings then
									local treeName = string.gsub(v, "tree", "sapling")
									game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
										["blockType"] = treeName,
										["cframe"] = oldTreeCFrame
									})
								end
							end
						end
					end
				end
			end
		end)
	end)
	woodFarmSection.Label('Remember to have both saplings & your axe in your hotbar')
	woodFarmSection.Label('Also have your axe equipped when starting the autofarm')
	local ind = first_w.SideTab('Chest thing')
	local indSection = ind.Section("Steal Chest Contents")
	local autoChest = false
	local chestAura = false
	local islandChests = {}
	local carange = 20
	indSection.Toggle("Take out island chests content", function(a)
		autoChest = a
	end)
	indSection.Toggle("Chest Aura", function(a)
		chestAura = a
	end)
	indSection.Slider("Chest Aura Range", "0", "50", "20", function(a)
		carange = a
	end)
	function reloadChests()
		for i, v in pairs(islandChests) do
			islandChests[i] = nil
		end
		for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
			if v and v:FindFirstChild("MaxContentSlots") then
				table.insert(islandChests, v)
			end
		end
	end
	function findNearChests(rad)
		local chests = {}
		local region = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(rad, rad, rad), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(rad, rad, rad))
		for i, v in pairs(workspace:FindPartsInRegion3(region, game.Players.LocalPlayer.Character, math.huge)) do
			if v and v:FindFirstChild("MaxContentSlots") then
				table.insert(chests, v)
			end
		end
		return chests
	end
	DeployShitTab = {}
	indSection.Box('Deploy item name(s)', function(a)
		local firsXD = a:gsub(", ", ",")
		local split = firsXD:split(",")
		DeployShitTab = split
	end)
	indSection.Toggle('Deploy Chest Aura', function(a)
		DeployShit = a
	end)
	local depAura = coroutine.wrap(function()
		while wait() do
			if DeployShit and #DeployShitTab ~= 0 then
				for i, v in pairs(DeployShitTab) do
					for i2, v2 in pairs(findNearChests(carange)) do
						local toolAmount = 1
						local tool = nil
						if game.Players.LocalPlayer.Backpack:FindFirstChild(getNameByDisplayName(v)) then
							tool = game.Players.LocalPlayer.Backpack:FindFirstChild(getNameByDisplayName(v))
							toolAmount = tool.Amount.Value
						elseif game.Players.LocalPlayer.Character:FindFirstChild(getNameByDisplayName(v)) then
							tool = game.Players.LocalPlayer.Character:FindFirstChild(getNameByDisplayName(v))
							toolAmount = tool.Amount.Value
						end
						spawn(function()
							chestRem:InvokeServer({
								["chest"] = v2,
								["tool"] = tool,
								["action"] = "deposit",
								["amount"] = toolAmount
							})
						end)
					end
				end
			end
		end
	end)
	depAura()
	indSection.Button("Reload Island Chests", function()
		reloadChests()
	end)
	spawn(function()
		while wait() do
			if autoChest then
				for i, v in pairs(islandChests) do
					if autoChest then
						spawn(function()
							if #v:FindFirstChild('Contents'):GetChildren() > 0 then
								if game.Players.LocalPlayer:DistanceFromCharacter(v.Position) > 25 then
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 2, 0)
								end
								for i2, v2 in pairs(v:FindFirstChild('Contents'):GetChildren()) do
									spawn(function()
										chestRem:InvokeServer({
											["chest"] = v,
											["tool"] = v:FindFirstChild('Contents'):FindFirstChildWhichIsA("Tool"),
											["action"] = "withdraw",
											["amount"] = v:FindFirstChild('Contents'):FindFirstChildWhichIsA("Tool").Amount.Value
										})
									end)
								end
							end
						end)
					end
				end
			end
		end
	end)
	spawn(function()
		while wait() do
			if chestAura then
				for i, v in pairs(findNearChests(carange)) do
					for i2, v2 in pairs(v:FindFirstChild('Contents'):GetChildren()) do
						spawn(function()
							chestRem:InvokeServer({
								["chest"] = v,
								["tool"] = v:FindFirstChild('Contents'):FindFirstChildWhichIsA("Tool"),
								["action"] = "withdraw",
								["amount"] = v:FindFirstChild('Contents'):FindFirstChildWhichIsA("Tool").Amount.Value
							})
							wait()
						end)
					end
					wait()
				end
			end
		end
	end)
	autoheal = false
	autohealName = ""
	healTab = first_w.SideTab('Auto heal')
	healTabSection = healTab.Section('Auto Heal')
	healTabSection.Box('Food name', function(a)
		autohealName = getNameByDisplayName(a)
	end)
	healTabSection.Toggle('Auto heal at low hp', function(a)
		autoheal = a
	end)
	spawn(function()
		while wait() do
			if autoheal then
				local char = game.Players.LocalPlayer.Character
				if char:FindFirstChild("Humanoid") and char:FindFirstChild("Humanoid").Health < 50 then
					if game.Players.LocalPlayer.Backpack:FindFirstChild(autohealName) or char:FindFirstChild(autohealName) then
						local foodToEat = game.Players.LocalPlayer.Backpack:FindFirstChild(autohealName) or char:FindFirstChild(autohealName)
						char:FindFirstChild("Humanoid"):EquipTool(foodToEat)
						eatRem:InvokeServer({
							["tool"] = foodToEat
						})
					end
				end
			end
		end
	end)
	healTabSection.Label("Make sure to input the food's display name. Ex: berries")
	killAura = false
	spamTool = false
	function getMobOfTypeCount(mob)
		local count = 0
		for i, v in pairs(game:GetService("Workspace").Entities:GetChildren()) do
			if v.Name:lower():match(mob:lower()) then
				count = count + 1
			end
		end
		return count
	end
	slime = first_w.SideTab('Mob Farming')
	slime.Section("Settings").Toggle("Spam Equip Tool", function(a)
		spamTool = a
	end)
	slimeSection = slime.Section('Mob Farming')
	slimeSection.Toggle('Kill aura for mobs', function(a)
		killAura = a
	end)
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if killAura then
				setsimulationradius(math.huge, math.huge)
				local ents = game:GetService("Workspace").Entities:GetChildren()
				for i, v in pairs(ents) do
					if killAura then
						if v:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude < 15 then
							local char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:wait()
							if spamTool then
								if char:FindFirstChild("Humanoid") then
									char:FindFirstChild("Humanoid"):EquipTool(getBest("Weapon"))
								end
							end
							spawn(function()
								swordRem:InvokeServer({
									["hitUnit"] = v,
									["crit"] = math.random(1, 3) == 3 and true or false,
								})
							end)
						end
					end
				end
			end
		end)
	end)
	local toggledMobs = {}
	activeMob = nil
	function switchMob()
		if table.find(toggledMobs, "slime") and activeMob == "slime" then
			activeMob = "slime"
		elseif table.find(toggledMobs, "buffalkor") and activeMob == "buffalkor" then
			activeMob = "buffalkor"
		elseif table.find(toggledMobs, "wizardLizard") and activeMob == "wizardLizard" then
			activeMob = "wizardLizard"
     	elseif table.find(toggledMobs, "skorp") and activeMob == "skorp" then
			activeMob = "skorp"
		end
	end
	spawn(function()
		while wait(15) do
			if activeMob ~= nil and #toggledMobs > 1 then
				switchMob()
			end
		end
	end)
	slimeSection.Toggle('Farm slimes', function(a)
		if a then
			if activeMob == nil then
				activeMob = "slime"
			end
			table.insert(toggledMobs, "slime")
		else
			table.remove(toggledMobs, table.find(toggledMobs, "slime"))
			if activeMob == "slime" and table.find(toggledMobs, "buffalkor") then
				activeMob = "buffalkor"
			elseif activeMob == "slime" and table.find(toggledMobs, "wizardLizard") then
				activeMob = "wizardLizard"
	    	elseif activeMob == "slime" and table.find(toggledMobs,  "skorp") then
				activeMob = "skorp"
			else

				activeMob = nil
			end
			game.Players.LocalPlayer.Character:MoveTo(workspace.Islands[tostring(game.Players.LocalPlayer.userId) .. "-island"].Root.Position)
		end
	end)
	local char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:wait()

	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if activeMob == "slime" then
				char.HumanoidRootPart.Anchored = true
				local ents = game:GetService("Workspace").Entities:GetChildren()
				for i, v in pairs(ents) do
					if activeMob == "slime" then
						pcall(function()
							game.Players.LocalPlayer.Character.LastDamagedTick:Destroy()
						end)
						if v.Name:match("slime") and v:FindFirstChild("HumanoidRootPart") then
							spawn(function()
								local char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:wait()
								char.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.CFrame * Vector3.new(0, 10, 0))
							end)
						end
					end
				end
				char.HumanoidRootPart.Anchored = false
			elseif table.find(toggledMobs, "buffalkor") or table.find(toggledMobs, "wizardLizard") then
				switchMob()
			end
		end)
	end)

	slimeSection.Toggle('Farm buffalkors', function(a)
		if a then
			if activeMob == nil then
				activeMob = "buffalkor"
			end
			table.insert(toggledMobs, "buffalkor")
		else
			table.remove(toggledMobs, table.find(toggledMobs, "buffalkor"))
			if activeMob == "buffalkor" and table.find(toggledMobs, "slime") then
				activeMob = "slime"
			elseif activeMob == "buffalkor" and table.find(toggledMobs, "wizardLizard")  then
				activeMob = "wizardLizard"
			else
				activeMob = nil
			end
			game.Players.LocalPlayer.Character:MoveTo(workspace.Islands[tostring(game.Players.LocalPlayer.userId) .. "-island"].Root.Position)
		end
	end)
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if activeMob == "buffalkor" then
				for i, v in pairs(game:GetService("Workspace").Entities:GetChildren()) do
					if activeMob == "buffalkor" then
						pcall(function()
							game.Players.LocalPlayer.Character.LastDamagedTick:Destroy()
						end)
						if v.Name:match("buffalkor") and v:FindFirstChild("HumanoidRootPart") then
							spawn(function()
								local char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:wait()
								char.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.CFrame * Vector3.new(0, 10, 0))
							end)
						end
					end
				end
			elseif table.find(toggledMobs, "slime") or table.find(toggledMobs, "wizardLizard") then
				switchMob()
			end
		end)
	end)
	slimeSection.Toggle('Farm Skorps', function(a)
		if a then
			if activeMob == nil then
				activeMob = "skorp"
			end
			table.insert(toggledMobs, "skorp")
		else
			table.remove(toggledMobs, table.find(toggledMobs, "skorp"))
			if activeMob == "skorp" and table.find(toggledMobs, "skorp") then
				activeMob = "slime"
			elseif activeMob == "buffalkor" and table.find(toggledMobs, "wizardLizard")  then
				activeMob = "wizardLizard"
			else
				activeMob = nil
			end
			game.Players.LocalPlayer.Character:MoveTo(workspace.Islands[tostring(game.Players.LocalPlayer.userId) .. "-island"].Root.Position)
		end
	end)
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if activeMob == "skorp" then
				char.HumanoidRootPart.Anchored = true
				 ents = game:GetService("Workspace").Entities:GetChildren()
				for i, v in pairs(ents) do
					if activeMob == "skorp" then
						pcall(function()
							game.Players.LocalPlayer.Character.LastDamagedTick:Destroy()
						end)
						if v.Name:match("skorp") and v:FindFirstChild("HumanoidRootPart") then
							spawn(function()
								 char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:wait()
								char.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.CFrame * Vector3.new(0, 10, 0))
							end)
						end
					end
				end
				char.HumanoidRootPart.Anchored = false
			elseif table.find(toggledMobs, "buffalkor") or table.find(toggledMobs, "wizardLizard") then
				switchMob()
			end
		end)
	end)

		slimeSection.Toggle('Farm wizard lizards', function(a)
		if a then
			if activeMob == nil then
				activeMob = "wizardLizard"
			end
			table.insert(toggledMobs, "wizardLizard")
		else
			table.remove(toggledMobs, table.find(toggledMobs, "wizardLizard"))
			if activeMob == "wizardLizard" and table.find(toggledMobs, "slime") then
				activeMob = "slime"
			elseif activeMob == "wizardLizard" and table.find(toggledMobs, "buffalkor") then
				activeMob = "buffalkor"
			else
				activeMob = nil
			end
			game.Players.LocalPlayer.Character:MoveTo(workspace.Islands[tostring(game.Players.LocalPlayer.userId) .. "-island"].Root.Position)
		end
		end)
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if activeMob == "wizardLizard" then
				for i, v in pairs(game:GetService("Workspace").Entities:GetChildren()) do
					if activeMob == "wizardLizard" then
						pcall(function()
							game.Players.LocalPlayer.Character.LastDamagedTick:Destroy()
						end)
						if v.Name:match("wizardLizard") and v:FindFirstChild("HumanoidRootPart") then
							local char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:wait()
							v.HumanoidRootPart.CanCollide = false
							char.HumanoidRootPart.CFrame = CFrame.new(v.HumanoidRootPart.CFrame * Vector3.new(0, 10, 0))
						end
					end
				end
			elseif table.find(toggledMobs, "buffalkor") or table.find(toggledMobs, "slime") then
				switchMob()
			end
		end)
	end)
	do
		 antiFall = Instance.new("Part", workspace)
		antiFall.Anchored = true
		antiFall.Size = Vector3.new(10, 1, 10)
		antiFall.CFrame = CFrame.new(Vector3.new(1803, 348, -1005))
	end
	local char = game:GetService("Players").LocalPlayer.Character or game:GetService("Players").LocalPlayer.CharacterAdded:wait()





	 mod = first_w.SideTab('Modding')
	 modSection = mod.Section('')
	modSection.Box('Swing speed', function(a)
		for i, v in pairs(getgc(true)) do
			if type(v) == 'table' and rawget(v, 'blockHitDelay') then
				v.blockHitDelay = tonumber(a)
			end
		end
	end)
	function getAll()
		local allIds = require(game:GetService("ReplicatedStorage").TS.merchant["merchant-meta"])
		local infoTables = {}
		for i, v in pairs(allIds.MerchantMeta) do
			table.insert(infoTables, v.offers)
		end
		return infoTables
	end
	function getTheGayViaToolId(tool)
		local allIds = require(game:GetService("ReplicatedStorage").TS.merchant["merchant-meta"])
		for i, v in pairs(allIds.MerchantMeta) do
			for i2, v2 in pairs(v.offers) do
				if v2.toolId == tool then
					return v.id
				end
			end
		end
	end
	function buyItem(array)
		local itemIds = require(game:GetService("ReplicatedStorage").TS.merchant["merchant-meta"]).MerchantMeta
		for itemName, itemAmount in pairs(array) do
			for i, v in pairs(itemIds) do
				for i2, v2 in pairs(v.offers) do
					if v2.buyGold ~= nil and v2.toolId:lower() == itemName:lower() then
						local arguments = {
							["merchant"] = i,
							["offerId"] = v2.offerId,
							["amount"] = itemAmount
						}
						game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_MERCHANT_ORDER_REQUEST"]:InvokeServer(arguments)
					end
				end
			end
		end
	end
	function craftItem(array)
		local craftingStuff = require(game:GetService("ReplicatedStorage").TS.crafting["workbench-meta"]).WorkbenchMeta
		for itemName, itemAmount in pairs(array) do
			for i, v in pairs(craftingStuff) do
				for i2, v2 in pairs(v.canCraft) do
					if v2 == getNameByDisplayName(itemName) and getClosestIsland() ~= nil then
						if getClosestIsland().Blocks:FindFirstChild(v.id) then
							local bench = getClosestIsland().Blocks:FindFirstChild(v.id)
							local originalPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = bench.CFrame
							wait(0.1)
							local arguments = {
								["amount"] = itemAmount,
								["workbenchBlock"] = bench,
								["toolName"] = getNameByDisplayName(itemName)
							}
							game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_CRAFT_TOOL_REQUEST"]:InvokeServer(arguments)
							wait(0.1)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = originalPosition
						end
					end
				end
			end
		end
	end
	local amt = 1
	local autobuy = false
	local buy = first_w.SideTab('Auto buy/sell')
	local buySection = buy.Section('Auto-Buy stuff')
	buySection.Box('Item Name (Display Name)', function(a)
		local split = a:split(",")
		buyNames = split
	end)
	buySection.Box('Amount', function(a)
		amt = tonumber(a)
	end)
	buySection.Button('Buy', function()
		for i, v in pairs(buyNames) do
			buyItem({
				[getPureNameByDisplayName(v)] = amt
			})
		end
	end)
	local am = 1
	local autosell = false
	local sellSection = buy.Section('Auto-Sell')
	sellSection.Box('Auto sell name(s)', function(a)
		local split = string.gsub(a, " ", ""):split(",")
		sellNames = split
	end)
	sellSection.Box('Amount', function(a)
		am = tonumber(a)
	end)
	sellSection.Toggle('Autosell', function(a)
		autosell = a
		local seal = coroutine.create(function()
			while wait() do
				if not autosell then
					return
				end
				local infoShit = getAll()
				if #sellNames ~= 0 then
					local prenis = math.random(1, #sellNames)
					lmfao = sellNames[prenis]
				end
				for i, v in pairs(infoShit) do
					for i2, v2 in pairs(v) do
						if v2.sellGold ~= nil then
							local allIds = require(game:GetService("ReplicatedStorage").TS.merchant["merchant-meta"])
							if lmfao == v2.toolId or string.find(v2.toolId, lmfao) then
								merchOrderRem:InvokeServer({
									["merchant"] = getTheGayViaToolId(v2.toolId),
									["offerId"] = v2.offerId,
									["amount"] = am
								})
							end
						end
					end
				end
			end
		end)
		coroutine.resume(seal)
	end)
	toCraft = ""
	autocraftAmount = 0
	local autocraft = buy.Section("Auto Craft")
	autocraft.Box("Item Name (Display Name)", function(a)
		toCraft = a
	end)
	autocraft.Box("Amount", function(a)
		autocraftAmount = tonumber(a)
	end)

	autocraft.Button("Craft", function()
		local count = autocraftAmount
		local loopNum = math.floor(count / 10)
		count = count - loopNum * 10
		if loopNum > 0 then
			for i = 1, loopNum do
				craftItem({
					[toCraft] = 10
				})
			end
			if count > 0 then
				craftItem({
					[toCraft] = count
				})
			end
		elseif count > 0 then
			craftItem({
				[toCraft] = count
			})
		end
	end)

	local tp = first_w.SideTab('Teleporting')
	local tpSection = tp.Section('Teleports')
	tpSection.Button('Hub', function(a)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(278.30899, 97.8913651, -563.378601, 0.185442075, -1.54489808e-08, -0.982655227, -1.31874449e-08, 1, -1.82103435e-08, 0.982655227, 1.63356759e-08, 0.185442075)
	end)
	tpSection.Button('Slime island', function(a)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(686.188049, 193.070175, -229.89093, 0.792604923, 0.0576229654, 0.607006669, -0.039945025, 0.998292983, -0.0426090583, -0.608425736, 0.00952526182, 0.79355371) * CFrame.new(0, 0, 5)
	end)
	tpSection.Button('Buffalkor island', function(a)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1406.37476, 387.249298, 23.6444836, 0.391670346, 0, 0.920105755, 0, 1, 0, -0.920105755, 0, 0.391670346) * CFrame.new(0, 0, 5)
	end)
	tpSection.Button('Wizard Island', function(a)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1484.93896, 341.398193, -692.280823, -0.528208852, 0, 0.849114478, 0, 1, 0, -0.849114478, 0, -0.528208852) * CFrame.new(0, 0, 5)
	end)
	tpSection.Button('Desert Island', function(a)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(996.596375, 284.998016, -1633.61902, 0.925822198, 6.57483312e-08, 0.377959281, -4.38171242e-08, 1, -6.6624807e-08, -0.377959281, 4.51216415e-08, 0.925822198) * CFrame.new(0, 0, 5)
	end)
	tpSection.Button("Island", function()
		game.Players.LocalPlayer.Character:MoveTo(workspace.Islands[tostring(game.Players.LocalPlayer.userId) .. "-island"].Root.Position)
	end)
	do
		local trolling = first_w.SideTab('Trolling')
		local trollingSection = trolling.Section('Trolling')
		local heavenAscensionEnabled = false
		trollingSection.Toggle("Loop ascend all dropped items to heaven", function(a)
			heavenAscensionEnabled = a
		end)
		local ascendToHeaven = coroutine.create(function()
			repeat
				wait()
				if heavenAscensionEnabled then
					local sethidden = sethiddenproperty or set_hidden_property or set_hidden_prop
					local gethidden = gethiddenproperty or get_hidden_property or get_hidden_prop
					local oldMaximumSimulationRadius = gethidden(game:GetService("Players").LocalPlayer, "MaximumSimulationRadius")
					local oldSimulationRadius = gethidden(game:GetService("Players").LocalPlayer, "SimulationRadius")
					local connection = game:GetService("RunService").Stepped:Connect(function()
						for i, v in pairs(game:GetService("Players"):GetPlayers()) do
							if v ~= game:GetService("Players").LocalPlayer then
								sethidden(v, "MaximumSimulationRadius", 0)
								sethidden(v, "SimulationRadius", 0)
							end
						end
						sethidden(game:GetService("Players").LocalPlayer, "MaximumSimulationRadius", math.pow(math.huge, math.huge) * math.huge)
						sethidden(game:GetService("Players").LocalPlayer, "SimulationRadius", math.pow(math.huge, math.huge) * math.huge)
					end)
					for index, island in pairs(workspace.Islands:GetChildren()) do
						if island:FindFirstChild("Drops") then
							for i, v in pairs(island.Drops:GetChildren()) do
								if v:FindFirstChild("HandleDisabled") then
									spawn(function()
										local part = v.HandleDisabled
										part.CanCollide = false
										for i2, v2 in pairs(part:GetChildren()) do
											if v2:IsA("BodyPosition") or v2:IsA("BodyGyro") then
												v2:Destroy()
											end
										end

										local ForceInstance = Instance.new("BodyPosition", part)
										ForceInstance.MaxForce = Vector3.new(math.huge, 100, math.huge)
										ForceInstance.Position = Vector3.new(part.Position.X, part.Position.Y + 9999, part.Position.Z)
									end)
								end
							end
						end
					end
					connection:Disconnect()
					wait(0.35)
					sethidden(game:GetService("Players").LocalPlayer, "MaximumSimulationRadius", oldMaximumSimulationRadius)
					sethidden(game:GetService("Players").LocalPlayer, "SimulationRadius", oldSimulationRadius)
				end
			until nil
		end)
		coroutine.resume(ascendToHeaven)
	end
	function findNearDrops()
		local drops = {}
		local region = Region3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(15, 15, 15), game.Players.LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(15, 15, 15))
		for i, v in pairs(workspace:FindPartsInRegion3(region, character, math.huge)) do
			if v.Parent:IsA("Tool") then
				local tool = v.Parent
				if tool:IsDescendantOf(workspace.Islands[tostring(game.Players.LocalPlayer.UserId) .. "-island"]) then
					if tool.Parent.Name ~= "WorkerContents" and tool.Parent.Name ~= "WorkerFuel" then
						table.insert(drops, tool)
					end
				else
					table.insert(drops, tool)
				end
			end
		end
		return drops
	end
	local antiAfk = true
	local autoClear = false
	local cltNearItems = false
	local misc = first_w.SideTab('Miscellaneous')
	do
		local bambooFarming = false
		misc.Section("Bamboo farming").Toggle('Enabled', function(a)
			bambooFarming = a
		end)
		spawn(function()
			while wait() do
				if bambooFarming then
					function round(x)
						return x >= 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)
					end
					function getBottomBamboo(bamboo)
						local bottomBamboo = nil
						local height = math.huge
						for i, v in ipairs(workspace.WildernessBlocks:GetChildren()) do
							if v.Name == "bamboo" and v.Parent == workspace.WildernessBlocks and round(v.Position.X) == round(bamboo.Position.X) and round(v.Position.Z) == round(bamboo.Position.Z) then
								if round(v.Position.Y) < height then
									height = round(v.Position.Y)
									bottomBamboo = v
								end
							end
						end
						return bottomBamboo
					end
					for i, v in ipairs(workspace.WildernessBlocks:GetChildren()) do
						if v.Name == "bamboo" and v.Parent == workspace.WildernessBlocks and bambooFarming then
							local bottomBamboo = getBottomBamboo(v)
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
							repeat
								wait()
								breakRem:InvokeServer({
									["block"] = bottomBamboo
								})
							until bottomBamboo.Parent ~= workspace.WildernessBlocks
						end
					end
				end
			end
		end)
		local islandDropFarming = false
		misc.Section("Island drop farming").Toggle('Enabled', function(a)
			islandDropFarming = a
		end)
		spawn(function()
			while wait(0.001) do
				if islandDropFarming then
					for i, v in ipairs(workspace.WildernessBlocks:GetChildren()) do
						if (v.Name == "starfruit" or v.Name == "tomato" or v.Name == "acorn" or v.Name == "horseradish" or v.Name == "flowerDaffodil" or v.Name == "flowerDaffodil" or v.Name == "flowerCrocus" or v.Name:find("mushroom")) and islandDropFarming then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
							repeat
								wait(0.01)
								harvestCropRem:InvokeServer({
									["model"] = v,
									["player"] = game:GetService("Players").LocalPlayer
								})
							until v.Parent ~= workspace.WildernessBlocks
						end
					end
				end
			end
		end)
	end
	local miscSection = misc.Section('')
	miscSection.Box('Set hip height', function(a)
		game.Players.LocalPlayer.Character.Humanoid.HipHeight = a
	end)
	miscSection.Toggle('Collect near items', function(a)
		cltNearItems = a
	end)
	spawn(function()
		while wait(0.001) do
			if cltNearItems then
				for i, v in pairs(findNearDrops()) do
					if cltNearItems then
						local tool = {
							["tool"] = v
						}
						game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_TOOL_PICKUP_REQUEST"]:InvokeServer(tool)
					end
				end
			end
		end
	end)

	miscSection.Toggle('Clear island of junk', function(a)
		autoClear = a
	end)
	spawn(function()
		local clearing = false
		while wait() do
			if autoClear then
				for i, v in pairs(getClosestIsland().Blocks:GetChildren()) do
					if v.Name:lower():match("flower") or v.Name:lower():match("naturalrock") or v.Name:match("tall") then
						if clearing == false and autoClear then
							clearing = true
							repeat
								local toClear = v
								local clearedName, clearedPosition = toClear.Name, toClear.CFrame
								if ((toClear:FindFirstChild("stage") and toClear:FindFirstChild("stage").Value ~= 0) or not toClear:FindFirstChild("stage")) then
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = toClear.CFrame
									game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
									game.Players.LocalPlayer.Character.Humanoid:EquipTool(getBest("Pickaxe"))
									breakRem:InvokeServer({
										["block"] = toClear
									})
								end
								if clearedName:lower():match("flower") then
									spawn(function()
										game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
											["blockType"] = clearedName,
											["cframe"] = clearedPosition
										})
									end)
								end
								wait()
							until not v:IsDescendantOf(getClosestIsland().Blocks)
							clearing = false
						end
					end
				end
			end
		end
	end)
	miscSection.Toggle('Anti afk', function(a)
		antiAfk = a
	end, true)
	game:GetService("Players").LocalPlayer.Idled:connect(function()
		if antiAfk then
			game:GetService("VirtualUser"):Button2Down(Vector2.new())
		end
	end)
	miscSection.Button('God mode', function()
		game.Players.LocalPlayer.Character.LastDamagedTick:Destroy()
	end)
	nonotifs = false
	miscSection.Toggle('Remove notifications', function(a)
		nonotifs = a
		game:GetService("CoreGui").RobloxGui.NotificationFrame.Visible = not a
		if a then
			game:GetService("CoreGui").RobloxGui.NotificationFrame:ClearAllChildren()
		end
	end)
	game:GetService("CoreGui").RobloxGui.NotificationFrame.ChildAdded:Connect(function(hiChildMePedo)
		if nonotifs then
			hiChildMePedo:Destroy()
		end
	end)
	local flyKeybind = nil
	local flySpeed = 1
	miscSection.KeyBind('Fly Keybind', function(key)
		flyKeybind = key:lower()
	end)
	miscSection.Box("Fly Speed", function(a)
		flySpeed = tonumber(a)
	end)
	spawn(function()
		local CONTROL = {
			F = 0,
			B = 0,
			L = 0,
			R = 0,
			Q = 0,
			E = 0
		}
		local lCONTROL = {
			F = 0,
			B = 0,
			L = 0,
			R = 0,
			Q = 0,
			E = 0
		}
		local SPEED = 0
		local mouse = game.Players.LocalPlayer:GetMouse()
		local FLYING = false
		local function FLY()
			if game:GetService("Players").LocalPlayer and game:GetService("Players").LocalPlayer.Character and game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local BG = Instance.new('BodyGyro', game:GetService("Players").LocalPlayer.Character.HumanoidRootPart)
				local BV = Instance.new('BodyVelocity', game:GetService("Players").LocalPlayer.Character.HumanoidRootPart)
				BG.P = 9e4
				BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
				BG.cframe = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame
				BV.velocity = Vector3.new(0, 0, 0)
				BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
				spawn(function()
					repeat
						wait()
						game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').PlatformStand = true
						if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
							SPEED = 50
						elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
							SPEED = 0
						end
						if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
							BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
							lCONTROL = {
								F = CONTROL.F,
								B = CONTROL.B,
								L = CONTROL.L,
								R = CONTROL.R
							}
						elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
							BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
						else
							BV.velocity = Vector3.new(0, 0, 0)
						end
						BG.cframe = workspace.CurrentCamera.CoordinateFrame
					until not FLYING
					CONTROL = {
						F = 0,
						B = 0,
						L = 0,
						R = 0,
						Q = 0,
						E = 0
					}
					lCONTROL = {
						F = 0,
						B = 0,
						L = 0,
						R = 0,
						Q = 0,
						E = 0
					}
					SPEED = 0
					BG:destroy()
					BV:destroy()
					game:GetService("Players").LocalPlayer.Character:FindFirstChildWhichIsA('Humanoid').PlatformStand = false
				end)
			end
		end
		mouse.KeyDown:connect(function(KEY)
			if KEY:lower() == flyKeybind then
				if FLYING then
					FLYING = false
				else
					FLYING = true
					FLY()
				end
			elseif KEY:lower() == 'w' then
				CONTROL.F = flySpeed
			elseif KEY:lower() == 's' then
				CONTROL.B = - flySpeed
			elseif KEY:lower() == 'a' then
				CONTROL.L = - flySpeed
			elseif KEY:lower() == 'd' then
				CONTROL.R = flySpeed
			elseif KEY:lower() == 'e' then
				CONTROL.Q = flySpeed * 2
			elseif KEY:lower() == 'q' then
				CONTROL.E = -flySpeed * 2
			end
		end)
		mouse.KeyUp:connect(function(KEY)
			if KEY:lower() == 'w' then
				CONTROL.F = 0
			elseif KEY:lower() == 's' then
				CONTROL.B = 0
			elseif KEY:lower() == 'a' then
				CONTROL.L = 0
			elseif KEY:lower() == 'd' then
				CONTROL.R = 0
			elseif KEY:lower() == 'e' then
				CONTROL.Q = 0
			elseif KEY:lower() == 'q' then
				CONTROL.E = 0
			end
		end)
		FLY()
	end)
	function sendChatMessage(message, color)
		game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
			Text = message,
			Color = color,
			Font = Enum.Font.SourceSansBold,
			TextSize = 20
		})
	end
	do
		local printer = misc.Section("Printer")
		local gameBlocks = {}
		for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
			if v:FindFirstChild("DisplayName") and (v:FindFirstChild("block-place") or v:FindFirstChild("seeds")) then
				table.insert(gameBlocks, v.DisplayName.Value)
			end
		end
		local firstPos, secondPos = nil, nil
		local editFirst, editSecond = false, false
		local blockType = ""
		local fastMode = false
		local firstPosPart, secondPosPart = nil, nil
		local mt = getrawmetatable(game)
		local namecall = mt.__namecall
		setreadonly(mt, false)
		mt.__namecall = newcclosure(function(self, ...)
			if editFirst or editSecond then
				local method = getnamecallmethod()
				local args = {
					...
				}
				if tostring(self) == "CLIENT_BLOCK_PLACE_REQUEST" and tostring(method) == "InvokeServer" then
					if editFirst then
						firstPos = args[1]["cframe"].p
						if firstPosPart and firstPosPart.Parent == workspace then
							firstPosPart:Destroy()
						end
						firstPosPart = Instance.new("Part", workspace)
						firstPosPart.Name = game:GetService("HttpService"):GenerateGUID(false)
						firstPosPart.Anchored = true
						firstPosPart.CanCollide = false
						firstPosPart.Transparency = 0.8
						firstPosPart.Color = Color3.fromRGB(50, 205, 50)
						firstPosPart.Size = Vector3.new(3, 3, 3)
						firstPosPart.Position = firstPos
						editFirst = false
						editSecond = false
						sendChatMessage("First position set to (" .. tostring(firstPos) .. ")", Color3.fromRGB(255, 0, 255))
						return {
							["success"] = false
						}
					elseif editSecond then
						secondPos = args[1]["cframe"].p
						if secondPosPart and secondPosPart.Parent == workspace then
							secondPosPart:Destroy()
						end
						secondPosPart = Instance.new("Part", workspace)
						secondPosPart.Name = game:GetService("HttpService"):GenerateGUID(false)
						secondPosPart.Anchored = true
						secondPosPart.CanCollide = false
						secondPosPart.Transparency = 0.8
						secondPosPart.Color = Color3.fromRGB(173, 216, 230)
						secondPosPart.Size = Vector3.new(3, 3, 3)
						secondPosPart.Position = secondPos
						editFirst = false
						editSecond = false
						sendChatMessage("Second position set to (" .. tostring(secondPos) .. ")", Color3.fromRGB(255, 0, 255))
						return {
							success = false
						}
					end
				end
			end
			return namecall(self, ...)
		end)
		printer.Button("Set First Point", function()
			editFirst = true
			editSecond = false
		end)
		printer.Button("Set Second Point", function()
			editFirst = false
			editSecond = true
		end)
		printer.Toggle("Fast Mode (Might Crash)", function(a)
			fastMode = a
		end)
		local showGhostParts = false
		local aborting = false
		bps = 100
		printer.Toggle("Show Ghost Parts", function(a)
			showGhostParts = a
		end)
		printer.Box("Blocks per second ", function(a)
			bps = tonumber(a)
		end)
		printer.Button("Start Printing", function()
			local player = game.Players.LocalPlayer
			local blockType = player.Character:FindFirstChildWhichIsA("Tool").Name
			local guid = game:GetService("HttpService"):GenerateGUID(false)
			local firstX, firstY, firstZ = firstPos.X, firstPos.Y, firstPos.Z
			local secondX, secondY, secondZ = secondPos.X, secondPos.Y, secondPos.Z
			local deltaX, deltaY, deltaZ = secondX - firstX, secondY - firstY, secondZ - firstZ
			local secondDeltaX, secondDeltaY, secondDeltaZ = firstX + deltaX, firstY + deltaY, firstZ + deltaZ
			local firstXCom, secondXCom, firstYCom, secondYCom, firstZCom, secondZCom
			if firstX > secondDeltaX then
				firstXCom = secondDeltaX
				secondXCom = firstX
			else
				firstXCom = firstX
				secondXCom = secondDeltaX
			end
			if firstY > secondDeltaY then
				firstYCom = secondDeltaY
				secondYCom = firstY
			else
				firstYCom = firstY
				secondYCom = secondDeltaY
			end
			if firstZ > secondDeltaZ then
				firstZCom = secondDeltaZ
				secondZCom = firstZ
			else
				firstZCom = firstZ
				secondZCom = secondDeltaZ
			end
			function grabPossibleSpots()
				local possibles = {}
				for i3 = firstZCom, secondZCom, 3 do
					for i2 = firstYCom, secondYCom, 3 do
						for i = firstXCom, secondXCom, 3 do
							local newPossible = Vector3.new(i, i2, i3)
							if table.find(possibles, newPossible) == nil then
								table.insert(possibles, newPossible)
							end
						end
					end
				end
				return possibles
			end
			local possibleSpots = grabPossibleSpots()
			if showGhostParts then
				for i, v in pairs(possibleSpots) do
					local part = Instance.new("Part", workspace)
					part.Name = guid
					part.Anchored = true
					part.CanCollide = false
					part.Transparency = 0.8
					part.Size = Vector3.new(3, 3, 3)
					part.Position = v
				end
			end
			local bv = Instance.new("BodyVelocity", player.character)
			bv.Velocity = Vector3.new(0, 0, 0)
			for i2, v2 in pairs(getClosestIsland().Blocks:GetChildren()) do
				local pos = table.find(possibleSpots, v2.Position)
				if pos then
					table.remove(possibleSpots, pos)
				end
			end

			for i, v in pairs(possibleSpots) do
				if aborting == false then
					player.Character.Humanoid:ChangeState(11)
					player.Character:MoveTo(v + Vector3.new(0, 20, 0))
					if fastMode then
						spawn(function()
							local subbed = string.gsub(blockType, "Seeds", "")
							game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
								["blockType"] = subbed,
								["cframe"] = CFrame.new(v)
							})
							game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
								["blockType"] = subbed,
								["cframe"] = CFrame.new(v)
							})
						end)
						if bps > 999 then
							game:GetService("RunService").RenderStepped:wait()
						else
							wait(1 / bps)
						end
					elseif fastMode == false then
						local subbed = string.gsub(blockType, "Seeds", "")
						game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
							["blockType"] = subbed,
							["cframe"] = CFrame.new(v)
						})
						game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
							["blockType"] = subbed,
							["cframe"] = CFrame.new(v)
						})
						if bps > 999 then
							game:GetService("RunService").RenderStepped:wait()
						else
							wait(1 / bps)
						end
					end
				elseif aborting == true then
					aborting = false
					return
				end
			end

			for i, v in pairs(workspace:GetChildren()) do
				if v.Name == guid then
					v:Destroy()
				end
			end
			if firstPosPart and firstPosPart.Parent == workspace then
				firstPosPart:Destroy()
			end
			if secondPosPart and secondPosPart.Parent == workspace then
				secondPosPart:Destroy()
			end
			sendChatMessage("Operation Completed (~" .. tostring(#possibleSpots) .. " blocks affected)")
		end)

		local gameBlocks = {}
		for i, v in pairs(game:GetService("ReplicatedStorage").Blocks:GetChildren()) do
			table.insert(gameBlocks, v.Name)
		end

		printer.Button("Destroy island", function()
			for i, v in next, getClosestIsland().Blocks do

			end
		end)

		printer.Button("Start Destroying", function()
			local destroyingBlocks = true
			local player = game.Players.LocalPlayer
			local guid = game:GetService("HttpService"):GenerateGUID(false)
			local firstX, firstY, firstZ = firstPos.X, firstPos.Y, firstPos.Z
			local secondX, secondY, secondZ = secondPos.X, secondPos.Y, secondPos.Z
			local deltaX, deltaY, deltaZ = secondX - firstX, secondY - firstY, secondZ - firstZ
			local secondDeltaX, secondDeltaY, secondDeltaZ = firstX + deltaX, firstY + deltaY, firstZ + deltaZ
			local firstXCom, secondXCom, firstYCom, secondYCom, firstZCom, secondZCom
			if firstX > secondDeltaX then
				firstXCom = secondDeltaX
				secondXCom = firstX
			else
				firstXCom = firstX
				secondXCom = secondDeltaX
			end
			if firstY > secondDeltaY then
				firstYCom = secondDeltaY
				secondYCom = firstY
			else
				firstYCom = firstY
				secondYCom = secondDeltaY
			end
			if firstZ > secondDeltaZ then
				firstZCom = secondDeltaZ
				secondZCom = firstZ
			else
				firstZCom = firstZ
				secondZCom = secondDeltaZ
			end
			function grabPossibleSpots()
				local possibles = {}
				for i3 = firstZCom, secondZCom, 3 do
					for i2 = firstYCom, secondYCom, 3 do
						for i = firstXCom, secondXCom, 3 do
							local newPossible = Vector3.new(i, i2, i3)
							if table.find(possibles, newPossible) == nil then
								table.insert(possibles, newPossible)
							end
						end
					end
				end
				return possibles
			end
			function getBlocksToDestroy(spots)
				local blocks = {}
				for i, v in pairs(spots) do
					local region = Region3.new(v, v)
					for i2, v2 in pairs(workspace:FindPartsInRegion3(region, player.Character, math.huge)) do
						if table.find(gameBlocks, v2.Name) then
							if v2.Name ~= "bedrock" and string.sub(v2.Name, 0, 6) ~= "portal" then
								table.insert(blocks, v2)
							end
						end
					end
				end
				return blocks
			end
			local possibleSpots = grabPossibleSpots()
			local blocksToDestroy = getBlocksToDestroy(possibleSpots)
			if showGhostParts then
				for i, v in pairs(possibleSpots) do
					local part = Instance.new("Part", workspace)
					part.Name = guid
					part.Anchored = true
					part.CanCollide = false
					part.Transparency = 0.9
					part.Size = Vector3.new(3, 3, 3)
					part.Position = v
				end
			end
			local bv = Instance.new("BodyVelocity", player.character)
			bv.Velocity = Vector3.new(0, 0, 0)
			local currentBlock = nil
			for i = 1, #blocksToDestroy do
				if aborting == false then
					if currentBlock == nil then
						currentBlock = blocksToDestroy[i]
					end
					player.Character.Humanoid:ChangeState(11)
					if player:DistanceFromCharacter(currentBlock.Position) > 25 then
						local bv = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
						bv.Velocity = Vector3.new(0, 0, 0)
						player.Character.HumanoidRootPart.CFrame = CFrame.new(currentBlock.Position + Vector3.new(0, 5, 0))
					end
					repeat
						if fastMode then
							spawn(function()
								game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_HIT_REQUEST"]:InvokeServer({
									["block"] = currentBlock
								})
							end)
						elseif fastMode == false then
							game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_HIT_REQUEST"]:InvokeServer({
								["block"] = currentBlock
							})
						end
						game:GetService("RunService").RenderStepped:wait()
					until not currentBlock:IsDescendantOf(game.Workspace)
					currentBlock = blocksToDestroy[i + 1]
				elseif aborting == true then
					aborting = false
					break
				end
				game:GetService("RunService").RenderStepped:wait()
			end
			currentBlock = nil
			for i, v in pairs(workspace:GetChildren()) do
				if v.Name == guid then
					v:Destroy()
				end
			end
			sendChatMessage("Operation Completed (~" .. tostring(#blocksToDestroy) .. " blocks affected)")
			bv:Destroy()
			by:Destroy()
		end)
		printer.Button("Abort", function()
			aborting = true
		end)
	end
    local main2 = IslandsMain.WindowTab("Main Stuff 2")
    local schematica = IslandsMain.WindowTab("Schematica")
	local mainSideTab3 = main2.SideTab("Miscellaneous")
	local mainSideTab2 = main2.SideTab("Vending Stuff")
	local vendingSection = mainSideTab2.Section('')
	local miscelSection = mainSideTab3.Section('')
	local price3 = 1
	local autoRefill = false
	local vmRange = 15
	helIt = false
	miscelSection.Button('Drop Current Held Item', function()
		local A_1 =
        {
			["tool"] = game:service'Players'.LocalPlayer.Character:FindFirstChildOfClass("Tool"),
			["amount"] = price3
		}
		game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_DROP_TOOL_REQUEST"]:InvokeServer(A_1)

	end)
	miscelSection.Box("Amount", function(a)
		price3 = tonumber(a)
	end)
	vendingSection.Toggle("Auto refill vending aura", function(bool)
		autoRefill = bool
	end)
	vendingSection.Toggle("Use held item", function(bo)
		helIt = bo
	end)
	local island = workspace.Islands[game:service'Players'.LocalPlayer.UserId.. '-island']
	function getVendings()
		local vMachines = {}
		local tool
		local toolAmount
		local toolName
		for i, v in pairs(plrIsland.Blocks:GetChildren()) do
			if v.Name == "vendingMachine" and v:FindFirstChild("SellingContents") and #v.SellingContents:GetChildren() >= 1 then
				tool = v.SellingContents:FindFirstChildOfClass("Tool")
				toolAmount = tool:FindFirstChild("Amount")
				toolName = tool.Name
				if toolAmount.Value < 150 then
					vMachines[1] = {
						["Amount"] = toolAmount,
						["Machine"] = v,
						["Tool"] = tool
					}
				end
			end
		end
		return vMachines
	end
	local VENDING_MACHINE_EDIT_TRANSACTION = game:GetService("ReplicatedStorage").Remotes.Functions.CLIENT_VENDING_MACHINE_EDIT_TRANSACTION
	local tool
	local toolName
	local val
	spawn(function()
		while wait() do
			if autoRefill then
				pcall(function()
					local v = getVendings()[1]
					tool = v["Tool"]
					if tool then
						toolName = tool.Name
					end
					if v and game:GetService("Players").LocalPlayer:DistanceFromCharacter(v["Machine"].Position) < vmRange then
						if tool and v["Amount"].Value < 150 then
							repeat
								wait()
								if helIt == true then
									VENDING_MACHINE_EDIT_TRANSACTION:InvokeServer({
										["tool"] = game:service'Players'.LocalPlayer.Character:FindFirstChildOfClass("Tool"),
										["vendingMachine"] = v["Machine"],
										["action"] = "deposit",
										["amount"] = 75
									})
								else
									VENDING_MACHINE_EDIT_TRANSACTION:InvokeServer({
										["tool"] = game:service'Players'.LocalPlayer.Backpack[toolName],
										["vendingMachine"] = v["Machine"],
										["action"] = "deposit",
										["amount"] = 75
									})
								end
								wait(.5)
							until v["Amount"].Value >= 150 or not autoRefill
						end
					end
				end)
			end
		end
	end)
	vendingSection.Slider("Vending Machine Range", "0", "30", "15", function(a)
		vmRange = tonumber(a)
	end)
	local b6h = false
	local price = 0
	vendingSection.Toggle("Vending Price Changer", function(bool)
		b6h = bool
	end)
	vendingSection.Box("Price", function(a)
		price = tonumber(a)
	end)
    local autoWithdraw = false
    vendingSection.Toggle("Auto Withdraw Coins",function(bool)
        autoWithdraw = bool
	end)
	autoRefT = false
	vendingSection.Toggle("Refill Vending machines with equipped tool",function(bool)
		autoRefT = bool
    end)
    plrIsland = workspace.Islands[game:service'Players'.LocalPlayer.UserId.. '-island']
    spawn(function()
		while wait() do
			if autoRefT then
				for i,v in pairs(plrIsland.Blocks:GetChildren()) do
					if v.Name == "vendingMachine" and v:FindFirstChild("SellingContents") and #v.SellingContents:GetChildren() <= 0 and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
						VENDING_MACHINE_EDIT_TRANSACTION:InvokeServer({
							["tool"] = game:service'Players'.LocalPlayer.Character:FindFirstChildOfClass("Tool"),
							["vendingMachine"] = v,
							["action"] = "deposit",
							["amount"] = 1
						})
					end
				end
			end
		end
	end)
	function getVendings2()
		local vMachines = {}
		local tool
		local toolAmount
		local toolName
		for i, v in pairs(plrIsland.Blocks:GetChildren()) do
			if v.Name == "vendingMachine" then
                transactionPrice = v:FindFirstChild("TransactionPrice")
                local CoinBalance = v:FindFirstChild("CoinBalance")
				if (b6h and tonumber(transactionPrice.Value) ~= tonumber(price)) or (autoDeposit and tonumber(CoinBalance.Value) < price4) or (autoWithdraw and CoinBalance.Value > 0) then
					vMachines[1] = {
						["Price"] = transactionPrice,
                        ["Machine"] = v,
                        ["Balance"] = CoinBalance
					}
				end
			end
		end
		return vMachines
    end
    spawn(function()
        while wait() do
            if autoWithdraw then
                pcall(function()
                    local v = getVendings2()[1]
                    if game:GetService("Players").LocalPlayer:DistanceFromCharacter(v["Machine"].Position) < 15 then
                        game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_VENDING_MACHINE_WITHDRAW_COINS"]:InvokeServer({
                            ["vendingMachine"] = v["Machine"]
                        })
                    end
                end)
            end
        end
    end)
	spawn(function()
		while wait() do
			if b6h then
				pcall(function()
					local v = getVendings2()[1]
					spawn(function()
						if game:service'Players'.LocalPlayer:DistanceFromCharacter(v["Machine"].Position) < 15 then
							game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_EDIT_VENDING_MACHINE"]:InvokeServer({
								["vendingMachine"] = v["Machine"],
								["transactionPrice"] = price,
								["mode"] = 0
							})
						end
					end)
				end)
			end
		end
	end)
		vendingSection.Toggle("Auto deposit money", function(bool)
		autoDeposit = bool
		end)
	vendingSection.Box("Price", function(a)
		price4 = tonumber(a)
	end)
	spawn(function()
		while wait() do
			if autoDeposit then
				pcall(function()
					local v = getVendings2()[1]
					spawn(function()
						if game:service'Players'.LocalPlayer:DistanceFromCharacter(v["Machine"].Position) < 15 then
							game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_VENDING_MACHINE_DEPOSIT_COINS"]:InvokeServer({
								["amount"] = price4,
								["vendingMachine"] = v["Machine"],
							})
						end
					end)
				end)
			end
		end
	end)
	local player = game:GetService("Players").LocalPlayer
	local defaultSchematics = {
		["Synapse X Dark"] = "https://pastebin.com/raw/gHMs5w3n";
		["Synapse X White"] = "https://pastebin.com/raw/theCe337";
		["Pringles Man"] = "https://pastebin.com/raw/fbdWd7sz";
		["MC Water Bucket"] = "https://pastebin.com/raw/JqT4XcRA";
		["MC Lava Bucket"] = "https://pastebin.com/raw/UHbfc0dn";
		["Sans"] = "https://pastebin.com/raw/NADtkj15";
		["Mario"] = "https://pastebin.com/raw/SnNmXm7c";
		["Medieval House"] = "https://pastebin.com/raw/PnJaRDUi";
	}
	if not isfolder("skyblock-schematics") then
		makefolder("skyblock-schematics")
		for i, v in pairs(defaultSchematics) do
			writefile("skyblock-schematics/" .. i .. ".schemi", game:HttpGet(v))
			print("loading " .. i)
			wait(0.5)
		end
	end
	local schematics = {}
	local blockNameList = {}
	local blocksList = {}
	for i, v in pairs(game:GetService("ReplicatedStorage").Blocks:GetChildren()) do
		table.insert(blockNameList, v.Name)
	end
	for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
		if v:FindFirstChild("DisplayName") and (v:FindFirstChild("block-place") or v:FindFirstChild("seeds")) then
			table.insert(blocksList, v.DisplayName.Value)
		end
	end
	function updateSchematicsList()
		for i, v in pairs(schematics) do
			schematics[i] = nil
		end
		for i, v in pairs(listfiles("skyblock-schematics")) do
			local replaced = string.gsub(v, "skyblock%pschematics%p", "")
			local replaced2 = string.sub(replaced, 0, -8)
			table.insert(schematics, replaced2)
		end
	end
	updateSchematicsList()
	local function getLowestValue(first, second)
		if first < second then
			return first
		else
			return second
		end
	end
	local function getHighestValue(first, second)
		if first > second then
			return first
		else
			return second
		end
	end
	function stringToCFrame(text)
		return (CFrame.new(text:match("(.+),(.+),(.+),(.+),(.+),(.+),(.+),(.+),(.+),(.+),(.+),(.+)")))
	end
	buildInfoTab = nil
	buildLabels = {}
	function weirdFormatStringLol(s)
		local s = s:gsub('(%S)(%u)', '%1 %2'):gsub("^%l", string.upper)
		return s
	end
	function getDisplayNameByName(name)
		for i, v in pairs(game:GetService("ReplicatedStorage").Tools:GetChildren()) do
			if v.Name == name and v:FindFirstChild("DisplayName") then
				return v:FindFirstChild("DisplayName").Value
			end
		end
	end
	local itemsToBuy = {}
	function loadBuildInformation(stuff)
		if buildInfoTab ~= nil then
			for i, v in pairs(itemsToBuy) do
				itemsToBuy[i] = nil
			end
			for i, v in pairs(stuff) do
				itemsToBuy[i] = #stuff[i]
			end
			for i, v in pairs(buildLabels) do
				v:Delete()
				buildLabels[i] = nil
			end
			for i, v in pairs(stuff) do
				local appearingName = getDisplayNameByName(i) or weirdFormatStringLol(i)
				local la = buildInfoTab.Label(appearingName .. " : " .. tostring(#stuff[i]))
				table.insert(buildLabels, la)
			end
		end
	end
	function generateModel(stuff, startPosition)
		local model = Instance.new("Model")
		for i, v in pairs(stuff) do
			for i2, v2 in pairs(v) do
				local truePos = stringToCFrame(v2)
				if i == "air" then
					local copy = Instance.new("Part")
					copy.Parent = model
					copy.Name = i
					copy.Size = Vector3.new(3, 3, 3)
					copy.CanCollide = false
					copy.Transparency = 1
					copy.Anchored = true
					copy.CFrame = truePos + startPosition
					if copy.CFrame.p == startPosition then
						model.PrimaryPart = copy
					end
				else
					local copy = game:GetService("ReplicatedStorage").Blocks[i].Root:Clone()
					copy.Parent = model
					copy.Name = i
					copy.CanCollide = false
					copy.Transparency = 0.5
					copy.CFrame = truePos + startPosition
					if copy.CFrame.p == startPosition then
						model.PrimaryPart = copy
					end
				end
			end
		end
		return model
	end
	local xoffset, yoffset, zoffset = 0, 0, 0
	function updateModel(model, method, value, startPosition)
		if method == "visible" then
			for i, v in pairs(model:GetChildren()) do
				v.Transparency = value
			end
		elseif method == "rotateX" then
			model:SetPrimaryPartCFrame(model.PrimaryPart.CFrame * CFrame.Angles(math.rad(90), 0, 0))
		elseif method == "rotateY" then
			model:SetPrimaryPartCFrame(model.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(90), 0))
		elseif method == "rotateZ" then
			model:SetPrimaryPartCFrame(model.PrimaryPart.CFrame * CFrame.Angles(0, 0, math.rad(90)))
		elseif method == "move" then
			model:SetPrimaryPartCFrame(CFrame.new(Vector3.new(xoffset * 3, yoffset * 3, zoffset * 3) + startPosition))
		end
	end
	setPosition = false
	schematicCFrame = nil
	schematic = nil
	loadSch = schematica.SideTab("Schematic Settings")
	loadSchematic = loadSch.Section("Schematic Settings")
	loadSchematic.Dropdown("Schematic", schematics, function(a)
		loadBuildInformation(game:GetService("HttpService"):JSONDecode(readfile("skyblock-schematics/" .. a .. ".schemi")))
		schematic = a
	end)
	local schematicModel = nil
	local offsetButtons = {}
	local mt = getrawmetatable(game)
	local namecall = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		local args = {
			...
		}
		if method == "InvokeServer" and tostring(self) == "CLIENT_BLOCK_PLACE_REQUEST" then
			if setPosition then
				schematicCFrame = args[1]["cframe"]
				setPosition = false
				if schematicModel ~= nil then
					for i, v in pairs(schematicModel:GetChildren()) do
						v:Destroy()
					end
				end
				if schematic ~= nil then
					local buildInfo = game:GetService("HttpService"):JSONDecode(readfile("skyblock-schematics/" .. schematic .. ".schemi"))
					schematicModel = generateModel(buildInfo, schematicCFrame.p)
					schematicModel.Parent = workspace
				end
				return {
					["success"] = false
				}
			end
		end
		return namecall(self, ...)
	end)
	setreadonly(mt, true)
	loadSchematic.Button("Reload Schematics", function()
		updateSchematicsList()
	end)
	loadSchematic.Button("Set Position", function()
		setPosition = true
	end)
	local positionSettings = loadSch.Section("Position Settings")
	local xOffset = positionSettings.Box("X-Offset", function(a)
		xoffset = tonumber(a)
		updateModel(schematicModel, "move", 0, schematicCFrame.p)
	end)
	local yOffset = positionSettings.Box("Y-Offset", function(a)
		yoffset = tonumber(a)
		updateModel(schematicModel, "move", 0, schematicCFrame.p)
	end)
	local zOffset = positionSettings.Box("Z-Offset", function(a)
		zoffset = tonumber(a)
		updateModel(schematicModel, "move", 0, schematicCFrame.p)
	end)
	positionSettings.Button("Rotate X Axis", function()
		updateModel(schematicModel, "rotateX")
	end)
	positionSettings.Button("Rotate Y Axis", function()
		updateModel(schematicModel, "rotateY")
	end)
	positionSettings.Button("Rotate Z Axis", function()
		updateModel(schematicModel, "rotateZ")
	end)
	local renderSettings = loadSch.Section("Render Settings", true)
	renderSettings.Toggle("Show preview", function(a)
		if a == true then
			updateModel(schematicModel, "visible", 0.5)
		elseif a == false then
			updateModel(schematicModel, "visible", 1)
		end
	end, true)
	local fastmode = false
	scBPS = 100
	renderSettings.Toggle("Fast Mode", function(a)
		fastmode = a
	end)
	renderSettings.Box("Blocks per second", function(a)
		scBPS = tonumber(a)
	end)
	local blockAlias = {
		dirt = "grass",
		soil = "grass"
	}
	renderSettings.Button("Buy materials", function()
		local itemInBuyTable = {}
		for i, v in pairs(itemsToBuy) do
			local amountToBuy = v
			if game.Players.LocalPlayer.Backpack:FindFirstChild(i) or game.Players.LocalPlayer.Character:FindFirstChild(i) then
				local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(i) or game.Players.LocalPlayer.Character:FindFirstChild(i)
				local toolCount = tool.Amount.Value
				amountToBuy = amountToBuy - toolCount
			end
			itemInBuyTable[i] = amountToBuy
		end
		buyItem(itemInBuyTable)
	end)
	renderSettings.Button("Craft materials", function()
		local itemInBuyTable = {}
		for i, v in pairs(itemsToBuy) do
			local amountToBuy = v
			if game.Players.LocalPlayer.Backpack:FindFirstChild(i) or game.Players.LocalPlayer.Character:FindFirstChild(i) then
				local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(i) or game.Players.LocalPlayer.Character:FindFirstChild(i)
				local toolCount = tool.Amount.Value
				amountToBuy = amountToBuy - toolCount
			end
			itemInBuyTable[i] = amountToBuy
		end
		craftItem(itemInBuyTable)
	end)
	renderSettings.Button("Load Build", function()
		local bv = Instance.new("BodyVelocity", player.Character.HumanoidRootPart)
		bv.Velocity = Vector3.new(0, 0, 0)
		if schematicModel ~= nil then
			local totalCount = schematicModel:GetChildren()
			for i, v in pairs(schematicModel:GetChildren()) do
				local blockName = v.Name
				for _ in pairs(blockAlias) do
					if _ == blockName then
						blockName = blockAlias[_]
					end
				end
				if blockName ~= "air" then
					if player:DistanceFromCharacter(v.Position) > 50 or player:DistanceFromCharacter(v.Position) < 5 then
						player.Character.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(15, 15, 15)
					end
					if fastmode == true then
						spawn(function()
							game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
								["blockType"] = blockName,
								["cframe"] = v.CFrame
							})
						end)
						if scBPS > 999 then
							game:GetService("RunService").RenderStepped:wait()
						else
							wait(1 / scBPS)
						end
					else
						game:GetService("ReplicatedStorage").Remotes.Functions["CLIENT_BLOCK_PLACE_REQUEST"]:InvokeServer({
							["blockType"] = blockName,
							["cframe"] = v.CFrame
						})
						if scBPS > 999 then
							game:GetService("RunService").RenderStepped:wait()
						else
							wait(1 / scBPS)
						end
					end
				end
				game:GetService("RunService").RenderStepped:wait()
			end
		end
		sendChatMessage("Operation Completed (~" .. tostring(#schematicModel:GetChildren()) .. " blocks affected)")
		bv:Destroy()
	end)
	buildInfoTab = loadSch.Section("Build Information")
	local buildCopying = schematica.SideTab("Copy Builds")
	local copyPoints = buildCopying.Section("Point Settings")
	local setFirstPoint = false
	local setSecondPoint = false
	local originalFirstPointPosition = nil
	local originalSecondPointPosition = nil
	local firstPointPosition = nil
	local secondPointPosition = nil
	copyPoints.Button("First Point", function()
		setFirstPoint = true
		setSecondPoint = false
	end)
	copyPoints.Button("Second Point", function()
		setFirstPoint = false
		setSecondPoint = true
	end)
	local exporterModel = nil
	local redPoint = nil
	local bluePoint = nil
	local visibleLines = true
	local function drawLine(firstPosition, secondPosition, parent)
		local ray = Ray.new(firstPosition, (secondPosition - firstPosition).unit * 300)
		local beam = Instance.new("Part", parent)
		beam.Transparency = 1
		beam.Anchored = true
		beam.CanCollide = false
		local distance = (firstPosition - secondPosition).magnitude
		beam.Size = Vector3.new(0.001, 0.001, distance)
		beam.CFrame = CFrame.new(firstPosition, secondPosition) * CFrame.new(0, 0, -distance / 2)
		local selectionbox = Instance.new("SelectionBox", beam)
		selectionbox.LineThickness = 0.1
		selectionbox.Adornee = beam
		if visibleLines then
			selectionbox.Visible = true
		else
			selectionbox.Visible = false
		end
		selectionbox.Color = BrickColor.new("White")
		return beam
	end
	local firstXSize, secondXSize, firstYSize, secondYSize, firstZSize, secondZSize = 0, 0, 0, 0, 0, 0
	local function generateExportingModel()
		if exporterModel ~= nil then
			for i, v in pairs(exporterModel:GetChildren()) do
				v:Destroy()
			end
		end
		if firstPointPosition ~= nil and secondPointPosition ~= nil then
			local model = Instance.new("Model")
			local part1 = Instance.new("Part", model)
			part1.Name = "redPoint"
			part1.Position = Vector3.new(getLowestValue(firstPointPosition.X, secondPointPosition.X), getLowestValue(firstPointPosition.Y, secondPointPosition.Y), getLowestValue(firstPointPosition.Z, secondPointPosition.Z)) + Vector3.new(firstXSize, firstYSize, firstZSize)
			part1.Size = Vector3.new(3, 3, 3)
			part1.Transparency = 1
			part1.Anchored = true
			part1.CanCollide = false
			redPoint = part1
			local part2 = Instance.new("Part", model)
			part1.Name = "bluePoint"
			part2.Position = Vector3.new(getHighestValue(firstPointPosition.X, secondPointPosition.X), getHighestValue(firstPointPosition.Y, secondPointPosition.Y), getHighestValue(firstPointPosition.Z, secondPointPosition.Z)) + Vector3.new(secondXSize, secondYSize, secondZSize)
			part2.Size = Vector3.new(3, 3, 3)
			part2.Transparency = 1
			part2.Anchored = true
			part2.CanCollide = false
			bluePoint = part2
			local lines1 = Instance.new("SelectionBox", part1)
			lines1.LineThickness = 0.1
			lines1.Adornee = part1
			if visibleLines then
				lines1.Visible = true
			else
				lines1.Visible = false
			end
			lines1.Color = BrickColor.new("Dark red")
			local lines2 = Instance.new("SelectionBox", part2)
			lines2.LineThickness = 0.1
			lines2.Adornee = part2
			if visibleLines then
				lines2.Visible = true
			else
				lines2.Visible = false
			end
			lines2.Color = BrickColor.new("Dark blue")
			local position1 = part1.Position
			local position2 = part2.Position
			local boxCornerPoint1 = Vector3.new(position1.X, position1.Y, position1.Z) + Vector3.new(-1.5, -1.5, -1.5)
			local boxCornerPoint2 = Vector3.new(position1.X, position1.Y, position2.Z) + Vector3.new(-1.5, -1.5, 1.5)
			local boxCornerPoint3 = Vector3.new(position1.X, position2.Y, position1.Z) + Vector3.new(-1.5, 1.5, -1.5)
			local boxCornerPoint4 = Vector3.new(position1.X, position2.Y, position2.Z) + Vector3.new(-1.5, 1.5, 1.5)
			local boxCornerPoint5 = Vector3.new(position2.X, position2.Y, position2.Z) + Vector3.new(1.5, 1.5, 1.5)
			local boxCornerPoint6 = Vector3.new(position2.X, position2.Y, position1.Z) + Vector3.new(1.5, 1.5, -1.5)
			local boxCornerPoint7 = Vector3.new(position2.X, position1.Y, position2.Z) + Vector3.new(1.5, -1.5, 1.5)
			local boxCornerPoint8 = Vector3.new(position2.X, position1.Y, position1.Z) + Vector3.new(1.5, -1.5, -1.5)
			drawLine(boxCornerPoint1, boxCornerPoint2, model)
			drawLine(boxCornerPoint1, boxCornerPoint3, model)
			drawLine(boxCornerPoint1, boxCornerPoint8, model)
			drawLine(boxCornerPoint2, boxCornerPoint4, model)
			drawLine(boxCornerPoint2, boxCornerPoint7, model)
			drawLine(boxCornerPoint3, boxCornerPoint4, model)
			drawLine(boxCornerPoint3, boxCornerPoint6, model)
			drawLine(boxCornerPoint4, boxCornerPoint5, model)
			drawLine(boxCornerPoint5, boxCornerPoint6, model)
			drawLine(boxCornerPoint5, boxCornerPoint7, model)
			drawLine(boxCornerPoint6, boxCornerPoint8, model)
			drawLine(boxCornerPoint7, boxCornerPoint8, model)
			return model
		end
	end
	local mt = getrawmetatable(game)
	local namecall = mt.__namecall
	setreadonly(mt, false)
	mt.__namecall = newcclosure(function(self, ...)
		local method = getnamecallmethod()
		local args = {
			...
		}
		if method == "InvokeServer" and tostring(self) == "CLIENT_BLOCK_PLACE_REQUEST" then
			if setFirstPoint then
				originalFirstPointPosition = args[1]["cframe"].p
				firstPointPosition = args[1]["cframe"].p
				setFirstPoint = false
				exporterModel = generateExportingModel()
				exporterModel.Parent = workspace
				return {
					["success"] = false
				}
			elseif setSecondPoint then
				originalSecondPointPosition = args[1]["cframe"].p
				secondPointPosition = args[1]["cframe"].p
				setSecondPoint = false
				exporterModel = generateExportingModel()
				exporterModel.Parent = workspace
				return {
					["success"] = false
				}
			end
		end
		return namecall(self, ...)
	end)
	setreadonly(mt, true)
	local exportSizeSettings = buildCopying.Section("Size Settings")
	exportSizeSettings.Label("Red Point")
	exportSizeSettings.Box("X-Size", function(a)
		firstXSize = a * 3
		exporterModel = generateExportingModel()
		exporterModel.Parent = workspace
	end)
	exportSizeSettings.Box("Y-Size", function(a)
		firstYSize = a * 3
		exporterModel = generateExportingModel()
		exporterModel.Parent = workspace
	end)
	exportSizeSettings.Box("Z-Size", function(a)
		firstZSize = a * 3
		exporterModel = generateExportingModel()
		exporterModel.Parent = workspace
	end)
	exportSizeSettings.Label("Blue Point")
	exportSizeSettings.Box("X-Size", function(a)
		secondXSize = a * 3
		exporterModel = generateExportingModel()
		exporterModel.Parent = workspace
	end)
	exportSizeSettings.Box("Y-Size", function(a)
		secondYSize = a * 3
		exporterModel = generateExportingModel()
		exporterModel.Parent = workspace
	end)
	exportSizeSettings.Box("Z-Size", function(a)
		secondZSize = a * 3
		exporterModel = generateExportingModel()
		exporterModel.Parent = workspace
	end)
	local textExporting = buildCopying.Section("Rendering", true)
	textExporting.Toggle("Show Lines", function(a)
		visibleLines = a
		exporterModel = generateExportingModel()
		exporterModel.Parent = workspace
	end, true)
	local function parseBlocksToSave()
		local foundBlocks = {}
		local region = Region3.new(redPoint.Position - Vector3.new(1.5, 1.5, 1.5), bluePoint.Position + Vector3.new(1.5, 1.5, 1.5))
		for i, v in pairs(workspace:FindPartsInRegion3(region, player.Character, math.huge)) do
			if table.find(blockNameList, v.Name) then
				table.insert(foundBlocks, v)
			end
		end
		return foundBlocks
	end
	textExporting.Button("Copy Data", function()
		local start_time = tick()
		local function roundClosest3(number)
			return math.floor(number / 3 + 0.5) * 3
		end
		local function formatCFrame(cframe)
			local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cframe:components()
			return CFrame.new(roundClosest3(x), roundClosest3(y), roundClosest3(z), r00, r01, r02, r10, r11, r12, r20, r21, r22)
		end
		local function getBlockList(list)
			local blocks = {}
			for i, v in pairs(list) do
				if table.find(blocks, v.Name) == nil then
					table.insert(blocks, v.Name)
				end
			end
			return blocks
		end
		function getPrimaryPart(list)
			return list[1]
		end
		local blocksToExport = parseBlocksToSave()
		local output = {}
		for i, v in pairs(getBlockList(blocksToExport)) do
			output[v] = {}
			for i2, v2 in pairs(blocksToExport) do
				if v2.Name == v then
					table.insert(output[v], tostring(formatCFrame(v2.CFrame - getPrimaryPart(blocksToExport).Position)))
				end
			end
		end
		local realOutput = string.gsub(game:GetService("HttpService"):JSONEncode(output), "%s", "")
		setclipboard(realOutput)
	end)
	fileNameExport = "u didnt put a name u fucking gay"
	textExporting.Box("File Name (If save file)", function(a)
		fileNameExport = a
	end)
	textExporting.Button("Save Data", function()
		local start_time = tick()
		local function roundClosest3(number)
			return math.floor(number / 3 + 0.5) * 3
		end
		local function formatCFrame(cframe)
			local x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22 = cframe:components()
			return CFrame.new(roundClosest3(x), roundClosest3(y), roundClosest3(z), r00, r01, r02, r10, r11, r12, r20, r21, r22)
		end
		local function getBlockList(list)
			local blocks = {}
			for i, v in pairs(list) do
				if table.find(blocks, v.Name) == nil then
					table.insert(blocks, v.Name)
				end
			end
			return blocks
		end
		function getPrimaryPart(list)
			return list[1]
		end
		local blocksToExport = parseBlocksToSave()
		local output = {}
		for i, v in pairs(getBlockList(blocksToExport)) do
			output[v] = {}
			for i2, v2 in pairs(blocksToExport) do
				if v2.Name == v then
					table.insert(output[v], tostring(formatCFrame(v2.CFrame - getPrimaryPart(blocksToExport).Position)))
				end
			end
		end
		local realOutput = string.gsub(game:GetService("HttpService"):JSONEncode(output), "%s", "")
		updateSchematicsList()
		writefile("skyblock-schematics/" .. fileNameExport .. ".schemi", realOutput)
	end)
	local letters = {
    A = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    B = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    C = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    D = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    E = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    F = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    G = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    H = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    I = {
			Size = 1,
			BlockData = {
				blocks = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    J = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    K = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    L = {
			Size = 3,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    M = {
			Size = 7,
			BlockData = {
				blocks = {CFrame.new(0,9,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,15,1,0,0,0,1,0,0,0,1),CFrame.new(0,6,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,6,1,0,0,0,1,0,0,0,1),CFrame.new(0,9,18,1,0,0,0,1,0,0,0,1),CFrame.new(0,6,18,1,0,0,0,1,0,0,0,1),CFrame.new(0,3,18,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,18,1,0,0,0,1,0,0,0,1),CFrame.new(0,9,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,3,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,6,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,3,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,3,1,0,0,0,1,0,0,0,1)}
			}
		},
    N = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    O = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    P = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    Q = {
			Size = 5,
			BlockData = {
				blocks = {
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    R = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    S = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    T = {
			Size = 3,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    U = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    V = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    W = {
			Size = 5,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    X = {
			Size = 3,
			BlockData = {
				blocks = {
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    Y = {
			Size = 3,
			BlockData = {
				blocks = {
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},
    Z = {
			Size = 4,
			BlockData = {
				blocks = {
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},["."] = {
			Size = 1,
			BlockData = {
				blocks = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1)
				}
			}
		},["0"] = {
			Size = 5,
			BlockData = {
				blocks = {CFrame.new(0,18,3,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,6,1,0,0,0,1,0,0,0,1),CFrame.new(0,9,6,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,9,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,6,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,3,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,15,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,3,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,6,3,1,0,0,0,1,0,0,0,1),CFrame.new(0,9,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,15,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,6,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,3,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,6,1,0,0,0,1,0,0,0,1),},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},["1"] = {
			Size = 2,
			BlockData = {
				blocks = {
					CFrame.new(0, 3, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},["2"] = {
			Size = 5,
			BlockData = {
				blocks = {
					CFrame.new(0, 18, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},["3"] = {
			Size = 5,
			BlockData = {
				blocks = {
					CFrame.new(0, 12, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},["4"] = {
			Size = 5,
			BlockData = {
				blocks = {
					CFrame.new(0, 18, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},["5"] = {
			Size = 5,
			BlockData = {
				blocks = {CFrame.new(0,0,3,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,3,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,3,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,6,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,6,1,0,0,0,1,0,0,0,1),CFrame.new(0,6,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,3,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,6,1,0,0,0,1,0,0,0,1),CFrame.new(0,3,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,15,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,9,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,0,1,0,0,0,1,0,0,0,1),},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},["6"] = {
			Size = 5,
			BlockData = {
				blocks = {
					CFrame.new(0, 15, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},["7"] = {
			Size = 5,
			BlockData = {
				blocks = {
					CFrame.new(0, 18, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},["8"] = {
			Size = 5,
			BlockData = {
				blocks = {CFrame.new(0,0,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,3,1,0,0,0,1,0,0,0,1),CFrame.new(0,18,6,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,3,1,0,0,0,1,0,0,0,1),CFrame.new(0,6,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,3,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,9,9,1,0,0,0,1,0,0,0,1),CFrame.new(0,15,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,9,3,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,12,1,0,0,0,1,0,0,0,1),CFrame.new(0,9,6,1,0,0,0,1,0,0,0,1),CFrame.new(0,15,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,12,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,0,6,1,0,0,0,1,0,0,0,1),CFrame.new(0,6,0,1,0,0,0,1,0,0,0,1),CFrame.new(0,3,0,1,0,0,0,1,0,0,0,1),},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},["9"] = {
			Size = 5,
			BlockData = {
				blocks = {
					CFrame.new(0, 0, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 0, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 3, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 9, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 6, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 3, 9, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 18, 6, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 15, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
					CFrame.new(0, 12, 12, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				},
				air = {
					CFrame.new(0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1),
				}
			}
		},}
	textConverter = schematica.SideTab("Shape Generators")
	local txtConverter = textConverter.Section("Generator")
	local output = textConverter.Section("Output")
	function outputThing(text)
		spawn(function()
			local newLabel = output.Label(text)
			wait(5)
			newLabel:Delete()
		end)
	end
	local sett = {
		shape = "Text";
		val = "fuck you";
	}
	 blockName = "grass"
	txtConverter.Dropdown("Shape Type", {
		"Text",
		"Filled Circle",
		"Hollow Circle",
		"Sphere"
	}, function(a)
		sett.shape = a
	end)
	txtConverter.Box("Shape Data", function(a)
		sett.val = a
	end)
	txtConverter.Box("Block Display Name", function(a)
		blockName = getNameByDisplayName(a)
	end)
	txtConverter.Button("Convert", function()
		 convThing = {
			["Filled Circle"] = "https://sowd.cool/SkyblockApis/circle.php?mode=Filled&rad=";
			["Hollow Circle"] = "https://sowd.cool/SkyblockApis/circle.php?mode=Hollow&rad=";
			["Sphere"] = "https://sowd.cool/SkyblockApis/sphere.php?Content=";
			["Text"] = "https://sowd.cool/SkyblockApis/text.php?Content=";
		}
		 reqData = string.gsub(game:HttpGet(convThing[sett.shape] .. sett.val), "blocks", blockName)
		 sliFN = string.gsub(sett.shape, "%s", "")
		 fileName = "skyblock-schematics/" .. sliFN .. sett.val .. "_txt.schemi"
		writefile(fileName, reqData)
		outputThing("Saved file as [ " .. sliFN .. sett.val .. "_.schemi ]")
	end)


	local someInfo = {
		textUrl = nil,
		schematicName = nil,
		todelete = nil
	}


	fileSystem = schematica.SideTab("File System")
	saving = fileSystem.Section("Save Schematic")
	saving.Box("Raw Text Url", function(a)
		someInfo["textUrl"] = a
	end)
	saving.Box("Schematic Name", function(a)
		someInfo["schematicName"] = a
	end)
	saving.Button("Save Schematic", function()
		local rawPasted;
	     success = pcall(function()
			local urlData = game:HttpGet(someInfo["textUrl"])
			game:GetService("HttpService"):JSONDecode(urlData)
			rawPasted = urlData


		end)
		if success then
			writefile("skyblock-schematics/" .. someInfo["schematicName"] .. ".schemi", rawPasted)
			print("saved")
		else
			print("not valid")
		end
	end)

	 deleting = fileSystem.Section("Delete Schematic")
	deleting.Dropdown("Schematic To Delete", schematics, function(a)
		someInfo["todelete"] = a
	end)
	deleting.Button("Delete", function()
		delfile("skyblock-schematics/" .. someInfo["todelete"] .. ".schemi")
		updateSchematicsList()
    end)
else
    game:GetService("Players").LocalPlayer:Kick()
end
