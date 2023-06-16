script_name('Click Warp + Warp Recon + Camera Distance')
script_authors('FYP', 'kyrtion')

local Vector3D = require 'vector3d'
local sampev = require('lib.samp.events')
local memory = require('memory')


local camera_settings = {
	changed = false,
	distance = 2.0
}

local font = renderCreateFont("Tahoma", 10, FCR_BOLD + FCR_BORDER)
local font2 = renderCreateFont("Arial", 8, FCR_ITALICS + FCR_BORDER)

local keyToggle = 0x04
local keyApply = 0x01
local keyApplyCar = 0x02


local spectate = {
    status = false,
    tip = 'none', -- none, vehicle, player
    reconId = -1,
    playerId = -1, -- id connected and not pause -> get sampPlayerId
    vehicleId = -1, -- if is car -> get store save car 1 seats and not pause -> get sampPlayerId
    syncData = {},
    request = {},
    position = {},
    process_teleport = false,
    count = 0,
    command = ''
}


function main()
    if not isSampfuncsLoaded() then return end
    lua_thread.create(function()
        while true do
            wait(0)
            if spectate.status then
                if not sampIsCursorActive() and getMousewheelDelta() ~= 0 then
				setValueCameraDistance(getMousewheelDelta())
			end
			if not camera_settings.changed then camera_settings.changed = true end
                setCameraDistanceActivated(1)
                setCameraDistance(camera_settings.distance)
            elseif not spectate.status and camera_settings.changed then
                camera_settings.changed = false
                setCameraDistanceActivated(0)
                setCameraDistance(1.5)
            end
        end
    end)
    lua_thread.create(function()
        while true do
            while isPauseMenuActive() do
                if cursorEnabled then
                    setShowCursor(false)
                end
            end

            if isKeyJustPressed(keyToggle) and not (sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() or isPauseMenuActive()) then
                cursorEnabled = not cursorEnabled
                setShowCursor(cursorEnabled)
                while isKeyJustPressed(keyToggle) do wait(0) end
            end

            if cursorEnabled then
                local mode = sampGetCursorMode()
                if mode == 0 then
                    setShowCursor(true)
                end
                local sx, sy = getCursorPos()
                local sw, sh = getScreenResolution()
                -- is cursor in game window bounds?
                if sx >= 0 and sy >= 0 and sx < sw and sy < sh then
                    local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
                    local camX, camY, camZ = getActiveCameraCoordinates()
                    -- search for the collision point
                    local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ, true, true, false, true, false, false, false)
                    if result and colpoint.entity ~= 0 then
                        local normal = colpoint.normal
                        local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
                        local zOffset = 300
                        if normal[3] >= 0.5 then zOffset = 1 end
                        -- search for the ground position vertically down
                        local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3,
                            true, true, false, true, false, false, false)
                        if result then
                            pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)

                            local curX, curY, curZ  = getCharCoordinates(playerPed)
                            local dist              = getDistanceBetweenCoords3d(curX, curY, curZ, pos.x, pos.y, pos.z)
                            local hoffs             = renderGetFontDrawHeight(font)

                            sy = sy - 2
                            sx = sx - 2
                            -- renderFontDrawText(font, string.format("%0.2fm", dist), sx, sy - hoffs, 0xEEEEEEEE)
                            renderFontDrawTextCenter(font, string.format("%0.2f", dist), sx+2, sy - hoffs, 0xEEEEEEEE)

                            local tpIntoCar = nil
                            if colpoint.entityType == 2 and not spectate.status then
                                local car = getVehiclePointerHandle(colpoint.entity)
                                if doesVehicleExist(car) and (not isCharInAnyCar(playerPed) or storeCarCharIsInNoSave(playerPed) ~= car) then
                                    renderFontDrawTextCenter(font, getNameOfVehicleModel(getCarModel(car)), sx, sy - hoffs * 2, -1)
                                    local color = 0x44FFFFFF
                                    if isKeyDown(keyApplyCar) then
                                        tpIntoCar = car
                                        color = 0xFFFFFFFF
                                    end
                                    renderFontDrawTextCenter(font, 'Нажмите правую кнопку чтобы сесть в машинке', sx, sy - hoffs*3, color)
                                end
                            end

                            createPointMarker(pos.x, pos.y, pos.z)

                            -- teleport!
                            if isKeyDown(keyApply) then
                                if sampTextdrawIsExists(2143) and spectate.status then
                                    local tdstr = sampTextdrawGetString(2143)
                                    if tdstr:find('%(%d+%)$') then
                                        local id = tdstr:match('%((%d+)%)$')
                                        if sampIsPlayerConnected(id) and not sampIsPlayerPaused(id) then
                                            spectate.command = '/gethere '..id
                                            spectate.position = pos
                                            spectate.process_teleport = true
                                        end
                                    end
                                elseif not spectate.status then
                                    if tpIntoCar then
                                        if not jumpIntoCar(tpIntoCar) then
                                        -- teleport to the car if there is no free seats
                                        teleportPlayer(pos.x, pos.y, pos.z)
                                        end
                                    else
                                        if isCharInAnyCar(playerPed) then
                                            local norm = Vector3D(colpoint.normal[1], colpoint.normal[2], 0)
                                            local norm2 = Vector3D(colpoint2.normal[1], colpoint2.normal[2], colpoint2.normal[3])
                                            rotateCarAroundUpAxis(storeCarCharIsInNoSave(playerPed), norm2)
                                            pos = pos - norm * 1.8
                                            pos.z = pos.z - 0.8
                                        end
                                        teleportPlayer(pos.x, pos.y, pos.z)
                                    end
                                end
                                removePointMarker()
                                setShowCursor(false)
                            end
                        end
                    end
                end
            end
            wait(0)
            removePointMarker()
        end
    end)
    while true do
        wait(0)
    end
