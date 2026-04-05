-- Interface arrastável com cantos arredondados e tema escuro - Estilo Script Hub
-- CORREÇÕES: 
-- - topBar com ClipsDescendants = true (elimina sobras dos botões)
-- - menuButton com pequeno arredondamento (6px)
-- - minimização esconde statusBar, accentLine e topBarMask
-- - todas as transições suaves preservadas

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BonnHUBScreenGui"
screenGui.Parent = player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- Container (permite animação de entrada)
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(0, 700, 0, 450)
container.Position = UDim2.new(0.5, -350, 0.5, -225)
container.BackgroundTransparency = 1
container.Parent = screenGui

-- Janela principal
local window = Instance.new("Frame")
window.Name = "MainWindow"
window.Size = UDim2.new(1, 0, 1, 0)
window.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
window.BorderSizePixel = 0
window.ClipsDescendants = true
window.Parent = container

-- Cantos arredondados da janela
local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 10)
windowCorner.Parent = window

-- Borda arredondada (UIStroke)
local windowBorder = Instance.new("UIStroke")
windowBorder.Thickness = 1.5
windowBorder.Color = Color3.fromRGB(35, 35, 40)
windowBorder.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
windowBorder.Parent = window

-- TOP BAR (faixa superior)
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
topBar.BackgroundTransparency = 0
topBar.BorderSizePixel = 0
topBar.ClipsDescendants = true  -- ESSENCIAL: corta os cantos dos filhos (menuButton)
topBar.Parent = window

-- Arredondamento apenas no topo da topBar
local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 10)
topBarCorner.Parent = topBar

-- Máscara para esconder cantos inferiores da topBar
local topBarMask = Instance.new("Frame")
topBarMask.Size = UDim2.new(1, 0, 0, 10)
topBarMask.Position = UDim2.new(0, 0, 1, -10)
topBarMask.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
topBarMask.BorderSizePixel = 0
topBarMask.Parent = topBar

-- Linha de destaque (accent)
local accentLine = Instance.new("Frame")
accentLine.Name = "AccentLine"
accentLine.Size = UDim2.new(1, 0, 0, 2)
accentLine.Position = UDim2.new(0, 0, 1, -2)
accentLine.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
accentLine.BorderSizePixel = 0
accentLine.Parent = topBar

-- CONTEÚDO PRINCIPAL
local contentFrame = Instance.new("Frame")
contentFrame.Name = "Content"
contentFrame.Size = UDim2.new(1, 0, 1, -45)
contentFrame.Position = UDim2.new(0, 0, 0, 45)
contentFrame.BackgroundColor3 = Color3.fromRGB(3, 3, 3)
contentFrame.BackgroundTransparency = 0
contentFrame.BorderSizePixel = 0
contentFrame.Parent = window

-- BOTÃO MENU (3 risquinhos)
local menuButton = Instance.new("TextButton")
menuButton.Name = "MenuButton"
menuButton.Size = UDim2.new(0, 50, 0, 45)
menuButton.Position = UDim2.new(0, 0, 0, 0)
menuButton.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
menuButton.BackgroundTransparency = 0
menuButton.Text = ""
menuButton.BorderSizePixel = 0
menuButton.Parent = topBar

-- Pequeno arredondamento no menuButton (para não criar quinas retas)
local menuButtonCorner = Instance.new("UICorner")
menuButtonCorner.CornerRadius = UDim.new(0, 6)
menuButtonCorner.Parent = menuButton

-- Hover do menuButton
menuButton.MouseEnter:Connect(function()
    TweenService:Create(menuButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    }):Play()
end)
menuButton.MouseLeave:Connect(function()
    TweenService:Create(menuButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    }):Play()
end)

-- Os três risquinhos (frames)
local line1 = Instance.new("Frame")
line1.Size = UDim2.new(0, 22, 0, 2.5)
line1.Position = UDim2.new(0.5, -11, 0.5, -9)
line1.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
line1.BorderSizePixel = 0
line1.Parent = menuButton

local line2 = Instance.new("Frame")
line2.Size = UDim2.new(0, 22, 0, 2.5)
line2.Position = UDim2.new(0.5, -11, 0.5, -1.5)
line2.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
line2.BorderSizePixel = 0
line2.Parent = menuButton

local line3 = Instance.new("Frame")
line3.Size = UDim2.new(0, 22, 0, 2.5)
line3.Position = UDim2.new(0.5, -11, 0.5, 6)
line3.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
line3.BorderSizePixel = 0
line3.Parent = menuButton

