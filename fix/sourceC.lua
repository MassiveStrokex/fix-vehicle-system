
local sx, sy = guiGetScreenSize()
local browser = guiCreateBrowser(0, 0, sx, sy, true, true, false)
guiSetVisible(browser, false)
local theBrowser = guiGetBrowser(browser)
guiSetInputMode("no_binds_when_editing")

addEventHandler("onClientBrowserCreated", theBrowser, 
	function()
		loadBrowserURL(source, "http://mta/local/index.html")
	end
)

addEvent("t.tamiret",true)
addEventHandler("t.tamiret",root,function()
	guiSetVisible( browser, not guiGetVisible( browser ) )
	showCursor(guiGetVisible( browser ))
	triggerServerEvent ("Tamirsistemi:tamir", getLocalPlayer(), getLocalPlayer())	
end)

addEvent("tamir.kapat",true)
addEventHandler("tamir.kapat",root,function()
	guiSetVisible( browser, not guiGetVisible( browser ) )
	showCursor(guiGetVisible( browser ))
end)

function bilgi()
local arac_koltuk = getPedOccupiedVehicleSeat ( getLocalPlayer() )
    if arac_koltuk == 0 then
		local arac = getPedOccupiedVehicle(getLocalPlayer())
		local arac_cani = getElementHealth(arac)
		local hasar = 1000 - arac_cani
		hasar = math.floor(hasar)
		para = math.floor(hasar * 3)
		if hasar >= 900 then
		artis = 0.9
		elseif hasar >= 800 then
		artis = 0.8
		elseif hasar >= 700 then
		artis = 0.7
		elseif hasar >= 600 then
		artis = 0.6
		elseif hasar >= 500 then
		artis = 0.5
		elseif hasar >= 400 then
		artis = 0.4
		elseif hasar >= 300 then
		artis = 0.3
		elseif hasar >= 200 then
		artis = 0.2
		elseif hasar >= 100 then
		artis = 0.1
		end
	end
	executeBrowserJavascript(source, "document.getElementById('tamirfiyat').innerHTML = '"..math.floor(para).."TL'");
end
addEventHandler("onClientBrowserDocumentReady", browser, bilgi)
addEventHandler("onClientRender",browser,bilgi)
-- setTimer ( browser,0, 0 )
-- setTimer(bilgi, 0,0)
addCommandHandler("t.panelaç",function(thePlayer, cmd)
	guiSetVisible( browser, not guiGetVisible( browser ) )
	showCursor(guiGetVisible( browser ))
	reloadBrowserPage(theBrowser)
end)

--[[
-Zodi- HTML Oluşturma Bitiş -
]]--

local artis = 1
local tamirci_marker = createMarker ( 1911.0673828125, -1776.3671875, 13.079972267151, "cylinder", 3, 255, 255, 0, 0 )

function marker_giris ( giren )
	if giren == localPlayer then
		local arac = getPedOccupiedVehicle ( giren )
		if arac then
			setTimer(function(arac,oyuncu)
				setElementFrozen ( arac, true )			
			end,500,1,arac,thePlayer)
			guiSetVisible( browser, not guiGetVisible( browser ) )
			showCursor(guiGetVisible( browser ))
			reloadBrowserPage(theBrowser)	
		end
	end	
end
addEventHandler ( "onClientMarkerHit", tamirci_marker, marker_giris )