end


function rotateCarAroundUpAxis(car, vec)
    local function getVehicleRotationMatrix(car)
        local function readFloatArray(ptr, idx)
            return representIntAsFloat(readMemory(ptr + idx * 4, 4, false))
        end
        local entityPtr = getCarPointer(car)
        if entityPtr ~= 0 then
            local mat = readMemory(entityPtr + 0x14, 4, false)
            if mat ~= 0 then
                local rx, ry, rz, fx, fy, fz, ux, uy, uz
                rx = readFloatArray(mat, 0); ry = readFloatArray(mat, 1); rz = readFloatArray(mat, 2)
                fx = readFloatArray(mat, 4); fy = readFloatArray(mat, 5); fz = readFloatArray(mat, 6)
                ux = readFloatArray(mat, 8); uy = readFloatArray(mat, 9); uz = readFloatArray(mat, 10)
                return rx, ry, rz, fx, fy, fz, ux, uy, uz
            end
        end
    end
    local mat = require('matrix3x3')(getVehicleRotationMatrix(car))
    local rotAxis = Vector3D(mat.up:get())
    vec:normalize()
    rotAxis:normalize()
    local theta = math.acos(rotAxis:dotProduct(vec))
    if theta ~= 0 then
        rotAxis:crossProduct(vec)
        rotAxis:normalize()
        rotAxis:zeroNearZero()
        mat = mat:rotate(rotAxis, -theta)
    end
    local function setVehicleRotationMatrix(car, rx, ry, rz, fx, fy, fz, ux, uy, uz)
        local function writeFloatArray(ptr, idx, value)
            writeMemory(ptr + idx * 4, 4, representFloatAsInt(value), false)
        end
        local entityPtr = getCarPointer(car)
        if entityPtr ~= 0 then
            local mat = readMemory(entityPtr + 0x14, 4, false)
            if mat ~= 0 then
                writeFloatArray(mat, 0, rx)
                writeFloatArray(mat, 1, ry)
                writeFloatArray(mat, 2, rz)

                writeFloatArray(mat, 4, fx)
                writeFloatArray(mat, 5, fy)
                writeFloatArray(mat, 6, fz)

                writeFloatArray(mat, 8, ux)
                writeFloatArray(mat, 9, uy)
                writeFloatArray(mat, 10, uz)
            end
        end
    end
    setVehicleRotationMatrix(car, mat:get())
end


function createPointMarker(x, y, z)
    pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end


function removePointMarker()
    if pointMarker then
        removeUser3dMarker(pointMarker)
        pointMarker = nil
    end
end


function renderFontDrawTextCenter(font, text, x, y, color)
    renderFontDrawText(font, text, x - renderGetFontDrawTextLength(font, text) / 2, y, color)
end


function jumpIntoCar(car)
    local function getCarFreeSeat(car)
        if doesCharExist(getDriverOfCar(car)) then
            local maxPassengers = getMaximumNumberOfPassengers(car)
            for i = 0, maxPassengers do
                if isCarPassengerSeatFree(car, i) then
                    return i + 1
                end
            end
            return nil -- no free seats
        else
            return 0 -- driver seat
        end
    end
    local seat = getCarFreeSeat(car)
    if not seat then return false end                         -- no free seats
    if seat == 0 then warpCharIntoCar(playerPed, car)         -- driver seat
    else warpCharIntoCarAsPassenger(playerPed, car, seat - 1) -- passenger seat
    end
    restoreCameraJumpcut()
    return true