-- TÍTULO "BONN HUB"
local titleLabel = Instance.new("TextLabel")
titleLabel.Name = "TitleLabel"
titleLabel.Size = UDim2.new(0, 150, 1, 0)
titleLabel.Position = UDim2.new(0, 60, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "BONN HUB"
titleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = topBar

-- BOTÃO MINIMIZAR
local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "MinimizeButton"
minimizeButton.Size = UDim2.new(0, 40, 0, 45)
minimizeButton.Position = UDim2.new(1, -40, 0, 0)
minimizeButton.BackgroundTransparency = 1
minimizeButton.Text = "─"
minimizeButton.TextColor3 = Color3.fromRGB(150, 150, 150)
minimizeButton.TextSize = 28
minimizeButton.Font = Enum.Font.SourceSans
minimizeButton.BorderSizePixel = 0
minimizeButton.Parent = topBar

minimizeButton.MouseEnter:Connect(function()
    TweenService:Create(minimizeButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextColor3 = Color3.fromRGB(255, 255, 255)
    }):Play()
end)
minimizeButton.MouseLeave:Connect(function()
    TweenService:Create(minimizeButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextColor3 = Color3.fromRGB(150, 150, 150)
    }):Play()
end)

-- MENU LATERAL (retângulo que desliza)
local sideRectangle = Instance.new("Frame")
sideRectangle.Name = "SideRectangle"
sideRectangle.Size = UDim2.new(0, 180, 1, -45)
sideRectangle.Position = UDim2.new(0, -180, 0, 45)
sideRectangle.BackgroundColor3 = Color3.fromRGB(8, 8, 8)
sideRectangle.BackgroundTransparency = 0
sideRectangle.BorderSizePixel = 0
sideRectangle.Visible = true
sideRectangle.Parent = window

local sideRectCorner = Instance.new("UICorner")
sideRectCorner.CornerRadius = UDim.new(0, 8)
sideRectCorner.Parent = sideRectangle

-- Indicador de página atual (fundo do botão ativo)
local currentPageIndicator = Instance.new("Frame")
currentPageIndicator.Name = "CurrentPageIndicator"
currentPageIndicator.Size = UDim2.new(0.9, 0, 0, 42)
currentPageIndicator.Position = UDim2.new(0.05, 0, 0, 8)
currentPageIndicator.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
currentPageIndicator.BackgroundTransparency = 0
currentPageIndicator.BorderSizePixel = 0
currentPageIndicator.Visible = true
currentPageIndicator.Parent = sideRectangle

local indicatorCorner = Instance.new("UICorner")
indicatorCorner.CornerRadius = UDim.new(0, 6)
indicatorCorner.Parent = currentPageIndicator

-- Botão MAIN
local mainPageButton = Instance.new("TextButton")
mainPageButton.Name = "MainPageButton"
mainPageButton.Size = UDim2.new(0.9, 0, 0, 42)
mainPageButton.Position = UDim2.new(0.05, 0, 0, 8)
mainPageButton.BackgroundTransparency = 1
mainPageButton.Text = "MAIN"
mainPageButton.TextColor3 = Color3.fromRGB(220, 220, 220)
mainPageButton.TextSize = 13
mainPageButton.TextXAlignment = Enum.TextXAlignment.Center
mainPageButton.TextYAlignment = Enum.TextYAlignment.Center
mainPageButton.Font = Enum.Font.SourceSansBold
mainPageButton.BorderSizePixel = 0
mainPageButton.Parent = sideRectangle

-- Botão CREDITS
local creditsPageButton = Instance.new("TextButton")
creditsPageButton.Name = "CreditsPageButton"
creditsPageButton.Size = UDim2.new(0.9, 0, 0, 42)
creditsPageButton.Position = UDim2.new(0.05, 0, 0, 58)
creditsPageButton.BackgroundTransparency = 1
creditsPageButton.Text = "CREDITS"
creditsPageButton.TextColor3 = Color3.fromRGB(220, 220, 220)
creditsPageButton.TextSize = 13
creditsPageButton.TextXAlignment = Enum.TextXAlignment.Center
creditsPageButton.TextYAlignment = Enum.TextYAlignment.Center
creditsPageButton.Font = Enum.Font.SourceSansBold
creditsPageButton.BorderSizePixel = 0
creditsPageButton.Parent = sideRectangle

-- Hover dos botões do menu lateral
mainPageButton.MouseEnter:Connect(function()
    if currentPage ~= "Main" then
        TweenService:Create(mainPageButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end
end)
mainPageButton.MouseLeave:Connect(function()
    if currentPage ~= "Main" then
        TweenService:Create(mainPageButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextColor3 = Color3.fromRGB(220, 220, 220)
        }):Play()
    end
end)

creditsPageButton.MouseEnter:Connect(function()
    if currentPage ~= "Credits" then
        TweenService:Create(creditsPageButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextColor3 = Color3.fromRGB(255, 255, 255)
        }):Play()
    end
end)
creditsPageButton.MouseLeave:Connect(function()
    if currentPage ~= "Credits" then
        TweenService:Create(creditsPageButton, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextColor3 = Color3.fromRGB(220, 220, 220)
        }):Play()
    end
end)

