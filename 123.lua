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
local third_window_state = imgui.ImBool(false)
local dialogArr = {'Наборы', 'Предложить МП', 'Игровой вопрос'}
local dialogStr = ''
local dialogArrr = {'Rifa', 'Vagos', 'Aztecas', 'Groove', 'Ballas'}
local dialogStrr = ''
local dialogGoss = {'ППС', 'ФСБ', 'ВМФ', 'Мэрия', 'ДПС', 'ОМОН', 'АП', 'МЧС', 'СМИ'}
local dialogGos = ''
local dialogMaff = {'LCN', 'Yakudza', 'Русская Мафия', 'Хитманы'}
local dialogMaf = ''
local pensTable = [[Блокировка чата:
    МГ
    Капс
    Флуд
    Оскорбление игроков
    Оскорбление администрации
    Упоминание родных
    Обман администрации
    Бред в /gov, /d, /vad, /ad
    Транслит в: Игровой чат
    Отсутствие тэга в /gov, или /d

    Блокировка аккаунта:
    Использование читов в деморгане
    Реклама проектов
    Вредительские читы
    Использование читов в деморгане
    Выход от наказания
    Оскорбление проекта
    Оскорбление родных

    Выдача деморгана:
    ДМ
    ДБ
    ТК
    СК
    ПГ
    nonRP
    БагоЮз
    DM от 3-их человек
    Читы во фракции
    Читы

    Выдача варна:
    Отказ от проверки
    Найденны читы при проверке

    Блокировка репорта:
    Транслит
    Оффтоп
    Неадекват
]]

local timesTable = [[
    Время
    10 минут
    5 минут
    10 минут
    15 минут
    15 минут
    60 минут
    15 минут
    10 минут
    5 минут
    10 минут


    5 дней
    60 минут
    Навсегда + banip
    5 дней
    1 день
    60 минут
    60 минут -> 2 дня бана


    10 минут
    10 минут
    10 минут
    10 минут
    5 минут
    10 минут
    15 минут
    20 минут
    30 минут + увольнение
    60 минут


    1 варн
    1 варн


    5 минут
    10 минут
    30 минут
]]
local tableOfNew = {
    tableRes = imgui.ImBool(false),
    tempLeader = imgui.ImBool(false),
    AutoReport = imgui.ImBool(false),
    commandsAdmins = imgui.ImBool(false),
    addInBuffer = imgui.ImBuffer(128),
    carColor1 = imgui.ImInt(0),
    carColor2 = imgui.ImInt(0),
    givehp = imgui.ImInt(100),
    selectGun = imgui.ImInt(0),
    numberGunCreate = imgui.ImInt(0),
    intComboCar = imgui.ImInt(0),
    findText = imgui.ImBuffer(256),
    intChangedStatis = imgui.ImInt(0),
    inputIntChangedStatis = imgui.ImBuffer(10),
    answer_report = imgui.ImBuffer(526),
    inputAmmoBullets = imgui.ImBuffer(5),
    fdOnlinePlayer = imgui.ImInt(0),
    inputAdminId = imgui.ImBuffer(4)
}
local reports = {
    [0] = {
        nickname = '',
        id = -1,
        textP = ''
    }
}
local imBool = imgui.ImBool(false)
local text_buffer = imgui.ImBuffer(256)
local texter = imgui.ImBuffer(256)
local mep = imgui.ImInt(0)
local mepo = imgui.ImInt(0)
local prizemep = {u8'"Король Дигла"', u8'"Русская Рулетка"', u8'"Дамба"', u8'"Прятки"', u8'"Последний Выживший"', u8'"Поливалка"', u8'"Бомбардировка"', u8'"Таран"', u8'"PUBG"', u8'"Реакция"', u8'"Бои без правил"', u8'"Гонки"'}
local prizemp = {u8'"На Выбор"', u8'"Аптечки"', u8'"VIP-CAR"', u8'"Уровень на выбор"', u8'"Стиль Боя"', u8'Номер телефона на выбор', u8'Деньги', u8'Секрет', u8'Админ-права', u8'ПРОМОКОД'} 
local numbers = {'20+23', '34+78', '46*2' , '4*7', '52+56', '46+54', '20-8', '46-41', '7*8', '44/4' , '10+99', '412-413', '45-54', '7+5', '1+1', '888+111', '111+111'}
local word = {u8'04', u8'EKB', u8'MS', u8'Healme', u8'Kills', u8'LVL', u8'VIPCAR'}
local prizeon = {u8'"500 Аптечек"', u8'"200 Аптечек"', u8'"400 Аптечек"', u8'500 миллионов', u8'1337 убийств в статистику',  u8'"Костюм попугая"', u8'"Мигалку на голову"', u8'"Комплект всемогущий"', u8'"Огонек на голову"', u8'"Шляпу курицы"', u8'"Номер телефона на выбор"', u8'"1ккк"', u8'"Стиль Боя на Выбор"', u8'"500 убийств"', u8'"Уровень"', u8'"ВипКар"', u8'Бизнес', u8'Дом на VineWood', u8'секретный приз'}
require "lib.moonloader"
local dialogOtb = {'Ghetto', 'Goss', 'Mafia'}
local dialogOtbb = ''
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
update_state = false
local str_rand = {u8'Носок – ©Роман Бакун', u8'Овсянников это не овсяш а лосяш – ©Владислав Дмитров', u8'Чил – ©Даниил Чилатов', u8'Мыша и глупый глупый глупый кот. – ©Дарья Веркеева', u8'Ты кто такой – ©Влад Гунинык', u8'дмитров куколд – ©Александр Овсянников', u8"помните: мари граса гей – ©Данил Оклей", u8"АФКшу месяц на И.О– ©Сергей Семець"}
local script_vers = 22
local script_vers_text = '1.22'
local update_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/update.ini'
local update_path = getWorkingDirectory() .. '/update.ini'