end


function teleportPlayer(x, y, z)
    if isCharInAnyCar(playerPed) then setCharCoordinates(playerPed, x, y, z) end
    local function setEntityCoordinates(entityPtr, x, y, z)
        if entityPtr ~= 0 then
            local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
            if matrixPtr ~= 0 then
                local posPtr = matrixPtr + 0x30
                writeMemory(posPtr + 0, 4, representFloatAsInt(x), false) -- X
                writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) -- Y
                writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) -- Z
            end
        end
    end
    local function setCharCoordinatesDontResetAnim(char, x, y, z)
        if doesCharExist(char) then
            local ptr = getCharPointer(char)
            setEntityCoordinates(ptr, x, y, z)
        end
    end
    setCharCoordinatesDontResetAnim(playerPed, x, y, z)
end


function setShowCursor(toggle)
    if toggle then
        sampSetCursorMode(CMODE_LOCKCAM)
    else
        sampToggleCursor(false)
    end
    cursorEnabled = toggle
end


function setCameraDistanceActivated(active)
	memory.setuint8(0xB6F028 + 0x38, active)
	memory.setuint8(0xB6F028 + 0x39, active)
end


function setCameraDistance(distance)
	memory.setfloat(0xB6F028 + 0xD4, distance)
	memory.setfloat(0xB6F028 + 0xD8, distance)
	memory.setfloat(0xB6F028 + 0xC0, distance)
	memory.setfloat(0xB6F028 + 0xC4, distance)
end


function setValueCameraDistance(distance)
	local cam = camera_settings.distance - distance
	if cam <= 1 or cam >= 103 then
		return false
	else
		printStringNow('Recon Camera: ~G~'..cam-2, 1000)
		camera_settings.distance = cam
	end
end


function sampev.onTogglePlayerSpectating(state)
    spectate.status = state
    if not state then
        spectate.tip = 'none'
        spectate.reconId = -1
        spectate.playerId = -1
        spectate.vehicleId = -1
    end
end


function sampev.onShowDialog(dialogId, style, title, button1, button2, text)
    local ntitle = title:gsub('{......}', ''):gsub('%c', '')
    local ntext = text:gsub('{......}', ''):gsub('%c', '')
    -- sampAddChatMessage(ntext, -1)
    if spectate.status and 
        (dialogId == 70     and style == 2 and ntitle:find('Куда Вы хотите выйти')) or
        (dialogId == 10999  and style == 0 and ntitle:find('^Аренда мопедов$')) or
        (dialogId == 9291   and style == 0 and ntitle:find('^Бизнес$') and ntext:find('^Вход платный и составляет'))
        -- (dialogId == 9291   and style == 0 and ntitle:find('^Бизнес$') and ntext:find('^Вход платный и составляет'))
    then
        return false
    end
end


function sampev.onSpectatePlayer(playerId, camType)
    spectate.tip = 'player'
    spectate.playerId = playerId
end


function sampev.onSpectateVehicle(vehicleId, camType)
    spectate.tip = 'vehicle'
    spectate.vehicleId = vehicleId
end


function sampev.onSendSpectatorSync(data)
    if spectate.process_teleport then
        spectate.count = spectate.count + 1
        if spectate.count <= 6 then
            data.position.x = spectate.position.x
            data.position.y = spectate.position.y-2 -- /gethere -> прибавит координаты Y+2
            data.position.z = spectate.position.z
            if spectate.count == 2 then
                sampSendChat(spectate.command)
            end
        else
            spectate.process_teleport = false
            spectate.count = 0
        end
    elseif spectate.tip == 'player' and spectate.playerId ~= -1 and sampIsPlayerConnected(spectate.playerId) then
        local result, ped = sampGetCharHandleBySampPlayerId(spectate.playerId)
        if result then
            local pX, pY, pZ = getCharCoordinates(ped)
            data.position.x = pX
            data.position.y = pY
            data.position.z = pZ
        end
    elseif spectate.tip == 'vehicle' and spectate.playerId ~= -1 then
        local result, car = sampGetCarHandleBySampVehicleId(spectate.vehicleId)
        if result then
            local cX, cY, cZ = getCarCoordinates(car)
            data.position.x = cX
            data.position.y = cY
            data.position.z = cZ
        end
    end
end

function onScriptTerminate(script, quitGame)
    if script == thisScript() then
        setShowCursor(false)
        removePointMarker()
    end
end
