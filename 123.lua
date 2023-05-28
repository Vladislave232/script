local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local key = require('vkeys')
local imgui = require "imgui"
local wm = require 'lib.windows.message'
local razdacha = imgui.ImInt(0)
imgui.ToggleButton = require('imgui_addons').ToggleButton
imgui.HotKey = require('imgui_addons').HotKey
imgui.Spinner = require('imgui_addons').Spinner
imgui.BufferingBar = require('imgui_addons').BufferingBar
local razdacha_zapusk = imgui.ImInt(0)
local sw, sh = getScreenResolution()
local sampev = require 'lib.samp.events'
local main_window_state = imgui.ImBool(false)
local second_window_state = imgui.ImBool(false)
local dialogArr = {'Наборы', 'Предложить МП', 'Игровой вопрос'}
local dialogStr = ''
local dialogArrr = {'Rifa', 'Vagos', 'Aztecas', 'Groove', 'Ballas'}
local dialogStrr = ''
local dialogGoss = {'ППС', 'ФСБ', 'ВМФ', 'Мэрия', 'ДПС', 'ОМОН', 'АП', 'МЧС', 'СМИ'}
local dialogGos = ''
local dialogMaff = {'LCN', 'Yakudza', 'Русская Мафия', 'Хитманы'}
local dialogMaf = ''
local imBool = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local texter = imgui.ImBuffer(256)
local mep = imgui.ImInt(0)
local mepo = imgui.ImInt(0)
local prizemep = {u8'"Король Дигла"', u8'"Русская Рулетка"', u8'"Дамба"', u8'"Прятки"', u8'"Последний Выживший"', u8'"Поливалка"', u8'"Бомбардировка"', u8'"Таран"', u8'"PUBG"', u8'"Реакция"', u8'"Бои без правил"', u8'"Гонки"'}
local prizemp = {u8'"На Выбор"', u8'"Аптечки"', u8'"VIP-CAR"', u8'"Уровень на выбор"', u8'"Стиль Боя"', u8'Номер телефона на выбор', u8'Деньги', u8'Секрет', u8'Админ-права', u8'ПРОМОКОД'} 
local numbers = {'20+23', '34+78', '46*2' , '4*7', '52+56', '46+54', '20-8', '46-41', '7*8', '44/4' , '10+99', '412-413', '45-54', '7+5', '1+1', '888+111', '111+111'}
local word = {u8'04', u8'EKB', u8'MS', u8'Healme', u8'Kills', u8'LVL', u8'VIPCAR'}
local prizeon = {u8'"500 Аптечек"', u8'"Костюм попугая"', u8'"Мигалку на голову"', u8'"Комплект всемогущий"', u8'"Огонек на голову"', u8'"Шляпу курицы"', u8'"Номер телефона на выбор"', u8'"1ккк"', u8'"Стиль Боя"', u8'"500 убийств"', u8'"Уровень"', u8'"ВипКар"', u8'секретный приз'}
require "lib.moonloader"
local dialogOtb = {'Ghetto', 'Goss', 'Mafia'}
local dialogOtbb = ''
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
update_state = false
local str_rand = {'123', '123'}
local script_vers = 16
local script_vers_text = '1.16'
local update_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/update.ini'
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/123.lua'
local script_path = thisScript().path

for _, str in ipairs(dialogArr) do
    dialogStr = dialogStr .. str .. "\n"
end

for _, str in ipairs(dialogArrr) do
    dialogStrr = dialogStrr .. str .. "\n"
end

for _, str in ipairs(dialogOtb) do
    dialogOtbb = dialogOtbb .. str .. "\n"
end

for _, str in ipairs(dialogGoss) do
    dialogGos = dialogGos .. str .. "\n"
end

for _, str in ipairs(dialogMaff) do
    dialogMaf = dialogMaf .. str .. "\n"
end

function obnova(arg)
    sampShowDialog(212, "{FFFFFF}О{FF0000}Б{000000}Н{FA8072}О{8B0000}В{FF1493}Л{006400}Е{808000}Н{FF4500}И{FF8C00}Е", "Добавлен цитатник!\n{FFFFFF}Исправлены баги!\n{FF00FF}ШОК! Добавлена команда /mep! /rhelp!", "Закрыть", 'Закрыть', 0)
end

