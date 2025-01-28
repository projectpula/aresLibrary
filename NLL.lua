local par = game.CoreGui and game.CoreGui or game.Players.LocalPlayer.PlayerGui

local ProtectGui = protectgui or protect_gui or (syn and syn.protect_gui) or function() end
local NormalHub456 = Instance.new("ScreenGui")
NormalHub456.Parent = par
NormalHub456.Name = "Normal Hub"
NormalHub456.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ProtectGui(NormalHub456)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Mouse = game.Players.LocalPlayer:GetMouse()

local MainDirectory = "Ares UI"
local AssetsDirectory = "Ares UI\\Assets"
local function CheckDirectory()
	if getgenv then
		if not isfolder(MainDirectory) then
			makefolder(MainDirectory)
		end
		if not isfolder(AssetsDirectory) then
			makefolder(AssetsDirectory)
		end
	end
end
local function GetImage(name, url)
	if getgenv then
		CheckDirectory()

		local path = string.format("%s\\%s.png", AssetsDirectory, name)
		if not isfile(path) then
			local content = game:HttpGet(url)
			writefile(path, content)
		end

		return getcustomasset(path)
	end
end

--local IconGen = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/refs/heads/master/src/Icons.lua"))()['assets']

local liber = {
	GuiFunction = {
		movePos = function(Frame, object)
			local dragToggle = nil
			local dragSpeed = .25
			local dragInput = nil
			local dragStart = nil
			local dragPos = nil

			local function updateInput(input)
				local Delta = input.Position - dragStart
				local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
				TweenService:Create(
					object,
					TweenInfo.new(0,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
					{Position = Position}
				):Play()
			end

			Frame.InputBegan:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
					dragToggle = true
					dragStart = input.Position
					startPos = object.Position
					input.Changed:Connect(function()
						if (input.UserInputState == Enum.UserInputState.End) then
							dragToggle = false
						end
					end)
				end
			end)

			Frame.InputChanged:Connect(function(input)
				if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch)then
					dragInput = input
				end
			end)

			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if (input == dragInput and dragToggle) then
					updateInput(input)
				end
			end)
		end,
		setBlurText = function(s)
			local censoredText = string.gsub(s, "(%w)(%w*)(%w)", function(first, middle, last)
				return first .. string.rep("*", #middle) .. last
			end)
			return censoredText
		end,
	},
}