local script_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/EkbTool.luac'
local script_path = thisScript().path

local table_nazaz = {
    u8'Деморган',

    u8'ДМ = 10 минут',
    u8'ДБ = 10 минут',
    u8'ПГ = 5 минут',
    u8'РК = 5 минут',
    u8'Багоюз = 15 минут',
    u8'Срыв набора = 15 минут',
    u8'Использование чит-программ во фракции = 30 минут + увольнение',
    u8'Читы = 60 минут',
    u8'Читы на капте/стреле = warn -> /ban',
    u8'Вред читы = /iban',
    u8'Читы в ДМЗ = Бан на 5 дней',
    u8'Помеха на капте/стреле = 5 минут дмз -> warn',
    u8'NonRP = 10 минут',
    u8'Офф от наказания = 1 день /ban',
    u8'Оскорбительный ник = 7 дней /ban'
}

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

function refresh_current_report()
	table.remove(reports, 1)
end

function obnova(arg)
    sampShowDialog(212, "{FFFFFF}О{FF0000}Б{000000}Н{FA8072}О{8B0000}В{FF1493}Л{006400}Е{808000}Н{FF4500}И{FF8C00}Е", "Добавлен цитатник! В /raz теперь вы сможете видеть фразы любимых руководящих!\n{FFFFFF}Исправлены баги!\n{FF00FF}ШОК! ТЕПЕРЬ ВЫ СМОЖЕТЕ ОТВЕЧАТЬ В 10 РАЗ ПРОДУКТИВНЕЕ /OTV! /rhelp!\nВ /nak добавлена система наказаний!", "Закрыть", 'Закрыть', 0)
end

function cmd_balalai2(arg)
    second_window_state.v = not second_window_state.v
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

function cmd_spv(arg)
    if #arg == 0 then
        sampAddChatMessage('Введите ID', -1)
    else
        lua_thread.create(function()
            sampSendChat('/slap ' .. arg)
            wait(1000)
            sampSendChat('/sp ' .. arg)
        end)
    end
end

function cmd_nakaz(arg)
    third_window_state.v = not third_window_state.v
    imgui.Process = third_window_state.v 
