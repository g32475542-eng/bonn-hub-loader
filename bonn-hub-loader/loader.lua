-- loader.lua - Estilo Bonn HUB (arrastável, escuro, cantos redondos)
-- Com botão Get Key e placeholder personalizado

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local API_URL = "https://painel-keys.onrender.com/api/validate"
local HUB_RAW_URL = "https://raw.githubusercontent.com/g32475542-eng/bonn-hub-loader/main/bonn-hub-loader/hub.lua"

-- Função de validação (GET)
local function validateKey(key)
    local url = API_URL .. "?key=" .. key
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if not success then
        return false, "Erro de conexão"
    end
    local data = HttpService:JSONDecode(response)
    return data.valid, data.message
end

-- Criar GUI principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeySystemGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Container (para animação e arrasto)
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(0, 420, 0, 280) -- Aumentei largura para caber dois botões
container.Position = UDim2.new(0.5, -210, 0.5, -140)
container.BackgroundTransparency = 1
container.Parent = screenGui

-- Janela principal
local window = Instance.new("Frame")
window.Name = "KeyWindow"
window.Size = UDim2.new(1, 0, 1, 0)
window.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
window.BorderSizePixel = 0
window.ClipsDescendants = true
window.Parent = container

local windowCorner = Instance.new("UICorner")
windowCorner.CornerRadius = UDim.new(0, 12)
windowCorner.Parent = window

local windowBorder = Instance.new("UIStroke")
windowBorder.Thickness = 1.5
windowBorder.Color = Color3.fromRGB(35, 35, 45)
windowBorder.Parent = window

-- TopBar
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(1, 0, 0, 45)
topBar.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
topBar.BorderSizePixel = 0
topBar.Parent = window

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 12)
topBarCorner.Parent = topBar

local topBarMask = Instance.new("Frame")
topBarMask.Size = UDim2.new(1, 0, 0, 10)
topBarMask.Position = UDim2.new(0, 0, 1, -10)
topBarMask.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
topBarMask.BorderSizePixel = 0
topBarMask.Parent = topBar

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -20, 1, 0)
titleLabel.Position = UDim2.new(0, 20, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "🔐 BONN HUB"
titleLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.TextYAlignment = Enum.TextYAlignment.Center
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = topBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 40, 0, 45)
minimizeBtn.Position = UDim2.new(1, -40, 0, 0)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Text = "─"
minimizeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
minimizeBtn.TextSize = 28
minimizeBtn.Font = Enum.Font.SourceSans
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = topBar

minimizeBtn.MouseButton1Click:Connect(function()
    container.Visible = false
    task.wait(0.1)
    container.Visible = true
end)

-- Conteúdo
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, 0, 1, -45)
content.Position = UDim2.new(0, 0, 0, 45)
content.BackgroundColor3 = Color3.fromRGB(5, 5, 8)
content.BackgroundTransparency = 0
content.BorderSizePixel = 0
content.Parent = window

-- Caixa de texto
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 280, 0, 42)
keyBox.Position = UDim2.new(0.5, -140, 0.35, 0)
keyBox.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
keyBox.TextColor3 = Color3.fromRGB(230, 230, 230)
keyBox.PlaceholderText = "ex: amobonnhub"
keyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
keyBox.Text = ""
keyBox.Font = Enum.Font.SourceSans
keyBox.TextSize = 14
keyBox.BorderSizePixel = 0
keyBox.ClearTextOnFocus = false
keyBox.Parent = content

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 8)
boxCorner.Parent = keyBox

local boxBorder = Instance.new("UIStroke")
boxBorder.Thickness = 1
boxBorder.Color = Color3.fromRGB(45, 45, 55)
boxBorder.Parent = keyBox

-- Botão VERIFICAR
local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0, 130, 0, 42)
verifyBtn.Position = UDim2.new(0.5, -140, 0.6, 0)
verifyBtn.Text = "VERIFICAR"
verifyBtn.BackgroundColor3 = Color3.fromRGB(30, 120, 80)
verifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
verifyBtn.Font = Enum.Font.SourceSansBold
verifyBtn.TextSize = 14
verifyBtn.BorderSizePixel = 0
verifyBtn.Parent = content

local verifyCorner = Instance.new("UICorner")
verifyCorner.CornerRadius = UDim.new(0, 8)
verifyCorner.Parent = verifyBtn

verifyBtn.MouseEnter:Connect(function()
    TweenService:Create(verifyBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(40, 140, 100) }):Play()
end)
verifyBtn.MouseLeave:Connect(function()
    TweenService:Create(verifyBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(30, 120, 80) }):Play()
end)

-- Botão GET KEY
local getKeyBtn = Instance.new("TextButton")
getKeyBtn.Size = UDim2.new(0, 110, 0, 42)
getKeyBtn.Position = UDim2.new(0.5, 10, 0.6, 0) -- ao lado do VERIFICAR
getKeyBtn.Text = "GET KEY"
getKeyBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 100)
getKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
getKeyBtn.Font = Enum.Font.SourceSansBold
getKeyBtn.TextSize = 14
getKeyBtn.BorderSizePixel = 0
getKeyBtn.Parent = content

local getKeyCorner = Instance.new("UICorner")
getKeyCorner.CornerRadius = UDim.new(0, 8)
getKeyCorner.Parent = getKeyBtn

getKeyBtn.MouseEnter:Connect(function()
    TweenService:Create(getKeyBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(100, 100, 120) }):Play()
end)
getKeyBtn.MouseLeave:Connect(function()
    TweenService:Create(getKeyBtn, TweenInfo.new(0.15), { BackgroundColor3 = Color3.fromRGB(80, 80, 100) }):Play()
end)

-- Ação do botão GET KEY (copiar link encurtado ou abrir página)
getKeyBtn.MouseButton1Click:Connect(function()
    local link = "https://discord.gg/QQrpaubeaw" -- substitua pelo seu link de aquisição de key
    setclipboard(link) -- tenta copiar para área de transferência
    statusLabel.Text = "Link copiado! Acesse para obter sua key."
    statusLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    task.wait(2)
    if statusLabel.Text == "Link copiado! Acesse para obter sua key." then
        statusLabel.Text = ""
    end
end)

-- Label de status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, -40, 0, 30)
statusLabel.Position = UDim2.new(0, 20, 1, -40)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.SourceSans
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = content

-- Rodapé
local footer = Instance.new("Frame")
footer.Size = UDim2.new(1, 0, 0, 2)
footer.Position = UDim2.new(0, 0, 1, -2)
footer.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
footer.BorderSizePixel = 0
footer.Parent = window

-- Sistema de arrastar
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

-- Animação de entrada
container.BackgroundTransparency = 1
container.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(container, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 420, 0, 280),
    BackgroundTransparency = 1
}):Play()

-- Validação
verifyBtn.MouseButton1Click:Connect(function()
    local key = keyBox.Text
    if key == "" then
        statusLabel.Text = "Digite uma key!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    verifyBtn.Text = "VERIFICANDO..."
    verifyBtn.Active = false
    
    local valid, message = validateKey(key)
    if valid then
        statusLabel.Text = message or "Acesso liberado! Carregando..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        wait(1)
        screenGui:Destroy()
        
        local successLoad, err = pcall(function()
            loadstring(game:HttpGet(HUB_RAW_URL))()
        end)
        if not successLoad then
            warn("Erro ao carregar hub: " .. tostring(err))
        end
    else
        statusLabel.Text = message or "Key inválida ou expirada"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        verifyBtn.Text = "VERIFICAR"
        verifyBtn.Active = true
    end
end)
