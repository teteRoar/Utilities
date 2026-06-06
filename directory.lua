-- Credits to RegularVynixu
-- https://raw.githubusercontent.com/RegularVynixu/Utilities/refs/heads/main/Directory.lua

-- \\ Services // --

local HttpService = game:GetService("HttpService")

-- \\ Variables // --

local Module = {}

-- \\ Functions // --

local function CreateBranch(tree: any, branch: any, parentPath: string)
    for i, v in branch do
        local name = (typeof(v) == "table") and i or v
        local path = (parentPath and parentPath.."/" or "")..name

        makefolder(path)
        tree[name] = path

        if typeof(v) == "table" then
            CreateBranch(tree, v, path)
        end
    end
end

-- \\ Main // --

Module.Create = function(tree: any, path: string?)
    path = typeof(path) == "string" and path.."/" or ""
    local t = {}

    for i, v in tree do
        local name = (typeof(v) == "table") and i or v
        local rootPath = path..name

        t.Root = rootPath
        makefolder(rootPath)

        if typeof(v) == "table" then
            CreateBranch(t, v, rootPath)
        end

        break
    end

    return t
end

--[[
EXAMPLE USAGE:

module.Create({
    ["YourScriptHub"] = {
        ["Game"] = {
            "gameConfigs";
            "scriptAssets"
        }
    }
})
]]

Module.WriteConfig = function(path: string, data: any): boolean
    local success = pcall(function()
        writefile(path, HttpService:JSONEncode(data))
    end)
    return success
end

--[[
EXAMPLE USAGE:

Module.WriteConfig("YourScriptHub/Game/gameConfigs/rageAimbot.SCRIPTHUBTAG", {
    SlientAim = true;
    Aimbot = true;
    WalkSpeed = 100;
    JumpPower = 150;
    SpoofName = "Roblox"
})
]]

Module.DecodeConfig = function(path: string): (boolean, any)
    local success, result = pcall(function()
        return HttpService:JSONDecode(readfile(path))
    end)
    return success, success and result or {}
end

--[[
EXAMPLE USAGE:

local _, decoded = Module.DecodeConfig("YourScriptHub/Game/gameConfigs/rageAimbot.SCRIPTHUBTAG") -- The _ is for the success boolean, you can also check if the decode was successful by checking if _ is true or false.
print(decoded.SlientAim)
print(decoded.WalkSpeed)
print(decoded.SpoofName)
]]

Module.GetFileName = function(path: string, noExtension: boolean): string
    local name = path:match("[^/\\]+$") or path
    if noExtension then
        name = name:gsub("%.[^.]+$", "")
    end
    return name
end

Module.GetNameFromDirectory = Module.GetFileName

--[[
EXAMPLE USAGE:

-- You don't have to add extensions to the path, but you can if you want to. The functions will work either way.
print(Module.GetFileName("YourScriptHub/Game/gameConfigs/rageAimbot.SCRIPTHUBTAG"))
print(Module.GetNameFromDirectory("YourScriptHub/Game/gameConfigs/rageAimbot.SCRIPTHUBTAG"))
]]

-- for i, v in Module do
--     if typeof(v) == "function" then
--         getgenv()[i] = v
--     end
-- end

return Module
