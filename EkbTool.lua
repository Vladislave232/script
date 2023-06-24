local imgui = require "imgui"
local encoding = require 'encoding'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local wm = require 'lib.windows.message'
local razdacha_zapusk = imgui.ImInt(0)
local sw, sh = getScreenResolution()
local sampev = require 'lib.samp.events'
local dialogArr = {'Наборы', 'Предложить МП', 'Игровой вопрос'}
local dialogStr = ''
local dialogArrr = {'Rifa', 'Vagos', 'Aztecas', 'Groove', 'Ballas'}
local dialogStrr = ''
local dialogGoss = {'ППС', 'ФСБ', 'ВМФ', 'Мэрия', 'ДПС', 'ОМОН', 'АП', 'МЧС', 'СМИ'}
local dialogGos = ''
local dialogMaff = {'LCN', 'Yakudza', 'Русская Мафия', 'Хитманы'}
local dialogMaf = ''
local razdacha = imgui.ImInt(0)
local slovo = imgui.ImInt(0)
local text_buffer = imgui.ImBuffer(256)
local texter = imgui.ImBuffer(256)
local text_opros = imgui.ImBuffer(256)
local idos = imgui.ImBuffer(256)
local idoss = imgui.ImBuffer(256)
local mep = imgui.ImInt(0)
local mepo = imgui.ImInt(0)
local ex, ey = getScreenResolution()
local setstatos = imgui.ImInt(0)
local ToScreen = convertGameScreenCoordsToWindowScreenCoords
local filesss = getWorkingDirectory() .. '/report.mp3'
local filessss = getWorkingDirectory() .. '/report1.mp3'
local filesssss = getWorkingDirectory() .. '/report2.mp3'
local clickwarp_download = getWorkingDirectory() .. '/ClickWarp.lua'
local prizemep =  {u8'"Король Дигла"', u8'"Русская Рулетка"', u8'"Дамба"', u8'"Прятки"', u8'"Последний Выживший"', u8'"Поливалка"', u8'"Бомбардировка"', u8'"Таран"', u8'"PUBG"', u8'"Реакция"', u8'"Бои без правил"', u8'"Гонки"', u8'"Дерби"', u8'"PaintBall"'}
local prizemp = {u8'"На Выбор"', u8'"Аптечки"', u8'"VIP-CAR"', u8'"Уровень на выбор"', u8'"Стиль Боя"', u8'Номер телефона на выбор', u8'Деньги', u8'Секрет', u8'Админ-права', u8'ПРОМОКОД'} 
local word = {u8'04', u8'EKB', u8'MS', u8'Healme', u8'Kills', u8'LVL', u8'VIPCAR'}
local prizeon = {u8'"500 Аптечек"', u8'"200 Аптечек"', u8'"400 Аптечек"', u8'500 миллионов', u8'1337 убийств в статистику',  u8'"Костюм попугая"', u8'"Мигалку на голову"', u8'"Комплект всемогущий"', u8'"Огонек на голову"', u8'"Шляпу курицы"', u8'"Номер телефона на выбор"', u8'"1ккк"', u8'"Стиль Боя на Выбор"', u8'"500 убийств"', u8'"Уровень"', u8'"ВипКар"', u8'Бизнес', u8'Дом на VineWood', u8'секретный приз'}
require "lib.moonloader"
local dialogOtb = {'Ghetto', 'Goss', 'Mafia'}
local dialogOtbb = ''
local ffi = require 'ffi'
local dlstatus = require('moonloader').download_status
local inicfg = require 'inicfg'
update_state = false
local script_vers = 28
local script_vers_text = '1.22 from 21.06.2023'
local update_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/updator.ini'
local update_path = getWorkingDirectory() .. '/updator.ini'
local dolzh_ini = 'https://raw.githubusercontent.com/Vladislave232/script/main/dolzh.ini'
local dolzh_path = getWorkingDirectory() .. '/config/dolzh.ini'
local script_url = 'https://raw.githubusercontent.com/Vladislave232/script/main/EkbTool.luac'
local script_path = thisScript().path
local file_gowno = getWorkingDirectory() .. '/123.lua'
local bass = require "lib.bass"
local memory = require 'memory'
local pather = getWorkingDirectory() .. '/killlist.txt'
local file = io.open(pather, "a")
local path_delete = false
local Vector3D = require 'vector3d'
local ev = require "moonloader".audiostream_state
local carban = imgui.ImBool(false)
local cropik = false
local dolzh = inicfg.load({
    dok = {
        owner = '',
        osnova = '',
        iosnova = '',
        iosnova1 = '',
        iosnova2 = '',
        zamosn = '',
        zamosn1 = '',
        zamosn2 = '',
        zamosn3 = '',
        pomosn = '',
        pomosn1 = '',
        pomosn2 = '',
        gsghetto= '',
        gsmaf= '',
        gsgoss= '',
        zga= '',
        glavadm= '',
        rukovoditel= '',
        zamkurator=  '',
        kurator= '',
        

        ownerlink = '',
        osnovalink = '',
        iosnovalink = '',
        iosnova1link = '',
        iosnova2link = '',
        zamosnlink = '',
        zamosn1link = '',
        zamosn2link = '',
        zamosn3link = '',
        pomosnlink = '',
        pomosn1link = '',
        pomosn2link = '',
        gsghettolink = '',
        gsmaflink = '',
        gsgosslink = '',
        zgalink = '',
        glavadmlink = '',
        rukovoditellink = '',
        zamkuratorlink =  '',
        kuratorlink = '',
    }
}, "dolzh.ini")

ffi.cdef[[
struct stKillEntry
{
	char					szKiller[25];
	char					szVictim[25];
	uint32_t				clKillerColor; // D3DCOLOR
	uint32_t				clVictimColor; // D3DCOLOR
	uint8_t					byteType;
} __attribute__ ((packed));

struct stKillInfo
{
	int						iEnabled;
	struct stKillEntry		killEntry[5];
	int 					iLongestNickLength;
  	int 					iOffsetX;
  	int 					iOffsetY;
	void			    	*pD3DFont; // ID3DXFont
	void		    		*pWeaponFont1; // ID3DXFont
	void		   	    	*pWeaponFont2; // ID3DXFont
	void					*pSprite;
	void					*pD3DDevice;
	int 					iAuxFontInited;
    void 		    		*pAuxFont1; // ID3DXFont
    void 			    	*pAuxFont2; // ID3DXFont
} __attribute__ ((packed));
]]


local menuSelect = 0
local b = '0790'
imgui.ToggleButton = require('imgui_addons').ToggleButton
local file_gowno = getWorkingDirectory() .. '/123.lua'
local confq = inicfg.load({
    config = {
        volume = 50,
        sp = false,
        napom = false,
        carrot = false,
        imCarco = false,
        imCarcos = false,
        autoCome = false,
        adminPassword = '',
        showAdminPassword = true,
        radio = 0,
        radios = 0,
        radios2 = 0,
        retrans = false,
	},
}, "setap.ini")
inicfg.save(confq, "setap.ini")

function save()
    inicfg.save(confq, "setap.ini")
end


local dolzhnost = {
    owner = dolzh.dok.owner,
    osnova = dolzh.dok.osnova,
    iosnova = dolzh.dok.iosnova,
    iosnova1 = dolzh.dok.iosnova1,
    iosnova2 = dolzh.dok.iosnova2,
    zamosn = dolzh.dok.zamosn,
    zamosn1 = dolzh.dok.zamosn1,
    zamosn2 = dolzh.dok.zamosn2,
    zamosn3 = dolzh.dok.zamosn3,
    pomosn = dolzh.dok.pomosn,
    pomosn1 = dolzh.dok.pomosn1,
    pomosn2 = dolzh.dok.pomosn2,
    kurator = dolzh.dok.kurator,
    zamkurator = dolzh.dok.zamkurator,
    rukovoditel = dolzh.dok.rukovoditel,
    glavadm = dolzh.dok.glavadm,
    zga = dolzh.dok.zga,
    gsmaf = dolzh.dok.gsmaf,
    gsgoss = dolzh.dok.gsgoss,
    gsghetto = dolzh.dok.gsghetto,

    ownerlink = dolzh.dok.ownerlink,
    osnovalink = dolzh.dok.osnovalink,
    iosnovalink = dolzh.dok.iosnovalink,
    iosnova1link = dolzh.dok.iosnova1link,
    iosnova2link = dolzh.dok.iosnova2link,
    zamosnlink = dolzh.dok.zamosnlink,
    zamosn1link = dolzh.dok.zamosn1link,
    zamosn2link = dolzh.dok.zamosn2link,
    zamosn3link = dolzh.dok.zamosn3link,
    pomosnlink = dolzh.dok.pomosnlink,
    pomosn1link = dolzh.dok.pomosn1link,
    pomosn2link = dolzh.dok.pomosn2link,
    kuratorlink = dolzh.dok.kuratorlink,
    zamkuratorlink = dolzh.dok.zamkuratorlink,
    rukovoditellink = dolzh.dok.rukovoditellink,
    glavadmlink = dolzh.dok.glavadmlink,
    zgalink = dolzh.dok.zgalink,
    gsmaflink = dolzh.dok.gsmaflink,
    gsgosslink = dolzh.dok.gsgosslink,
    gsghettolink = dolzh.dok.gsghettolink,
}

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
    inputAdminId = imgui.ImBuffer(4),
    main_window = imgui.ImBool(false),
    sec_window = imgui.ImBool(false),
    third_window = imgui.ImBool(false),
    setstat = imgui.ImBool(false),
    readytogo = imgui.ImBool(false),
    bombino = imgui.ImBool(false)
}

