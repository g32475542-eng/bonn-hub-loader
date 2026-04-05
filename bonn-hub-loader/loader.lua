-- loader.lua - Sistema de Key + Carregamento do Bonn HUB
-- GitHub: g32475542-eng/bonn-hub-loader
-- Painel: https://painel-keys.onrender.com

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local player = Players.LocalPlayer

local API_URL = "https://painel-keys.onrender.com/api/validate"
local HUB_RAW_URL = "https://raw.githubusercontent.com/g32475542-eng/bonn-hub-loader/main/bonn-hub-loader/hub.lua"

-- Criar tela de entrada da key
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KeySystemGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 0.6
background.Parent = screenGui

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 400, 0, 220)
panel.Position = UDim2.new(0.5, -200, 0.5, -110)
panel.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
panel.BorderSizePixel = 0
panel.Parent = background

local panelCorner = Instance.new("UICorner")
panelCorner.CornerRadius = UDim.new(0, 12)
panelCorner.Parent = panel

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Text = "🔐 INSIRA SUA KEY"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = panel

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0, 280, 0, 40)
keyBox.Position = UDim2.new(0.5, -140, 0.5, -20)
keyBox.PlaceholderText = "Digite sua key"
keyBox.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
keyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
keyBox.Font = Enum.Font.Gotham
keyBox.TextSize = 14
keyBox.Parent = panel

local boxCorner = Instance.new("UICorner")
boxCorner.CornerRadius = UDim.new(0, 8)
boxCorner.Parent = keyBox

local validateBtn = Instance.new("TextButton")
validateBtn.Size = UDim2.new(0, 140, 0, 40)
validateBtn.Position = UDim2.new(0.5, -70, 0.8, 0)
validateBtn.Text = "VALIDAR"
validateBtn.BackgroundColor3 = Color3.fromRGB(80, 120, 220)
validateBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
validateBtn.Font = Enum.Font.GothamBold
validateBtn.TextSize = 14
validateBtn.Parent = panel

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 8)
btnCorner.Parent = validateBtn

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 30)
statusLabel.Position = UDim2.new(0, 0, 1, -30)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
statusLabel.TextSize = 12
statusLabel.Font = Enum.Font.Gotham
statusLabel.Parent = panel

local function validateKey(key)
    local body = HttpService:JSONEncode({ key = key })
    local success, response = pcall(function()
        return HttpService:PostAsync(API_URL, body, Enum.HttpContentType.ApplicationJson)
    end)
    if not success then
        return false, "Erro ao conectar ao servidor de validação"
    end
    local data = HttpService:JSONDecode(response)
    return data.valid, data.message
end

validateBtn.MouseButton1Click:Connect(function()
    local key = keyBox.Text
    if key == "" then
        statusLabel.Text = "Digite uma key!"
        return
    end
    
    validateBtn.Text = "Verificando..."
    validateBtn.Active = false
    
    local valid, message = validateKey(key)
    if valid then
        statusLabel.Text = message or "Key válida! Carregando hub..."
        statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
        task.wait(1)
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