function main()
    if not isSampLoaded() or not isSampfuncsLoaded then return end
    while not isSampAvailable() do wait(1000) end
    sampAddChatMessage('{FF0000}[Раздача] {00FF00}Скрипт готов - чтобы узнать команды - /rhelp. {4B0082}Ваша версия: ' .. script_vers_text, -1)
    sampRegisterChatCommand("car", cmd_basa)
    sampRegisterChatCommand('nap', cmd_churka)
    sampRegisterChatCommand("raz", cmd_balalai)
    sampRegisterChatCommand('obnova', obnova)
    sampRegisterChatCommand('otb', cmd_otbor)
    sampRegisterChatCommand('rhelp', cmd_woopo)
    sampRegisterChatCommand('mep', cmd_balalai2)
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage('{00FFFF}Мой бот обнаружил обновление: ' .. updateIni.info.vers_text, -1)
                update_state = true
            end
            os.remove(update_path)
        end
    end)
    while true do
        wait(0)
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /OBNOVA')
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /OBNOVA')
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /OBNOVA')
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /OBNOVA')
                    sampAddChatMessage('{FF0000}[Ekaterinburg-ToolHelper] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /OBNOVA')
                    thisScript():reload()
                end
            end)
        end
        local result, button, list, input = sampHasDialogRespond(212)
        if result then
            if button == 1 then
                sampAddChatMessage('{FF0000}Напишите свою реакцию на обновление - @guninik')
            end
        end
        local result, button, list, input = sampHasDialogRespond(13)
        if result then
            if button == 1 then
                if list == 0 then
                    sampSendChat('/aad INFO | Ув. лидеры/заместители, проводите собеседования наборы. Игрокам скучно!')
                elseif list == 1 then
                    sampSendChat('/aad INFO | Ув. игроки, вы можете предложить свое мероприятие - /report.')
                elseif list == 2 then
                    sampSendChat('/aad INFO | Ув. игроки. Вы можете задать любой игровой вопрос - /report.')
                end
            end
        end
        local result, button, list, input = sampHasDialogRespond(16)
        if result then
            if button == 1 then
                if list == 0 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Rifa".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 1 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Vagos".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 2 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Grove".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 3 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Aztec".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 4 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Ballas".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                end
            end
        end
        local result, button, list, input = sampHasDialogRespond(17)
        if result then
            if button == 1 then
                if list == 0 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "ППС".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 1 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "ФСБ".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 2 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "ВМФ".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 3 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Мэрии".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 4 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "ДПС".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 5 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "ОМОН".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 6 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "АП".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 7 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "МЧС".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 8 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "СМИ".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                end
            end
        end
        local result, button, list, input = sampHasDialogRespond(18)
        if result then
            if button == 1 then
                if list == 0 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "LCN".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 1 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Якудза".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 2 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Русская Мафия".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 3 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Хитманы".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                end
            end
        end
        local result, button, list, input = sampHasDialogRespond(14)
        if result then
            if button == 1 then
                if list == 0 then
                    sampShowDialog(16, 'Выберите лидерку', dialogStrr, 'Тык', 'Закрыть', 2)
                elseif list == 1 then
                    sampShowDialog(17, 'Выберите лидерку', dialogGos, 'Тык', 'Закрыть', 2)
                elseif list == 2 then
                    sampShowDialog(18, 'Выберите лидерку', dialogMaf, 'Тык', 'Закрыть', 2)
                end
            end
        end
    end
    wait(2000)
    ran2 = math.random(1, #str_rand)
end

function imgui.OnDrawFrame()
    if not main_window_state.v and not second_window_state.v then
        imgui.Process = false
    end
    if main_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(500, 300), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(600, 300), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Раздача', main_window_state)
        imgui.Text(u8'Раздача')
        imgui.Combo(u8'Слово', razdacha, word, #word)
        imgui.Combo(u8'Призы', razdacha_zapusk, prizeon, #prizeon)
        imgui.SameLine()
        imgui.Spinner("##spinner", 5, 3, imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]))
        if imgui.InputText(u8'Введите ID победителя', text_buffer) then
        end
        if imgui.Button(u8'Раздача') then
            sampSendChat('/aad РАЗДАЧА | Кто первый напишет "/rep' .. ' ' .. u8:decode(word[razdacha.v + 1]).. '"' .. " тот получит " .. u8:decode(prizeon[razdacha_zapusk.v + 1]))
        end
        imgui.SameLine()
        if imgui.Button(u8'Выдать') then
            sampSendChat('/aad РАЗДАЧА | ' .. text_buffer.v .. ' WIN')
        end
        imgui.Separator()
        imgui.Text(u8'Примеры')
        math.randomseed(os.time())
        rand = math.random(1, 200)
        ral = math.random(1, 200)
        if imgui.Button(u8'Плюс') then
            sampSendChat('/aad Примеры | Кто первый решит пример ' .. rand .. '+' .. ral .. ' получит ' .. u8:decode(prizeon[razdacha_zapusk.v + 1]))
        end
        imgui.SameLine()
        if imgui.Button(u8'Минус') then
            sampSendChat('/aad Примеры | Кто первый решит пример ' .. rand .. '-' .. ral .. ' получит ' .. u8:decode(prizeon[razdacha_zapusk.v + 1]))
        end
        imgui.SameLine()
        imgui.BufferingBar("##buffer_bar", 0.7, imgui.ImVec2(390, 6), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.Button]), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.ButtonHovered]));
        imgui.Link('https://vk.com/guninik', u8'Влад Гунинык')
        imgui.Link('https://vk.com/klagem00n', u8'Сергей Семец')
        imgui.Link('https://vk.com/natriy14', u8'Какой-то Дмитров')
        imgui.Text(u8'Тут скоро появятся цитатники!')
        imgui.End()
    end
    if second_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(sw /2, sh /2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(0, 0), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Меню мероприятий', second_window_state)
        imgui.Combo(u8'Выберите приз', mep, prizemp, #prizemp)
        imgui.Combo(u8'Выберите мероприятие', mepo, prizemep, #prizemep)
        if imgui.Button(u8'Запустить', imgui.ImVec2(390, 120)) then
            lua_thread.create(function()
                sampSendChat('/aad MP | Уважаемые игроки, сейчас пройдёт мероприятие ' .. u8:decode(prizemep[mepo.v + 1]))
                wait(1000)
                sampSendChat('/aad MP | Приз: ' .. u8:decode(prizemp[mep.v + 1]) .. '. Для телепорта: /gomp')
                wait(1000)
                sampSendChat('/mp')
            end)
        end
        imgui.Separator()
        imgui.InputText(u8'Кастомный приз', texter)
        if imgui.Button(u8'Запустить со своим призом', imgui.ImVec2(390, 120)) then
            lua_thread.create(function()
                sampSendChat('/aad MP | Уважаемые игроки, сейчас пройдёт мероприятие ' .. u8:decode(prizemep[mepo.v + 1]))
                wait(1000)
                sampSendChat('/aad MP | Приз: ' .. u8:decode(texter.v) .. '! Для телепорта: /gomp')
                wait(1000)
                sampSendChat('/mp')
            end)
        end
        imgui.End()
    end
end

function cmd_balalai(arg)
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
end

function cmd_balalai2(arg)
    second_window_state.v = not second_window_state.vad
    imgui.Process = second_window_state.v
end

function cmd_churka(arg)
    if #arg == 0 then
        sampShowDialog(13, 'Выберите пункт', dialogStr, 'Тыкнуть', 'Закрыть', 2)
    end
end

function cmd_otbor(arg)
    if #arg == 0 then
        sampShowDialog(14, 'Выберите структуру', dialogOtbb, 'Тык', 'Закрыть', 2)
    end
end

function cmd_basa(arg)
    lua_thread.create(function()
        if #arg == 0 then
            sampSendChat('/veh 522 3 3')
        else
        sampSendChat('/re ' .. arg)
        wait(1000)
        sampSendChat('/veh 522 1 1')
        wait(1000)
        sampSendChat('/pm ' .. arg .. " Приятной игры на Екатеринбурге")
        end
    end)
end

function cmd_woopo(arg)
    if #arg == 0 then
        sampShowDialog(209, 'Команды этого скрипта', "\n{FFFFFF}/otb - сделать отбор \n{FF0000}/raz - cделать раздачу \n{FF0000}/nap - сделать напоминание \n{FF00FF}/mep - сделать мероприятие \n{00FFFF}/car[id] - выдать машину игроку ", "Выдать", 'Закрыть', 2)
    end
end

function imgui.Link(link,name,myfunc)
    myfunc = type(name) == 'boolean' and name or myfunc or false
    name = type(name) == 'string' and name or type(name) == 'boolean' and link or link
    local size = imgui.CalcTextSize(name)
    local p = imgui.GetCursorScreenPos()
    local p2 = imgui.GetCursorPos()
    local resultBtn = imgui.InvisibleButton('##'..link..name, size)
    if resultBtn then
        if not myfunc then
            os.execute('explorer '..link)
        end
    end
    imgui.SetCursorPos(p2)
    if imgui.IsItemHovered() then
        imgui.TextColored(imgui.ImVec4(0, 0.5, 1, 1), name)
        imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y + size.y), imgui.ImVec2(p.x + size.x, p.y + size.y), imgui.GetColorU32(imgui.ImVec4(0, 0.5, 1, 1)))
    else
        imgui.TextColored(imgui.ImVec4(0, 0.3, 0.8, 1), name)
    end
    return resultBtn
end