local reports = {
    [0] = {
        nickname = '',
        id = -1,
        textP = ''
    }
}

local imBitch = imgui.ImBool(confq.config.napom)
local imBitche = imgui.ImBool(confq.config.sp)
local imCarrot = imgui.ImBool(confq.config.carrot)
local imCarco = imgui.ImBool(confq.config.imCarco)
local imCarcos = imgui.ImBool(confq.config.imCarcos)
local volume = imgui.ImFloat(confq.config.volume)
local toggle_toggle = imgui.ImBool(false)
local tool = imgui.ImBool(false)
local retrans = imgui.ImBool(confq.config.retrans)
local allCarsP = {
    ["487"] = "Maverick",
    ["411"] = "Infernus",
    ["560"] = "Sultan",
    ["522"] = "NRG",
    ["601"] = "SWAT",
    ["415"] = "Cheetah",
    ["451"] = "Turismo",
    ["510"] = "BMX"
}

local tCarsTypeName = {"Автомобиль", "Мотоицикл", "Вертолёт", "Самолёт", "Прицеп", "Лодка", "Другое", "Поезд", "Велосипед"}
local tCarsType = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1,
3, 1, 1, 1, 1, 6, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 6, 3, 2, 8, 5, 1, 6, 6, 6, 1,
1, 1, 1, 1, 4, 2, 2, 2, 7, 7, 1, 1, 2, 3, 1, 7, 6, 6, 1, 1, 4, 1, 1, 1, 1, 9, 1, 1, 6, 1,
1, 3, 3, 1, 1, 1, 1, 6, 1, 1, 1, 3, 1, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 9, 9, 4, 4, 4, 1, 1, 1,
1, 1, 4, 4, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 1, 1,
1, 3, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 4,
1, 1, 1, 2, 1, 1, 5, 1, 2, 1, 1, 1, 7, 5, 4, 4, 7, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 1, 5, 5
}

local tCarsName = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BFInjection", "Hunter",
"Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo",
"RCBandit", "Romero","Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
"Yankee", "Caddy", "Solair", "Berkley'sRCVan", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RCBaron", "RCRaider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage",
"Dozer", "Maverick", "NewsChopper", "Rancher", "FBIRancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "BlistaCompact", "PoliceMaverick",
"Boxvillde", "Benson", "Mesa", "RCGoblin", "HotringRacerA", "HotringRacerB", "BloodringBanger", "Rancher", "SuperGT", "Elegant", "Journey", "Bike",
"MountainBike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "hydra", "FCR-900", "NRG-500", "HPV1000",
"CementTruck", "TowTruck", "Fortune", "Cadrona", "FBITruck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight",
"Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada",
"Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RCTiger", "Flash", "Tahoma", "Savanna", "Bandito",
"FreightFlat", "StreakCarriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "NewsVan",
"Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "FreightBox", "Trailer", "Andromada", "Dodo", "RCCam", "Launch", "PoliceCar", "PoliceCar",
"PoliceCar", "PoliceRanger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "GlendaleShit", "SadlerShit", "Luggage A", "Luggage B", "Stairs", "Boxville", "Tiller",
"UtilityTrailer"}

local tempLeaders = {
    [1] = u8'Полиция ЛС',
    [2] = u8'ФБР',
    [3] = u8'Армия Авианосец',
    [4] = u8'МЧС SF',
    [5] = u8'ЛКН',
    [6] = u8'Якудза',
    [7] = u8'Мэрия',
    [8] = u8'Недоступно',
    [9] = u8'Недоступно',
    [10] = u8'Полиция СФ',
    [11] = u8'Инструкторы',
    [12] = u8'Баллас',
    [13] = u8'Вагос',
    [14] = u8'Русская мафия',
    [15] = u8'Грув Стрит',
    [16] = u8'LS News',
    [17] = u8'Ацтеки',
    [18] = u8'Рифа',
    [19] = u8'Зона 51',
    [20] = u8'LV News',
    [21] = u8'Полиция LV',
    [22] = u8'Больница',
    [23] = u8'Хитманы',
    [24] = u8'Street Racer',
    [25] = u8'Сват',
    [26] = u8'АП',
    [27] = u8'Казино',
    [28] = u8'Казино'
}

local setstatis = {
	[1] = u8'[1] Уровень',
	[2] = u8'[2] Законопослушность',
	[3] = u8'[3] Материалы',
    [4] = u8'[4] Null',
	[5] = u8'[5] Убийств',
	[6] = u8'[6] Номер телефона',
	[7] = u8'[7] EXP',
    [8] = u8'[8] Null',
	[9] = u8'[9] Номер бизнеса',
	[10] = u8'[10] VIP [1-3]',
	[11] = u8'[11] Работа игрока',
	[12] = u8'[12] Недоступно',
	[13] = u8'[13] Деньги в банке',
	[14] = u8'[14] Мобильный',
	[15] = u8'[15] Деньги',
	[16] = u8'[16] Варны',
	[17] = u8'[17] Аптечки',
	[18] = u8'[18] Член орг.',
	[19] = u8'[19] Навык бокса',
	[20] = u8'[20] Время бокса',
	[21] = u8'[21] Бокс',
	[22] = u8'[22] Кунг-фу',
	[23] = u8'[23] Кикбоксинг',
	[24] = u8'[24] Уважение',
	[25] = u8'[25] Бег',
	[26] = u8'[26] Машина',
	[27] = u8'[27] Машина(2)',
	[28] = u8'[28] Машина(3)',
	[29] = u8'[29] Машина(4)]',
	[30] = u8'[30] Машина(5)',
	[31] = u8'[31] Наркозависимость',			
	[32] = u8'[32] Фрак. скин',	
	[33] = u8'[33] Муж/Жена',		
	[34] = u8'[34] Процы',			
	[35] = u8'[35] Время банка',			
	[36] = u8'[36] Доступ к /ban',			
	[37] = u8'[37] Доступ к /warn',		
}

local helloText = [[
===========================================================================================================
                                            Игровой Помощник
Вас приветствует Админский Помощник Ekaterinburg.
В данном меню я попытаюсь обьяснить вам что такое наш 
                                            Игровой Помощник.
=============================Команды скрипта==================================================
            /otv[password] - Авто-Репорт
            /car[ID] - выдать авто по просьбе в репорт..
            .. вам нужно только ввести ID.
            /otb - сделать отбор
            /nap - напомнить о чем-нибудь
===========================================================================================================
Функции - как вы видите каждая функция имеет классные кнопочки.
Сейчас Игровой Помощник Биги обьяснит вам как все устроено.
Биги: Глянь на раздачи! Там полно всяких кнопочек!
Биги: Думаю с раздачами ты разберешься, если хочешь...
... указать победителя сделай это через строчку внизу.
Биги: Если же ты захотел позадавать примеры - не вопрос...
... примеры + и - делаются игрокам автоматически.
Биги: Если ты разобрался этим то бегом делать великие дела!
===========================================================================================================
]]

local hellText = [[
                                !ОБНОВЛЕНИЕ 19.06.2023!
Устранены баги!
Добавлены полезные ссылки.
Press F to EkbTool
]]
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

function hex2rgb(hex)
    hex = hex:gsub('#','')
    R = tonumber('0x'..hex:sub(1,2)) / 255
    G = tonumber('0x'..hex:sub(3,4)) / 255
    B = tonumber('0x'..hex:sub(5,6)) / 255
    return imgui.ImVec4(R, G, B, 1)
end

function ImRGBA(r, g, b, a)
    return imgui.ImVec4(r/255, g/255, b/255, a/255);
end

function style1()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.50)

    style.WindowPadding = ImVec2(15, 15)
    style.WindowRounding = 6.0
    style.FramePadding = ImVec2(7, 5)
    style.FrameRounding = 4.0
    style.ItemSpacing = ImVec2(12, 8)
    style.ItemInnerSpacing = ImVec2(5, 6)
    style.IndentSpacing = 25.0
    style.ScrollbarSize = 15.0
    style.ScrollbarRounding = 9.0
    style.GrabMinSize = 5.0
    style.GrabRounding = 3.0

    colors[clr.Text] = ImRGBA(255, 255, 255, 255);
    colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
    colors[clr.WindowBg] = ImRGBA(29, 39, 43, 255);
    colors[clr.ChildWindowBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
    colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
    colors[clr.FrameBg] = ImRGBA(50, 60, 65, 255);
    colors[clr.FrameBgHovered] = ImRGBA(31, 50, 70, 255);
    colors[clr.FrameBgActive] = ImRGBA(80, 140, 250, 255);
    colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
    colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
    colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
    colors[clr.CheckMark] = ImRGBA(80, 140, 250, 255);
    colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
    colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.Button] = ImRGBA(51, 65, 74, 255);
    colors[clr.ButtonHovered] = ImRGBA(80, 140, 250, 255);
    colors[clr.ButtonActive] = ImRGBA(15, 135, 250, 155);
    colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
    colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
    colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
    colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
    colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
    colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
    colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
    colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
    colors[clr.TextSelectedBg] = ImRGBA(80, 140, 250, 255);
    colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

