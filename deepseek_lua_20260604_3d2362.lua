-- JANE GUI (ESP & CHAMS) 🔥 - JANE DOE EDITION
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- GUI Setup
local gui = Instance.new("ScreenGui")
gui.Name = "JaneGUI"
gui.ResetOnSpawn = false
gui.Parent = game:GetService("CoreGui")

-- Modern Rectangle Frame with Pink theme
local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 350, 0, 500)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(25, 15, 25) -- Dark pink/purple
mainFrame.BackgroundTransparency = 0.1
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true

-- Animation variables
local pageTransitionTween = nil

-- Modern gradient background with pink tones
local gradient = Instance.new("UIGradient", mainFrame)
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(40, 20, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 15, 30))
})
gradient.Rotation = 90

-- Glow effect border with pink/purple
local glowBorder = Instance.new("Frame", mainFrame)
glowBorder.Size = UDim2.new(1, 2, 1, 2)
glowBorder.Position = UDim2.new(0, -1, 0, -1)
glowBorder.BackgroundTransparency = 1
glowBorder.BorderSizePixel = 0
local glowGradient = Instance.new("UIGradient", glowBorder)
glowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 100, 150)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 50, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 100, 150))
})
glowGradient.Rotation = 45

-- Animate glow border
spawn(function()
    while true do
        for i = 45, 405 do
            glowGradient.Rotation = i
            task.wait(0.01)
        end
    end
end)

-- Title bar with pink theme
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.Position = UDim2.new(0, 0, 0, 0)
titleBar.BackgroundColor3 = Color3.fromRGB(35, 20, 45)
titleBar.BackgroundTransparency = 0.2
titleBar.BorderSizePixel = 0

-- Title with Jane Doe
local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -80, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.Text = "JANE GUI"
title.TextColor3 = Color3.fromRGB(255, 150, 200)
title.BackgroundTransparency = 1
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left

-- Subtle animation for title
spawn(function()
    while true do
        TweenService:Create(title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency = 0.1,
            TextColor3 = Color3.fromRGB(255, 180, 220)
        }):Play()
        task.wait(2)
        TweenService:Create(title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            TextTransparency = 0,
            TextColor3 = Color3.fromRGB(255, 150, 200)
        }):Play()
        task.wait(2)
    end
end)

-- Creator text
local creatorText = Instance.new("TextLabel", titleBar)
creatorText.Size = UDim2.new(0, 100, 0, 20)
creatorText.Position = UDim2.new(0, 15, 1, -22)
creatorText.Text = "by Nekofred"
creatorText.TextColor3 = Color3.fromRGB(200, 150, 200)
creatorText.BackgroundTransparency = 1
creatorText.TextSize = 12
creatorText.Font = Enum.Font.Gotham
creatorText.TextXAlignment = Enum.TextXAlignment.Left

-- Minimize button with pink theme
local minimizeBtn = Instance.new("TextButton", titleBar)
minimizeBtn.Size = UDim2.new(0, 30, 0, 30)
minimizeBtn.Position = UDim2.new(1, -40, 0.5, -15)
minimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 60)
minimizeBtn.TextColor3 = Color3.fromRGB(255, 200, 220)
minimizeBtn.Text = "−"
minimizeBtn.TextSize = 20
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0

-- Minimize button hover animation
minimizeBtn.MouseEnter:Connect(function()
    TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(70, 50, 80)}):Play()
end)

minimizeBtn.MouseLeave:Connect(function()
    TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 30, 60)}):Play()
end)

-- GUI state variables
local isMinimized = false
local originalSize = mainFrame.Size
local minimizedSize = UDim2.new(0, 350, 0, 45)

-- Content container
local contentContainer = Instance.new("Frame", mainFrame)
contentContainer.Size = UDim2.new(1, -20, 1, -55)
contentContainer.Position = UDim2.new(0, 10, 0, 50)
contentContainer.BackgroundTransparency = 1
contentContainer.Visible = true
contentContainer.ClipsDescendants = true

-- Page System - 7 PAGES NOW
local currentPage = 1
local totalPages = 7  -- Changed from 6 to 7
local pageFrames = {}
local pageButtons = {}

-- Modern Page Navigation with pink theme
local navBar = Instance.new("Frame", contentContainer)
navBar.Size = UDim2.new(1, 0, 0, 40)
navBar.Position = UDim2.new(0, 0, 1, -40)
navBar.BackgroundTransparency = 1

local prevPageBtn = Instance.new("TextButton", navBar)
prevPageBtn.Size = UDim2.new(0, 35, 0, 35)
prevPageBtn.Position = UDim2.new(0, 0, 0, 0)
prevPageBtn.BackgroundColor3 = Color3.fromRGB(45, 30, 55)
prevPageBtn.TextColor3 = Color3.fromRGB(255, 180, 220)
prevPageBtn.Text = "◀"
prevPageBtn.TextSize = 20
prevPageBtn.Font = Enum.Font.GothamBold
prevPageBtn.BorderSizePixel = 0
prevPageBtn.Visible = false

prevPageBtn.MouseEnter:Connect(function()
    TweenService:Create(prevPageBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 50, 75)}):Play()
end)

prevPageBtn.MouseLeave:Connect(function()
    TweenService:Create(prevPageBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 30, 55)}):Play()
end)

local nextPageBtn = Instance.new("TextButton", navBar)
nextPageBtn.Size = UDim2.new(0, 35, 0, 35)
nextPageBtn.Position = UDim2.new(1, -35, 0, 0)
nextPageBtn.BackgroundColor3 = Color3.fromRGB(45, 30, 55)
nextPageBtn.TextColor3 = Color3.fromRGB(255, 180, 220)
nextPageBtn.Text = "▶"
nextPageBtn.TextSize = 20
nextPageBtn.Font = Enum.Font.GothamBold
nextPageBtn.BorderSizePixel = 0

nextPageBtn.MouseEnter:Connect(function()
    TweenService:Create(nextPageBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(65, 50, 75)}):Play()
end)

nextPageBtn.MouseLeave:Connect(function()
    TweenService:Create(nextPageBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 30, 55)}):Play()
end)

local pageIndicator = Instance.new("TextLabel", navBar)
pageIndicator.Size = UDim2.new(0, 80, 0, 35)
pageIndicator.Position = UDim2.new(0.5, -40, 0, 0)
pageIndicator.BackgroundTransparency = 1
pageIndicator.TextColor3 = Color3.fromRGB(255, 180, 220)
pageIndicator.Text = "1/7"
pageIndicator.TextSize = 16
pageIndicator.Font = Enum.Font.GothamBold

-- Create page frames
for page = 1, totalPages do
    local pageFrame = Instance.new("ScrollingFrame", contentContainer)
    pageFrame.Size = UDim2.new(1, 0, 1, -50)
    pageFrame.Position = UDim2.new(0, 0, 0, 0)
    pageFrame.BackgroundTransparency = 1
    pageFrame.BorderSizePixel = 0
    pageFrame.ScrollBarThickness = 4
    pageFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 100, 200)
    pageFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    pageFrame.Visible = (page == 1)
    pageFrames[page] = pageFrame
end

-- Function to switch pages with animation
local function switchPage(page)
    if page < 1 or page > totalPages then return end
    
    local oldPage = pageFrames[currentPage]
    local newPage = pageFrames[page]
    
    if pageTransitionTween then
        pageTransitionTween:Cancel()
    end
    
    local direction = page > currentPage and -1 or 1
    
    newPage.Position = UDim2.new(direction, 0, 0, 0)
    newPage.Visible = true
    
    local fadeOut = TweenService:Create(oldPage, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(-direction, 0, 0, 0),
        BackgroundTransparency = 1
    })
    
    local slideIn = TweenService:Create(newPage, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    })
    
    fadeOut:Play()
    slideIn:Play()
    
    task.wait(0.3)
    oldPage.Visible = false
    oldPage.Position = UDim2.new(0, 0, 0, 0)
    
    currentPage = page
    prevPageBtn.Visible = (currentPage > 1)
    nextPageBtn.Visible = (currentPage < totalPages)
    pageIndicator.Text = currentPage .. "/" .. totalPages
    
    TweenService:Create(pageIndicator, TweenInfo.new(0.2), {TextTransparency = 0.5}):Play()
    task.wait(0.1)
    TweenService:Create(pageIndicator, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
end

prevPageBtn.MouseButton1Click:Connect(function()
    switchPage(currentPage - 1)
end)

nextPageBtn.MouseButton1Click:Connect(function()
    switchPage(currentPage + 1)
end)

-- Minimize/Maximize functionality with animation
minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    
    local targetSize = isMinimized and minimizedSize or originalSize
    local targetContentVisible = not isMinimized
    
    TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = targetSize
    }):Play()
    
    TweenService:Create(contentContainer, TweenInfo.new(0.2), {
        BackgroundTransparency = isMinimized and 1 or 0
    }):Play()
    
    task.wait(0.15)
    contentContainer.Visible = targetContentVisible
    
    minimizeBtn.Text = isMinimized and "+" or "−"
    
    TweenService:Create(minimizeBtn, TweenInfo.new(0.2), {
        BackgroundColor3 = isMinimized and Color3.fromRGB(70, 50, 80) or Color3.fromRGB(50, 30, 60),
        Rotation = isMinimized and 90 or 0
    }):Play()
end)

