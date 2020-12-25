function arac_tamir (thePlayer)
	local arac = getPedOccupiedVehicle(source)
	setElementData(arac, "tamir_oldumu", 1)
	setTimer(function(arac,oyuncu)
	end,6600,1,arac,thePlayer)
	 setElementFrozen ( arac, true )
	-- outputChatBox("[!]#ffffff Aracınız (1-2) saniye içerisin de tamir edilecektir.", thePlayer, 0, 0, 194, true)
			triggerEvent("addBox",source,source,"warning", "Aracınız (1-2) saniye içerisin de tamir edilecektir.")
	arac_tamir2(arac, oyuncu)

end
addEvent("Tamirsistemi:tamir", true)
addEventHandler("Tamirsistemi:tamir", root, arac_tamir)

local para = nil

function arac_tamir2(arac, oyuncu)
	local arac_cani = getElementHealth(arac)
	local hasar = 1000 - arac_cani

	hasar = math.floor(hasar)
			para = math.floor(hasar * 3)
		
	local oyuncu_para = getElementData(source, "money") or 0
	if oyuncu_para < para then
	outputChatBox("[!]#ffffff Maalesef yeterli miktarda paran yok.", oyuncu, 255, 0, 0, true)
	setElementFrozen ( arac, false )
	setElementData(arac, "tamir_oldumu", 0)
	return end

		exports.global:takeMoney(source, math.floor(para))

		 -- outputChatBox("[!]#ffffff Aracınız başarıyla tamir edilmiştir."..math.floor(para).."$'",oyuncu, 0, 194, 0, true)
			triggerEvent("addBox",source,source,"success", "Başarılı Bir Şekilde Aracınızı Tamir Ettiniz!  ("..math.floor(para).."$)")

		 fixVehicle(arac) --// ARACIN KAPORTASININ TAMİR EDİLMESİ KALKMIŞTIR
		 setElementData(arac, "tamir_oldumu", 0)
		 setElementFrozen ( arac, false )
		for i = 0, 5 do
		 setVehicleDoorState(arac, i, 0)
	end
end


--////////// TAMİR OLURKEN ARAÇTAN İNME //////////-

function exitVehicle ( thePlayer, seat, jacked ) 
   if ( getElementData(source, "tamir_oldumu") == 1 ) then 
      outputChatBox ( "[!]#ffffff Araç tamir olurken inemezsiniz.", thePlayer, 255, 0, 0, true )  
      cancelEvent()
   end
end
addEventHandler ( "onVehicleStartExit", getRootElement(), exitVehicle)