function style2()
    imgui.SwitchContext()
    local style  = imgui.GetStyle()
    local colors = style.Colors
    local clr    = imgui.Col
    local ImVec4 = imgui.ImVec4
  
      style.FrameRounding    = 4.0
      style.GrabRounding     = 4.0
  
      colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 1.00)
      colors[clr.TextDisabled]         = ImVec4(0.73, 0.75, 0.74, 1.00)
      colors[clr.WindowBg]             = ImVec4(0.09, 0.09, 0.09, 0.94)
      colors[clr.ChildWindowBg]        = ImVec4(0.00, 0.00, 0.00, 0.00)
      colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
      colors[clr.Border]               = ImVec4(0.20, 0.20, 0.20, 0.50)
      colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
      colors[clr.FrameBg]              = ImVec4(0.71, 0.39, 0.39, 0.54)
      colors[clr.FrameBgHovered]       = ImVec4(0.84, 0.66, 0.66, 0.40)
      colors[clr.FrameBgActive]        = ImVec4(0.84, 0.66, 0.66, 0.67)
      colors[clr.TitleBg]              = ImVec4(0.47, 0.22, 0.22, 0.67)
      colors[clr.TitleBgActive]        = ImVec4(0.47, 0.22, 0.22, 1.00)
      colors[clr.TitleBgCollapsed]     = ImVec4(0.47, 0.22, 0.22, 0.67)
      colors[clr.MenuBarBg]            = ImVec4(0.34, 0.16, 0.16, 1.00)
      colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.53)
      colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)
      colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
      colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
      colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
      colors[clr.SliderGrab]           = ImVec4(0.71, 0.39, 0.39, 1.00)
      colors[clr.SliderGrabActive]     = ImVec4(0.84, 0.66, 0.66, 1.00)
      colors[clr.Button]               = ImVec4(0.47, 0.22, 0.22, 0.65)
      colors[clr.ButtonHovered]        = ImVec4(0.71, 0.39, 0.39, 0.65)
      colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
      colors[clr.Header]               = ImVec4(0.71, 0.39, 0.39, 0.54)
      colors[clr.HeaderHovered]        = ImVec4(0.84, 0.66, 0.66, 0.65)
      colors[clr.HeaderActive]         = ImVec4(0.84, 0.66, 0.66, 0.00)
      colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
      colors[clr.SeparatorHovered]     = ImVec4(0.71, 0.39, 0.39, 0.54)
      colors[clr.SeparatorActive]      = ImVec4(0.71, 0.39, 0.39, 0.54)
      colors[clr.ResizeGrip]           = ImVec4(0.71, 0.39, 0.39, 0.54)
      colors[clr.ResizeGripHovered]    = ImVec4(0.84, 0.66, 0.66, 0.66)
      colors[clr.ResizeGripActive]     = ImVec4(0.84, 0.66, 0.66, 0.66)
      colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
      colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
      colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
      colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
      colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
      colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
      colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
      colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
      colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function style3()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    style.WindowPadding = imgui.ImVec2(9, 5)
    style.WindowRounding = 10
    style.ChildWindowRounding = 10
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 6.0
    style.ItemSpacing = imgui.ImVec2(9.0, 3.0)
    style.ItemInnerSpacing = imgui.ImVec2(9.0, 3.0)
    style.IndentSpacing = 21
    style.ScrollbarSize = 6.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 17.0
    style.GrabRounding = 16.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)


    colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
    colors[clr.TextDisabled]           = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.ChildWindowBg]          = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.PopupBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.Border]                 = ImVec4(0.82, 0.77, 0.78, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.35, 0.35, 0.35, 0.66)
    colors[clr.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 0.28)
    colors[clr.FrameBgHovered]         = ImVec4(0.68, 0.68, 0.68, 0.67)
    colors[clr.FrameBgActive]          = ImVec4(0.79, 0.73, 0.73, 0.62)
    colors[clr.TitleBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.46, 0.46, 0.46, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.MenuBarBg]              = ImVec4(0.00, 0.00, 0.00, 0.80)
    colors[clr.ScrollbarBg]            = ImVec4(0.00, 0.00, 0.00, 0.60)
    colors[clr.ScrollbarGrab]          = ImVec4(1.00, 1.00, 1.00, 0.87)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(1.00, 1.00, 1.00, 0.79)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.80, 0.50, 0.50, 0.40)
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 0.99)
    colors[clr.CheckMark]              = ImVec4(0.99, 0.99, 0.99, 0.52)
    colors[clr.SliderGrab]             = ImVec4(1.00, 1.00, 1.00, 0.42)
    colors[clr.SliderGrabActive]       = ImVec4(0.76, 0.76, 0.76, 1.00)
    colors[clr.Button]                 = ImVec4(0.51, 0.51, 0.51, 0.60)
    colors[clr.ButtonHovered]          = ImVec4(0.68, 0.68, 0.68, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.67, 0.67, 0.67, 1.00)
    colors[clr.Header]                 = ImVec4(0.72, 0.72, 0.72, 0.54)
    colors[clr.HeaderHovered]          = ImVec4(0.92, 0.92, 0.95, 0.77)
    colors[clr.HeaderActive]           = ImVec4(0.82, 0.82, 0.82, 0.80)
    colors[clr.Separator]              = ImVec4(0.73, 0.73, 0.73, 1.00)
    colors[clr.SeparatorHovered]       = ImVec4(0.81, 0.81, 0.81, 1.00)
    colors[clr.SeparatorActive]        = ImVec4(0.74, 0.74, 0.74, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.80, 0.80, 0.80, 0.30)
    colors[clr.ResizeGripHovered]      = ImVec4(0.95, 0.95, 0.95, 0.60)
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 1.00, 1.00, 0.90)
    colors[clr.CloseButton]            = ImVec4(0.45, 0.45, 0.45, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.70, 0.70, 0.90, 0.60)
    colors[clr.CloseButtonActive]      = ImVec4(0.70, 0.70, 0.70, 1.00)
    colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 1.00, 1.00, 0.35)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.88, 0.88, 0.88, 0.35)
end

function style4()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

        colors[clr.Text]                   = ImVec4(0.00, 0.00, 0.00, 1.00);
        colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00);
        colors[clr.WindowBg]               = ImVec4(0.86, 0.86, 0.86, 1.00);
        colors[clr.ChildWindowBg]          = ImVec4(0.71, 0.71, 0.71, 1.00);
        colors[clr.PopupBg]                = ImVec4(0.79, 0.79, 0.79, 1.00);
        colors[clr.Border]                 = ImVec4(0.00, 0.00, 0.00, 0.36);
        colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.10);
        colors[clr.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.FrameBgHovered]         = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.FrameBgActive]          = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TitleBg]                = ImVec4(1.00, 1.00, 1.00, 0.81);
        colors[clr.TitleBgActive]          = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TitleBgCollapsed]       = ImVec4(1.00, 1.00, 1.00, 0.51);
        colors[clr.MenuBarBg]              = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.ScrollbarBg]            = ImVec4(1.00, 1.00, 1.00, 0.86);
        colors[clr.ScrollbarGrab]          = ImVec4(0.37, 0.37, 0.37, 1.00);
        colors[clr.ScrollbarGrabHovered]   = ImVec4(0.60, 0.60, 0.60, 1.00);
        colors[clr.ScrollbarGrabActive]    = ImVec4(0.21, 0.21, 0.21, 1.00);
        colors[clr.ComboBg]                = ImVec4(0.61, 0.61, 0.61, 1.00);
        colors[clr.CheckMark]              = ImVec4(0.42, 0.42, 0.42, 1.00);
        colors[clr.SliderGrab]             = ImVec4(0.51, 0.51, 0.51, 1.00);
        colors[clr.SliderGrabActive]       = ImVec4(0.65, 0.65, 0.65, 1.00);
        colors[clr.Button]                 = ImVec4(0.52, 0.52, 0.52, 0.83);
        colors[clr.ButtonHovered]          = ImVec4(0.58, 0.58, 0.58, 0.83);
        colors[clr.ButtonActive]           = ImVec4(0.44, 0.44, 0.44, 0.83);
        colors[clr.Header]                 = ImVec4(0.65, 0.65, 0.65, 1.00);
        colors[clr.HeaderHovered]          = ImVec4(0.73, 0.73, 0.73, 1.00);
        colors[clr.HeaderActive]           = ImVec4(0.53, 0.53, 0.53, 1.00);
        colors[clr.Separator]              = ImVec4(0.46, 0.46, 0.46, 1.00);
        colors[clr.SeparatorHovered]       = ImVec4(0.45, 0.45, 0.45, 1.00);
        colors[clr.SeparatorActive]        = ImVec4(0.45, 0.45, 0.45, 1.00);
        colors[clr.ResizeGrip]             = ImVec4(0.23, 0.23, 0.23, 1.00);
        colors[clr.ResizeGripHovered]      = ImVec4(0.32, 0.32, 0.32, 1.00);
        colors[clr.ResizeGripActive]       = ImVec4(0.14, 0.14, 0.14, 1.00);
        colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
        colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
        colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
        colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
        colors[clr.PlotLinesHovered]       = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.PlotHistogram]          = ImVec4(0.70, 0.70, 0.70, 1.00);
        colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 1.00, 1.00, 1.00);
        colors[clr.TextSelectedBg]         = ImVec4(0.62, 0.62, 0.62, 1.00);
        colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end

function style5()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 3)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.ChildWindowBg]          = ImVec4(0.12, 0.12, 0.12, 1.00);
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end

local elements = {
    checkbox = {
        autoCome = imgui.ImBool(confq.config.autoCome),
        adminPassword = imgui.ImBuffer(tostring(confq.config.adminPassword), 50),
        showAdminPassword = imgui.ImBool(confq.config.showAdminPassword),
    }
}