-- Modern Button Creator with pink theme
local function createModernButton(parent, text, isToggle, color)
    local btnContainer = Instance.new("Frame", parent)
    btnContainer.Size = UDim2.new(1, -20, 0, 45)
    btnContainer.BackgroundTransparency = 1
    
    local btn = Instance.new("TextButton", btnContainer)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.Position = UDim2.new(0, 0, 0, 0)
    btn.BackgroundColor3 = color or Color3.fromRGB(45, 30, 55)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Text = text .. (isToggle and " [OFF]" or "")
    btn.TextSize = 16
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
    btn.ClipsDescendants = true
    
    local shine = Instance.new("Frame", btn)
    shine.Size = UDim2.new(0, 0, 1, 0)
    shine.Position = UDim2.new(0, 0, 0, 0)
    shine.BackgroundColor3 = Color3.fromRGB(255, 200, 220)
    shine.BackgroundTransparency = 0.7
    shine.BorderSizePixel = 0
    shine.Visible = false
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(
            math.min(color.R * 255 + 30, 255),
            math.min(color.G * 255 + 30, 255),
            math.min(color.B * 255 + 30, 255)
        )}):Play()
        
        TweenService:Create(btn, TweenInfo.new(0.2), {
            Size = UDim2.new(1.02, 0, 1.02, 0),
            Position = UDim2.new(-0.01, 0, -0.01, 0)
        }):Play()
        
        shine.Visible = true
        TweenService:Create(shine, TweenInfo.new(0.3), {
            Size = UDim2.new(2, 0, 1, 0),
            Position = UDim2.new(1, 0, 0, 0)
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = color}):Play()
        
        TweenService:Create(btn, TweenInfo.new(0.2), {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
        
        shine.Visible = false
        shine.Size = UDim2.new(0, 0, 1, 0)
        shine.Position = UDim2.new(0, 0, 0, 0)
    end)
    
    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {
            Size = UDim2.new(0.95, 0, 0.95, 0),
            Position = UDim2.new(0.025, 0, 0.025, 0)
        }):Play()
        
        task.wait(0.1)
        
        TweenService:Create(btn, TweenInfo.new(0.1), {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
    end)
    
    table.insert(pageButtons, {
        button = btn,
        container = btnContainer,
        text = text,
        isToggle = isToggle,
        defaultColor = color,
        shine = shine
    })
    
    return btn, btnContainer
end

-- =============================================
-- VARIABLES FOR ALL FEATURES
-- =============================================
-- Combat variables
local espEnabled = false
local rainbowEspEnabled = false
local chamsEnabled = false
local rainbowChamsEnabled = false
local aimbotEnabled = false
local aimbotEnemyOnlyEnabled = false
local teamCheckEnabled = false
local spinbotEnabled = false

-- Aimbot target variable
local aimbotTarget = "Torso"
local aimbotTargets = {"Head", "Torso", "Whole Character", "Random"}

-- NEW: Shot Through Walls variables
local shotThroughWallsEnabled = false
local originalProjectileProperties = {}
local wallbangConnection = nil

-- Movement variables
local speedEnabled = false
local defaultWalkSpeed = 16
local jumpPowerEnabled = false
local defaultJumpPower = 50
local infiniteJumpEnabled = false
local infiniteStaminaEnabled = false
local noclipEnabled = false
local autoDodgeEnabled = false
local clickTpTool = nil

-- Visual variables
local xrayEnabled = false
local noFogEnabled = false
local fullBrightEnabled = false
local playerDetectorEnabled = false
local originalTransparency = {}
local originalLightingData = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    FogColor = Lighting.FogColor
}
local originalFogData = {
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    FogColor = Lighting.FogColor
}

-- Protection variables
local godModeEnabled = false
local antiDamageEnabled = false
local antiFallDamageEnabled = false
local antiExplosionEnabled = false
local antiFireEnabled = false
local antiDrownEnabled = false
local godModeConnection = nil

-- ESP variables
local drawings = {}
local espHue = 0

-- Chams variables
local highlights = {}
local chamsHue = 0

-- Player detector variables
local playerDetectorConnection = nil
local detectorRange = 50
local detectionLabels = {}

-- =============================================
-- PAGE 1: COMBAT FEATURES
-- =============================================
local combatTitle = Instance.new("TextLabel", pageFrames[1])
combatTitle.Size = UDim2.new(1, 0, 0, 30)
combatTitle.Position = UDim2.new(0, 10, 0, 5)
combatTitle.BackgroundTransparency = 1
combatTitle.Text = "⚔️ COMBAT"
combatTitle.TextColor3 = Color3.fromRGB(255, 150, 200)
combatTitle.TextSize = 20
combatTitle.Font = Enum.Font.GothamBold
combatTitle.TextXAlignment = Enum.TextXAlignment.Left

local yPos = 40
local combatButtons = {
    {"ESP", true, Color3.fromRGB(255, 100, 150)},
    {"Rainbow ESP", true, Color3.fromRGB(255, 150, 100)},
    {"Chams", true, Color3.fromRGB(255, 100, 180)},
    {"Rainbow Chams", true, Color3.fromRGB(220, 100, 255)},
    {"Aimbot", true, Color3.fromRGB(100, 255, 150)},
    {"Aimbot Enemy Only", true, Color3.fromRGB(255, 200, 100)},
    {"Team Check", true, Color3.fromRGB(150, 100, 255)},
    {"Spinbot", true, Color3.fromRGB(255, 255, 100)}
}

for i, data in ipairs(combatButtons) do
    local btn, container = createModernButton(pageFrames[1], data[1], data[2], data[3])
    container.Position = UDim2.new(0, 10, 0, yPos)
    
    if data[1] == "ESP" then espBtn = btn
    elseif data[1] == "Rainbow ESP" then rainbowEspBtn = btn
    elseif data[1] == "Chams" then chamsBtn = btn
    elseif data[1] == "Rainbow Chams" then rainbowChamsBtn = btn
    elseif data[1] == "Aimbot" then aimbotBtn = btn
    elseif data[1] == "Aimbot Enemy Only" then aimbotEnemyOnlyBtn = btn
    elseif data[1] == "Team Check" then teamCheckBtn = btn
    elseif data[1] == "Spinbot" then spinbotBtn = btn
    end
    
    yPos = yPos + 50
end

pageFrames[1].CanvasSize = UDim2.new(0, 0, 0, yPos + 10)

-- =============================================
-- PAGE 2: MOVEMENT FEATURES
-- =============================================
local movementTitle = Instance.new("TextLabel", pageFrames[2])
movementTitle.Size = UDim2.new(1, 0, 0, 30)
movementTitle.Position = UDim2.new(0, 10, 0, 5)
movementTitle.BackgroundTransparency = 1
movementTitle.Text = "🏃 MOVEMENT"
movementTitle.TextColor3 = Color3.fromRGB(150, 255, 200)
movementTitle.TextSize = 20
movementTitle.Font = Enum.Font.GothamBold
movementTitle.TextXAlignment = Enum.TextXAlignment.Left

yPos = 40
local movementButtons = {
    {"Speed", true, Color3.fromRGB(150, 255, 150)},
    {"JumpPower", true, Color3.fromRGB(150, 255, 220)},
    {"Infinite Jump", true, Color3.fromRGB(150, 200, 255)},
    {"Infinite Stamina", true, Color3.fromRGB(200, 255, 150)},
    {"Noclip", true, Color3.fromRGB(255, 150, 255)},
    {"Auto Dodge", true, Color3.fromRGB(255, 220, 150)},
    {"Click TP", false, Color3.fromRGB(255, 180, 150)}
}

for i, data in ipairs(movementButtons) do
    local btn, container = createModernButton(pageFrames[2], data[1], data[2], data[3])
    container.Position = UDim2.new(0, 10, 0, yPos)
    
    if data[1] == "Speed" then speedBtn = btn
    elseif data[1] == "JumpPower" then jumpPowerBtn = btn
    elseif data[1] == "Infinite Jump" then infiniteJumpBtn = btn
    elseif data[1] == "Infinite Stamina" then infiniteStaminaBtn = btn
    elseif data[1] == "Noclip" then noclipBtn = btn
    elseif data[1] == "Auto Dodge" then autoDodgeBtn = btn
    elseif data[1] == "Click TP" then clickTpBtn = btn
    end
    
    yPos = yPos + 50
end

pageFrames[2].CanvasSize = UDim2.new(0, 0, 0, yPos + 10)

-- =============================================
-- PAGE 3: VISUAL FEATURES
-- =============================================
local visualTitle = Instance.new("TextLabel", pageFrames[3])
visualTitle.Size = UDim2.new(1, 0, 0, 30)
visualTitle.Position = UDim2.new(0, 10, 0, 5)
visualTitle.BackgroundTransparency = 1
visualTitle.Text = "👁️ VISUAL"
visualTitle.TextColor3 = Color3.fromRGB(255, 220, 150)
visualTitle.TextSize = 20
visualTitle.Font = Enum.Font.GothamBold
visualTitle.TextXAlignment = Enum.TextXAlignment.Left

yPos = 40
local visualButtons = {
    {"XRay", true, Color3.fromRGB(220, 150, 255)},
    {"No Fog", true, Color3.fromRGB(150, 220, 255)},
    {"Full Bright", true, Color3.fromRGB(255, 255, 150)},
    {"Player Detector", true, Color3.fromRGB(150, 255, 255)}
}

for i, data in ipairs(visualButtons) do
    local btn, container = createModernButton(pageFrames[3], data[1], data[2], data[3])
    container.Position = UDim2.new(0, 10, 0, yPos)
    
    if data[1] == "XRay" then xrayBtn = btn
    elseif data[1] == "No Fog" then noFogBtn = btn
    elseif data[1] == "Full Bright" then fullBrightBtn = btn
    elseif data[1] == "Player Detector" then playerDetectorBtn = btn
    end
    
    yPos = yPos + 50
end

-- Teleport section
local teleportTitle = Instance.new("TextLabel", pageFrames[3])
teleportTitle.Size = UDim2.new(1, 0, 0, 30)
teleportTitle.Position = UDim2.new(0, 10, 0, yPos + 5)
teleportTitle.BackgroundTransparency = 1
teleportTitle.Text = "📡 TELEPORT"
teleportTitle.TextColor3 = Color3.fromRGB(200, 150, 255)
teleportTitle.TextSize = 18
teleportTitle.Font = Enum.Font.GothamBold
teleportTitle.TextXAlignment = Enum.TextXAlignment.Left

yPos = yPos + 40

local playerSearchBox = Instance.new("TextBox", pageFrames[3])
playerSearchBox.Size = UDim2.new(1, -20, 0, 35)
playerSearchBox.Position = UDim2.new(0, 10, 0, yPos)
playerSearchBox.BackgroundColor3 = Color3.fromRGB(40, 30, 50)
playerSearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
playerSearchBox.PlaceholderText = "Enter player name..."
playerSearchBox.PlaceholderColor3 = Color3.fromRGB(200, 150, 200)
playerSearchBox.Text = ""
playerSearchBox.TextSize = 14
playerSearchBox.Font = Enum.Font.Gotham
playerSearchBox.BorderSizePixel = 0

playerSearchBox.Focused:Connect(function()
    TweenService:Create(playerSearchBox, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(50, 40, 60),
        Size = UDim2.new(1, -18, 0, 37)
    }):Play()
end)

playerSearchBox.FocusLost:Connect(function()
    TweenService:Create(playerSearchBox, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(40, 30, 50),
        Size = UDim2.new(1, -20, 0, 35)
    }):Play()
end)

yPos = yPos + 45