-- CONTEÚDO DAS PÁGINAS
local mainContent = Instance.new("Frame")
mainContent.Name = "MainContent"
mainContent.Size = UDim2.new(1, 0, 1, 0)
mainContent.Position = UDim2.new(0, 0, 0, 0)
mainContent.BackgroundTransparency = 1
mainContent.Visible = true
mainContent.Parent = contentFrame

local mainLabel = Instance.new("TextLabel")
mainLabel.Size = UDim2.new(1, -40, 0, 30)
mainLabel.Position = UDim2.new(0, 20, 0, 20)
mainLabel.BackgroundTransparency = 1
mainLabel.Text = "Welcome to Bonn HUB!"
mainLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
mainLabel.TextSize = 18
mainLabel.TextXAlignment = Enum.TextXAlignment.Left
mainLabel.Font = Enum.Font.SourceSansBold
mainLabel.Parent = mainContent

local creditsContent = Instance.new("TextLabel")
creditsContent.Name = "CreditsContent"
creditsContent.Size = UDim2.new(1, -40, 1, -40)
creditsContent.Position = UDim2.new(0, 20, 0, 20)
creditsContent.BackgroundTransparency = 1
creditsContent.Text = "by Bala e Null\n\ndiscord.gg/QQrpaubeaw"
creditsContent.TextColor3 = Color3.fromRGB(80, 180, 80)
creditsContent.TextSize = 13
creditsContent.TextXAlignment = Enum.TextXAlignment.Left
creditsContent.TextYAlignment = Enum.TextYAlignment.Top
creditsContent.TextWrapped = true
creditsContent.Font = Enum.Font.SourceSans
creditsContent.Visible = false
creditsContent.Parent = contentFrame

-- LINHA DE STATUS (inferior)
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(1, 0, 0, 2)
statusBar.Position = UDim2.new(0, 0, 1, -2)
statusBar.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
statusBar.BorderSizePixel = 0
statusBar.Parent = window

-- VARIÁVEIS DE ESTADO
local isMinimized = false
local minimizedSize = nil
local isRectangleOpen = false
local currentPage = "Main"

-- FUNÇÕES DO MENU LATERAL
local function closeRectangle()
    if isRectangleOpen then
        TweenService:Create(sideRectangle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Position = UDim2.new(0, -180, 0, 45)
        }):Play()
        isRectangleOpen = false
    end
end

local function openRectangle()
    TweenService:Create(sideRectangle, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 45)
    }):Play()
    isRectangleOpen = true
end

-- TROCA DE PÁGINAS
local function switchToMain()
    if currentPage == "Main" then
        closeRectangle()
        return
    end
    currentPage = "Main"
    mainContent.Visible = true
    creditsContent.Visible = false
    TweenService:Create(currentPageIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Position = UDim2.new(0.05, 0, 0, 8)
    }):Play()
    closeRectangle()
end

local function switchToCredits()
    if currentPage == "Credits" then
        closeRectangle()
        return
    end
    currentPage = "Credits"
    mainContent.Visible = false
    creditsContent.Visible = true
    TweenService:Create(currentPageIndicator, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
        Position = UDim2.new(0.05, 0, 0, 58)
    }):Play()
    closeRectangle()
end

mainPageButton.MouseButton1Click:Connect(switchToMain)
creditsPageButton.MouseButton1Click:Connect(switchToCredits)
menuButton.MouseButton1Click:Connect(function()
    if isRectangleOpen then closeRectangle() else openRectangle() end
end)

-- MINIMIZAR (COM CORREÇÃO TOTAL)
local function toggleMinimize()
    if isMinimized then
        -- Restaurar
        isMinimized = false
        contentFrame.Visible = true
        statusBar.Visible = true
        accentLine.Visible = true
        topBarMask.Visible = true
        
        TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = minimizedSize or UDim2.new(0, 700, 0, 450)
        }):Play()
        TweenService:Create(contentFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0
        }):Play()
        minimizeButton.Text = "─"
    else
        -- Minimizar
        isMinimized = true
        minimizedSize = container.Size
        if isRectangleOpen then closeRectangle() end
        
        -- Esconde elementos que criam bordas falsas
        statusBar.Visible = false
        accentLine.Visible = false
        topBarMask.Visible = false
        
        TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
            Size = UDim2.new(0, 700, 0, 45)
        }):Play()
        TweenService:Create(contentFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            BackgroundTransparency = 1
        }):Play()
        minimizeButton.Text = "□"
        task.wait(0.3)
        if isMinimized then
            contentFrame.Visible = false
        end
    end
end

minimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- SISTEMA DE ARRASTAR
local dragging = false
local dragStart = nil
local startPos = nil

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = Vector2.new(input.Position.X, input.Position.Y)
        startPos = container.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = Vector2.new(input.Position.X, input.Position.Y) - dragStart
        container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- ANIMAÇÃO DE ENTRADA
container.BackgroundTransparency = 1
container.Size = UDim2.new(0, 700, 0, 0)
TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    BackgroundTransparency = 1,
    Size = UDim2.new(0, 700, 0, 450)
}):Play()