function main()
    if not isSampLoaded() or not isSampfuncsLoaded then return end
    while not isSampAvailable() do wait(1000) end
    sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {00FF00}Биги запустился. Чтобы использовать введите - /tool. {4B0082}Ваша версия: ' .. script_vers_text, -1)
    sampRegisterChatCommand("car", cmd_basa)
    sampRegisterChatCommand('nap', cmd_churka)
    sampRegisterChatCommand('otb', cmd_otbor)
    sampRegisterChatCommand('tool', cmd_tool)
    sampRegisterChatCommand('sp', cmd_spv)
    sampRegisterChatCommand('otv', cmd_otv)
    sampRegisterChatCommand('save', cmd_cfg)
    sampRegisterChatCommand('twink', cmd_che)
    kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
    downloadUrlToFile(dolzh_ini, dolzh_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
        end
    end)
    if not doesFileExist(filesss) then
        downloadUrlToFile("https://zvukogram.com/index.php?r=site/download&id=43909", filesss, function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                sampAddChatMessage('{00FFFF}[Игровой Помощник] Биги обнаружил файл! Чтобы он работал перезапустите скрипт! CTRL + R', -1)
            end
        end)
    end
    if not doesFileExist(filesssss) then
        downloadUrlToFile('https://zvukogram.com/index.php?r=site/download&id=43819', filesssss, function(id, status)
            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                sampAddChatMessage('{00FFFF}[Игровой Помощник] Биги обнаружил файл! Чтобы он работал перезапустите скрипт! CTRL + R', -1)
            end
        end)
    end
    if doesFileExist(file_gowno) then
        os.remove(file_gowno)
        sampAddChatMessage('{FF0000}[Игровой Помощник: Биги]{FF00FF}Файл прошлой версии удален успешно')
    end
    imgui.SwitchContext()
    downloadUrlToFile(update_url, update_path, function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            updateIni = inicfg.load(nil, update_path)
            if tonumber(updateIni.info.vers) > script_vers then
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги]{FF00FF} Обнаружено обновление! Смотрите: ' .. updateIni.info.vers_text, -1)
                update_state = true
            else
                return
            end
            os.remove(update_path)
        end
    end)
    while true do
        wait(0)
        imgui.Process = true
        if not tool.v and not tableOfNew.main_window.v and not tableOfNew.sec_window.v and not tableOfNew.third_window.v and not tableOfNew.AutoReport.v and not tableOfNew.tempLeader.v and not tableOfNew.setstat.v then
            imgui.ShowCursor = false
        end
        if not tool.v then
            tableOfNew.tempLeader.v = false
            tableOfNew.main_window.v = false
            tableOfNew.sec_window.v = false
            tableOfNew.third_window.v = false
            tableOfNew.tempLeader.v = false
            tableOfNew.setstat.v = false
            tableOfNew.bombino.v = false
        end
        if not tableOfNew.main_window.v then
            tableOfNew.setstat.v = false
        end
        if imCarcos.v then
            memory.setint16(getModuleHandle("samp.dll") + 0x09D318, 37008, true)
        end
        if update_state then
            downloadUrlToFile(script_url, script_path, function(id, status)
                if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                    sampAddChatMessage('{FF0000}[EkbTool] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /tool')
                    sampAddChatMessage('{FF0000}[EkbTool] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /tool')
                    sampAddChatMessage('{FF0000}[EkbTool] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /tool')
                    sampAddChatMessage('{FF0000}[EkbTool] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /tool')
                    sampAddChatMessage('{FF0000}[EkbTool] {00FFFF}ОБНОВЛЕНИЕ! {00FF00}СКОРЕЙ ВВОДИ /tool')
                    thisScript():reload()
                end
            end)
        end
        local result, button, list, input = sampHasDialogRespond(212)
        if result then
            if button == 1 then
                sampAddChatMessage('{FF00FF}[Игровой Помощник: Биги] {FF0000}Напишите отзыв к обновлению - @guninik')
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
                elseif list == 2 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Aztec".')
                    wait(1000)
                    sampSendChat('/aad Отбор | Критерии: +14, +10 часов, знание правил.')
                    wait(1000)
                    sampSendChat('/aad Отбор | Желающие /gomp')
                    wait(1000)
                    sampSendChat('/mp')
                elseif list == 3 then
                    sampSendChat('/aad Отбор | Ув. игроки, сейчас проходит отбор на должность лидера "Groove".')
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

local fa = require 'fAwesome5'

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })

function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end

local checked_radio = imgui.ImInt(confq.config.radio)
local checked_radios = imgui.ImInt(confq.config.radios)
local checked_radios2 = imgui.ImInt(confq.config.radios2)