local teleportBtn, teleportContainer = createModernButton(pageFrames[3], "Teleport to Player", false, Color3.fromRGB(150, 100, 255))
teleportContainer.Position = UDim2.new(0, 10, 0, yPos)
teleportToPlayerBtn = teleportBtn

yPos = yPos + 50

pageFrames[3].CanvasSize = UDim2.new(0, 0, 0, yPos + 10)

-- =============================================
-- PAGE 4: PROTECTION FEATURES
-- =============================================
local protectionTitle = Instance.new("TextLabel", pageFrames[4])
protectionTitle.Size = UDim2.new(1, 0, 0, 30)
protectionTitle.Position = UDim2.new(0, 10, 0, 5)
protectionTitle.BackgroundTransparency = 1
protectionTitle.Text = "🛡️ PROTECTION"
protectionTitle.TextColor3 = Color3.fromRGB(255, 180, 180)
protectionTitle.TextSize = 20
protectionTitle.Font = Enum.Font.GothamBold
protectionTitle.TextXAlignment = Enum.TextXAlignment.Left

yPos = 40

-- GOD MODE BUTTON
local godModeContainer = Instance.new("Frame", pageFrames[4])
godModeContainer.Size = UDim2.new(1, -20, 0, 55)
godModeContainer.Position = UDim2.new(0, 10, 0, yPos)
godModeContainer.BackgroundTransparency = 1

local godModeBtn = Instance.new("TextButton", godModeContainer)
godModeBtn.Size = UDim2.new(1, 0, 1, 0)
godModeBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
godModeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
godModeBtn.Text = "👑 GOD MODE [OFF]"
godModeBtn.TextSize = 18
godModeBtn.Font = Enum.Font.GothamBold
godModeBtn.BorderSizePixel = 0

godModeBtn.MouseEnter:Connect(function()
    TweenService:Create(godModeBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(1.02, 0, 1.02, 0),
        Position = UDim2.new(-0.01, 0, -0.01, 0)
    }):Play()
end)

godModeBtn.MouseLeave:Connect(function()
    TweenService:Create(godModeBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
end)

yPos = yPos + 65

-- ANTI DAMAGE BUTTON
local antiDamageContainer = Instance.new("Frame", pageFrames[4])
antiDamageContainer.Size = UDim2.new(1, -20, 0, 55)
antiDamageContainer.Position = UDim2.new(0, 10, 0, yPos)
antiDamageContainer.BackgroundTransparency = 1

local antiDamageBtn = Instance.new("TextButton", antiDamageContainer)
antiDamageBtn.Size = UDim2.new(1, 0, 1, 0)
antiDamageBtn.BackgroundColor3 = Color3.fromRGB(150, 100, 255)
antiDamageBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
antiDamageBtn.Text = "🛡️ ANTI DAMAGE [OFF]"
antiDamageBtn.TextSize = 18
antiDamageBtn.Font = Enum.Font.GothamBold
antiDamageBtn.BorderSizePixel = 0

antiDamageBtn.MouseEnter:Connect(function()
    TweenService:Create(antiDamageBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(1.02, 0, 1.02, 0),
        Position = UDim2.new(-0.01, 0, -0.01, 0)
    }):Play()
end)

antiDamageBtn.MouseLeave:Connect(function()
    TweenService:Create(antiDamageBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
end)

yPos = yPos + 65

-- Additional protection features
local protectionLabel = Instance.new("TextLabel", pageFrames[4])
protectionLabel.Size = UDim2.new(1, -20, 0, 30)
protectionLabel.Position = UDim2.new(0, 10, 0, yPos)
protectionLabel.BackgroundTransparency = 1
protectionLabel.Text = "🔰 ADDITIONAL PROTECTION"
protectionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
protectionLabel.TextSize = 14
protectionLabel.Font = Enum.Font.Gotham
protectionLabel.TextXAlignment = Enum.TextXAlignment.Left

yPos = yPos + 35

local protectionFeatures = {
    {"Anti Fall Damage", true, Color3.fromRGB(150, 180, 255)},
    {"Anti Explosion", true, Color3.fromRGB(200, 150, 255)},
    {"Anti Fire", true, Color3.fromRGB(255, 150, 150)},
    {"Anti Drown", true, Color3.fromRGB(150, 220, 255)}
}

for i, data in ipairs(protectionFeatures) do
    local btn, container = createModernButton(pageFrames[4], data[1], data[2], data[3])
    container.Position = UDim2.new(0, 10, 0, yPos)
    
    if data[1] == "Anti Fall Damage" then antiFallDamageBtn = btn
    elseif data[1] == "Anti Explosion" then antiExplosionBtn = btn
    elseif data[1] == "Anti Fire" then antiFireBtn = btn
    elseif data[1] == "Anti Drown" then antiDrownBtn = btn
    end
    
    yPos = yPos + 50
end

pageFrames[4].CanvasSize = UDim2.new(0, 0, 0, yPos + 10)

-- =============================================
-- PAGE 5: AIMBOT SETTINGS
-- =============================================
local aimbotSettingsTitle = Instance.new("TextLabel", pageFrames[5])
aimbotSettingsTitle.Size = UDim2.new(1, 0, 0, 35)
aimbotSettingsTitle.Position = UDim2.new(0, 10, 0, 5)
aimbotSettingsTitle.BackgroundTransparency = 1
aimbotSettingsTitle.Text = "🎯 AIMBOT SETTINGS"
aimbotSettingsTitle.TextColor3 = Color3.fromRGB(150, 220, 255)
aimbotSettingsTitle.TextSize = 20
aimbotSettingsTitle.Font = Enum.Font.GothamBold
aimbotSettingsTitle.TextXAlignment = Enum.TextXAlignment.Left

local aimbotInfo = Instance.new("TextLabel", pageFrames[5])
aimbotInfo.Size = UDim2.new(1, -20, 0, 40)
aimbotInfo.Position = UDim2.new(0, 10, 0, 45)
aimbotInfo.BackgroundTransparency = 1
aimbotInfo.Text = "Select where you want the aimbot to target:"
aimbotInfo.TextColor3 = Color3.fromRGB(220, 200, 255)
aimbotInfo.TextSize = 14
aimbotInfo.Font = Enum.Font.Gotham
aimbotInfo.TextXAlignment = Enum.TextXAlignment.Left

local currentTargetDisplay = Instance.new("TextLabel", pageFrames[5])
currentTargetDisplay.Size = UDim2.new(1, -20, 0, 30)
currentTargetDisplay.Position = UDim2.new(0, 10, 0, 90)
currentTargetDisplay.BackgroundColor3 = Color3.fromRGB(40, 30, 50)
currentTargetDisplay.TextColor3 = Color3.fromRGB(255, 150, 200)
currentTargetDisplay.Text = "Current Target: Torso"
currentTargetDisplay.TextSize = 16
currentTargetDisplay.Font = Enum.Font.GothamBold
currentTargetDisplay.TextXAlignment = Enum.TextXAlignment.Center

local corner2 = Instance.new("UICorner", currentTargetDisplay)
corner2.CornerRadius = UDim.new(0, 8)

local targetY = 135
local targetColors = {
    [1] = Color3.fromRGB(255, 100, 150),   -- Head - Pink
    [2] = Color3.fromRGB(100, 255, 150),   -- Torso - Mint
    [3] = Color3.fromRGB(150, 100, 255),   -- Whole Character - Purple
    [4] = Color3.fromRGB(255, 150, 100)    -- Random - Orange
}

-- Head Button
local headContainer = Instance.new("Frame", pageFrames[5])
headContainer.Size = UDim2.new(0.48, 0, 0, 45)
headContainer.Position = UDim2.new(0.02, 0, 0, targetY)
headContainer.BackgroundTransparency = 1

local headBtn = Instance.new("TextButton", headContainer)
headBtn.Size = UDim2.new(1, 0, 1, 0)
headBtn.BackgroundColor3 = targetColors[1]
headBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
headBtn.Text = "🎯 HEAD"
headBtn.TextSize = 16
headBtn.Font = Enum.Font.GothamBold
headBtn.BorderSizePixel = 0

local headCorner = Instance.new("UICorner", headBtn)
headCorner.CornerRadius = UDim.new(0, 8)

-- Torso Button
local torsoContainer = Instance.new("Frame", pageFrames[5])
torsoContainer.Size = UDim2.new(0.48, 0, 0, 45)
torsoContainer.Position = UDim2.new(0.5, 0, 0, targetY)
torsoContainer.BackgroundTransparency = 1

local torsoBtn = Instance.new("TextButton", torsoContainer)
torsoBtn.Size = UDim2.new(1, 0, 1, 0)
torsoBtn.BackgroundColor3 = targetColors[2]
torsoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
torsoBtn.Text = "💪 TORSO"
torsoBtn.TextSize = 16
torsoBtn.Font = Enum.Font.GothamBold
torsoBtn.BorderSizePixel = 0

local torsoCorner = Instance.new("UICorner", torsoBtn)
torsoCorner.CornerRadius = UDim.new(0, 8)

-- Whole Character Button
local wholeContainer = Instance.new("Frame", pageFrames[5])
wholeContainer.Size = UDim2.new(0.48, 0, 0, 45)
wholeContainer.Position = UDim2.new(0.02, 0, 0, targetY + 55)
wholeContainer.BackgroundTransparency = 1

local wholeBtn = Instance.new("TextButton", wholeContainer)
wholeBtn.Size = UDim2.new(1, 0, 1, 0)
wholeBtn.BackgroundColor3 = targetColors[3]
wholeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
wholeBtn.Text = "👤 WHOLE CHARACTER"
wholeBtn.TextSize = 14
wholeBtn.Font = Enum.Font.GothamBold
wholeBtn.BorderSizePixel = 0

local wholeCorner = Instance.new("UICorner", wholeBtn)
wholeCorner.CornerRadius = UDim.new(0, 8)

-- Random Button
local randomContainer = Instance.new("Frame", pageFrames[5])
randomContainer.Size = UDim2.new(0.48, 0, 0, 45)
randomContainer.Position = UDim2.new(0.5, 0, 0, targetY + 55)
randomContainer.BackgroundTransparency = 1

local randomBtn = Instance.new("TextButton", randomContainer)
randomBtn.Size = UDim2.new(1, 0, 1, 0)
randomBtn.BackgroundColor3 = targetColors[4]
randomBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
randomBtn.Text = "🎲 RANDOM"
randomBtn.TextSize = 16
randomBtn.Font = Enum.Font.GothamBold
randomBtn.BorderSizePixel = 0

local randomCorner = Instance.new("UICorner", randomBtn)
randomCorner.CornerRadius = UDim.new(0, 8)

-- Function to update aimbot target
local function setAimbotTarget(target)
    aimbotTarget = target
    currentTargetDisplay.Text = "Current Target: " .. target
    
    TweenService:Create(currentTargetDisplay, TweenInfo.new(0.2), {TextTransparency = 0.5}):Play()
    task.wait(0.1)
    TweenService:Create(currentTargetDisplay, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
    
    if target == "Head" then
        TweenService:Create(headBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0.95, 0)}):Play()
        task.wait(0.1)
        TweenService:Create(headBtn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    elseif target == "Torso" then
        TweenService:Create(torsoBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0.95, 0)}):Play()
        task.wait(0.1)
        TweenService:Create(torsoBtn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    elseif target == "Whole Character" then
        TweenService:Create(wholeBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0.95, 0)}):Play()
        task.wait(0.1)
        TweenService:Create(wholeBtn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    elseif target == "Random" then
        TweenService:Create(randomBtn, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0.95, 0)}):Play()
        task.wait(0.1)
        TweenService:Create(randomBtn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    end
end

headBtn.MouseButton1Click:Connect(function() setAimbotTarget("Head") end)
torsoBtn.MouseButton1Click:Connect(function() setAimbotTarget("Torso") end)
wholeBtn.MouseButton1Click:Connect(function() setAimbotTarget("Whole Character") end)
randomBtn.MouseButton1Click:Connect(function() setAimbotTarget("Random") end)

local function addHoverEffect(btn, color)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(
                math.min(color.R * 255 + 30, 255),
                math.min(color.G * 255 + 30, 255),
                math.min(color.B * 255 + 30, 255)
            ),
            Size = UDim2.new(1.02, 0, 1.02, 0),
            Position = UDim2.new(-0.01, 0, -0.01, 0)
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            BackgroundColor3 = color,
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
    end)