end

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function sampev.onServerMessage(color, text)
    if text:find('Репорт от (.*)%[(%d+)%]: %{FFFFFF%}(.*)') then
        local Rnickname, Rid, RtextP = text:match('Репорт от (.*)%[(%d+)%]: %{FFFFFF%}(.*)')
        reports[#reports + 1] = {nickname = Rnickname, id = Rid, textP = RtextP}
    end
    if #reports > 0 then
        if color == -6732289 then
            for k, v in pairs(reports) do
                if k == 1 then
                    if not tableOfNew.AutoReport.v then
                        if text:find('%[.%] (.*)%[(%d+)%] для '..reports[1].nickname..'%['..reports[1].id..'%]: (.*)') then
                            refresh_current_report()
                        end
                    end
                elseif #reports > 1 then
                    if text:find('%[.%] (.*)%[(%d+)%] для '..reports[k].nickname..'%['..reports[k].id..'%]: (.*)') then
                        table.remove(reports, k)
                    end
                end
            end
        end
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
        sampShowDialog(209, 'Команды этого скрипта', "\n{FFFFFF}/otb - сделать отбор \n{FF0000}/raz - cделать раздачу \n{FF0000}/nap - сделать напоминание \n{FF00FF}/mep - сделать мероприятие \n{00FFFF}/car[id] - выдать машину игроку \n /sp[id] - заспавнить игрока(Работает в даже в случае если игрок в Т/С) \n /otv - меню ответов на репорт \n/nak - Система Наказаний", "Выдать", 'Закрыть', 2)
    end
end

function cmd_otv(arg)
    tableOfNew.AutoReport.v = not tableOfNew.AutoReport.v
    imgui.Process = tableOfNew.AutoReport.v
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
    sampRegisterChatCommand('nak', cmd_nakaz)
    sampRegisterChatCommand('sp', cmd_spv)
    sampRegisterChatCommand('mep', cmd_balalai2)
    sampRegisterChatCommand('otv', cmd_otv)
    imgui.SwitchContext()
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage('{00FFFF}Мой бот обнаружил обновление: ' .. updateIni.info.vers_text, -1)
                update_state = true
            else
                return
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
        wait(5000)
        ran2 = math.random(1, #str_rand)
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
end

function imgui.OnDrawFrame()
    if not main_window_state.v and not second_window_state.v and not tableOfNew.AutoReport.v and not tableOfNew.tableRes.v and not third_window_state.v then
        imgui.Process = false
    end
    apply_custom_style()
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
        imgui.Text(str_rand[ran2])
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
    if tableOfNew.AutoReport.v then
        imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(537, 450), imgui.Cond.FirstUseEver)	
        imgui.Begin(u8'Авто-Репорт', tableOfNew.AutoReport, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild('##i_report', imgui.ImVec2(520, 30), true)		
        if #reports > 0 then
            imgui.PushTextWrapPos(500)
            imgui.TextUnformatted(u8(reports[1].nickname..'['..reports[1].id..']: '..reports[1].textP))
            imgui.PopTextWrapPos()
        end
        imgui.EndChild()
        imgui.Separator()
        imgui.PushItemWidth(520)
        imgui.InputText(u8'##answer_input_report', tableOfNew.answer_report)
        imgui.PopItemWidth()
        imgui.Text(u8'                                                          Введите ответ')
        imgui.Separator()
        if imgui.Button(u8'Работать по ID', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                if reports[1].textP:find('%d+') then
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    lua_thread.create(function()
                        local id = reports[1].textP:match('(%d+)')
                        sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, начинаю работу по вашей жалобе!')
                        wait(1000)
                        sampSendChat('/re '..id)
                        refresh_current_report()
                    end)
                else
                    sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}В репорте отсутствует ИД.', stColor)
                end
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Помочь автору', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    sampSendChat('/goto '..reports[1].id)
                    wait(1000)
                    sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, сейчас попробую вам помочь!')		
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Следить', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    sampSendChat('/re '..reports[1].id)
                    local pID = reports[1].id
                    wait(1000)
                    sampSendChat('/pm '..pID..' Уважаемый игрок, начинаю работу по вашей жалобе!')
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Переслать', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    local bool = _sampSendChat(reports[1].nickname..'['..reports[1].id..']: '..reports[1].textP, 80)
                    wait(1000)
                    sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, передал вашу жалобу администрации.')
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Укажите ИД', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    sampSendChat('/pm '..reports[1].id..' Укажите ИД.')
                    refresh_current_report()
                end)
            end
        end
        imgui.Separator()
        local clr = imgui.Col
        imgui.PushStyleColor(clr.Button, imgui.ImVec4(0.86, 0.09, 0.09, 0.65))
        imgui.PushStyleColor(clr.ButtonHovered, imgui.ImVec4(0.74, 0.04, 0.04, 0.65))
        imgui.PushStyleColor(clr.ButtonActive, imgui.ImVec4(0.96, 0.15, 0.15, 0.50))
        if imgui.Button(u8'Оффтоп', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                imgui.OpenPopup(u8'Оффтоп')
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Оск.Адм', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 15 Оскорбление администрации')
                refresh_current_report()
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Оск.Род', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 60 Оскорбление родных')
                refresh_current_report()
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Капс', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 5 Капс')
                refresh_current_report()
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Обман Адм', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 15 Обман администрации')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'Оск Проекта', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 60 Оскорбление проекта')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Оск Игроков', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 15 Оскорбление игроков')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Мат', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 5 Мат')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Упом.Род', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/mute '..reports[1].id..' 30 Упоминание родных')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'ЧСС', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/iban '..reports[1].id..' Чсс')
                refresh_current_report()
            end
        end
        imgui.PopStyleColor(3)
        imgui.Separator()
        if imgui.Button(u8'ЖБ в СГ', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, вы можете оставить свою жалобу в нашей свободной группе ВК.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Не знаем', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Не знаем.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'РП Путём', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' РП Путём.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Выпустить', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, сейчас попробую вам помочь!')
                    wait(1000)
                    sampSendChat('/unjail '..reports[1].id)
                    refresh_current_report()
                end)
            end
        end imgui.SameLine()
        if imgui.Button(u8'Приятной игры', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Приятной игры на нашем сервере.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'Уточните', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, переформулируйте вашу жалобу так, чтобы была ясна ваша просьба/утверждение.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Ожидайте', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, убедительная просьба проявить терпение.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'У.Интернете', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Уточните в интернете.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Отказ', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, то, что вы просите - не может быть исполнено.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'РП Путём', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' РП Путём.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'Да', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Да.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Нет', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Нет.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/buybiz', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /buybiz.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/gps', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /gps.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/buylead', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /buylead.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/drecorder', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /drecorder.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/su', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /su [ID].')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/showudost', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /showudost.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/fvig', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /fvig.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/invite', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /invite.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/clear', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /clear.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/call', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /call.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/sms', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /sms [ID] [MESSAGE].')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/togphone', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /togphone.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/business', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /business.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/drag', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /drag [ID]')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/buyadm', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /buyadm')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/h', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /h.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/divorce', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /divorce.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/gov', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /gov.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/recorder', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /recorder.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/find', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /find.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/mm', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /mm')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/unrent', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /unrent.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/selfie', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /selfie.')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'/pgun', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /pgun.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/sellhouse', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /sellhouse')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/sellcar', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /sellcar')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/buycar', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /buycar')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/propose', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /propose')
                refresh_current_report()
            end
        end
        imgui.Separator()
        if imgui.Button(u8'Ответить', imgui.ImVec2(100, 0)) then
            if tableOfNew.answer_report.v == '' then
                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Введите корректный ответ.', stColor)
            else
                if #reports > 0 then
                    sampSendChat('/pm '..reports[1].id..' '..u8:decode(tableOfNew.answer_report.v))
                    refresh_current_report()
                    tableOfNew.answer_report.v = ''
                end
            end
        end imgui.SameLine()
        if imgui.Button(u8'СП', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, сейчас попробую вам помочь!')
                    wait(1000)
                    sampSendChat('/spawn '..reports[1].id)
                    refresh_current_report()
                end)
            end
        end imgui.SameLine()
        if imgui.Button(u8'Пропустить все', imgui.ImVec2(100, 0)) then
            reports = {
                [0] = {
                    nickname = '',
                    id = -1,
                    textP = ''
                }
            }
        end imgui.SameLine()
        if imgui.Button(u8'Выдать ХП', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                imgui.OpenPopup(u8'Выдача жизней')
            end	
        end	imgui.SameLine()
        if imgui.Button(u8'Пропустить', imgui.ImVec2(100, 0)) then
            refresh_current_report()
        end
        imgui.Separator()
        if imgui.BeginPopupModal(u8"Оффтоп", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
            if imgui.Button(u8"Сделать предупреждение", imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    sampSendChat("/pm "..reports[1].id.." Уважаемый игрок, при последующем осуществлении оффтопа - последует бан репорта.")
                    refresh_current_report()
                    imgui.CloseCurrentPopup()
                end
            end
            if imgui.Button(u8"Наказать", imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    sampSendChat("/rmute "..reports[1].id.." 10 ОффТоп")
                    refresh_current_report()
                    imgui.CloseCurrentPopup()
                end
            end 
            if imgui.Button(u8'Закрыть', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Выдача жизней", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize) then
            imgui.Text(u8'Выберите, сколько выдать ХП')
            imgui.PushItemWidth(175) imgui.SliderInt('##giveHpSlider', tableOfNew.givehp, 0, 100) imgui.PopItemWidth()
            if imgui.Button(u8'Выдать жизни', imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    lua_thread.create(function()
                        sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, сейчас попробую вам помочь!')
                        wait(1000)
                        sampSendChat('/sethp '..reports[1].id..' '..tableOfNew.givehp.v)
                        refresh_current_report()
                        imgui.CloseCurrentPopup()
                    end)
                end
            end
            if imgui.Button(u8'Закрыть', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        imgui.End()
    end
    if third_window_state.v then
        imgui.SetNextWindowPos(imgui.ImVec2(sw /2, sh /2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"##pensBar", third_window_state)
		imgui.SetWindowFontScale(1.1)
		imgui.Text(u8"Таблица наказаний:")
		imgui.SetWindowFontScale(1.0)
		imgui.Separator()
		imgui.BeginChild("##pens")
		imgui.Columns(2, _, false)
		imgui.SetColumnWidth(-1, 255)
		imgui.Text(u8(pensTable))
		imgui.NextColumn()
		imgui.Text(u8(timesTable))
		imgui.Columns(1)
		imgui.EndChild()
		imgui.End()
    end
end


function cmd_balalai(arg)
    main_window_state.v = not main_window_state.v
    imgui.Process = main_window_state.v
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