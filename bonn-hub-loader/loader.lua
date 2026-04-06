-- loader.lua - Sistema de Key com estilo Bonn HUB
-- Compatível com executores (sem URLEncode)

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local API_URL = "https://painel-keys.onrender.com/api/validate"
local HUB_RAW_URL = "https://raw.githubusercontent.com/g32475542-eng/bonn-hub-loader/main/bonn-hub-loader/hub.lua"
local SHORTENER_URL = "https://discord.gg/QQrpaubeaw"  -- substitua pelo seu link encurtado

-- Criar tela principal
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeySystemGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Fundo escuro com desfoque (simulado por transparência)
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.7
background.Parent = screenGui

-- Painel central
local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 420, 0, 280)
panel.Position = UDim2.new(0.5, -210, 0.5, -140)
panel.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
panel.BorderSizePixel = 0
panel.Parent = background

-- Cantos arredondados do painel
local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 12)
panelCorner.Parent = panel

-- Borda sutil no painel
local panelStroke = Instance.new("UIStroke")
panelStroke.Thickness = 1.5
panelStroke.Color = Color3.fromRGB(45, 45, 55)
panelStroke.Parent = panel

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "🔐 BONN HUB"
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Center
title.Parent = panel

-- Subtítulo
local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, 0, 0, 25)
subTitle.Position = UDim2.new(0, 0, 0, 45)
subTitle.Text = "Insira sua key para acessar"
subTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
subTitle.BackgroundTransparency = 1
subTitle.Font = Enum.Font.Gotham
subTitle.TextSize = 13
subTitle.TextXAlignment = Enum.TextXAlignment.Center
subTitle.Parent = panel

-- Campo de texto (sem borda cinza, apenas fundo escuro com borda suave)
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 300, 0, 45)
keyBox.Position = UDim2.new(0.5, -150, 0.5, -20)
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.PlaceholderText = "ex: euamonull"
keyBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 140)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 15
keyBox.TextXAlignment = Enum.TextXAlignment.Center
keyBox.ClearTextOnFocus = false
keyBox.Parent = panel

-- Cantos arredondados do campo
local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 8)
boxCorner.Parent = keyBox

-- Borda do campo (sutil)
local boxStroke = Instance.new("UIStroke")
boxStroke.Thickness = 1
boxStroke.Color = Color3.fromRGB(60, 60, 70)
boxStroke.Parent = keyBox

-- Botão validar
local validateBtn = Instance.new("TextButton")
validateBtn.Size = UDim2.new(0, 180, 0, 45)
validateBtn.Position = UDim2.new(0.5, -90, 0.8, 0)
validateBtn.Text = "VALIDAR"
validateBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
validateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
validateBtn.Font = Enum.Font.GothamBold
validateBtn.TextSize = 15
validateBtn.Parent = panel

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = validateBtn

-- Efeito hover no botão
validateBtn.MouseEnter:Connect(function()
    TweenService:Create(validateBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), { BackgroundColor3 = Color3.fromRGB(100, 140, 255) }):Play()
end)
validateBtn.MouseLeave:Connect(function()
    TweenService:Create(validateBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), { BackgroundColor3 = Color3.fromRGB(80, 120, 220) }):Play()
end)

-- Botão copiar link encurtado
local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0, 180, 0, 35)
copyBtn.Position = UDim2.new(0.5, -90, 1, -45)
copyBtn.Text = "📋 LINK ENCURTADO"
copyBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 48)
copyBtn.TextColor3 = Color3.fromRGB(180, 180, 200)
copyBtn.Font = Enum.Font.Gotham
copyBtn.TextSize = 12
copyBtn.Parent = panel

local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 8)
copyCorner.Parent = copyBtn

-- Efeito hover no botão copiar
copyBtn.MouseEnter:Connect(function()
    TweenService:Create(copyBtn, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(55, 55, 65) }):Play()
end)
copyBtn.MouseLeave:Connect(function()
    TweenService:Create(copyBtn, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(40, 40, 48) }):Play()
end)

-- Label de status
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 1, -35)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Center
statusLabel.Parent = panel

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

-- Função copiar link (usando setclipboard se disponível)
local function copyToClipboard(text)
    local success, err = pcall(function()
        if setclipboard then
            setclipboard(text)
        elseif toclipboard then
            toclipboard(text)
        else
            return false, "Clipboard não suportado"
        end
        return true
    end)
    if success then
        statusLabel.Text = "✅ Link copiado!"
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(2)
        if statusLabel.Text == "✅ Link copiado!" then
            statusLabel.Text = ""
        end
    else
        statusLabel.Text = "❌ Não foi possível copiar"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        task.wait(2)
        statusLabel.Text = ""
    end
end

-- Ação do botão copiar
copyBtn.MouseButton1Click:Connect(function()
    copyToClipboard(SHORTENER_URL)
end)

-- Ação do botão validar
validateBtn.MouseButton1Click:Connect(function()
    local key = keyBox.Text
    if key == "" then
        statusLabel.Text = "Digite uma key!"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        return
    end
    
    validateBtn.Text = "VERIFICANDO..."
    validateBtn.Active = false
    
    local valid, message = validateKey(key)
    if valid then
        statusLabel.Text = message or "Key válida! Carregando hub..."
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
        statusLabel.Text = message or "Key inválida"
        statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
        validateBtn.Text = "VALIDAR"
        validateBtn.Active = true
    end
end)

-- Animação de entrada do painel
panel.BackgroundTransparency = 1
panel.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(panel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 420, 0, 280),
    BackgroundTransparency = 0
}):Play()