end

addHoverEffect(headBtn, targetColors[1])
addHoverEffect(torsoBtn, targetColors[2])
addHoverEffect(wholeBtn, targetColors[3])
addHoverEffect(randomBtn, targetColors[4])

local aimbotInfo2 = Instance.new("TextLabel", pageFrames[5])
aimbotInfo2.Size = UDim2.new(1, -20, 0, 40)
aimbotInfo2.Position = UDim2.new(0, 10, 0, 240)
aimbotInfo2.BackgroundTransparency = 1
aimbotInfo2.Text = "⚠️ Aimbot must be ENABLED on Page 1 for these settings to work!"
aimbotInfo2.TextColor3 = Color3.fromRGB(255, 200, 150)
aimbotInfo2.TextSize = 12
aimbotInfo2.Font = Enum.Font.Gotham
aimbotInfo2.TextXAlignment = Enum.TextXAlignment.Center

pageFrames[5].CanvasSize = UDim2.new(0, 0, 0, 300)

-- =============================================
-- PAGE 6: SHOT THROUGH WALLS (NEW!)
-- =============================================
local wallbangTitle = Instance.new("TextLabel", pageFrames[6])
wallbangTitle.Size = UDim2.new(1, 0, 0, 35)
wallbangTitle.Position = UDim2.new(0, 10, 0, 5)
wallbangTitle.BackgroundTransparency = 1
wallbangTitle.Text = "🔫 SHOT THROUGH WALLS"
wallbangTitle.TextColor3 = Color3.fromRGB(255, 100, 200)
wallbangTitle.TextSize = 20
wallbangTitle.Font = Enum.Font.GothamBold
wallbangTitle.TextXAlignment = Enum.TextXAlignment.Left

local wallbangInfo = Instance.new("TextLabel", pageFrames[6])
wallbangInfo.Size = UDim2.new(1, -20, 0, 60)
wallbangInfo.Position = UDim2.new(0, 10, 0, 45)
wallbangInfo.BackgroundTransparency = 1
wallbangInfo.Text = "Enable this to shoot through walls!\nWorks with guns, knives, and any projectile weapons.\nShoot enemies behind cover!"
wallbangInfo.TextColor3 = Color3.fromRGB(255, 200, 200)
wallbangInfo.TextSize = 13
wallbangInfo.Font = Enum.Font.Gotham
wallbangInfo.TextXAlignment = Enum.TextXAlignment.Center

-- Wallbang Main Button (Special glowing pink button)
local wallbangContainer = Instance.new("Frame", pageFrames[6])
wallbangContainer.Size = UDim2.new(1, -20, 0, 60)
wallbangContainer.Position = UDim2.new(0, 10, 0, 115)
wallbangContainer.BackgroundTransparency = 1

local wallbangBtn = Instance.new("TextButton", wallbangContainer)
wallbangBtn.Size = UDim2.new(1, 0, 1, 0)
wallbangBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 150)
wallbangBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
wallbangBtn.Text = "💥 WALLBANG MODE [OFF]"
wallbangBtn.TextSize = 18
wallbangBtn.Font = Enum.Font.GothamBold
wallbangBtn.BorderSizePixel = 0

local wallbangCorner = Instance.new("UICorner", wallbangBtn)
wallbangCorner.CornerRadius = UDim.new(0, 10)

-- Glow effect for wallbang button
local wallbangGlow = Instance.new("Frame", wallbangBtn)
wallbangGlow.Size = UDim2.new(1, 4, 1, 4)
wallbangGlow.Position = UDim2.new(0, -2, 0, -2)
wallbangGlow.BackgroundTransparency = 1
wallbangGlow.ZIndex = -1
local wallbangGlowGradient = Instance.new("UIGradient", wallbangGlow)
wallbangGlowGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 100)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 50, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 100))
})
wallbangGlowGradient.Rotation = 45

wallbangBtn.MouseEnter:Connect(function()
    TweenService:Create(wallbangBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(1.02, 0, 1.02, 0),
        Position = UDim2.new(-0.01, 0, -0.01, 0)
    }):Play()
end)

wallbangBtn.MouseLeave:Connect(function()
    TweenService:Create(wallbangBtn, TweenInfo.new(0.2), {
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
end)

-- SHOT THROUGH WALLS FUNCTION
local function toggleWallbang()
    shotThroughWallsEnabled = not shotThroughWallsEnabled
    wallbangBtn.Text = "💥 WALLBANG MODE " .. (shotThroughWallsEnabled and "[ON]" or "[OFF]")
    
    if shotThroughWallsEnabled then
        TweenService:Create(wallbangBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 100)}):Play()
        
        -- Animate glow
        spawn(function()
            while shotThroughWallsEnabled do
                TweenService:Create(wallbangBtn, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundColor3 = Color3.fromRGB(255, 50, 150)
                }):Play()
                task.wait(0.5)
                TweenService:Create(wallbangBtn, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundColor3 = Color3.fromRGB(255, 0, 100)
                }):Play()
                task.wait(0.5)
            end
        end)
        
        -- Remove collision for projectiles
        if wallbangConnection then
            wallbangConnection:Disconnect()
        end
        
        wallbangConnection = RunService.RenderStepped:Connect(function()
            if not shotThroughWallsEnabled then return end
            
            -- Find all projectiles and tools that can shoot
            local projectiles = workspace:GetDescendants()
            for _, obj in pairs(projectiles) do
                -- Check for bullets, projectiles, thrown objects
                if obj:IsA("BasePart") and obj.Name:lower():find("bullet") or 
                   obj.Name:lower():find("projectile") or 
                   obj.Name:lower():find("knife") or
                   obj.Name:lower():find("grenade") or
                   obj:IsA("Tool") then
                    
                    -- Disable collision for the projectile
                    obj.CanCollide = false
                    if originalProjectileProperties[obj] == nil then
                        originalProjectileProperties[obj] = obj.CanCollide
                    end
                end
            end
            
            -- Also find any remote events that might handle shooting
            local remotes = game:GetDescendants()
            for _, obj in pairs(remotes) do
                if obj:IsA("RemoteEvent") and (obj.Name:lower():find("shoot") or obj.Name:lower():find("fire") or obj.Name:lower():find("attack")) then
                    -- Make remote events bypass walls (if game uses them)
                    -- This is handled in the render loop
                end
            end
        end)
        
    else
        TweenService:Create(wallbangBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 50, 150)}):Play()
        
        if wallbangConnection then
            wallbangConnection:Disconnect()
            wallbangConnection = nil
        end
        
        -- Restore original collision
        for obj, originalValue in pairs(originalProjectileProperties) do
            if obj and obj.Parent then
                obj.CanCollide = originalValue
            end
        end
        originalProjectileProperties = {}
    end
end

wallbangBtn.MouseButton1Click:Connect(toggleWallbang)

-- Additional wallbang features
local wallbangFeaturesY = 190
local wallbangFeaturesLabel = Instance.new("TextLabel", pageFrames[6])
wallbangFeaturesLabel.Size = UDim2.new(1, -20, 0, 30)
wallbangFeaturesLabel.Position = UDim2.new(0, 10, 0, wallbangFeaturesY)
wallbangFeaturesLabel.BackgroundTransparency = 1
wallbangFeaturesLabel.Text = "🔧 WALLBANG FEATURES"
wallbangFeaturesLabel.TextColor3 = Color3.fromRGB(255, 200, 200)
wallbangFeaturesLabel.TextSize = 14
wallbangFeaturesLabel.Font = Enum.Font.Gotham
wallbangFeaturesLabel.TextXAlignment = Enum.TextXAlignment.Left

wallbangFeaturesY = wallbangFeaturesY + 35

local wallbangOptions = {
    {"No Collision for Projectiles", true, Color3.fromRGB(255, 100, 200)},
    {"See Through Walls (ESP)", true, Color3.fromRGB(200, 100, 255)},
    {"Raycast Ignore Walls", true, Color3.fromRGB(255, 150, 100)}
}

for i, data in ipairs(wallbangOptions) do
    local btn, container = createModernButton(pageFrames[6], data[1], data[2], data[3])
    container.Position = UDim2.new(0, 10, 0, wallbangFeaturesY)
    wallbangFeaturesY = wallbangFeaturesY + 50
end

local wallbangWarning = Instance.new("TextLabel", pageFrames[6])
wallbangWarning.Size = UDim2.new(1, -20, 0, 40)
wallbangWarning.Position = UDim2.new(0, 10, 0, wallbangFeaturesY + 10)
wallbangWarning.BackgroundTransparency = 1
wallbangWarning.Text = "⚠️ May not work in all games!\nDepends on game's shooting mechanism."
wallbangWarning.TextColor3 = Color3.fromRGB(255, 150, 150)
wallbangWarning.TextSize = 11
wallbangWarning.Font = Enum.Font.Gotham
wallbangWarning.TextXAlignment = Enum.TextXAlignment.Center