liber.addWindown = function(o)
	if type(o) ~= 'table' then
		assert(type(o) == 'table', "need Table")
	end

	local TextSize = o.UIColor and o.UIColor['TextSize'] or 12

	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	Main.Name = "Main"
	Main.Parent = NormalHub456
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.ClipsDescendants = true
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 600, 0, 350)

	UICorner.Parent = Main
	
	local OpenUI = true
	UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == (o.KeyCode or Enum.KeyCode.LeftControl)  then
			if OpenUI then
				OpenUI = false
				Main.Visible = false
			else
				OpenUI = true
				Main.Visible = true
			end
		end
	end)

	if par:FindFirstChild("CloseUI") then
		for i,v in pairs(par:GetChildren()) do
			if v.Name == "CloseUI" then
				v:Destroy()
			end
		end
	end
	if UserInputService.TouchEnabled then
		local CloseUI = Instance.new("ScreenGui")
		local CloseUIMain = Instance.new("Frame")
		local Logo = Instance.new("ImageLabel")
		local UICorner = Instance.new("UICorner")
		local Use = Instance.new("TextButton")

		CloseUI.Name = "CloseUI"
		CloseUI.Parent = par
		CloseUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

		CloseUIMain.Name = "CloseUIMain"
		CloseUIMain.Parent = CloseUI
		CloseUIMain.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
		CloseUIMain.BorderColor3 = Color3.new(0, 0, 0)
		CloseUIMain.BorderSizePixel = 0
		CloseUIMain.Position = UDim2.new(0.0319926888, 0, 0.129, 0)
		CloseUIMain.Size = UDim2.new(0, 75, 0, 0)

		CloseUIMain:TweenSize(UDim2.new(0, 75, 0, 51),"Out","Back",3.5,false)

		Logo.Name = "Logo"
		Logo.Parent = CloseUIMain
		Logo.BackgroundColor3 = Color3.new(1, 1, 1)

		Logo.BackgroundTransparency = 1
		Logo.BorderColor3 = Color3.new(0, 0, 0)
		Logo.BorderSizePixel = 0
		Logo.Position = UDim2.new(0.323333323, 0, 0.235294119, 0)
		Logo.Size = UDim2.new(0.349999994, 0, 0.5, 0)
		Logo.Image = "rbxassetid://".. 78590114316385


		UICorner.Parent = CloseUIMain
		UICorner.CornerRadius = UDim.new(0, 100)

		Use.Name = "Use"
		Use.Parent = CloseUIMain
		Use.BackgroundColor3 = Color3.new(1, 1, 1)
		Use.BackgroundTransparency = 1
		Use.BorderColor3 = Color3.new(0, 0, 0)
		Use.BorderSizePixel = 0
		Use.Size = UDim2.new(1, 0, 1, 0)
		Use.Font = Enum.Font.SourceSans
		Use.Text = ""
		Use.TextColor3 = Color3.new(0, 0, 0)
		Use.TextSize = 14

		Use.MouseButton1Click:Connect(function()
			if OpenUI then
				OpenUI = false
				Main.Visible = false
			else
				OpenUI = true
				Main.Visible = true
			end
		end)
	end

	local Top = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	Top.Name = "Top"
	Top.Parent = Main
	Top.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
	Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(1, 0, 0.0993710682, 0)
	UICorner_2.Parent = Top

	liber.GuiFunction.movePos(Top, Main)

	local Cut = Instance.new("Frame")
	local Logo = Instance.new("ImageLabel")
	local NameHub = Instance.new("TextLabel")
	local Tap = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	Cut.Name = "Cut"
	Cut.Parent = Top
	Cut.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
	Cut.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Cut.BorderSizePixel = 0
	Cut.Position = UDim2.new(-0.000791219063, 0, 0.978541195, 0)
	Cut.Size = UDim2.new(1.00000024, 0, 0.34902218, 0)

	Logo.Name = "Logo"
	Logo.Parent = Top
	Logo.AnchorPoint = Vector2.new(0.5, 0.5)
	Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Logo.BackgroundTransparency = 1.000
	Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Logo.BorderSizePixel = 0
	Logo.Position = UDim2.new(0.0529999994, 0, 0.699999988, 0)
	Logo.Size = UDim2.new(0, 20, 0, 20)
	Logo.ZIndex = 2
	Logo.Image = "rbxassetid://78590114316385"

	NameHub.Name = "NameHub"
	NameHub.Parent = Top
	NameHub.AnchorPoint = Vector2.new(0.5, 0.5)
	NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.BackgroundTransparency = 1.000
	NameHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NameHub.BorderSizePixel = 0
	NameHub.ClipsDescendants = true
	NameHub.Position = UDim2.new(0.185833335, 0, 0.700000167, 0)
	NameHub.Size = UDim2.new(0, 125, 0, 50)
	NameHub.ZIndex = 2
	NameHub.Font = Enum.Font.Nunito

	NameHub.Text = o.HubName or 'Normal Hub'
	NameHub.TextColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.TextSize = TextSize
	NameHub.TextXAlignment = Enum.TextXAlignment.Left

	Tap.Name = "Tap"
	Tap.Parent = Top
	Tap.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
	Tap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Tap.BorderSizePixel = 0
	Tap.Position = UDim2.new(0.300000012, 0, 0.316274881, 0)
	Tap.Size = UDim2.new(0, 413, 0, 26)
	Tap.ZIndex = 2

	print(NameHub.TextBounds.X)
	if NameHub.TextBounds.X > 100 then
		print('TT')
		local n = TextSize >= 14 and NameHub.TextBounds.X / 4 or NameHub.TextBounds.X / 12
		NameHub.Position = UDim2.new(0.185833335, n, 0.700000167, 0)
		NameHub.Size = UDim2.new(0, NameHub.TextBounds.X + 30, 0, 50)
		local nn = NameHub.TextBounds.X - 110
		Tap.Size = UDim2.new(0, 413 - nn, 0, 26)
		Tap.Position = UDim2.new(0.300000012, nn, 0.316274881, 0)
	end

	UICorner_3.Parent = Tap

	local ScrollingTap = Instance.new("ScrollingFrame")
	ScrollingTap.Name = "ScrollingTap"
	ScrollingTap.Parent = Tap
	ScrollingTap.Active = true
	ScrollingTap.AnchorPoint = Vector2.new(0.5, 0.5)
	ScrollingTap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingTap.BackgroundTransparency = 1.000
	ScrollingTap.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingTap.BorderSizePixel = 0
	ScrollingTap.Position = UDim2.new(0.502463102, 0, 0.500000119, 0)
	ScrollingTap.Size = UDim2.new(0.959113419, 0, 0.900000036, 0)
	ScrollingTap.CanvasSize = UDim2.new(2, 0, 0, 0)
	ScrollingTap.ScrollBarThickness = 0

	local Bottom = Instance.new("Frame")
	local Search = Instance.new("Frame")
	local UICorner_5 = Instance.new("UICorner")
	local Searchicon = Instance.new("ImageLabel")
	local TextBox = Instance.new("TextBox")

	Bottom.Name = "Bottom"
	Bottom.Parent = Main
	Bottom.AnchorPoint = Vector2.new(0.5, 0.5)
	Bottom.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Bottom.BackgroundTransparency = 1.000
	Bottom.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Bottom.BorderSizePixel = 0
	Bottom.Position = UDim2.new(0.5, 0, 0.570494235, 0)
	Bottom.Size = UDim2.new(1, 0, 0.85901165, 0)

	Search.Name = "Search"
	Search.Parent = Bottom
	Search.AnchorPoint = Vector2.new(0.5, 0.5)
	Search.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
	Search.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Search.BorderSizePixel = 0
	Search.ClipsDescendants = true
	Search.Position = UDim2.new(0.5, 0, 0.0633261278, 0)
	Search.Size = UDim2.new(0.951999903, 0, 0.0766331404, 0)

	UICorner_5.CornerRadius = UDim.new(0, 25)
	UICorner_5.Parent = Search

	Searchicon.Name = "Search icon"
	Searchicon.Parent = Search
	Searchicon.AnchorPoint = Vector2.new(0.5, 0.5)
	Searchicon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Searchicon.BackgroundTransparency = 1.000
	Searchicon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Searchicon.BorderSizePixel = 0
	Searchicon.Position = UDim2.new(0.0294139367, 0, 0.457665682, 0)
	Searchicon.Size = UDim2.new(0, 10, 0, 10)
	Searchicon.Image = "rbxassetid://82658488651944"

	TextBox.Parent = Search
	TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
	TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.BackgroundTransparency = 1.000
	TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextBox.BorderSizePixel = 0
	TextBox.Position = UDim2.new(0.516633153, 0, 0.499999434, 0)
	TextBox.Size = UDim2.new(0, 535, 0, 10)
	TextBox.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
	TextBox.PlaceholderColor3 = Color3.fromRGB(116, 116, 116)
	TextBox.PlaceholderText = "Search ..."
	TextBox.Text = ""
	TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextBox.TextScaled = true
	TextBox.TextSize = 14.000
	TextBox.TextWrapped = true
	TextBox.TextXAlignment = Enum.TextXAlignment.Left

	TextBox.Changed:Connect(function()
		print('Not Work Now ')
	end)

	liber.fun = {}
	liber.fun.Tap  = {
		Value = false
	}
	liber.fun.CreateTap = function( o : teble)
		if type(o) ~= 'table' then
			assert(type(o) == 'table', "need Table")
		end

		local Tap = Instance.new("TextButton")
		local UICorner_4 = Instance.new("UICorner")
		local UIGradient = Instance.new("UIGradient")
		local TextLabel = Instance.new("TextLabel") 

		Tap.Name = "Tap"
		Tap.Parent = ScrollingTap
		Tap.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tap.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tap.BorderSizePixel = 0
		Tap.Text = ""
		Tap.Position = UDim2.new(0, 0, -6.52084964e-07, 0)
		Tap.Size = UDim2.new(0, 70, 0, 21)
		Tap.BackgroundTransparency = 1

		UICorner_4.Parent = Tap
		UICorner_4.CornerRadius = UDim.new(0, 15)

		UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(213, 55, 102)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(235, 30, 157))}
		UIGradient.Parent = Tap

		TextLabel.Parent = Tap
		TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TextLabel.BackgroundTransparency = 1.000
		TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.BorderSizePixel = 0
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.Font = Enum.Font.Nunito
		TextLabel.Text = o.Title or 'None'
		TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
		TextLabel.TextSize = TextSize
		TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

		local a = tonumber(TextLabel.TextBounds.X) and TextLabel.TextBounds.X + 45 or 70
		Tap.Size = UDim2.new(0,  a , 0, 21)

		local PageMain = Instance.new("Frame")
		local Page = Instance.new("Frame")
		local RightMain = Instance.new("ScrollingFrame")
		local UIListLayout_2 = Instance.new("UIListLayout")
		local UIPadding_2 = Instance.new("UIPadding")

		PageMain.Name = "Page Main"
		PageMain.Parent = Bottom
		PageMain.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
		PageMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		PageMain.BorderSizePixel = 0
		PageMain.Position = UDim2.new(0.0233333334, 0, 0.119738936, 0)
		PageMain.Size = UDim2.new(0, 571, 0, 249)
		PageMain.Visible = false
		
		if liber.fun.Tap.Value == false then
			liber.fun.Tap.Value = true
			Tap.BackgroundTransparency = 0
			TextLabel.TextColor3 = Color3.fromRGB(0,0,0)
			PageMain.Visible = true
		end

		local UICorner = Instance.new("UICorner")
		UICorner.Parent = PageMain

		Page.Name = "Page"
		Page.Parent = PageMain
		Page.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Page.BackgroundTransparency = 1.000
		Page.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Page.BorderSizePixel = 0
		Page.Size = UDim2.new(1, 0, 1, 0)

		local LeftMain = Instance.new("ScrollingFrame")
		local UIListLayout_4 = Instance.new("UIListLayout")
		local UIPadding_4 = Instance.new("UIPadding")
		LeftMain.Name = "LeftMain"
		LeftMain.Parent = Page
		LeftMain.Active = true
		LeftMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		LeftMain.BackgroundTransparency = 1.000
		LeftMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		LeftMain.BorderSizePixel = 0
		LeftMain.Position = UDim2.new(0, 0, 0, 0)
		LeftMain.Size = UDim2.new(0.485216528, 0, 1, 0)
		LeftMain.ScrollBarThickness = 0

		UIListLayout_4.Parent = LeftMain
		UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder

		UIPadding_4.Parent = LeftMain

		RightMain.Name = "RightMain"
		RightMain.Parent = Page
		RightMain.Active = true
		RightMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		RightMain.BackgroundTransparency = 1.000
		RightMain.BorderColor3 = Color3.fromRGB(0, 0, 0)
		RightMain.BorderSizePixel = 0
		RightMain.Position = UDim2.new(0.501307607, 0, 0, 0)
		RightMain.Size = UDim2.new(0.485000014, 0, 1, 0)
		RightMain.ScrollBarThickness = 0

		UIListLayout_2.Parent = RightMain
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 5)

		UIPadding_2.Parent = RightMain

		UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			RightMain.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_2.AbsoluteContentSize.Y + 35)
		end)
		UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			LeftMain.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_4.AbsoluteContentSize.Y + 35)
		end)

		Tap.MouseButton1Click:Connect(function()
			for i,v in pairs(Bottom:GetChildren()) do
				if v:IsA('Frame') and v.Name ~= 'Search' then
					v.Visible = false
				end
			end
			for i,v in pairs(ScrollingTap:GetChildren()) do
				if v:IsA('TextButton') then
					TweenService:Create(
						v,
						TweenInfo.new(.75,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
						{BackgroundTransparency = 1}
					):Play()
					TweenService:Create(
						v.TextLabel,
						TweenInfo.new(.8,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
						{TextColor3 = Color3.fromRGB(255, 255, 255)}
					):Play()
				end
			end
			TweenService:Create(
				Tap,
				TweenInfo.new(0.5,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
				{BackgroundTransparency = 0}
			):Play()
			TweenService:Create(
				TextLabel,
				TweenInfo.new(0.6,Enum.EasingStyle.Linear,Enum.EasingDirection.Out),
				{TextColor3 = Color3.fromRGB(0, 0, 0)}
			):Play()
			PageMain.Visible = true
		end)

		local GetType = function(value)
			if value == 1 or value == "Left" then
				return LeftMain
			elseif value == 2 or value == "Right" then
				return RightMain
			else
				return LeftMain
			end
		end

		liber.fun.Tap.CreatePage = function(options)
			local Sections = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local UIListLayout = Instance.new("UIListLayout")
			local UIPadding = Instance.new("UIPadding")

			Sections.Name = "Sections"
			Sections.Parent = GetType(options.Side)
			Sections.BackgroundColor3 = Color3.fromRGB(48, 51, 71)
			Sections.BackgroundTransparency = 1.000
			Sections.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Sections.BorderSizePixel = 0
			Sections.Position = UDim2.new(0.0767134205, 0, 0, 0)
			Sections.Size = UDim2.new(1.00000012, 0, 0.828694463, 100)
			Sections.Visible = true

			UICorner.Parent = Sections

			UIListLayout.Parent = Sections
			UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout.Padding = UDim.new(0, 5)

			UIPadding.Parent = Sections
			UIPadding.PaddingLeft = UDim.new(0, 5)
			UIPadding.PaddingTop = UDim.new(0, 5)
			UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Sections.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + 35)
			end)
			liber.fun.FuncMain = {}
			liber.fun.FuncMain.CreateLable = function(options)
				local Lable = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local TextLabel = Instance.new("TextLabel")

				Lable.Name = "Lable"
				Lable.Parent = Sections
				Lable.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Lable.BackgroundTransparency = 0.600
				Lable.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Lable.BorderSizePixel = 0
				Lable.Size = UDim2.new(0.949999988, 0, 0, 30)

				UICorner.CornerRadius = UDim.new(0, 2)
				UICorner.Parent = Lable

				TextLabel.Parent = Lable
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0.0441415086, 0, 0, 0)
				TextLabel.Size = UDim2.new(0.955858469, 0, 1, 0)
				TextLabel.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextLabel.Text = options.Name
				TextLabel.TextColor3 = Color3.fromRGB(142, 144, 150)
				TextLabel.TextSize = TextSize
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left

				local TextTable = {}
				function TextTable:Set(Value)
					TextLabel.Text = Value
					local textHeight = TextLabel.TextBounds.Y
					if textHeight > 12 then
						if _G.Debug then
							warn('[DEBUG]', textHeight)
						end
						Lable.Size = UDim2.new(0.949999988, 0, 0, textHeight)
					end
				end
				function TextTable:SetColor(Color)
					TextLabel.TextColor3 = Color or Color3.fromRGB(142, 144, 150)
				end
				function TextTable:SetFontSize(Size)
					TextLabel.TextSize = Size
				end
				return TextTable
			end
			liber.fun.FuncMain.CreateToggle  = function(options, Lock)
				local ToggleTable = {}
				local Name = options.Name
				local default = options.Value
				local Dis = options.Dis
				local callback = options.Callback or function() end
				local ToggleTable = {}
				local Lock = Lock or false

				local Toggle = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local LockToggle = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local ToggleLocker = Instance.new("ImageLabel")
				local TextButton = Instance.new("TextButton")
				local ToggleO = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local O = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local TitleDis = Instance.new("TextLabel")
				local TitleText = Instance.new("TextLabel")

				Toggle.Name = "Toggle"
				Toggle.Parent = Sections
				Toggle.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Toggle.BackgroundTransparency = 0.600
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(0.949999988, 0, 0, 30)

				UICorner.CornerRadius = UDim.new(0, 2)
				UICorner.Parent = Toggle

				LockToggle.Name = "LockToggle"
				LockToggle.Parent = Toggle
				LockToggle.BackgroundColor3 = Color3.fromRGB(43, 42, 53)
				LockToggle.BackgroundTransparency = 0.500
				LockToggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				LockToggle.BorderSizePixel = 0
				LockToggle.Size = UDim2.new(1, 0, 1, 0)
				LockToggle.Visible = false
				LockToggle.ZIndex = 99

				UICorner_2.CornerRadius = UDim.new(0, 2)
				UICorner_2.Parent = LockToggle

				ToggleLocker.Name = "ToggleLocker"
				ToggleLocker.Parent = LockToggle
				ToggleLocker.AnchorPoint = Vector2.new(0.5, 0.5)
				ToggleLocker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleLocker.BackgroundTransparency = 1.000
				ToggleLocker.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleLocker.BorderSizePixel = 0
				ToggleLocker.Position = UDim2.new(0.5, 0, 0.5, 0)
				ToggleLocker.Size = UDim2.new(0, 20, 0, 20)
				ToggleLocker.Image = "http://www.roblox.com/asset/?id=6031082533"

				TextButton.Parent = Toggle
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 1.000
				TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextButton.BorderSizePixel = 0
				TextButton.Size = UDim2.new(1, 0, 1, 0)
				TextButton.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton.TextSize = 14.000
				TextButton.TextTransparency = 1.000

				ToggleO.Name = "ToggleO"
				ToggleO.Parent = Toggle
				ToggleO.AnchorPoint = Vector2.new(0.5, 0.5)
				ToggleO.BackgroundColor3 = Color3.fromRGB(147, 38, 71)
				ToggleO.BackgroundTransparency = 0.200
				ToggleO.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleO.BorderSizePixel = 0
				ToggleO.Position = UDim2.new(0.855000019, 0, 0.5, 0)
				ToggleO.Size = UDim2.new(0, 35, 0, 15)

				UICorner_3.Parent = ToggleO

				O.Name = "O"
				O.Parent = ToggleO
				O.AnchorPoint = Vector2.new(0, 0.5)
				O.BackgroundColor3 = Color3.fromRGB(213, 55, 102)
				O.BorderColor3 = Color3.fromRGB(0, 0, 0)
				O.BorderSizePixel = 0
				O.Position = UDim2.new(0.100000001, 0, 0.5, 0)
				O.Size = UDim2.new(0, 10, 0, 10)

				UICorner_4.CornerRadius = UDim.new(1, 0)
				UICorner_4.Parent = O

				if Dis ~= nil and Dis ~= "" then
					TitleDis.Name = "TitleDis"
					TitleDis.Parent = Toggle
					TitleDis.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					TitleDis.BackgroundTransparency = 1.000
					TitleDis.BorderColor3 = Color3.fromRGB(0, 0, 0)
					TitleDis.BorderSizePixel = 0
					TitleDis.ClipsDescendants = true
					TitleDis.Position = UDim2.new(0.0439999998, 0, 0.449999988, 0)
					TitleDis.Size = UDim2.new(0.728003502, 0, 0.5, 0)
					TitleDis.Visible = false
					TitleText.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
					TitleDis.Text = "How to Open Function ClickMe Now"
					TitleDis.TextColor3 = Color3.fromRGB(142, 144, 150)
					TitleDis.TextSize = 10.000
					TitleDis.TextWrapped = true
					TitleDis.TextXAlignment = Enum.TextXAlignment.Left
					TitleDis.TextYAlignment = Enum.TextYAlignment.Top
				end
				if Dis == nil or  Dis == "" then
					TitleText.Text = Name
					TitleText.AnchorPoint = Vector2.new(0, 0.5)
					TitleText.Position = UDim2.new(0.0441415198, 0, .5, 0)
					Toggle.Size = UDim2.new(0.949999988, 0, 0, 30)
				end

				TitleText.Name = "TitleText"
				TitleText.Parent = Toggle
				TitleText.AnchorPoint = Vector2.new(0, 0.5)
				TitleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TitleText.BackgroundTransparency = 1.000
				TitleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TitleText.BorderSizePixel = 0
				TitleText.Position = UDim2.new(0.0439999998, 0, 0.5, 0)
				TitleText.Size = UDim2.new(0.955858588, 0, 0.374999851, 0)
				TitleText.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TitleText.Text = Name
				TitleText.TextColor3 = Color3.fromRGB(142, 144, 150)
				TitleText.TextSize = 12.000
				TitleText.TextXAlignment = Enum.TextXAlignment.Left
				if default == true then
					callback(default)
					TweenService:Create(
						O,
						TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{Position = UDim2.new(0.6, 0, 0.5, 0)}
					):Play()
				end

				TextButton.MouseButton1Click:Connect(function()
					if not Lock then
						if not default then
							default = true
							TweenService:Create(
								O,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Position = UDim2.new(0.6, 0, 0.5, 0)}
							):Play()
						else
							default = false
							TweenService:Create(
								O,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Position = UDim2.new(0.1, 0, 0.5, 0)}
							):Play()
						end 
						callback(default)
					end
				end)

				function ToggleTable:Update(Value)
					if not Lock then
						if not Value then
							default = true
							TweenService:Create(
								O,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Position = UDim2.new(0.6, 0, 0.5, 0)}
							):Play()
						else
							default = false
							TweenService:Create(
								O,
								TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
								{Position = UDim2.new(0.1, 0, 0.5, 0)}
							):Play()
						end 
						callback(default)
					end
				end
				function ToggleTable:UnLocker()
					Lock = false
					LockToggle.Visible = false
				end
				function ToggleTable:Locker()
					Lock = true
					LockToggle.Visible = true
				end
				function ToggleTable:UpdateNameText(Value)
					TitleText.Text = Value
				end
				function ToggleTable:UpdateDis(Value)
					TitleDis.Text = Value
				end

				return ToggleTable
			end
			liber.fun.FuncMain.CreateButton = function(options) 
				local Name = options.Name or "Button"
				local callback = options.Callback or function() end

				local Button = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ImageLabel = Instance.new("ImageLabel")
				local TextButton = Instance.new("TextButton")
				local TextLabel = Instance.new("TextLabel")

				Button.Name = "Button"
				Button.Parent = Sections
				Button.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Button.BackgroundTransparency = 0.600
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Position = UDim2.new(0, 0, 0.270586133, 0)
				Button.Size = UDim2.new(0.949999988, 0, 0, 25)

				UICorner.CornerRadius = UDim.new(0, 2)
				UICorner.Parent = Button

				ImageLabel.Parent = Button
				ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BackgroundTransparency = 1.000
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.Position = UDim2.new(0.868354499, 0, 0.5, 0)
				ImageLabel.Size = UDim2.new(0, 15, 0, 15)
				ImageLabel.Image = "http://www.roblox.com/asset/?id=6031094687"
				ImageLabel.ImageColor3 = Color3.fromRGB(142, 144, 150)

				TextButton.Parent = Button
				TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextButton.BackgroundTransparency = 1.000
				TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextButton.BorderSizePixel = 0
				TextButton.Size = UDim2.new(1, 0, 1, 0)
				TextButton.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextButton.Text = ""
				TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				TextButton.TextSize = 14.000

				TextLabel.Parent = Button
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Position = UDim2.new(0.0439998619, 0, 0, 0)
				TextLabel.Size = UDim2.new(0.956000149, 0, 1, 0)
				TextLabel.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextLabel.Text = Name
				TextLabel.TextColor3 = Color3.fromRGB(142, 144, 150)
				TextLabel.TextSize = TextSize
				TextLabel.TextXAlignment = Enum.TextXAlignment.Left

				TextButton.MouseButton1Click:Connect(function()
					TextLabel.TextSize = 0
					TweenService:Create(
						TextLabel,
						TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
						{TextSize = TextSize}
					):Play()
					callback()
				end)

			end
			liber.fun.FuncMain.CreateDropdown = function(options) 
				local default = options.Value or ""
				local text = options.Name
				local list = options.List
				local callback = options.Callback

				local Dropdown = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Main2 = Instance.new("Frame")
				local ScrollingFrame = Instance.new("ScrollingFrame")
				local UIPadding = Instance.new("UIPadding")
				local UIListLayout = Instance.new("UIListLayout")
				local Main1 = Instance.new("Frame")
				local ImageLabel = Instance.new("ImageLabel")
				local TextLabel_2 = Instance.new("TextLabel")
				local ImageButton = Instance.new("ImageButton")

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Sections
				Dropdown.BackgroundColor3 = Color3.fromRGB(56, 60, 83)
				Dropdown.BackgroundTransparency = 1.000
				Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown.BorderSizePixel = 0
				Dropdown.ClipsDescendants = true
				Dropdown.Position = UDim2.new(-1.12172792e-07, 0, 0.82208395, 0)
				Dropdown.Size = UDim2.new(0.949999869, 0, -0.00799936894, 30)

				UICorner.CornerRadius = UDim.new(0, 2)
				UICorner.Parent = Dropdown

				Main2.Name = "Main2"
				Main2.Parent = Dropdown
				Main2.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Main2.BackgroundTransparency = 0.600
				Main2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main2.BorderSizePixel = 0
				Main2.Position = UDim2.new(0, 0, 0, 30)
				Main2.Size = UDim2.new(1, 0, 0, 92)

				ScrollingFrame.Parent = Main2
				ScrollingFrame.Active = true
				ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScrollingFrame.BackgroundTransparency = 1.000
				ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame.BorderSizePixel = 0
				ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
				ScrollingFrame.ScrollBarThickness = 1

				UIPadding.Parent = ScrollingFrame
				UIPadding.PaddingLeft = UDim.new(0, 5)
				UIPadding.PaddingTop = UDim.new(0, 5)

				UIListLayout.Parent = ScrollingFrame
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

				Main1.Name = "Main1"
				Main1.Parent = Dropdown
				Main1.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Main1.BackgroundTransparency = 0.600
				Main1.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main1.BorderSizePixel = 0
				Main1.Size = UDim2.new(1, 0, 0, 27)

				ImageLabel.Parent = Main1
				ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BackgroundTransparency = 1.000
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.Position = UDim2.new(0.868354499, 0, 0.5, 0)
				ImageLabel.Size = UDim2.new(0, 15, 0, 15)
				ImageLabel.Image = "http://www.roblox.com/asset/?id=6031094687"
				ImageLabel.ImageColor3 = Color3.fromRGB(142, 144, 150)

				TextLabel_2.Parent = Main1
				TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_2.BackgroundTransparency = 1.000
				TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_2.BorderSizePixel = 0
				TextLabel_2.Size = UDim2.new(1, 0, 1, 0)
				TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextLabel_2.Text = text.." (".. default ..")"
				TextLabel_2.TextColor3 = Color3.fromRGB(142, 144, 150)
				TextLabel_2.TextSize = 11.000

				ImageButton.Parent = Main1
				ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageButton.BackgroundTransparency = 1.000
				ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageButton.BorderSizePixel = 0
				ImageButton.Size = UDim2.new(1, 0, 1, 0)
				ImageButton.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
				ImageButton.ImageTransparency = 1.000

				local DropF = {}
				local DropG = true
				function DropF:Clear()
					for i, v in next, ScrollingFrame:GetChildren() do
						if v:IsA("Frame") then 
							v:Destroy()
						end
					end
				end

				TextLabel_2.Text = text.." (".. ' None ' ..")"
				function DropF:Add(Text)
					if Text == "Search" then
						local Button = Instance.new("Frame")
						local UICorner_2 = Instance.new("UICorner")
						local TextLabel = Instance.new("TextBox")

						Button.Name = "Button"
						Button.Parent = ScrollingFrame
						Button.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
						Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Button.BorderSizePixel = 0
						Button.Position = UDim2.new(0, 0, 0.270586133, 0)
						Button.Size = UDim2.new(0.949999988, 0, 0, 25)

						UICorner_2.CornerRadius = UDim.new(0, 2)
						UICorner_2.Parent = Button

						TextLabel.Parent = Button
						TextLabel.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
						TextLabel.BackgroundTransparency = 1.000
						TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextLabel.BorderSizePixel = 0
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
						TextLabel.Text = "Search"
						TextLabel.TextColor3 = Color3.fromRGB(142, 144, 150)
						TextLabel.TextSize = TextSize
						TextLabel.Changed:Connect(function()
							if TextLabel.Text ~= "" and TextLabel.Text ~= "Search" then
								local InputText = string.upper(TextLabel.Text)
								for _, button in pairs(ScrollingFrame:GetChildren()) do
									if button:FindFirstChild("TextLabel") then
										if string.upper(button:FindFirstChild("TextLabel").Text):find(string.upper(TextLabel.Text)) then
											button.Visible = true
										else
											if button.Name ~= "Search" then
												button.Visible = false
											end

										end
									end
								end
							else
								for _, button in pairs(ScrollingFrame:GetChildren()) do
									if button:FindFirstChild("TextLabel") then
										button.Visible = true
									end
								end
							end
						end)
					else
						local Button = Instance.new("Frame")
						local TextButton = Instance.new("TextButton")
						local UICorner_2 = Instance.new("UICorner")
						local TextLabel = Instance.new("TextLabel")

						Button.Name = "Button"
						Button.Parent = ScrollingFrame
						Button.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
						Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Button.BorderSizePixel = 0
						Button.Position = UDim2.new(0, 0, 0.270586133, 0)
						Button.Size = UDim2.new(0.949999988, 0, 0, 25)

						TextButton.Parent = Button
						TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						TextButton.BackgroundTransparency = 1.000
						TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextButton.BorderSizePixel = 0
						TextButton.Size = UDim2.new(1, 0, 1, 0)
						TextButton.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
						TextButton.Text = ""
						TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
						TextButton.TextSize = 14.000

						UICorner_2.CornerRadius = UDim.new(0, 2)
						UICorner_2.Parent = Button

						TextLabel.Parent = Button
						TextLabel.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
						TextLabel.BackgroundTransparency = 1.000
						TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextLabel.BorderSizePixel = 0
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
						TextLabel.Text = Text
						TextLabel.TextColor3 = Color3.fromRGB(142, 144, 150)
						TextLabel.TextSize = TextSize

						if TextLabel.Text == default then
							TextLabel_2.Text = text.." (".. Text ..")"
							callback(default)
						end

						TextButton.MouseButton1Click:Connect(function()
							TextLabel_2.Text = text.." (".. Text ..")"
							default = Text
							callback(Text)
						end)
					end
				end
				UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_4.AbsoluteContentSize.Y + 35)
				end)

				ImageButton.MouseButton1Click:Connect(function()
					if not DropG then
						DropG = true
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Size = UDim2.new(0.949999988, 0, 0, 30)}
						):Play()
					else
						DropG = false
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Size = UDim2.new(0.949999988, 0, 0, 200)}
						):Play()
					end
				end)

				DropF:Add("Search")
				for _, v in next,list do
					DropF:Add(v)
				end
				callback(default)
				return DropF
			end

			liber.fun.FuncMain.CreateMultiDropdown  = function(options) 
				local default = options.Value or {}
				local text = options.Name
				local list = options.List
				local callback = options.Callback
				local DropFF = {}

				for i,v in next, default do
					if table.find(list, v) then
						table.insert(DropFF, v)
					end
				end

				local Dropdown = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Main2 = Instance.new("Frame")
				local ScrollingFrame = Instance.new("ScrollingFrame")
				local UIPadding = Instance.new("UIPadding")
				local UIListLayout = Instance.new("UIListLayout")
				local Main1 = Instance.new("Frame")
				local ImageLabel = Instance.new("ImageLabel")
				local TextLabel_2 = Instance.new("TextLabel")
				local ImageButton = Instance.new("ImageButton")

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = Sections
				Dropdown.BackgroundColor3 = Color3.fromRGB(56, 60, 83)
				Dropdown.BackgroundTransparency = 1.000
				Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown.BorderSizePixel = 0
				Dropdown.ClipsDescendants = true
				Dropdown.Position = UDim2.new(-1.12172792e-07, 0, 0.82208395, 0)
				Dropdown.Size = UDim2.new(0.949999869, 0, -0.00799936894, 30)

				UICorner.CornerRadius = UDim.new(0, 2)
				UICorner.Parent = Dropdown

				Main2.Name = "Main2"
				Main2.Parent = Dropdown
				Main2.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Main2.BackgroundTransparency = 0.600
				Main2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main2.BorderSizePixel = 0
				Main2.Position = UDim2.new(0, 0, 0, 30)
				Main2.Size = UDim2.new(1, 0, 0, 92)

				ScrollingFrame.Parent = Main2
				ScrollingFrame.Active = true
				ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ScrollingFrame.BackgroundTransparency = 1.000
				ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ScrollingFrame.BorderSizePixel = 0
				ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
				ScrollingFrame.ScrollBarThickness = 1

				UIPadding.Parent = ScrollingFrame
				UIPadding.PaddingLeft = UDim.new(0, 5)
				UIPadding.PaddingTop = UDim.new(0, 5)

				UIListLayout.Parent = ScrollingFrame
				UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

				Main1.Name = "Main1"
				Main1.Parent = Dropdown
				Main1.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Main1.BackgroundTransparency = 0.600
				Main1.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main1.BorderSizePixel = 0
				Main1.Size = UDim2.new(1, 0, 0, 27)

				ImageLabel.Parent = Main1
				ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BackgroundTransparency = 1.000
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.Position = UDim2.new(0.868354499, 0, 0.5, 0)
				ImageLabel.Size = UDim2.new(0, 15, 0, 15)
				ImageLabel.Image = "http://www.roblox.com/asset/?id=6031094687"
				ImageLabel.ImageColor3 = Color3.fromRGB(142, 144, 150)

				TextLabel_2.Parent = Main1
				TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel_2.BackgroundTransparency = 1.000
				TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel_2.BorderSizePixel = 0
				TextLabel_2.Size = UDim2.new(1, 0, 1, 0)
				TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextLabel_2.Text = text.." ()"
				TextLabel_2.TextColor3 = Color3.fromRGB(142, 144, 150)
				TextLabel_2.TextSize = 11.000

				local function UpdateTextLabel()
					local maxDisplayCount = 3
					local ww = text .. " ("
					if #DropFF > maxDisplayCount then
						ww = ww .. table.concat(DropFF, ", ", 1, maxDisplayCount) .. ", ..."
					else
						if #DropFF < 1 then
							TextLabel_2.Text = text.." (".. 'None' ..")"
						else
							ww = ww .. table.concat(DropFF, ", ")
						end
					end
					ww = ww .. ")"
					TextLabel_2.Text = ww
				end;UpdateTextLabel()

				ImageButton.Parent = Main1
				ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageButton.BackgroundTransparency = 1.000
				ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageButton.BorderSizePixel = 0
				ImageButton.Size = UDim2.new(1, 0, 1, 0)
				ImageButton.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
				ImageButton.ImageTransparency = 1.000

				local DropF = {}
				local DropG = true
				function DropF:Clear()
					for i, v in next, ScrollingFrame:GetChildren() do
						if v:IsA("Frame") then 
							v:Destroy()
						end
					end
				end

				TextLabel_2.Text = text.." (".. ' None ' ..")"
				function DropF:Add(Text)
					if Text == "Search" then
						local Button = Instance.new("Frame")
						local UICorner_2 = Instance.new("UICorner")
						local TextLabel = Instance.new("TextBox")

						Button.Name = "Button"
						Button.Parent = ScrollingFrame
						Button.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
						Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Button.BorderSizePixel = 0
						Button.Position = UDim2.new(0, 0, 0.270586133, 0)
						Button.Size = UDim2.new(0.949999988, 0, 0, 25)

						UICorner_2.CornerRadius = UDim.new(0, 2)
						UICorner_2.Parent = Button

						TextLabel.Parent = Button
						TextLabel.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
						TextLabel.BackgroundTransparency = 1.000
						TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextLabel.BorderSizePixel = 0
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
						TextLabel.Text = "Search"
						TextLabel.TextColor3 = Color3.fromRGB(142, 144, 150)
						TextLabel.TextSize = TextSize
						TextLabel.Changed:Connect(function()
							if TextLabel.Text ~= "" and TextLabel.Text ~= "Search" then
								local InputText = string.upper(TextLabel.Text)
								for _, button in pairs(ScrollingFrame:GetChildren()) do
									if button:FindFirstChild("TextLabel") then
										if string.upper(button:FindFirstChild("TextLabel").Text):find(string.upper(TextLabel.Text)) then
											button.Visible = true
										else
											if button.Name ~= "Search" then
												button.Visible = false
											end

										end
									end
								end
							else
								for _, button in pairs(ScrollingFrame:GetChildren()) do
									if button:FindFirstChild("TextLabel") then
										button.Visible = true
									end
								end
							end
						end)
					else
						local Button = Instance.new("Frame")
						local TextButton = Instance.new("TextButton")
						local UICorner_2 = Instance.new("UICorner")
						local TextLabel = Instance.new("TextLabel")

						Button.Name = "Button"
						Button.Parent = ScrollingFrame
						Button.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
						Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Button.BorderSizePixel = 0
						Button.Position = UDim2.new(0, 0, 0.270586133, 0)
						Button.Size = UDim2.new(0.949999988, 0, 0, 25)

						TextButton.Parent = Button
						TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						TextButton.BackgroundTransparency = 1.000
						TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextButton.BorderSizePixel = 0
						TextButton.Size = UDim2.new(1, 0, 1, 0)
						TextButton.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
						TextButton.Text = ""
						TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
						TextButton.TextSize = 14.000

						UICorner_2.CornerRadius = UDim.new(0, 2)
						UICorner_2.Parent = Button

						TextLabel.Parent = Button
						TextLabel.BackgroundColor3 = Color3.fromRGB(31, 35, 44)
						TextLabel.BackgroundTransparency = 1.000
						TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
						TextLabel.BorderSizePixel = 0
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
						TextLabel.Text = Text
						TextLabel.TextColor3 = Color3.fromRGB(142, 144, 150)
						TextLabel.TextSize = TextSize

						TextButton.MouseButton1Click:Connect(function()
							if not table.find(DropFF, Text) then
								table.insert(DropFF, Text)
								callback(DropFF, Text)
								UpdateTextLabel()
							else
								for i2, v2 in ipairs(DropFF) do
									if v2 == Text then
										table.remove(DropFF, i2)
										callback(DropFF, Text)
										UpdateTextLabel()
										break
									end
								end
							end
						end)
					end
				end
				UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout_4.AbsoluteContentSize.Y + 35)
				end)

				ImageButton.MouseButton1Click:Connect(function()
					if not DropG then
						DropG = true
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Size = UDim2.new(0.949999988, 0, 0, 30)}
						):Play()
					else
						DropG = false
						TweenService:Create(
							Dropdown,
							TweenInfo.new(0.4,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
							{Size = UDim2.new(0.949999988, 0, 0, 200)}
						):Play()
					end
				end)

				DropF:Add("Search")
				for _, v in next,list do
					DropF:Add(v)
				end
				callback(DropFF)
				return DropF
			end

			liber.fun.FuncMain.CreateColorpicker  = function(options) 
				return nil
			end

			liber.fun.FuncMain.CreateInput = function(options)
				local Name = options.Name
				local default = options.Value or ''
				local Placeholder = options.Placeholder
				local callback = options.Callback

				local Input = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local Main = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local InputTitle = Instance.new("TextLabel")
				local TextBox = Instance.new("TextBox")
				local UICorner_3 = Instance.new("UICorner")

				Input.Name = "Input"
				Input.Parent = Sections
				Input.BackgroundColor3 = Color3.fromRGB(56, 60, 83)
				Input.BackgroundTransparency = 1.000
				Input.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Input.BorderSizePixel = 0
				Input.ClipsDescendants = true
				Input.Position = UDim2.new(0, 0, 0.638990283, 0)
				Input.Size = UDim2.new(0.950000107, 0, 0.0111752702, 35)

				UICorner.CornerRadius = UDim.new(0, 2)
				UICorner.Parent = Input

				Main.Name = "Main"
				Main.Parent = Input
				Main.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Main.BackgroundTransparency = 0.600
				Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Main.BorderSizePixel = 0
				Main.ClipsDescendants = true
				Main.Size = UDim2.new(1, 0, 1, 0)

				UICorner_2.CornerRadius = UDim.new(0, 2)
				UICorner_2.Parent = Main

				InputTitle.Name = "InputTitle"
				InputTitle.Parent = Main
				InputTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				InputTitle.BackgroundTransparency = 1.000
				InputTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InputTitle.BorderSizePixel = 0
				InputTitle.Position = UDim2.new(0.0292273257, 0, 0.107466936, 0)
				InputTitle.Size = UDim2.new(0.949801564, 0, 0.340152115, 0)
				InputTitle.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				InputTitle.Text = Name
				InputTitle.TextColor3 = Color3.fromRGB(197, 199, 208)
				InputTitle.TextSize = 10.000
				InputTitle.TextXAlignment = Enum.TextXAlignment.Left

				TextBox.Parent = Main
				TextBox.AnchorPoint = Vector2.new(0.5, 0.5)
				TextBox.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				TextBox.BackgroundTransparency = 0.600
				TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.BorderSizePixel = 0
				TextBox.Position = UDim2.new(0.5, 0, 0.699999988, 0)
				TextBox.Size = UDim2.new(0.800000012, 0, 0.459695935, 0)
				TextBox.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				TextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
				TextBox.PlaceholderText = Placeholder
				TextBox.Text = default
				TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextSize = TextSize

				local aa = Instance.new('UIStroke', TextBox)
				aa.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				aa.Color = Color3.fromRGB(147, 38, 71)

				UICorner_3.CornerRadius = UDim.new(0, 2)
				UICorner_3.Parent = TextBox

				TextBox.FocusLost:Connect(function(ep)
					if #TextBox.Text > 0 then
						callback(TextBox.Text)
						TextBox.Text = TextBox.Text
					end
				end)
				callback(default)
			end

			liber.fun.FuncMain.CreateSlider = function(options)
				local text = options.Name
				local callback = options.Format or function() end
				local Max = options.Max
				local Min = options.Min
				local de = options.Value
				local dragging = false

				local Slider = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ValueFrame2 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local ValueFrame = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local Frame = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local TextBox = Instance.new("TextBox")
				local UICorner_5 = Instance.new("UICorner")
				local ButtonText = Instance.new("TextLabel")

				Slider.Name = "Slider"
				Slider.Parent = Sections
				Slider.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Slider.BackgroundTransparency = 0.600
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.Position = UDim2.new(0, 0, 0.745725453, 0)
				Slider.Size = UDim2.new(0.950000107, 0, 0.00989808794, 31)

				UICorner.CornerRadius = UDim.new(0, 2)
				UICorner.Parent = Slider

				ValueFrame2.Name = "ValueFrame2"
				ValueFrame2.Parent = Slider
				ValueFrame2.AnchorPoint = Vector2.new(0.5, 0.5)
				ValueFrame2.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
				ValueFrame2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ValueFrame2.BorderSizePixel = 0
				ValueFrame2.Position = UDim2.new(0.5, 0, 0.800000012, 0)
				ValueFrame2.Size = UDim2.new(0.949999988, 0, 0, 2)

				UICorner_2.CornerRadius = UDim.new(0, 5)
				UICorner_2.Parent = ValueFrame2

				ValueFrame.Name = "ValueFrame"
				ValueFrame.Parent = ValueFrame2
				ValueFrame.BackgroundColor3 = Color3.fromRGB(213, 55, 102)
				ValueFrame.Size = UDim2.new(0.827, 0, 1, 0)

				UICorner_3.CornerRadius = UDim.new(0, 5)
				UICorner_3.Parent = ValueFrame

				Frame.Parent = ValueFrame
				Frame.AnchorPoint = Vector2.new(0.5, 0.5)
				Frame.BackgroundColor3 = Color3.fromRGB(213, 55, 102)
				Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Frame.BorderSizePixel = 0
				Frame.Position = UDim2.new(1, 0, 0, 0)
				Frame.Size = UDim2.new(0, 10, 0, 10)

				UICorner_4.CornerRadius = UDim.new(1, 8)
				UICorner_4.Parent = Frame

				TextBox.Parent = Slider
				TextBox.BackgroundColor3 = Color3.fromRGB(147, 38, 71)
				TextBox.BackgroundTransparency = 1.000
				TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.BorderSizePixel = 0
				TextBox.ClipsDescendants = true
				TextBox.Position = UDim2.new(0.747350395, 0, 0.175377965, 0)
				TextBox.Size = UDim2.new(0, 36, 0, 10)
				TextBox.Font = Enum.Font.Ubuntu
				TextBox.Text = "123"
				TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextSize = 7.000

				UICorner_5.CornerRadius = UDim.new(0, 2)
				UICorner_5.Parent = TextBox

				local aa = Instance.new('UIStroke', TextBox)
				aa.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				aa.Color = Color3.fromRGB(147, 38, 71)

				ButtonText.Name = "ButtonText"
				ButtonText.Parent = Slider
				ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonText.BackgroundTransparency = 1.000
				ButtonText.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ButtonText.BorderSizePixel = 0
				ButtonText.Position = UDim2.new(0.0462909453, 0, 0.191856131, 0)
				ButtonText.Size = UDim2.new(0, 148, 0, 9)
				ButtonText.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				ButtonText.Text = text
				ButtonText.TextColor3 = Color3.fromRGB(197, 199, 208)
				ButtonText.TextSize = 12.000
				ButtonText.TextXAlignment = Enum.TextXAlignment.Left

				ValueFrame:TweenSize(UDim2.new((de or 0) / Max, 0, 1, 0), "Out", "Back", 0.2, true)
				callback(de)
				TextBox.Text = de

				TextBox.FocusLost:Connect(function()
					local value = tonumber(TextBox.Text)
					if not value then
						TextBox.Text = de
					end
					value = math.clamp(value, Min, Max)
					ValueFrame:TweenSize(UDim2.new((value - Min) / (Max - Min), 0, 1, 0), "Out", "Back", 0.2, true)
					callback(value)
				end)

				local function move(input)
					local relativeX = (input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame2.AbsoluteSize.X
					relativeX = math.clamp(relativeX, 0, 1)
					local newPos = UDim2.new(relativeX, 0, 1, 0)
					ValueFrame:TweenSize(newPos, "Out", "Sine", 0.2, true)
					local value = 0
					if options.Floor then
						value = string.format("%.1f",((relativeX * ( - Min)) + Min))
					else
						value = math.floor((relativeX * (Max - Min)) + Min)
					end
					TextBox.Text = tostring(value)
					callback(value)
				end

				Frame.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = true
					end
				end)

				Frame.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
					end
				end)

				game:GetService("UserInputService").InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						move(input)
					end
				end)
			end

			liber.fun.FuncMain.CreateImage = function(options)
				local TableImg = {}

				local Image = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local NameIcon = Instance.new("TextLabel")
				local Title = Instance.new("TextLabel")
				local ImageIcon = Instance.new("ImageLabel")

				Image.Name = "Image"
				Image.Parent = Sections
				Image.BackgroundColor3 = Color3.fromRGB(27, 31, 40)
				Image.BackgroundTransparency = 0.600
				Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Image.BorderSizePixel = 0
				Image.ClipsDescendants = true
				Image.Position = UDim2.new(0, 0, 0.311646491, 0)
				Image.Size = UDim2.new(0.950000107, 0, 0.152440205, 27)

				UICorner.CornerRadius = UDim.new(0, 2)
				UICorner.Parent = Image

				NameIcon.Name = "NameIcon"
				NameIcon.Parent = Image
				NameIcon.AnchorPoint = Vector2.new(0.5, 0.5)
				NameIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				NameIcon.BackgroundTransparency = 1.000
				NameIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				NameIcon.BorderSizePixel = 0
				NameIcon.Position = UDim2.new(0.5, 0, 0.899999976, 0)
				NameIcon.Size = UDim2.new(1, 0, 0.151999995, 0)
				NameIcon.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				NameIcon.Text = options.Dis
				NameIcon.TextColor3 = Color3.fromRGB(185, 185, 185)
				NameIcon.TextSize = 12.000
				NameIcon.TextWrapped = true

				Title.Name = "Title"
				Title.Parent = Image
				Title.AnchorPoint = Vector2.new(0.5, 0.5)
				Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title.BackgroundTransparency = 1.000
				Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0.5, 0, 0.100000001, 0)
				Title.Size = UDim2.new(1, 0, 0.151999995, 0)
				Title.FontFace = Font.new("rbxasset://fonts/families/Nunito.json", Enum.FontWeight.Bold, Enum.FontStyle.Normal)
				Title.Text = options.Title
				Title.TextColor3 = Color3.fromRGB(185, 185, 185)
				Title.TextSize = 12.000
				Title.TextWrapped = true

				ImageIcon.Name = "ImageIcon"
				ImageIcon.Parent = Image
				ImageIcon.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageIcon.BackgroundTransparency = 1.000
				ImageIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageIcon.BorderSizePixel = 0
				ImageIcon.Position = UDim2.new(0.493066698, 0, 0.5, 0)
				ImageIcon.Size = UDim2.new(0, 50, 0, 50)
				ImageIcon.Image = "rbxassetid://16917322600"

				if options.AIP then
					local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
					local length = 20
					local randomString = ""

					math.randomseed(os.time())

					local charTable = {}
					for c in chars:gmatch "." do
						table.insert(charTable, c)
					end

					for i = 1, length do
						randomString = randomString .. charTable[math.random(1, #charTable)]
					end
					ImageIcon.Image = GetImage("Image".. randomString, options.Image)
				else
					ImageIcon.Image = "rbxassetid://".. options.Image
				end

				function TableImg:UpdateImage(Value)
					if options.AIP then
						local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
						local length = 20
						local randomString = ""

						math.randomseed(os.time())

						local charTable = {}
						for c in chars:gmatch "." do
							table.insert(charTable, c)
						end

						for i = 1, length do
							randomString = randomString .. charTable[math.random(1, #charTable)]
						end
						ImageIcon.Image = GetImage("Image".. randomString, Value)
					else
						ImageIcon.Image = "rbxassetid://".. Value
					end
				end
				function TableImg:UpdateTitle(Value)
					Title.Text = Value
				end
				function TableImg:UpdateDis(Value)
					NameIcon.Text = Value
				end
				return TableImg
			end

			return liber.fun.FuncMain
		end

		local UIPadding = Instance.new("UIPadding")
		local UIListLayout = Instance.new("UIListLayout")

		UIPadding.Parent = ScrollingTap
		UIPadding.PaddingTop = UDim.new(0, 1)

		UIListLayout.Parent = ScrollingTap
		UIListLayout.FillDirection = Enum.FillDirection.Horizontal
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.Padding = UDim.new(0, 3)
		
		UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			ScrollingTap.CanvasSize = UDim2.new(0, UIListLayout.AbsoluteContentSize.Y + 85, 0, 0)
		end)

		return liber.fun.Tap 

	end

	return liber.fun
end
return liber
