---------------------------------------------------------------------------------
--
-- Prat - A framework for World of Warcraft chat mods
--
-- Copyright (C) 2006-2008  Prat Development Team
--
-- This program is free software; you can redistribute it and/or
-- modify it under the terms of the GNU General Public License
-- as published by the Free Software Foundation; either version 2
-- of the License, or (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to:
--
-- Free Software Foundation, Inc.,
-- 51 Franklin Street, Fifth Floor,
-- Boston, MA  02110-1301, USA.
--
--
-------------------------------------------------------------------------------
--[[
Name: Prat 3.0 (events.lua)
Revision: $Revision: 80213 $
Author(s): Sylvaanar (sylvanaar@mindspring.com)
Inspired By: Prat 2.0, Prat, and idChat2 by Industrial
Website: http://files.wowace.com/Prat/
Documentation: http://www.wowace.com/wiki/Prat
Forum: http://www.wowace.com/forums/index.php?topic=6243.0
SVN: http://svn.wowace.com/wowace/trunk/Prat/
Description: The chat event service
]]

--[[ BEGIN STANDARD HEADER ]]--

-- Imports
local _G = _G
local type = type
local strsub = strsub
local wipe = table.wipe

-- Isolate the environment
setfenv(1, SVC_NAMESPACE)

--[[ END STANDARD HEADER ]]--

ServerChannels = { _G.EnumerateServerChannels() }

do
    local chanTable = {}
    local function buildChanTable(t, name, num, ...)
        if name and num then
            t[num] = name
            t[name] = num
            return buildChanTable(t, ...)
        end
    
        return t
    end
    
    function GetChannelTable(t)
        if not t then 
            t = chanTable 
        end
        
        wipe(t)
    
        return buildChanTable(t, _G.GetChannelList())
    end
end

local name
function CanLinkInChannel(num)
    if type(num) == "number" then 
        name = GetChannelTable()[num]
    else
        name = num
    end

    if type(num) == "string" then 
        name = (name:gsub("^.+$", Prat.ServerChannels))
    end

    if type(name) == "string" then
        return (name ~= _G.TRADE)
    end
    
    return false
end


--function CanLinkInChannel(num)
--    return GetChannelTable()[num]
----
----    if type(num) == "number" then name = GetChannelName(name)
----        return (name:gsub("^.+$", Prat.ServerChannels))
----    else
--end
--function IsServerChannel(name)
--    if type(name) == "number" then name = GetChannelName(name)
--        return (name:gsub("^.+$", Prat.ServerChannels))
--    else
--
--name, header, collapsed, channelNumber, count, active, category, voiceEnabled, voiceActive = GetChannelDisplayInfo(index) 
--
--end