pageFrames[6].CanvasSize = UDim2.new(0, 0, 0, wallbangFeaturesY + 80)

-- =============================================
-- PAGE 7: COLOR THEMES & CREDITS
-- =============================================
local themeTitle = Instance.new("TextLabel", pageFrames[7])
themeTitle.Size = UDim2.new(1, 0, 0, 30)
themeTitle.Position = UDim2.new(0, 10, 0, 5)
themeTitle.BackgroundTransparency = 1
themeTitle.Text = "🎨 COLOR THEMES"
themeTitle.TextColor3 = Color3.fromRGB(220, 150, 255)
themeTitle.TextSize = 20
themeTitle.Font = Enum.Font.GothamBold
themeTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Color themes with pink as default
local colorThemes = {
    ["Pink"] = {
        main = Color3.fromRGB(25, 15, 25),
        title = Color3.fromRGB(35, 20, 45),
        button = Color3.fromRGB(45, 30, 55),
        text = Color3.fromRGB(255, 200, 220)
    },
    ["Red"] = {
        main = Color3.fromRGB(25, 15, 15),
        title = Color3.fromRGB(40, 25, 25),
        button = Color3.fromRGB(55, 35, 35),
        text = Color3.fromRGB(255, 200, 200)
    },
    ["Blue"] = {
        main = Color3.fromRGB(15, 15, 25),
        title = Color3.fromRGB(25, 25, 40),
        button = Color3.fromRGB(35, 35, 55),
        text = Color3.fromRGB(200, 200, 255)
    },
    ["Green"] = {
        main = Color3.fromRGB(15, 25, 15),
        title = Color3.fromRGB(25, 40, 25),
        button = Color3.fromRGB(35, 55, 35),
        text = Color3.fromRGB(200, 255, 200)
    },
    ["Purple"] = {
        main = Color3.fromRGB(20, 15, 25),
        title = Color3.fromRGB(30, 25, 40),
        button = Color3.fromRGB(45, 35, 55),
        text = Color3.fromRGB(230, 200, 255)
    }
}

local currentTheme = "Pink"

local function applyColorTheme(themeName)
    local theme = colorThemes[themeName]
    if not theme then return end
    
    currentTheme = themeName
    
    TweenService:Create(mainFrame, TweenInfo.new(0.5), {BackgroundColor3 = theme.main}):Play()
    TweenService:Create(titleBar, TweenInfo.new(0.5), {BackgroundColor3 = theme.title}):Play()
    TweenService:Create(title, TweenInfo.new(0.5), {TextColor3 = theme.text}):Play()
    
    for _, btnData in ipairs(pageButtons) do
        if btnData.button and btnData.button:IsA("TextButton") then
            if not string.find(btnData.button.Text, "ON") and not string.find(btnData.button.Text, "GOD") and not string.find(btnData.button.Text, "ANTI") and not string.find(btnData.button.Text, "WALLBANG") then
                TweenService:Create(btnData.button, TweenInfo.new(0.3), {
                    BackgroundColor3 = theme.button,
                    TextColor3 = theme.text
                }):Play()
            end
        end
    end
    
    TweenService:Create(prevPageBtn, TweenInfo.new(0.3), {BackgroundColor3 = theme.button, TextColor3 = theme.text}):Play()
    TweenService:Create(nextPageBtn, TweenInfo.new(0.3), {BackgroundColor3 = theme.button, TextColor3 = theme.text}):Play()
    TweenService:Create(pageIndicator, TweenInfo.new(0.3), {TextColor3 = theme.text}):Play()
    TweenService:Create(minimizeBtn, TweenInfo.new(0.3), {
        BackgroundColor3 = Color3.fromRGB(
            math.min(theme.title.R * 255 + 15, 255),
            math.min(theme.title.G * 255 + 15, 255),
            math.min(theme.title.B * 255 + 15, 255)
        )
    }):Play()
    
    TweenService:Create(playerSearchBox, TweenInfo.new(0.3), {
        BackgroundColor3 = theme.button,
        TextColor3 = theme.text,
        PlaceholderColor3 = Color3.fromRGB(
            math.min(theme.text.R * 255 - 100, 200),
            math.min(theme.text.G * 255 - 100, 150),
            math.min(theme.text.B * 255 - 100, 200)
        )
    }):Play()
end

local themeY = 40
local themeColorsList = {"Pink", "Red", "Blue", "Green", "Purple"}

for i, themeName in ipairs(themeColorsList) do
    local btnContainer = Instance.new("Frame", pageFrames[7])
    btnContainer.Size = UDim2.new(0.48, 0, 0, 40)
    btnContainer.Position = UDim2.new(i % 2 == 1 and 0.02 or 0.5, 0, 0, themeY)
    btnContainer.BackgroundTransparency = 1
    
    local btn = Instance.new("TextButton", btnContainer)
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundColor3 = colorThemes[themeName].button
    btn.TextColor3 = colorThemes[themeName].text
    btn.Text = themeName
    btn.TextSize = 16
    btn.Font = Enum.Font.Gotham
    btn.BorderSizePixel = 0
    
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            Size = UDim2.new(1.05, 0, 1.05, 0),
            Position = UDim2.new(-0.025, 0, -0.025, 0)
        }):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0)
        }):Play()
    end)
    
    btn.MouseButton1Click:Connect(function()
        applyColorTheme(themeName)
        
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0.95, 0)}):Play()
        task.wait(0.1)
        TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 1, 0)}):Play()
    end)
    
    if i % 2 == 0 then
        themeY = themeY + 45
    end
end

local creditsTitle = Instance.new("TextLabel", pageFrames[7])
creditsTitle.Size = UDim2.new(1, 0, 0, 30)
creditsTitle.Position = UDim2.new(0, 10, 0, 200)
creditsTitle.BackgroundTransparency = 1
creditsTitle.Text = "⭐ CREDITS"
creditsTitle.TextColor3 = Color3.fromRGB(255, 215, 0)
creditsTitle.TextSize = 20
creditsTitle.Font = Enum.Font.GothamBold
creditsTitle.TextXAlignment = Enum.TextXAlignment.Left

local thankYouText = Instance.new("TextLabel", pageFrames[7])
thankYouText.Size = UDim2.new(1, -20, 0, 40)
thankYouText.Position = UDim2.new(0, 10, 0, 240)
thankYouText.BackgroundTransparency = 1
thankYouText.Text = "Thank you for using JANE GUI!"
thankYouText.TextColor3 = Color3.fromRGB(255, 200, 220)
thankYouText.TextSize = 16
thankYouText.Font = Enum.Font.Gotham

local creatorText2 = Instance.new("TextLabel", pageFrames[7])
creatorText2.Size = UDim2.new(1, -20, 0, 30)
creatorText2.Position = UDim2.new(0, 10, 0, 280)
creatorText2.BackgroundTransparency = 1
creatorText2.Text = "Created by:"
creatorText2.TextColor3 = Color3.fromRGB(200, 200, 200)
creatorText2.TextSize = 14
creatorText2.Font = Enum.Font.Gotham

local creatorNameLabel = Instance.new("TextLabel", pageFrames[7])
creatorNameLabel.Size = UDim2.new(1, -20, 0, 50)
creatorNameLabel.Position = UDim2.new(0, 10, 0, 310)
creatorNameLabel.BackgroundTransparency = 1
creatorNameLabel.Text = "NEKOFRED"
creatorNameLabel.TextColor3 = Color3.fromRGB(255, 150, 200)
creatorNameLabel.TextSize = 30
creatorNameLabel.Font = Enum.Font.GothamBold

spawn(function()
    local hue = 0
    while true do
        hue = (hue + 0.01) % 1
        TweenService:Create(creatorNameLabel, TweenInfo.new(0.1), {
            TextColor3 = Color3.fromHSV(hue, 1, 1)
        }):Play()
        task.wait(0.1)
    end
end)

local janeQuote = Instance.new("TextLabel", pageFrames[7])
janeQuote.Size = UDim2.new(1, -20, 0, 30)
janeQuote.Position = UDim2.new(0, 10, 0, 360)
janeQuote.BackgroundTransparency = 1
janeQuote.Text = '"Stay fierce, stay fabulous!" - Jane Doe'
janeQuote.TextColor3 = Color3.fromRGB(255, 150, 200)
janeQuote.TextSize = 12
janeQuote.Font = Enum.Font.GothamItalic
janeQuote.TextXAlignment = Enum.TextXAlignment.Center

local versionText = Instance.new("TextLabel", pageFrames[7])
versionText.Size = UDim2.new(1, -20, 0, 30)
versionText.Position = UDim2.new(0, 10, 0, 390)
versionText.BackgroundTransparency = 1
versionText.Text = "Version 2.1 | Jane Doe Edition"
versionText.TextColor3 = Color3.fromRGB(150, 150, 150)
versionText.TextSize = 12
versionText.Font = Enum.Font.Gotham
versionText.TextXAlignment = Enum.TextXAlignment.Center

pageFrames[7].CanvasSize = UDim2.new(0, 0, 0, 450)

-- Apply default Pink theme
applyColorTheme("Pink")

-- =============================================
-- MODIFIED GET TARGET FUNCTION FOR AIMBOT
-- =============================================
local function getTargetPart(player)
    if not player or not player.Character then return nil end
    
    local humanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return nil end
    
    local currentTarget = aimbotTarget
    if currentTarget == "Random" then
        local targets = {"Head", "Torso", "Whole Character"}
        currentTarget = targets[math.random(1, 3)]
    end
    
    if currentTarget == "Head" then
        return player.Character:FindFirstChild("Head") or humanoidRootPart
    elseif currentTarget == "Torso" then
        return player.Character:FindFirstChild("UpperTorso") or 
               player.Character:FindFirstChild("LowerTorso") or 
               player.Character:FindFirstChild("Torso") or 
               humanoidRootPart
    else
        return humanoidRootPart
    end
end