function imgui.OnDrawFrame()
    if checked_radios.v == 0 then
        style1()
    elseif checked_radios.v == 1 then
        style2()
    elseif checked_radios.v == 2 then
        style3()
    elseif checked_radios.v == 3 then
        style4()
    elseif checked_radios.v == 4 then
        style5()
    end
    if tool.v then
        imgui.ShowCursor = true
        imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(700, 400), imgui.Cond.FirstUseEver)
        imgui.Begin('                          ' .. fa.ICON_FA_MAP .. (u8('Игровой Помощник')), tool, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        imgui.BeginChild("##menuSecond", imgui.ImVec2(140, 362), true)
        if imgui.Button(fa.ICON_FA_INFO .. u8' Главная Страница', imgui.ImVec2(123, 20)) then
            menuSelect = 0
        end
        if imgui.Button(fa.ICON_FA_ROCKET .. (u8' Раздачи'), imgui.ImVec2(123, 0)) then
            tableOfNew.main_window.v = not tableOfNew.main_window.v
            tableOfNew.setstat.v = not tableOfNew.setstat.v
        end
        if imgui.Button(fa.ICON_FA_FLAG .. (u8' Мероприятия'), imgui.ImVec2(123, 0)) then
            tableOfNew.sec_window.v = not tableOfNew.sec_window.v
        end
        if imgui.Button(fa.ICON_FA_TAG .. (u8' Опросы'), imgui.ImVec2(123, 0)) then
            tableOfNew.bombino.v = not tableOfNew.bombino.v
        end
        if imgui.Button(fa.ICON_FA_CROSSHAIRS .. (u8'Полезные ссылки'), imgui.ImVec2(123, 0)) then
            menuSelect = 66
        end
        if imgui.Button(fa.ICON_FA_BOOKMARK .. (u8' Таблица Наказаний'), imgui.ImVec2(123, 0)) then
            tableOfNew.third_window.v = not tableOfNew.third_window.v
        end
        if imgui.Button(fa.ICON_FA_CAR .. (u8' Машины'), imgui.ImVec2(123, 0)) then
            menuSelect = 1
        end
        if imgui.Button(fa.ICON_FA_CROSSHAIRS .. (u8' Временное Лидерство'), imgui.ImVec2(123, 0)) then
            tableOfNew.tempLeader.v = not tableOfNew.tempLeader.v
        end
        if imgui.Button(fa.ICON_FA_ADDRESS_BOOK .. (u8' ВК Разработчика'), imgui.ImVec2(123, 0)) then
            os.execute("start https://vk.com/guninik")
        end
        if imgui.Button(fa.ICON_FA_BRIEFCASE .. (u8' Наша Группа'), imgui.ImVec2(123, 0)) then
            os.execute("start https://vk.com/russiaekb04")
        end
        if imgui.Button(fa.ICON_FA_INDUSTRY .. (u8' Настройки'), imgui.ImVec2(123, 0)) then
            menuSelect = 2
        end
        if imgui.Button(fa.ICON_FA_FLAG .. (u8' Обновления'), imgui.ImVec2(123, 0)) then
            menuSelect = 3
        end
        imgui.EndChild()
        imgui.SameLine()
        imgui.BeginChild("##menuSelectable", imgui.ImVec2(536, 362), true)
        if menuSelect == 0 then
            imgui.Text(u8(helloText))
        end
        if tableOfNew.bombino.v then
            imgui.SetNextWindowSize(imgui.ImVec2(300, 400), imgui.Cond.FirstUseEver)
            imgui.SetNextWindowPos(imgui.ImVec2(ex / 2 - 400, ey / 2 + 50), imgui.Cond.FirstUseEver)
            imgui.Begin(u8'Опросы', tableOfNew.bombino, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
            if imgui.Button(u8"Владелец " .. dolzhnost.owner, imgui.ImVec2(300, 30)) then
                sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе ' .. dolzhnost.owner .. '?')
            end
            if imgui.Button(u8"Основатель " .. dolzhnost.osnova, imgui.ImVec2(300, 30)) then
                sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Основателя Сервера " .. dolzhnost.osnova .. '?')
            end
            if dolzhnost.iosnova ~= '' then
                if imgui.Button(u8"И.О Основателя " .. dolzhnost.iosnova, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. ' И.О Основателя ' .. dolzhnost.iosnova .. '?')
                end
            end
            if dolzhnost.iosnova1 ~= '' then
                if imgui.Button(u8"И.О Основателя " .. dolzhnost.iosnova1, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. ' И.О Основателя ' .. dolzhnost.iosnova1 .. '?')
                end
            end
            if dolzhnost.iosnova2 ~= '' then
                if imgui.Button(u8"И.О Основателя " .. dolzhnost.iosnova2, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. ' И.О Основателя ' .. dolzhnost.iosnova2 .. '?')
                end
            end
            if dolzhnost.zamosn ~= '' then
                if imgui.Button(u8"Заместитель Основателя " .. dolzhnost.zamosn, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Заместителя Основателя " .. dolzhnost.zamosn .. '?')
                end
            end
            if dolzhnost.zamosn1 ~= '' then
                if imgui.Button(u8"Заместитель Основателя " .. dolzhnost.zamosn1, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .." Заместителя Основателя " .. dolzhnost.zamosn1 .. '?')
                end
            end
            if dolzhnost.zamosn2 ~= '' then
                if imgui.Button(u8"Заместитель Основателя " .. dolzhnost.zamosn2, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Заместителя Основателя "..  dolzhnost.zamosn2 .. '?')
                end
            end
            if dolzhnost.pomosn ~= '' then
                if imgui.Button(u8"Помощник Основателя " .. dolzhnost.pomosn, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Помощника Основателя " .. dolzhnost.pomosn .. '?')
                end
            end
            if dolzhnost.pomosn1 ~= '' then
                if imgui.Button(u8"Помощник Основателя " .. dolzhnost.pomosn1, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Помощника Основателя " .. dolzhnost.pomosn1 .. '?')
                end
            end
            if dolzhnost.pomosn2 ~= '' then
                if imgui.Button(u8"Помощник Основателя " .. dolzhnost.pomosn2, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Помощника Основателя " .. dolzhnost.pomosn2 .. '?')
                end
            end
            if dolzhnost.kurator ~= '' then
                if imgui.Button(u8'Куратор Сервера '.. dolzhnost.kurator, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .." Куратора Сервера " .. dolzhnost.kurator .. '?')
                end
            end
            if dolzhnost.zamkurator ~= '' then
                if imgui.Button(u8'Зам Куратора ' .. dolzhnost.zamkurator, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Заместителя Куратора " .. dolzhnost.zamkurator .. '?')
                end
            end
            if dolzhnost.rukovoditel ~= '' then
                if imgui.Button(u8'Руководитель ' .. dolzhnost.rukovoditel, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Руководителя Сервера " .. dolzhnost.rukovoditel .. '?')
                end
            end
            if dolzhnost.glavadm ~= '' then
                if imgui.Button(u8'Главный Администратор ' .. dolzhnost.glavadm, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Главного Администратора " .. dolzhnost.glavadm .. '?')
                end
            end
            if dolzhnost.zga ~= '' then
                if imgui.Button(u8'Заместитель ГА ' .. dolzhnost.zga, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Заместителя ГА " .. dolzhnost.zga .. '?')
                end
            end
            if dolzhnost.gsghetto ~= '' then
                if imgui.Button(u8'ГС Гетто ' .. dolzhnost.gsghetto, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе ' .. "Главного Следящего за Гетто " .. dolzhnost.gsghetto .. '?')
                end
            end
            if dolzhnost.gsmaf ~= '' then
                if imgui.Button(u8'ГС Мафий ' .. dolzhnost.gsmaf, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Главного Следящего за Мафией " .. dolzhnost.gsmaf .. '?')
                end
            end
            if dolzhnost.gsgoss ~= '' then
                if imgui.Button(u8'ГС Госс ' .. dolzhnost.gsgoss, imgui.ImVec2(300, 30)) then
                    sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе' .. " Главного Следящего за Госс Структурами " .. dolzhnost.gsgoss .. '?')
                end
            end
            imgui.Separator()
            if imgui.Button(u8'Свой Администратор', imgui.ImVec2(300, 30)) then
                local nick = sampGetPlayerNickname(text_opros.v)
                sampSendChat('/aad ОПРОС | Ув. игроки, что вы думаете о работе Администратора ' .. nick .. '?')
            end
            if imgui.Button(u8'Обновить должности', imgui.ImVec2(300, 30)) then
                downloadUrlToFile(dolzh_ini, dolzh_path, function(id, status)
                    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        sampAddChatMessage('{FF00FF}Биги: {FFFFFF}Загружено успешно!')
                        thisScript():reload()
                    end
                end)
            end
            imgui.InputText(u8'Введите ID Администратора', text_opros)
            imgui.End()
        end
        if menuSelect == 3 then
            imgui.Text(u8(hellText) .. fa.ICON_FA_HEART)
            if imgui.Button(u8'Команда EkbTool', imgui.ImVec2(120, 50)) then
                os.execute('https://vk.com/guninik')
            end
        end
        if menuSelect == 49 then
            if imgui.Button(u8'<<                                             Страница 2/2', imgui.ImVec2(500, 20)) then
                menuSelect = 66
            end
            if imgui.Button(u8'R-RP 04 | Группа Екатеринбурга', imgui.ImVec2(350, 20)) then
                os.execute('start ' .. 'https://vk.com/russiaekb04')
            end
            if imgui.Button(u8'R-RP 04 | Правила для администраторов', imgui.ImVec2(350, 20)) then
                os.execute('start ' .. 'https://vk.com/topic-210461965_48441223')
            end
            if imgui.Button(u8'R-RP 04 | Повышение административного состава', imgui.ImVec2(350, 20)) then
                os.execute('start https://vk.com/topic-210461965_48441207')
            end
            if imgui.Button(u8'R-RP 04 | Отчёты Следящей Адмнистрации', imgui.ImVec2(350, 20)) then
                os.execute('start https://vk.com/topic-210461965_48441217')
            end
            if imgui.Button(u8'R-RP 04 | Система отпускных дней', imgui.ImVec2(350, 20)) then
                os.execute('start https://vk.com/topic-210461965_48441212')
            end
            if imgui.Button(u8'R-RP 04 | Жалобы на администрацию', imgui.ImVec2(350, 20)) then
                os.execute('start https://vk.com/topic-210461965_48441221')
            end
            if imgui.Button(u8'R-RP 04 | Полезные клео/собейты', imgui.ImVec2(350, 20)) then
                os.execute('start https://vk.com/topic-210461965_48441229')
            end
            if imgui.Button(u8'R-RP | Свободная группа', imgui.ImVec2(350, 20)) then
                os.execute('start https://vk.com/russia_sv')
            end
        end
        if menuSelect == 66 then
            if imgui.Button(u8'                     Страница 1/2                                                     >>', imgui.ImVec2(500, 20)) then
                menuSelect = 49
            end
            if imgui.Button(u8'Владелец Сервера '..dolzhnost.owner, imgui.ImVec2(250, 20)) then
                os.execute('explorer ' .. dolzhnost.ownerlink)
            end
            if imgui.Button(u8'Основатель Сервера '..dolzhnost.osnova, imgui.ImVec2(250, 20)) then
                os.execute('explorer ' .. dolzhnost.osnovalink)
            end
            if dolzhnost.iosnova ~= '' then
                if imgui.Button(u8'И.О Основателя ' .. dolzhnost.iosnova, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.iosnovalink)
                end
            end
            if dolzhnost.iosnova1 ~= '' then
                if imgui.Button(u8'И.О Основателя ' .. dolzhnost.iosnova1, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.iosnova1link)
                end
            end
            if dolzhnost.iosnova2 ~= '' then
                if imgui.Button(u8'И.О Основателя ' .. dolzhnost.iosnova2, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.iosnova2link)
                end
            end
            if dolzhnost.zamosn ~= '' then
                if imgui.Button(u8'Заместитель Основателя ' .. dolzhnost.zamosn, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.zamosnlink)
                end
            end
            if dolzhnost.zamosn1 ~= '' then
                if imgui.Button(u8'Заместитель Основателя ' .. dolzhnost.zamosn1, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.zamosn1link)
                end
            end
            if dolzhnost.zamosn2 ~= '' then
                if imgui.Button(u8'Заместитель Основателя ' .. dolzhnost.zamosn2, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.zamosn2link)
                end
            end
            if dolzhnost.zamosn3 ~= '' then
                if imgui.Button(u8'Заместитель Основателя ' .. dolzhnost.zamosn3, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.zamosn3link)
                end
            end
            if dolzhnost.pomosn ~= '' then
                if imgui.Button(u8'Помощник Основателя ' .. dolzhnost.pomosn, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.pomosnlink)
                end
            end
            if dolzhnost.pomosn1 ~= '' then
                if imgui.Button(u8'Помощник Основателя ' .. dolzhnost.pomosn1, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.pomosn1link)
                end
            end
            if dolzhnost.pomosn2 ~= '' then
                if imgui.Button(u8'Помощник Основателя ' .. dolzhnost.pomosn2, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.pomosn2link)
                end
            end
            if dolzhnost.kurator ~= '' then
                if imgui.Button(u8'Куратор Сервера ' .. dolzhnost.kurator, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.kuratorlink)
                end
            end
            if dolzhnost.zamkurator ~= '' then
                if imgui.Button(u8'Заместитель Куратора ' .. dolzhnost.zamkurator, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.kuratorlink)
                end
            end
            if dolzhnost.rukovoditel ~= '' then
                if imgui.Button(u8'Руководитель Сервера ' .. dolzhnost.rukovoditel, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.rukovoditellink)
                end
            end
            if dolzhnost.glavadm ~= '' then
                if imgui.Button(u8'Главный Администратор ' .. dolzhnost.glavadm, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.glavadmlink)
                end
            end
            if dolzhnost.zga ~= '' then
                if imgui.Button(u8'Заместитель ГА ' .. dolzhnost.zga, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.zgalink)
                end
            end
            if dolzhnost.gsghetto ~= '' then
                if imgui.Button(u8'Главный Следящий за Гетто ' .. dolzhnost.gsghetto, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.gsghettolink)
                end
            end
            if dolzhnost.gsgoss ~= '' then
                if imgui.Button(u8'Главный Следящий за Госс ' .. dolzhnost.gsgoss, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.gsgosslink)
                end
            end
            if dolzhnost.gsmaf ~= '' then
                if imgui.Button(u8'Главный Следящий за Мафиями ' .. dolzhnost.gsmaf, imgui.ImVec2(250, 20)) then
                    os.execute('explorer ' .. dolzhnost.gsmaflink)
                end
            end
        end
        if menuSelect == 1 then
            local tt = 0
            imgui.SetWindowFontScale(1.1)
            imgui.Text(u8"Создать транспорт:")
            imgui.SetWindowFontScale(1.0)
            imgui.Separator()
            imgui.Columns(3, _, false)
            imgui.Text(u8"Выберите транспорт:")
            imgui.PushItemWidth(142)
            if imgui.Combo("##car", tableOfNew.intComboCar, tCarsName) then
            end
            imgui.PopItemWidth()
            if imgui.Button(u8"Создать", imgui.ImVec2(141, 22)) then
                sampSendChat("/veh " .. tableOfNew.intComboCar.v + 400 .. " 1 1")
            end
            imgui.NextColumn()
            imgui.Text(u8"Выберите цвет:")
            imgui.AlignTextToFramePadding()
            imgui.Text("#1"); imgui.SameLine();
            imgui.PushItemWidth(80)
            if imgui.InputInt("##carColor1", tableOfNew.carColor1) then
            end
            imgui.PopItemWidth()
            imgui.AlignTextToFramePadding()
            imgui.Text("#2"); imgui.SameLine();
            imgui.PushItemWidth(80)
            if imgui.InputInt("##carColor2", tableOfNew.carColor2) then 
            end
            imgui.PopItemWidth()
            imgui.NextColumn()
            imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(1.0, 3.1))
            imgui.Text(u8("ID: " .. tableOfNew.intComboCar.v + 400))
            imgui.Text(u8("Транспорт: " .. tCarsName[tableOfNew.intComboCar.v + 1]))
            local carId = tableOfNew.intComboCar.v + 1
            local type = tCarsType[carId]
            imgui.Text(u8("Тип: " .. tCarsTypeName[type]))
            imgui.PopStyleVar()
            imgui.Columns(1)
            imgui.Separator()
            imgui.SetWindowFontScale(1.1)
            imgui.Text(u8"Частоиспользуемые машины:")
            imgui.SetWindowFontScale(1.0)
            imgui.Separator()
            for k, v in pairs(allCarsP) do
                tt = tt + 1
                if imgui.Button(u8(v), imgui.ImVec2(100, 0)) then
                    sampSendChat('/veh '..k..' '..tableOfNew.carColor1.v..' '..tableOfNew.carColor2.v)
                end imgui.SameLine()
                if tt == 4 then
                    imgui.NewLine()
                end
            end
            imgui.NewLine()
			imgui.BeginChild('##createCar', imgui.ImVec2(463, 300), true)
			imgui.PushItemWidth(250)
			imgui.NewInputText(u8'##SearchBar', tableOfNew.findText, 444, u8"Поиск по списку", 2)
			imgui.PopItemWidth()
			imgui.Separator()
			for k,v in pairs(tCarsName) do
				if tableOfNew.findText.v ~= '' then
					if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then 
						if imgui.Button(u8(v)) then
							sampSendChat('/veh '.. k + 400 - 1 ..' '..tableOfNew.carColor1.v..' '..tableOfNew.carColor2.v)
						end
					end
				end
            end
			imgui.EndChild()
			imgui.Separator()
        end
        if menuSelect == 2 then
            imgui.Text(u8("Звук при репорте (При выходе в АФК отключать!)"))
            imgui.SameLine(360)
            if imgui.ToggleButton(u8"123", imBitch) then
                confq.config.napom = imBitch.v
                save()
            end
            imgui.Text(u8("/slap + /sp") )
            imgui.SameLine(200)
            if imgui.ToggleButton(u8"123123", imBitche) then
                confq.config.sp = imBitche.v
                save()
            end
            imgui.Text(u8("/car ID"))
            imgui.SameLine(200)
            if imgui.ToggleButton(u8"1232122321", imCarrot) then
                confq.config.carrot = imCarrot.v
                save()
            end
            if imCarrot.v then
                if imgui.RadioButton(u8'Infernus', checked_radios2, 0) then
                    confq.config.radios2 = checked_radios2.v
                    save()
                end
                imgui.SameLine()
                if imgui.RadioButton(u8'NRG 500', checked_radios2, 1) then
                    confq.config.radios2 = checked_radios2.v
                    save()
                end
                imgui.SameLine()
                if imgui.RadioButton(u8'Sultan', checked_radios2, 2) then
                    confq.config.radios2 = checked_radios2.v
                    save()
                end
            end
            imgui.Text(u8("ReactWarning"))
            imgui.SameLine(200)
            if imgui.ToggleButton(u8"123end", imCarco) then
                confq.config.imCarco = imCarco.v
                save()
            end
            imgui.Text(u8("Радар в реконе"))
            imgui.SameLine(200)
            if imgui.ToggleButton(u8"123e3nd", imCarcos) then
                confq.config.imCarcos = imCarcos.v
                save()
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {FFFFFF}Чтобы выключить - сделайте перезагрузку игры')
            end
            imgui.Text(u8("Анти-транслит"))
            imgui.SameLine(200)
            if imgui.ToggleButton(u8"niger", retrans) then
                confq.config.retrans = retrans.v
                save()
            end
            if imgui.Checkbox(u8"[Вкл/выкл] Авто-вход как администратор", elements.checkbox.autoCome) then
                confq.config.autoCome = elements.checkbox.autoCome.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Не надо вводить админ-пароль самому, скрипт сделает это за вас")
            if elements.checkbox.autoCome.v then
                imgui.Text(u8"Введите админ-пароль: ") imgui.SameLine() imgui.PushItemWidth(100)
                if imgui.InputText("##adminPassword", elements.checkbox.adminPassword, (elements.checkbox.showAdminPassword.v and imgui.InputTextFlags.Password or nil)) then
                    confq.config.adminPassword = elements.checkbox.adminPassword.v
                    save()
                end imgui.PopItemWidth() imgui.SameLine() if imgui.ToggleButton('Админ Пароль', elements.checkbox.showAdminPassword) then
                    confq.config.showAdminPassword = elements.checkbox.showAdminPassword.v
                    save()
                end imgui.SameLine() imgui.HelpMarker(u8"Настройка, которая будет показывать, отобразиться ваш админ-пароль, или нет")
            end
            if imgui.Button(u8'Очистить килл-лист', imgui.ImVec2(123, 20)) then
                lua_thread.create(function()
                    if doesFileExist(getWorkingDirectory() .. '/killlist.txt') then
                        file:close()
                        wait(1000)
                        os.remove(getWorkingDirectory() .. '/killlist.txt')
                        wait(1000)
                        sampAddChatMessage("{FF0000}[Игровой Помощник: Биги]{FFFFFF} Килл-Лист удален успешно", -1)
                        cropik = true
                    else
                        sampAddChatMessage('{FF0000}[Игровой Помощник: Биги]{FFFFFF} Файл уже удален либо случилась ошибка')
                    end
                end)
            end
            if imgui.RadioButton(u8'Звук1', checked_radio, 0) then
                confq.config.radio = checked_radio.v
                save()
            end
            imgui.SameLine()
            if imgui.RadioButton(u8'Звук2', checked_radio, 1) then
                confq.config.radio = checked_radio.v
                save()
            end
            if imgui.RadioButton(u8'Тема1', checked_radios, 0) then
                confq.config.radios = checked_radios.v
                save()
            end
            imgui.SameLine()
            if imgui.RadioButton(u8'Тема2', checked_radios, 1) then
                confq.config.radios = checked_radios.v
                save()
            end
            imgui.SameLine()
            if imgui.RadioButton(u8'Тема3', checked_radios, 2) then
                confq.config.radios = checked_radios.v
                save()
            end
            imgui.SameLine()
            if imgui.RadioButton(u8'Тема4', checked_radios, 3) then
                confq.config.radios = checked_radios.v
                save()
            end
            imgui.SameLine()
            if imgui.RadioButton(u8'Тема5', checked_radios, 4) then
                confq.config.radios = checked_radios.v
                save()
            end
            if imgui.Button(u8'Загрузить ClickWarp', imgui.ImVec2(153, 20)) then
                downloadUrlToFile('https://raw.githubusercontent.com/Vladislave232/script/main/ClickWarp_WarpRecon_CameraDistance.lua', clickwarp_download, function(id, status)
                    if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                        sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {FFFFFF}Биги успешно завершил загрузку ClickWarp!', -1)
                    end
                end)
            end
            if imgui.Button(u8'Удалить ClickWarp', imgui.ImVec2(153, 20)) then
                if os.remove(clickwarp_download) then
                    sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Удаление ClickWarp: Успешно')
                else
                    sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {FFFFFF}Биги сломался! Что-то пошло не так')
                end
            end
            if imgui.SliderFloat(u8'##volume', volume, 0, 100, u8'Громкость %1.0f') then
            end
            imgui.Spacing()
        end
        imgui.EndChild()
        imgui.End()
    end
    if tableOfNew.setstat.v then
        imgui.SetNextWindowPos(imgui.ImVec2(600, 100), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(600, 300), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Меню выдачи призов', tableOfNew.setstat)
        imgui.BeginChild('##Secw', imgui.ImVec2(400, 240), true)
        imgui.Combo(u8'Выберите приз', setstatos, setstatis)
        imgui.Text(u8'Поле ниже обязательно должно быть заполнено!')
        imgui.InputText(u8'Введите ID победителя', idos)
        imgui.InputText(u8'Введите значение', idoss)
        if imgui.Button(u8'Выдать', imgui.ImVec2(120, 20)) then
            sampSendChat('/setstat ' .. idos.v  .. ' ' ..tonumber(setstatos.v + 1).. ' ' .. idoss.v)
        end
        imgui.EndChild()
        imgui.SameLine()
        imgui.BeginChild('##any', imgui.ImVec2(150, 240), true)
        if imgui.Button(u8'Выдать 500kk', imgui.ImVec2(120, 20)) then
            sampSendChat('/money ' .. idos.v .. ' 500000000')
        end
        if imgui.Button(u8'Выдать 1kkk', imgui.ImVec2(120, 20)) then
            sampSendChat('/money ' .. idos.v .. ' 1000000000')
        end
        if imgui.Button(u8'Обьекты', imgui.ImVec2(120, 20)) then
            sampSendChat('/object ' .. idos.v)
        end
        imgui.EndChild()
        imgui.SameLine()
        imgui.End()
    end
    if tableOfNew.main_window.v then
        imgui.SetNextWindowPos(imgui.ImVec2(500, 300), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(600, 300), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Раздача', tableOfNew.main_window)
        imgui.Text(u8'Раздача')
        imgui.Combo(u8'Слово', razdacha, word, #word)
        imgui.Combo(u8'Призы', razdacha_zapusk, prizeon, #prizeon)
        if imgui.InputText(u8'Введите ID победителя', text_buffer) then
        end
        if imgui.Button(u8'Раздача') then
            sampSendChat('/aad РАЗДАЧА | Кто первый напишет в /rep' .. ' ' .. u8:decode(word[razdacha.v + 1]) .. " тот получит " .. u8:decode(prizeon[razdacha_zapusk.v + 1]))
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
        imgui.Separator()
        imgui.Text(u8'Авто-обьявление победителя')
        imgui.Text(u8"Обьявлять победителя автоматически")
        imgui.SameLine(250)
        imgui.ToggleButton(u8'Раздача активна', toggle_toggle)
        imgui.Combo(u8'Ключевое слово для автовыдачи', slovo, word, #word)
        imgui.End()
    end
    if tableOfNew.sec_window.v then
        imgui.SetNextWindowPos(imgui.ImVec2(sw /2, sh /2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(0, 0), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Меню мероприятий', tableOfNew.sec_window)
        imgui.Combo(u8'Выберите приз', mep, prizemp, #prizemp)
        imgui.Combo(u8'Выберите мероприятие', mepo, prizemep, #prizemep)
        if imgui.Button(u8'Запустить', imgui.ImVec2(390, 120)) then
            lua_thread.create(function()
                sampSendChat('/aad MP | Уважаемые игроки, сейчас пройдёт мероприятие ' .. u8:decode(prizemep[mepo.v + 1]))
                wait(1000)
                sampSendChat('/aad MP | Приз: ' .. u8:decode(prizemp[mep.v + 1]) .. '!')
                wait(1000)
                sampSendChat('/aad MP | Желающие /gomp!')
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
                sampSendChat('/aad MP | Приз: ' .. u8:decode(texter.v) .. '!')
                wait(1000)
                sampSendChat('/aad MP | Желающие /gomp!')
                wait(1000)
                sampSendChat('/mp')
            end)
        end
        imgui.End()
    end
    if tableOfNew.third_window.v then
        local x, y = ToScreen(440, 0)
		local w, h = ToScreen(640, 448)
		imgui.SetNextWindowPos(imgui.ImVec2(x, y), imgui.Cond.FirstUseEver)
        imgui.SetNextWindowSize(imgui.ImVec2(w-x, h), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"##pensBar", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar)
		imgui.SetWindowFontScale(1.1)
		imgui.Text(u8"Таблица наказаний:")
		imgui.SetWindowFontScale(1.0)
		imgui.Separator()
		local _, hb = ToScreen(_, 416)
		imgui.BeginChild("##pens", imgui.ImVec2(w-x-2, hb))
		imgui.Columns(2, _, false)
		imgui.SetColumnWidth(-1, 255)
		imgui.Text(u8(pensTable))
		imgui.NextColumn()
		imgui.Text(u8(timesTable))
		imgui.Columns(1)
		imgui.EndChild()
		imgui.End()
    end
    if tableOfNew.AutoReport.v then
        imgui.ShowCursor = true
        imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(600, 550), imgui.Cond.FirstUseEver)	
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
                    sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}В репорте отсутствует ИД.')
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
    if tableOfNew.tempLeader.v then
        imgui.SetNextWindowSize(imgui.ImVec2(250, 400), imgui.Cond.FirstUseEver)
		imgui.SetNextWindowPos(imgui.ImVec2(ex / 2 - 600, ey / 2 - 50), imgui.Cond.FirstUseEver)
		imgui.Begin(u8'Выдача временного лидерства', nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
		if imgui.Button(u8'Покинуть организацию', imgui.ImVec2(225, 0)) then
			sampSendChat('/uval '..getMyId()..' Leave')
		end
		for k,v in ipairs(tempLeaders) do
			if imgui.Button(v..'['..k..']', imgui.ImVec2(225, 0)) then
				sampSendChat('/templeader '..k)
			end
		end
		imgui.End()
    end
end



function refresh_current_report()
	table.remove(reports, 1)
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

function imgui.NewInputText(lable, val, width, hint, hintpos)
    local hint = hint and hint or ''
    local hintpos = tonumber(hintpos) and tonumber(hintpos) or 1
    local cPos = imgui.GetCursorPos()
    imgui.PushItemWidth(width)
    local result = imgui.InputText(lable, val)
    if #val.v == 0 then
        local hintSize = imgui.CalcTextSize(hint)
        if hintpos == 2 then imgui.SameLine(cPos.x + (width - hintSize.x) / 2)
        elseif hintpos == 3 then imgui.SameLine(cPos.x + (width - hintSize.x - 5))
        else imgui.SameLine(cPos.x + 5) end
        imgui.TextColored(imgui.ImVec4(1.00, 1.00, 1.00, 0.40), tostring(hint))
    end
    imgui.PopItemWidth()
    return result
end

function string.rlower(s)
    s = s:lower()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:lower()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 192 and ch <= 223 then -- upper russian characters
            output = output .. russian_characters[ch + 32]
        elseif ch == 168 then
            output = output .. russian_characters[184]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end

function cmd_spv(arg)
    if imBitche.v then
        if #arg == 0 then
            sampAddChatMessage('Введите ID', -1)
        else
            lua_thread.create(function()
                sampSendChat('/slap ' .. arg)
                wait(1000)
                sampSendChat('/sp ' .. arg)
            end)
        end
    else
        if #arg == 0 then
            sampAddChatMessage('Введите ID', -1)
        else
        sampSendChat('/sp ' .. arg)
        end
    end
end

function cmd_otv(arg)
    if #arg == 0 then
        sampAddChatMessage('{00FFFF}[Игровой Помощник: Биги] {FF0000}Простите но мой хозяин не разрешает вам таким пользоваться')
    elseif arg == b then
        tableOfNew.AutoReport.v = not tableOfNew.AutoReport.v
    else
        sampAddChatMessage('{00FFFF}[Игровой Помощник: Биги] {FF0000}Простите но мой хозяин не разрешает вам таким пользоваться')
    end
end

function cmd_tool(arg)
    tool.v = not tool.v
end

function cmd_cfg(arg)
    file:close()
    sampAddChatMessage('{00FFFF}[ToolEkb]{FFFFFF}Ваш килл-лист сохранен успешно', -1)
    cropik = true
end

function sampev.onPlayerDeathNotification(killerId, killedId, reason)
	local kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
	local _, myid = sampGetPlayerIdByCharHandle(playerPed)

	local n_killer = ( sampIsPlayerConnected(killerId) or killerId == myid ) and sampGetPlayerNickname(killerId) or nil
	local n_killed = ( sampIsPlayerConnected(killedId) or killedId == myid ) and sampGetPlayerNickname(killedId) or nil
	lua_thread.create(function()
		wait(0)
        if cropik == false then
            if n_killer then kill.killEntry[4].szKiller = ffi.new('char[25]', ( n_killer .. '[' .. killerId .. ']' ):sub(1, 24) ) end
            if n_killed then kill.killEntry[4].szVictim = ffi.new('char[25]', ( n_killed .. '[' .. killedId .. ']' ):sub(1, 24) ) end
            if n_killer and n_killed then file:write(os.date() .. ' ' .. n_killer .. ' убил игрока ' ..  n_killed .. "\n") end
            if n_killed and not n_killer then file:write(os.date() .. ' ' .. n_killed .. ' сделал самоубийство' .. "\n") end
        end
    end)
end

local transac_forma = false
local trans_forma = false

function sampev.onSendChat(text)
    if retrans.v then
        if string.lower(text, imer):match('.ку щаа') then
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/re off? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/re off")
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
            return false
        end
        if string.lower(text, ider):match(".ку (%d+)") then
            local ider = text:match(".ку (%d+)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/re ' .. ider .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/re " .. ider)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ф (.*)') then
            local imer = text:match(".ф (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/a ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/a " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.л (.*)') then
            local imer = text:match(".л (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/k ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/k " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ифт (.*)') then
            local imer = text:match('.ифт (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/ban ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/ban " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.шифт (.*)') then
            local imer = text:match('.шифт (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/iban ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/iban " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.мур (.*)') then
            local imer = text:match('.мур (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/veh ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/veh " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ыифт (.*)') then
            local imer = text:match('.ыифт (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/sban ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/sban " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.цфкт (.*)') then
            local imer = text:match('.цфкт (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/warn ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/warn " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ифтгз (.*)') then
            local imer = text:match('.ифтгз (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/banip ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/banip " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.офшд (.*)') then
            local imer = text:match('.офшд (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/jail ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/jail " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.еуьздуфвук (.*)') then
            local imer = text:match('.еуьздуфвук (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/templeader ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/templeader " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ьфлудуфвук (.*)') then
            local imer = text:match('.ьфлудуфвук (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/makeleader ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/makeleader " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.пуеіефеі (.*)') then
            local imer = text:match('.пуеіефеі (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/getstats ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/iban " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.пуеыефеы (.*)') then
            local imer = text:match('.пуеыефеы (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/getstats ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/getstats " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.фыефеы (.*)') then
            local imer = text:match('.фыефеы (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/astats ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/astats " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.фіефеі (.*)') then
            local imer = text:match('.фіефеі (.*)')
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/astats ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/astats " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.фвьшты') then
            local imer = text:match(".фвьшты")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/admins? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/admins " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.фвьшті') then
            local imer = text:match(".фвьшті")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/admins? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/admins " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ез (.*)') then
            local imer = text:match(".ез (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/tp ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/tp " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.пуеруку (.*)') then
            local imer = text:match(".пуеруку (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/gethere ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/gethere " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.п (.*)') then
            local imer = text:match(".п (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/g ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/g " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.вмфдд (.*)') then
            local imer = text:match(".вмфдд (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/dvall ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/dvall " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ешьу') then
            local imer = text:match(".ешьу")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/time? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/time " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ыуеыефе (.*)') then
            local imer = text:match(".ыуеыефе (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/setstat ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/setstat " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.іуеіефе (.*)') then
            local imer = text:match(".іуеіефе (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/setstat ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/setstat " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.кьгеу (.*)') then
            local imer = text:match(".кьгеу (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/rmute ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/rmute " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ьгеу (.*)') then
            local imer = text:match(".ьгеу (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/mute ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/mute " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ффв (.*)') then
            local imer = text:match(".ффв (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/aad ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/aad " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.зь (.+)') then
            local imer = text:match(".зь (.*)")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/pm ' .. imer .. '? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/pm " .. imer)
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
        if string.lower(text, imer):match('.ещщл') then
            local imer = text:match(".ещщл")
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 5
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {ffffff}Вы имели виду: ' .. '{FF00FF}/tool? {FFFFFF}Да: {00ffff}X. {FFFFFF}Нет: {00FF00}Z', -1)
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("Anti-Translit " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if trans_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        trans_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        tool.v = not tool.v
                        transac_forma = false
                        break
                    elseif isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        transac_forma = false
                        break
                    end
                end
            end)
        end
    end
end


local active_forma = false
local stop_forma = false
local active_razdat = false

local cip = false
local cip_cip = ''

function sampev.onServerMessage(color, text)
    local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
    if text:find('Запрещено создавать машину в зеленой зоне') then
        carban.v = true
    else
        carban.v = false
    end
    if text:find('(.*) %| IP%: (.*)') then
        if cip then
            local Rnickname, Rip = text:match('(.*) %| IP%: (.*)')
            cip_cip = Rip
            return false
        end
    end
    if text:find('Репорт от (.*)%[(%d+)%]: %{FFFFFF%}(.*)') then
        local Rnickname, Rid, RtextP = text:match('Репорт от (.*)%[(%d+)%]: %{FFFFFF%}(.*)')
        reports[#reports + 1] = {nickname = Rnickname, id = Rid, textP = RtextP}
    end
    if text:find('(.*) ' .. nick .. '(.*) РАЗДАЧА %| Кто первый напишет в %/rep ' .. u8:decode(word[slovo.v + 1]) .. ' тот получит (.*)') then
        active_razdat = true
        sampAddChatMessage('{FF0000}[Игровой Помощник: Биги]{00FF00}Поиск текста - ON', -1)
    end
    if text:find('Репорт от (.*)%[(%d+)%]: %{FFFFFF%}' .. u8:decode(word[slovo.v + 1])) then
        local Rnickname, Rid = text:match('Репорт от (.*)%[(%d+)%]: %{FFFFFF%}' .. u8:decode(word[slovo.v + 1]))
        if toggle_toggle.v then
            if active_razdat == true then
                lua_thread.create(function()
                    active_razdat = false
                    wait(3000)
                    sampSendChat('/aad РАЗДАЧА | ' .. Rnickname .. ' выиграл ' ..  u8:decode(prizeon[razdacha_zapusk.v + 1]) .. '!')
                end)
            end
        end
    end
    if text:find('Репорт от (.*)%[(%d+)%]: %{FFFFFF%}(.*)') then
        if imBitch.v then
            lua_thread.create(function()
                if checked_radio.v == 0 then
                    local sound = loadAudioStream(filesss)
                    setAudioStreamState(sound, ev.PLAY)
                elseif checked_radio.v == 1 then
                    local sound = loadAudioStream(filesssss)
                    setAudioStreamState(sound, ev.PLAY)
                end
            end)
        end
    end
    if text:find("RussiaGuard | %[Подозрение%] (.*)%[(%d+)]: (.+)") then
        if imCarco.v then
            active_forma = true
            local Rnikos, ridos, rtext = text:match("RussiaGuard | %[Подозрение%] (.*)%[(%d+)]: (.+)")
            sampAddChatMessage('{FF0000}[Игровой Помощник: Биги]{00FF00} Подозрение на чит: ' .. Rnikos .. '[' .. ridos .. ']' .. '. Желаете за ним проследить? R - Да. P - Нет.')
            active_forma = true
            lua_thread.create(function()
                lasttime = os.time()
                lasttimes = 0
                time_out = 10
                while lasttimes < time_out do
                    lasttimes = os.time() - lasttime
                    wait(0)
                    printStyledString("REPORT " .. time_out - lasttimes .. " WAIT", 1000, 4)
                    if stop_forma then
                        printStyledString('Form already accepted', 1000, 4)
                        stop_forma = false
                        break
                    end
                    if lasttimes == time_out then
                        printStyledString("TIME OUT", 1000, 4)
                    end
                    if isKeyJustPressed(VK_R) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        sampSendChat("/re " .. ridos)
                        active_forma = false
                        break
                    elseif isKeyJustPressed(VK_P) and not sampIsChatInputActive() and not sampIsDialogActive() then
                        active_forma = false
                        break
                    end
                end
            end)
        end
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



function sampev.onShowDialog(id, style, title, button1, button2, text)
    if elements.checkbox.autoCome.v then
        if elements.checkbox.adminPassword ~= '' then
            lua_thread.create(function()
                while true do
                    wait(0)
                    if title:match("Админ%-авторизация") then
                        sampSendDialogResponse(sampGetCurrentDialogId(), 1, _, elements.checkbox.adminPassword.v)
                        sampCloseCurrentDialogWithButton(0)
                        break
                    end
                end
            end)
        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Авто-вход не будет произведён, по-скольку вы не указали админ-пароль.', stColor)
            elements.checkbox.autoCome.v = false
            confq.config.autoCome = elements.checkbox.autoCome.v
            save()
        end
	end
end

function cmd_che(arg)
    if #arg == 0 then
        sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {00FF00}Введите /cip ID')
    else
        lua_thread.create(function()
            cip = true
            sampSendChat('/getip ' .. arg)
            wait(1000)
            sampSendChat('/pgetip ' .. cip_cip)
            wait(1000)
            cip = false
        end)
    end
end

function cmd_basa(arg)
    local nick = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(playerPed)))
    lua_thread.create(function()
        if imCarrot.v then
            if #arg == 0 then
                sampSendChat('/veh 522 3 3')
            else
                sampSendChat('/re ' .. arg)
                wait(1000)
                if checked_radios2.v == 0 then
                    sampSendChat('/veh 411 1 1')
                elseif checked_radios2.v == 1 then
                    sampSendChat('/veh 522 1 1')
                elseif checked_radios2.v == 2 then
                    sampSendChat('/veh 560 3 3')
                end
                wait(1000)
                if carban.v then
                    sampAddChatMessage('{FFFF00}[Игровой Помощник: Биги] {FFFFFF}Случилась ошибка при выдаче Т/С выполняю резервную функцию', -1)
                    sampSendChat('/re off')
                    wait(1000)
                    sampSendChat('/tp')
                    wait(100)
                    sampSendDialogResponse(sampGetCurrentDialogId(), 1, 9, nil)
                    sampCloseCurrentDialogWithButton()
                    wait(1000)
                    if checked_radios2.v == 0 then
                        sampSendChat('/veh 411 1 1')
                    elseif checked_radios2.v == 1 then
                        sampSendChat('/veh 522 1 1')
                    elseif checked_radios2.v == 2 then
                        sampSendChat('/veh 560 3 3')
                    end
                    wait(1000)
                    sampSendChat('/g ' .. arg)
                    wait(1000)
                    sampSendChat('/pm ' .. arg .. " Приятной игры на Екатеринбурге")
                    wait(1000)
                    sampSendChat('/re ' .. arg)
                else
                    wait(1000)
                    sampSendChat('/pm ' .. arg .. " Приятной игры на Екатеринбурге")
                end
            end
        else
            lua_thread.create(function()
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {FFFFFF}Извините но вы не разрешили мне этим пользоваться.')
                wait(500)
                sampAddChatMessage('{FF0000}[Игровой Помощник: Биги] {FFFFFF}Чтобы разрешить перейдите в {008000}Настройки{FFFFFF} => /car ID')
            end)
        end
    end)
end

function imgui.HelpMarker(text)
	imgui.TextDisabled('(?)')
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function imgui.BuyMark(text)
	imgui.TextDisabled(u8'Наведи на меня')
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function getMyId()
    local result, id = sampGetPlayerIdByCharHandle(playerPed)
    if result then
        return id
    end
end

function showCursor(toggle)
    if toggle then
      sampSetCursorMode(CMODE_LOCKCAM)
    else
      sampToggleCursor(false)
    end
    cursorEnabled = toggle
end
