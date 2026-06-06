local directory = loadstring(game:HttpGet("https://github.com/teteRoar/Utilities/releases/latest/download//directory.lua"))()

directory.Create({
    ["YourScriptHub"] = {
        ["Game"] = {
            "gameConfigs";
            "scriptAssets"
        }
    }
})

directory.WriteConfig("YourScriptHub/Game/gameConfigs/rageAimbot.SCRIPTHUBTAG", {
    SlientAim = true;
    Aimbot = true;
    WalkSpeed = 100;
    JumpPower = 150;
    SpoofName = "Roblox"
})

local _, decoded = directory.DecodeConfig("YourScriptHub/Game/gameConfigs/rageAimbot.SCRIPTHUBTAG")
print(decoded.SlientAim)
print(decoded.WalkSpeed)
print(decoded.SpoofName)

print(directory.GetFileName("YourScriptHub/Game/gameConfigs/rageAimbot.SCRIPTHUBTAG", true))
print(directory.GetNameFromDirectory("YourScriptHub/Game/gameConfigs/rageAimbot"))