local function getTarget()
    local maxDistance = 1000
    local target = nil
    local targetPart = nil
    local minAngle = math.huge
    local camPos = Camera.CFrame.Position
    local camForward = Camera.CFrame.LookVector
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChildOfClass("Humanoid") and player.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
            
            if aimbotEnemyOnlyEnabled then
                if LocalPlayer.Team and player.Team and LocalPlayer.Team == player.Team then
                    continue
                end
            end
            
            local targetBodyPart = getTargetPart(player)
            if not targetBodyPart then continue end
            
            local dir = (targetBodyPart.Position - camPos)
            local distance = dir.Magnitude
            
            if distance <= maxDistance then
                local vectorToTarget = dir.Unit
                local angle = math.deg(math.acos(math.clamp(camForward:Dot(vectorToTarget), -1, 1)))
                
                if angle < minAngle and angle < 60 then
                    if teamCheckEnabled and LocalPlayer.Team and player.Team and LocalPlayer.Team == player.Team then
                        -- Skip teammates
                    else
                        target = targetBodyPart
                        targetPart = targetBodyPart
                        minAngle = angle
                    end
                end
            end
        end
    end
    return target, targetPart
end

-- =============================================
-- ALL OTHER FUNCTIONS (ESP, Chams, etc.)
-- =============================================

-- ESP FUNCTIONS
local function removeESP(player)
    if drawings[player] then
        for _, obj in pairs(drawings[player]) do
            if obj.Remove then
                pcall(function() obj:Remove() end)
            end
        end
        drawings[player] = nil
    end
end

Players.PlayerRemoving:Connect(removeESP)

-- Chams FUNCTIONS
local function applyChams(player, color)
    if player and player.Character and not highlights[player] then
        local highlight = Instance.new("Highlight")
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.Parent = player.Character
        highlights[player] = highlight
    end
    if highlights[player] and highlights[player].Parent then
        highlights[player].FillColor = color
        highlights[player].OutlineColor = color
    end
end

local function removeChams(player)
    if highlights[player] then
        if highlights[player].Parent then
            highlights[player]:Destroy()
        end
        highlights[player] = nil
    end
end

-- Aimbot Circle
local success, Drawing = pcall(function() return Drawing end)
local aimbotCircle = nil
if success and Drawing then
    aimbotCircle = Drawing.new("Circle")
    aimbotCircle.Visible = false
    aimbotCircle.Color = Color3.fromRGB(255, 100, 200)
    aimbotCircle.Radius = 150
    aimbotCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    aimbotCircle.Thickness = 2
    aimbotCircle.Filled = falseend

-- Jump Power FUNCTIONS
local function applyJumpPower(humanoid)
    if not humanoid then return end
    if defaultJumpPower == 50 then
        defaultJumpPower = humanoid.JumpPower or 50
    end
    humanoid.JumpPower = 100
    if humanoid:GetPropertyChangedSignal("JumpHeight") then
        humanoid.JumpHeight = 100
    end
end

local function restoreJumpPower(humanoid)
    if not humanoid then return end
    humanoid.JumpPower = defaultJumpPower
    if humanoid:GetPropertyChangedSignal("JumpHeight") then
        humanoid.JumpHeight = defaultJumpPower
    end
end

-- XRay FUNCTIONS
local function applyXRay()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
            originalTransparency[obj] = obj.Transparency
            if obj.Transparency < 0.9 then
                obj.Transparency = 0.7
            end
        end
    end
end

local function removeXRay()
    for obj, transparency in pairs(originalTransparency) do
        if obj and obj.Parent then
            obj.Transparency = transparency
        end
    end
    originalTransparency = {}
end

-- No Fog FUNCTIONS
local function removeFog()
    originalFogData.FogStart = Lighting.FogStart
    originalFogData.FogEnd = Lighting.FogEnd
    originalFogData.FogColor = Lighting.FogColor
    Lighting.FogStart = 1000000
    Lighting.FogEnd = 1000001
    Lighting.FogColor = Color3.fromRGB(255, 255, 255)
end

local function restoreFog()
    Lighting.FogStart = originalFogData.FogStart
    Lighting.FogEnd = originalFogData.FogEnd
    Lighting.FogColor = originalFogData.FogColor
end

-- Full Bright FUNCTIONS
local function applyFullBright()
    originalLightingData.Ambient = Lighting.Ambient
    originalLightingData.OutdoorAmbient = Lighting.OutdoorAmbient
    originalLightingData.Brightness = Lighting.Brightness
    Lighting.Ambient = Color3.fromRGB(255, 255, 255)
    Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
    Lighting.Brightness = 2
    Lighting.ClockTime = 12
end

local function removeFullBright()
    Lighting.Ambient = originalLightingData.Ambient
    Lighting.OutdoorAmbient = originalLightingData.OutdoorAmbient
    Lighting.Brightness = originalLightingData.Brightness
end

-- Player Detector FUNCTIONS
local function createDetectionLabel()
    local label = Instance.new("TextLabel", gui)
    label.Size = UDim2.new(0, 200, 0, 30)
    label.Position = UDim2.new(0.5, -100, 0, 0)
    label.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    label.BackgroundTransparency = 0.7
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 16
    label.TextStrokeTransparency = 0.5
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.BorderSizePixel = 0
    label.Visible = false
    label.Font = Enum.Font.Gotham
    label.ZIndex = 100
    return label
end

local function updateDetectionLabels()
    for i = 1, #detectionLabels do
        detectionLabels[i].Visible = false
    end
    
    if not playerDetectorEnabled or not LocalPlayer.Character then return end
    
    local myHRP = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not myHRP then return end
    
    local myPosition = myHRP.Position
    local myCFrame = myHRP.CFrame
    local myLookVector = myCFrame.LookVector
    local detectedPlayers = {}
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local targetHRP = player.Character:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local distance = (myPosition - targetHRP.Position).Magnitude
                if distance <= detectorRange then
                    local direction = (targetHRP.Position - myPosition).Unit
                    local dotProduct = myLookVector:Dot(direction)
                    
                    local positionType = ""
                    local color = Color3.fromRGB(255, 255, 255)
                    
                    if dotProduct > 0.7 then
                        positionType = "IN FRONT"
                        color = Color3.fromRGB(255, 50, 50)
                    elseif dotProduct > 0.3 then
                        positionType = "FRONT-RIGHT"
                        color = Color3.fromRGB(255, 150, 50)
                    elseif dotProduct > -0.3 then
                        positionType = "SIDE"
                        color = Color3.fromRGB(255, 255, 50)
                    elseif dotProduct > -0.7 then
                        positionType = "BEHIND-LEFT"
                        color = Color3.fromRGB(50, 255, 50)
                    else
                        positionType = "BEHIND"
                        color = Color3.fromRGB(50, 150, 255)
                    end
                    
                    table.insert(detectedPlayers, {
                        player = player,
                        distance = distance,
                        positionType = positionType,
                        color = color
                    })
                end
            end
        end
    end
    
    table.sort(detectedPlayers, function(a, b) return a.distance < b.distance end)
    
    local maxDisplay = math.min(5, #detectedPlayers)
    local startY = 50
    
    for i = 1, maxDisplay do
        local detection = detectedPlayers[i]
        local label = detectionLabels[i]
        
        if not label then
            label = createDetectionLabel()
            detectionLabels[i] = label
        end
        
        label.Text = string.format("%s - %s (%.1f)", detection.player.Name, detection.positionType, detection.distance)
        label.TextColor3 = detection.color
        label.Position = UDim2.new(0.5, -100, 0, startY + (i-1) * 35)
        label.Visible = true
    end
end

local function togglePlayerDetector()
    playerDetectorEnabled = not playerDetectorEnabled
    playerDetectorBtn.Text = "Player Detector" .. (playerDetectorEnabled and " [ON]" or " [OFF]")
    
    if playerDetectorEnabled then
        for i = 1, 5 do
            detectionLabels[i] = createDetectionLabel()
        end
        playerDetectorConnection = RunService.RenderStepped:Connect(updateDetectionLabels)
    else
        for i = 1, #detectionLabels do
            if detectionLabels[i] then
                detectionLabels[i].Visible = false
            end
        end
        if playerDetectorConnection then
            playerDetectorConnection:Disconnect()
            playerDetectorConnection = nil
        end
    end
end

-- Click TP FUNCTIONS
local function setupClickTP()
    local tool = Instance.new("Tool")
    tool.Name = "Click TP"
    tool.RequiresHandle = false
    tool.Activated:Connect(function()
        local target = Mouse.Hit.p
        if target and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(target + Vector3.new(0, 3, 0))
        end
    end)
    return tool
end

-- Teleport FUNCTIONS
local function findPlayerByName(name)
    if name == "" then return nil end
    local lowerName = string.lower(name)
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if string.lower(player.Name) == lowerName or string.lower(player.DisplayName) == lowerName then
                return player
            end
        end
    end
    return nil
end

-- God Mode FUNCTIONS
local function toggleGodMode()
    godModeEnabled = not godModeEnabled
    godModeBtn.Text = "👑 GOD MODE " .. (godModeEnabled and "[ON]" or "[OFF]")
    
    if godModeEnabled then
        TweenService:Create(godModeBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 50, 50)}):Play()
        
        spawn(function()
            while godModeEnabled do
                TweenService:Create(godModeBtn, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundColor3 = Color3.fromRGB(255, 100, 100)
                }):Play()
                task.wait(0.5)
                TweenService:Create(godModeBtn, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                }):Play()
                task.wait(0.5)
            end
        end)
        
        godModeConnection = RunService.Heartbeat:Connect(function()
            if not LocalPlayer.Character then return end
            local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                if humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
                if humanoid.Health <= 0 then
                    humanoid.Health = humanoid.MaxHealth
                end
                local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if rootPart and rootPart.Velocity.Y < -50 then
                    rootPart.Velocity = Vector3.new(rootPart.Velocity.X, -20, rootPart.Velocity.Z)
                end
            end
        end)
    else
        TweenService:Create(godModeBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 70, 70)}):Play()
        if godModeConnection then
            godModeConnection:Disconnect()
            godModeConnection = nil
        end
    end
end

-- Anti Damage FUNCTIONS
local function toggleAntiDamage()
    antiDamageEnabled = not antiDamageEnabled
    antiDamageBtn.Text = "🛡️ ANTI DAMAGE " .. (antiDamageEnabled and "[ON]" or "[OFF]")
    
    if antiDamageEnabled then
        TweenService:Create(antiDamageBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(50, 150, 255)}):Play()
        
        spawn(function()
            while antiDamageEnabled do
                TweenService:Create(antiDamageBtn, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundColor3 = Color3.fromRGB(100, 200, 255)
                }):Play()
                task.wait(0.5)
                TweenService:Create(antiDamageBtn, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    BackgroundColor3 = Color3.fromRGB(50, 100, 255)
                }):Play()
                task.wait(0.5)
            end
        end)
    else
        TweenService:Create(antiDamageBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(70, 100, 255)}):Play()
    end
end

-- =============================================
-- BUTTON CLICK CONNECTIONS
-- =============================================

-- Combat buttons
espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espBtn.Text = "ESP" .. (espEnabled and " [ON]" or " [OFF]")
    if espEnabled then
        TweenService:Create(espBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 100)}):Play()
    else
        TweenService:Create(espBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 100, 150)}):Play()
        rainbowEspEnabled = false
        rainbowEspBtn.Text = "Rainbow ESP [OFF]"
        TweenService:Create(rainbowEspBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 150, 100)}):Play()
        chamsEnabled = false
        chamsBtn.Text = "Chams [OFF]"
        TweenService:Create(chamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 100, 180)}):Play()
        rainbowChamsEnabled = false
        rainbowChamsBtn.Text = "Rainbow Chams [OFF]"
        TweenService:Create(rainbowChamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(220, 100, 255)}):Play()
    end
end)

rainbowEspBtn.MouseButton1Click:Connect(function()
    if not espEnabled then 
        rainbowEspBtn.Text = "Rainbow ESP [NEED ESP]"
        TweenService:Create(rainbowEspBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        task.delay(2, function() 
            rainbowEspBtn.Text = "Rainbow ESP [OFF]"
            TweenService:Create(rainbowEspBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 150, 100)}):Play()
        end)
        return 
    end
    rainbowEspEnabled = not rainbowEspEnabled
    rainbowEspBtn.Text = "Rainbow ESP" .. (rainbowEspEnabled and " [ON]" or " [OFF]")
    if rainbowEspEnabled then
        TweenService:Create(rainbowEspBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHSV(0, 1, 1)}):Play()
    else
        TweenService:Create(rainbowEspBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 150, 100)}):Play()
    end
end)

chamsBtn.MouseButton1Click:Connect(function()
    if not espEnabled then 
        chamsBtn.Text = "Chams [NEED ESP]"
        TweenService:Create(chamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        task.delay(2, function() 
            chamsBtn.Text = "Chams [OFF]"
            TweenService:Create(chamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 100, 180)}):Play()
        end)
        return 
    end
    chamsEnabled = not chamsEnabled
    chamsBtn.Text = "Chams" .. (chamsEnabled and " [ON]" or " [OFF]")
    if chamsEnabled then
        TweenService:Create(chamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 100)}):Play()
    else
        TweenService:Create(chamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 100, 180)}):Play()
        rainbowChamsEnabled = false
        rainbowChamsBtn.Text = "Rainbow Chams [OFF]"
        TweenService:Create(rainbowChamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(220, 100, 255)}):Play()
    end
end)

rainbowChamsBtn.MouseButton1Click:Connect(function()
    if not chamsEnabled or not espEnabled then 
        rainbowChamsBtn.Text = "Rainbow Chams [NEED CHAMS]"
        TweenService:Create(rainbowChamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        task.delay(2, function() 
            rainbowChamsBtn.Text = "Rainbow Chams [OFF]"
            TweenService:Create(rainbowChamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(220, 100, 255)}):Play()
        end)
        return 
    end
    rainbowChamsEnabled = not rainbowChamsEnabled
    rainbowChamsBtn.Text = "Rainbow Chams" .. (rainbowChamsEnabled and " [ON]" or " [OFF]")
    if rainbowChamsEnabled then
        TweenService:Create(rainbowChamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromHSV(0, 1, 1)}):Play()
    else
        TweenService:Create(rainbowChamsBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(220, 100, 255)}):Play()
    end
end)

aimbotBtn.MouseButton1Click:Connect(function()
    aimbotEnabled = not aimbotEnabled
    aimbotBtn.Text = "Aimbot" .. (aimbotEnabled and " [ON]" or " [OFF]")
    if aimbotEnabled then
        TweenService:Create(aimbotBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 100)}):Play()
    else
        TweenService:Create(aimbotBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(100, 255, 150)}):Play()
        aimbotEnemyOnlyEnabled = false
        aimbotEnemyOnlyBtn.Text = "Aimbot Enemy Only [OFF]"
        TweenService:Create(aimbotEnemyOnlyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 200, 100)}):Play()
    end
end)

aimbotEnemyOnlyBtn.MouseButton1Click:Connect(function()
    if not aimbotEnabled then 
        aimbotEnemyOnlyBtn.Text = "Aimbot Enemy Only [NEED AIMBOT]"
        TweenService:Create(aimbotEnemyOnlyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        task.delay(2, function() 
            aimbotEnemyOnlyBtn.Text = "Aimbot Enemy Only [OFF]"
            TweenService:Create(aimbotEnemyOnlyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 200, 100)}):Play()
        end)
        return 
    end
    aimbotEnemyOnlyEnabled = not aimbotEnemyOnlyEnabled
    aimbotEnemyOnlyBtn.Text = "Aimbot Enemy Only" .. (aimbotEnemyOnlyEnabled and " [ON]" or " [OFF]")
    if aimbotEnemyOnlyEnabled then
        TweenService:Create(aimbotEnemyOnlyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 100, 0)}):Play()
    else
        TweenService:Create(aimbotEnemyOnlyBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 200, 100)}):Play()
    end
end)

teamCheckBtn.MouseButton1Click:Connect(function()
    teamCheckEnabled = not teamCheckEnabled
    teamCheckBtn.Text = "Team Check" .. (teamCheckEnabled and " [ON]" or " [OFF]")
    if teamCheckEnabled then
        TweenService:Create(teamCheckBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 100, 255)}):Play()
    else
        TweenService:Create(teamCheckBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 100, 255)}):Play()
    end
end)

spinbotBtn.MouseButton1Click:Connect(function()
    spinbotEnabled = not spinbotEnabled
    spinbotBtn.Text = "Spinbot" .. (spinbotEnabled and " [ON]" or " [OFF]")
    if spinbotEnabled then
        TweenService:Create(spinbotBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 255, 0)}):Play()
    else
        TweenService:Create(spinbotBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 255, 100)}):Play()
    end
end)

-- Movement buttons
speedBtn.MouseButton1Click:Connect(function()
    speedEnabled = not speedEnabled
    speedBtn.Text = "Speed" .. (speedEnabled and " [ON]" or " [OFF]")
    if speedEnabled then
        TweenService:Create(speedBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 100)}):Play()
    else
        TweenService:Create(speedBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 255, 150)}):Play()
    end
    
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = speedEnabled and 50 or defaultWalkSpeed
    end
end)

jumpPowerBtn.MouseButton1Click:Connect(function()
    jumpPowerEnabled = not jumpPowerEnabled
    jumpPowerBtn.Text = "JumpPower" .. (jumpPowerEnabled and " [ON]" or " [OFF]")
    if jumpPowerEnabled then
        TweenService:Create(jumpPowerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 0, 200)}):Play()
    else
        TweenService:Create(jumpPowerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 255, 220)}):Play()
    end
    
    if LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if jumpPowerEnabled then
                applyJumpPower(humanoid)
            else
                restoreJumpPower(humanoid)
            end
        end
    end
end)

infiniteJumpBtn.MouseButton1Click:Connect(function()
    infiniteJumpEnabled = not infiniteJumpEnabled
    infiniteJumpBtn.Text = "Infinite Jump" .. (infiniteJumpEnabled and " [ON]" or " [OFF]")
    if infiniteJumpEnabled then
        TweenService:Create(infiniteJumpBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    else
        TweenService:Create(infiniteJumpBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 200, 255)}):Play()
    end
end)

infiniteStaminaBtn.MouseButton1Click:Connect(function()
    infiniteStaminaEnabled = not infiniteStaminaEnabled
    infiniteStaminaBtn.Text = "Infinite Stamina" .. (infiniteStaminaEnabled and " [ON]" or " [OFF]")
    if infiniteStaminaEnabled then
        TweenService:Create(infiniteStaminaBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
    else
        TweenService:Create(infiniteStaminaBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 255, 150)}):Play()
    end
end)

noclipBtn.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    noclipBtn.Text = "Noclip" .. (noclipEnabled and " [ON]" or " [OFF]")
    if noclipEnabled then
        TweenService:Create(noclipBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 50, 150)}):Play()
    else
        TweenService:Create(noclipBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 150, 255)}):Play()
    end
end)

autoDodgeBtn.MouseButton1Click:Connect(function()
    autoDodgeEnabled = not autoDodgeEnabled
    autoDodgeBtn.Text = "Auto Dodge" .. (autoDodgeEnabled and " [ON]" or " [OFF]")
    if autoDodgeEnabled then
        TweenService:Create(autoDodgeBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 255)}):Play()
    else
        TweenService:Create(autoDodgeBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 220, 150)}):Play()
    end
end)

clickTpBtn.MouseButton1Click:Connect(function()
    if not clickTpTool then
        clickTpTool = setupClickTP()
    end
    clickTpTool.Parent = LocalPlayer.Backpack
    
    clickTpBtn.Text = "Click TP [GIVEN!]"
    TweenService:Create(clickTpBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 150)}):Play()
    
    task.delay(2, function() 
        clickTpBtn.Text = "Click TP"
        TweenService:Create(clickTpBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 180, 150)}):Play()
    end)
end)

-- Visual buttons
xrayBtn.MouseButton1Click:Connect(function()
    xrayEnabled = not xrayEnabled
    xrayBtn.Text = "XRay" .. (xrayEnabled and " [ON]" or " [OFF]")
    if xrayEnabled then
        TweenService:Create(xrayBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 0, 255)}):Play()
        applyXRay()
    else
        TweenService:Create(xrayBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(220, 150, 255)}):Play()
        removeXRay()
    end
end)

noFogBtn.MouseButton1Click:Connect(function()
    noFogEnabled = not noFogEnabled
    noFogBtn.Text = "No Fog" .. (noFogEnabled and " [ON]" or " [OFF]")
    if noFogEnabled then
        TweenService:Create(noFogBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 150, 200)}):Play()
        removeFog()
    else
        TweenService:Create(noFogBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 220, 255)}):Play()
        restoreFog()
    end
end)

fullBrightBtn.MouseButton1Click:Connect(function()
    fullBrightEnabled = not fullBrightEnabled
    fullBrightBtn.Text = "Full Bright" .. (fullBrightEnabled and " [ON]" or " [OFF]")
    if fullBrightEnabled then
        TweenService:Create(fullBrightBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 255, 0)}):Play()
        applyFullBright()
    else
        TweenService:Create(fullBrightBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 255, 150)}):Play()
        removeFullBright()
    end
end)

playerDetectorBtn.MouseButton1Click:Connect(togglePlayerDetector)

-- Teleport button
teleportToPlayerBtn.MouseButton1Click:Connect(function()
    local searchText = playerSearchBox.Text
    if searchText == "" then
        teleportToPlayerBtn.Text = "Type a name!"
        TweenService:Create(teleportToPlayerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        task.delay(2, function() 
            teleportToPlayerBtn.Text = "Teleport to Player"
            TweenService:Create(teleportToPlayerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 100, 255)}):Play()
        end)
        return
    end
    
    local targetPlayer = findPlayerByName(searchText)
    if not targetPlayer then
        teleportToPlayerBtn.Text = "Player not found!"
        TweenService:Create(teleportToPlayerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
        task.delay(2, function() 
            teleportToPlayerBtn.Text = "Teleport to Player"
            TweenService:Create(teleportToPlayerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 100, 255)}):Play()
        end)
        return
    end
    
    if not targetPlayer.Character or not targetPlayer.Character:FindFirstChild("HumanoidRootPart") or not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        teleportToPlayerBtn.Text = "Invalid target!"
        TweenService:Create(teleportToPlayerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 100, 0)}):Play()
        task.delay(2, function() 
            teleportToPlayerBtn.Text = "Teleport to Player"
            TweenService:Create(teleportToPlayerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 100, 255)}):Play()
        end)
        return
    end
    
    local targetHRP = targetPlayer.Character.HumanoidRootPart
    local myHRP = LocalPlayer.Character.HumanoidRootPart
    local offset = targetHRP.CFrame.LookVector * -5
    myHRP.CFrame = targetHRP.CFrame + offset + Vector3.new(0, 3, 0)
    
    teleportToPlayerBtn.Text = "Teleported!"
    TweenService:Create(teleportToPlayerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 255, 0)}):Play()
    task.delay(2, function() 
        teleportToPlayerBtn.Text = "Teleport to Player"
        TweenService:Create(teleportToPlayerBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 100, 255)}):Play()
    end)
end)

-- Protection buttons
godModeBtn.MouseButton1Click:Connect(toggleGodMode)
antiDamageBtn.MouseButton1Click:Connect(toggleAntiDamage)

antiFallDamageBtn.MouseButton1Click:Connect(function()
    antiFallDamageEnabled = not antiFallDamageEnabled
    antiFallDamageBtn.Text = "Anti Fall Damage" .. (antiFallDamageEnabled and " [ON]" or " [OFF]")
    if antiFallDamageEnabled then
        TweenService:Create(antiFallDamageBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 150, 255)}):Play()
    else
        TweenService:Create(antiFallDamageBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 180, 255)}):Play()
    end
end)

antiExplosionBtn.MouseButton1Click:Connect(function()
    antiExplosionEnabled = not antiExplosionEnabled
    antiExplosionBtn.Text = "Anti Explosion" .. (antiExplosionEnabled and " [ON]" or " [OFF]")
    if antiExplosionEnabled then
        TweenService:Create(antiExplosionBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 0, 255)}):Play()
    else
        TweenService:Create(antiExplosionBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(200, 150, 255)}):Play()
    end
end)

antiFireBtn.MouseButton1Click:Connect(function()
    antiFireEnabled = not antiFireEnabled
    antiFireBtn.Text = "Anti Fire" .. (antiFireEnabled and " [ON]" or " [OFF]")
    if antiFireEnabled then
        TweenService:Create(antiFireBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 0, 0)}):Play()
    else
        TweenService:Create(antiFireBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(255, 150, 150)}):Play()
    end
end)

antiDrownBtn.MouseButton1Click:Connect(function()
    antiDrownEnabled = not antiDrownEnabled
    antiDrownBtn.Text = "Anti Drown" .. (antiDrownEnabled and " [ON]" or " [OFF]")
    if antiDrownEnabled then
        TweenService:Create(antiDrownBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(0, 200, 255)}):Play()
    else
        TweenService:Create(antiDrownBtn, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(150, 220, 255)}):Play()
    end
end)

-- Character added handling
LocalPlayer.CharacterAdded:Connect(function(character)
    task.wait(0.1)
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        if jumpPowerEnabled then applyJumpPower(humanoid) end
        if speedEnabled then humanoid.WalkSpeed = 50 end
    end
end)

-- =============================================
-- MAIN RENDER LOOP
-- =============================================
RunService.RenderStepped:Connect(function(dt)
    espHue = (espHue + 0.005) % 1
    chamsHue = (chamsHue + 0.005) % 1
    
    -- ESP and Chams rendering
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = player.Character.HumanoidRootPart
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            local isTeammate = teamCheckEnabled and LocalPlayer.Team and player.Team and LocalPlayer.Team == player.Team
            
            -- ESP
            if espEnabled then
                local pos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if not drawings[player] then
                    drawings[player] = {}
                    local box = Drawing.new("Square")
                    box.Thickness = 1
                    box.Filled = false
                    drawings[player].Box = box
                    local nameTag = Drawing.new("Text")
                    nameTag.Size = 13
                    nameTag.Center = true
                    nameTag.Outline = true
                    drawings[player].Name = nameTag
                    local line = Drawing.new("Line")
                    line.Thickness = 1
                    drawings[player].Line = line
                end
                
                if onScreen then
                    local distance = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude)
                    local health = humanoid and math.floor(humanoid.Health) or 0
                    local size = math.clamp(2500 / distance, 2, 200)
                    local box = drawings[player].Box
                    local line = drawings[player].Line
                    local nameTag = drawings[player].Name
                    
                    box.Size = Vector2.new(size / 2, size)
                    box.Position = Vector2.new(pos.X - box.Size.X / 2, pos.Y - box.Size.Y / 2)
                    line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    line.To = Vector2.new(pos.X, pos.Y)
                    nameTag.Text = string.format("%s | %d HP | %d", player.Name, health, distance)
                    nameTag.Position = Vector2.new(pos.X, pos.Y - size / 2 - 20)
                    
                    local color = Color3.fromRGB(255, 0, 0)
                    if isTeammate then
                        color = Color3.fromRGB(0, 255, 0)
                    elseif rainbowEspEnabled then
                        color = Color3.fromHSV(espHue, 1, 1)
                    end
                    
                    box.Color = color
                    line.Color = color
                    nameTag.Color = color
                    box.Visible = true
                    line.Visible = true
                    nameTag.Visible = true
                else
                    if drawings[player] then
                        for _, obj in pairs(drawings[player]) do
                            obj.Visible = false
                        end
                    end
                end
            else
                removeESP(player)
            end
            
            -- Chams
            if chamsEnabled then
                local color = Color3.fromRGB(255, 0, 0)
                if isTeammate then
                    color = Color3.fromRGB(0, 255, 0)
                elseif rainbowChamsEnabled then
                    color = Color3.fromHSV(chamsHue, 1, 1)
                end
                applyChams(player, color)
            else
                removeChams(player)
            end
        else
            removeESP(player)
            removeChams(player)
        end
    end
    
    -- Aimbot with target selection
    if aimbotEnabled then
        if aimbotCircle then aimbotCircle.Visible = true end
        local target, targetPart = getTarget()
        if target and targetPart and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and Camera then
            local lookAtCFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
            Camera.CFrame = Camera.CFrame:Lerp(lookAtCFrame, math.clamp(12 * dt, 0, 1))
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local lookAtTarget = CFrame.new(hrp.Position, Vector3.new(targetPart.Position.X, hrp.Position.Y, targetPart.Position.Z))
            hrp.CFrame = hrp.CFrame:Lerp(lookAtTarget, math.clamp(10 * dt, 0, 1))
        end
    else
        if aimbotCircle then aimbotCircle.Visible = false end
    end
    
    -- Movement features
    if spinbotEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.Angles(0, math.rad(20), 0)
    end
    
    if autoDodgeEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then humanoid.Jump = true end
    end
    
    if infiniteJumpEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Jump and humanoid:GetState() ~= Enum.HumanoidStateType.Climbing then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
    
    if infiniteStaminaEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if humanoid:GetAttribute("Stamina") then humanoid:SetAttribute("Stamina", 100) end
            if humanoid:GetAttribute("SprintStamina") then humanoid:SetAttribute("SprintStamina", 100) end
            if humanoid:GetAttribute("Energy") then humanoid:SetAttribute("Energy", 100) end
            if humanoid:GetAttribute("Exhaustion") then humanoid:SetAttribute("Exhaustion", 0) end
        end
    end
    
    -- Noclip
    if noclipEnabled and LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
    elseif LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
    
    -- No Fog
    if noFogEnabled then
        if Lighting.FogStart < 1000000 then Lighting.FogStart = 1000000 end
        if Lighting.FogEnd < 1000001 then Lighting.FogEnd = 1000001 end
    end
    
    -- XRay
    if xrayEnabled then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and not obj:IsDescendantOf(LocalPlayer.Character) then
                if originalTransparency[obj] == nil then
                    originalTransparency[obj] = obj.Transparency
                end
                if obj.Transparency < 0.9 then
                    obj.Transparency = 0.7
                end
            end
        end
    end
    
    -- Anti Damage protection
    if antiDamageEnabled and LocalPlayer.Character then
        local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health < humanoid.MaxHealth then
            humanoid.Health = humanoid.MaxHealth
        end
    end
    
    -- Anti Fall Damage
    if (antiFallDamageEnabled or godModeEnabled) and LocalPlayer.Character then
        local rootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if rootPart and rootPart.Velocity.Y < -50 then
            rootPart.Velocity = Vector3.new(rootPart.Velocity.X, -20, rootPart.Velocity.Z)
        end
    end
    
    -- Shot Through Walls - Additional effect
    if shotThroughWallsEnabled then
        -- Make the player's weapons phase through walls
        if LocalPlayer.Character then
            local tools = LocalPlayer.Character:GetChildren()
            for _, tool in pairs(tools) do
                if tool:IsA("Tool") then
                    local handle = tool:FindFirstChild("Handle")
                    if handle and handle:IsA("BasePart") then
                        handle.CanCollide = false
                    end
                end
            end
        end
    end
end)

-- Animation on GUI open
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = originalSize,
    Position = UDim2.new(0.5, -175, 0.5, -250)
}):Play()

-- Cleanup
gui.Destroying:Connect(function()
    if godModeConnection then godModeConnection:Disconnect() end
    if playerDetectorConnection then playerDetectorConnection:Disconnect() end
    if wallbangConnection then wallbangConnection:Disconnect() end
    for _, label in pairs(detectionLabels) do
        if label then label:Destroy() end
    end
end)