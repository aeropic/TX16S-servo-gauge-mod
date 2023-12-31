---- ###############################################################
---- Variables
---- ###############################################################
local cellfull, cellempty = 4.2, 3.00                                      --## Cellule Li-Po considérée pleine et vide sans charge appliquée.
local batType = 3                                                      -- 3S

local myArrayPercentList =                                                       --## Tableau de decharge LIPO
--{{3.000, 0}, {3.053, 1}, {3.113, 2}, {3.174, 3}, {3.237, 4}, {3.300, 5}, {3.364, 6}, {3.427, 7}, {3.488, 8}, {3.547, 9}, {3.600, 10}, {3.621, 11}, {3.637, 12}, {3.649, 13}, {3.659, 14}, {3.668, 15}, {3.676, 16}, {3.683, 17}, {3.689, 18}, {3.695, 19}, {3.700, 20}, {3.706, 21}, {3.712, 22}, {3.717, 23}, {3.723, 24}, {3.728, 25}, {3.732, 26}, {3.737, 27}, {3.741, 28}, {3.746, 29}, {3.750, 30}, {3.754, 31}, {3.759, 32}, {3.763, 33}, {3.767, 34}, {3.771, 35}, {3.775, 36}, {3.779, 37}, {3.782, 38}, {3.786, 39}, {3.790, 40}, {3.794, 41}, {3.798, 42}, {3.802, 43}, {3.806, 44}, {3.810, 45}, {3.814, 46}, {3.818, 47}, {3.822, 48}, {3.826, 49}, {3.830, 50}, {3.834, 51}, {3.838, 52}, {3.842, 53}, {3.846, 54}, {3.850, 55}, {3.854, 56}, {3.858, 57}, {3.862, 58}, {3.866, 59}, {3.870, 60}, {3.875, 61}, {3.880, 62}, {3.885, 63}, {3.890, 64}, {3.895, 65}, {3.900, 66}, {3.905, 67}, {3.910, 68}, {3.915, 69}, {3.920, 70}, {3.924, 71}, {3.929, 72}, {3.933, 73}, {3.938, 74}, {3.942, 75}, {3.947, 76}, {3.952, 77}, {3.958, 78}, {3.963, 79}, {3.970, 80}, {3.982, 81}, {3.994, 82}, {4.007, 83}, {4.020, 84}, {4.033, 85}, {4.047, 86}, {4.060, 87}, {4.074, 88}, {4.087, 89}, {4.100, 90}, {4.111, 91}, {4.122, 92}, {4.132, 93}, {4.143, 94}, {4.153, 95}, {4.163, 96}, {4.173, 97}, {4.182, 98}, {4.191, 99}, {4.200, 100}} --## Table standard (Empirique & théorique)
--{{2.8, 0}, {2.942, 1}, {3.1, 2}, {3.258, 3}, {3.401, 4}, {3.485, 5}, {3.549, 6}, {3.601, 7}, {3.637, 8}, {3.664, 9}, {3.679, 10}, {3.683, 11}, {3.689, 12}, {3.692, 13}, {3.705, 14}, {3.71, 15}, {3.713, 16}, {3.715, 17}, {3.72, 18}, {3.731, 19}, {3.735, 20}, {3.744, 21}, {3.753, 22}, {3.756, 23}, {3.758, 24}, {3.762, 25}, {3.767, 26}, {3.774, 27}, {3.78, 28}, {3.783, 29}, {3.786, 30}, {3.789, 31}, {3.794, 32}, {3.797, 33}, {3.8, 34}, {3.802, 35}, {3.805, 36}, {3.808, 37}, {3.811, 38}, {3.815, 39}, {3.818, 40}, {3.822, 41}, {3.826, 42}, {3.829, 43}, {3.833, 44}, {3.837, 45}, {3.84, 46}, {3.844, 47}, {3.847, 48}, {3.85, 49}, {3.854, 50}, {3.857, 51}, {3.86, 52}, {3.863, 53}, {3.866, 54}, {3.87, 55}, {3.874, 56}, {3.879, 57}, {3.888, 58}, {3.893, 59}, {3.897, 60}, {3.902, 61}, {3.906, 62}, {3.911, 63}, {3.918, 64}, {3.923, 65}, {3.928, 66}, {3.939, 67}, {3.943, 68}, {3.949, 69}, {3.955, 70}, {3.961, 71}, {3.968, 72}, {3.974, 73}, {3.981, 74}, {3.987, 75}, {3.994, 76}, {4.001, 77}, {4.008, 78}, {4.014, 79}, {4.021, 80}, {4.029, 81}, {4.036, 82}, {4.044, 83}, {4.052, 84}, {4.062, 85}, {4.074, 86}, {4.085, 87}, {4.095, 88}, {4.105, 89}, {4.111, 90}, {4.116, 91}, {4.12, 92}, {4.125, 93}, {4.129, 94}, {4.135, 95}, {4.145, 96}, {4.176, 97}, {4.179, 98}, {4.193, 99}, {4.2, 100}}                 --## Table Robbe originale fiable (Départ à 2.8V
{{3, 0}, {3.093, 1}, {3.196, 2}, {3.301, 3}, {3.401, 4}, {3.477, 5}, {3.544, 6}, {3.601, 7}, {3.637, 8}, {3.664, 9}, {3.679, 10}, {3.683, 11}, {3.689, 12}, {3.692, 13}, {3.705, 14}, {3.71, 15}, {3.713, 16}, {3.715, 17}, {3.72, 18}, {3.731, 19}, {3.735, 20}, {3.744, 21}, {3.753, 22}, {3.756, 23}, {3.758, 24}, {3.762, 25}, {3.767, 26}, {3.774, 27}, {3.78, 28}, {3.783, 29}, {3.786, 30}, {3.789, 31}, {3.794, 32}, {3.797, 33}, {3.8, 34}, {3.802, 35}, {3.805, 36}, {3.808, 37}, {3.811, 38}, {3.815, 39}, {3.818, 40}, {3.822, 41}, {3.825, 42}, {3.829, 43}, {3.833, 44}, {3.836, 45}, {3.84, 46}, {3.843, 47}, {3.847, 48}, {3.85, 49}, {3.854, 50}, {3.857, 51}, {3.86, 52}, {3.863, 53}, {3.866, 54}, {3.87, 55}, {3.874, 56}, {3.879, 57}, {3.888, 58}, {3.893, 59}, {3.897, 60}, {3.902, 61}, {3.906, 62}, {3.911, 63}, {3.918, 64}, {3.923, 65}, {3.928, 66}, {3.939, 67}, {3.943, 68}, {3.949, 69}, {3.955, 70}, {3.961, 71}, {3.968, 72}, {3.974, 73}, {3.981, 74}, {3.987, 75}, {3.994, 76}, {4.001, 77}, {4.007, 78}, {4.014, 79}, {4.021, 80}, {4.029, 81}, {4.036, 82}, {4.044, 83}, {4.052, 84}, {4.062, 85}, {4.074, 86}, {4.085, 87}, {4.095, 88}, {4.105, 89}, {4.111, 90}, {4.116, 91}, {4.12, 92}, {4.125, 93}, {4.129, 94}, {4.135, 95}, {4.145, 96}, {4.176, 97}, {4.179, 98}, {4.193, 99}, {4.2, 100}}                 --## Table Robbe fiable modifiée pour départ à 3.0V

---- ###############################################################
---- Calcul du pourcentage de chaque élément ; Pas de virgule
---- ###############################################################
function percentcell(targetVoltage)
  local result = 0
  if targetVoltage > cellfull or targetVoltage < cellempty then
    if  targetVoltage > cellfull then                                            --## trap for odd values not in array
      result = 100
    end
    if  targetVoltage < cellempty then
      result = 0
    end
  else
    for j, v in ipairs( myArrayPercentList ) do                                  --## method of finding percent in my array provided by on4mh (Mike)
      if v[ 1 ] >= targetVoltage then
        result =  v[ 2 ]
        break
      end
    end --for
  end --if
 return result
end




local function init()
	-- Called once when the script is loaded
	
end
  
local function run()
	-- switch on power on port 0 = aux1 --serialSetPower(port_nr, value)
	serialSetPower(0, 1)  -- set power on AUX1

	i=0

	mys2 = getValue('s2') -- get the S2 pot value (-1024 ; + 1024)
	-- detect the value of mode
	mode = 1
    if mys2 < -900 then mode = 0 end
	if mys2 > 900 then mode = 2 end

    if mode == 0 then   -- altimeter
		i = getValue('Alt')    -- should be a float with altitude in  meters

		model.setGlobalVariable(0, 0, i) -- jusy for debug
		if  (i < 0) then i = 0.0 end
		if (i > 600) then i = 0.0 end	-- FSIA6B ibus and edgetx get a bug for negative values of telemetry
		
		i = i*3 - 150*3 -- give some gain to the servo arm : 300 m ==> 900 usec on the servo ==>  150m should be horizontal
		
		
	end

	if mode == 1 then  -- vario
			--i = getValue('thr')
			i = (100*getValue('VSpd'))    -- should be a float with vertical speed in cm/sec
			model.setGlobalVariable(0, 0, i) -- jusy for debug
		if (i>0) and (i< 30) then i = 0.0 end  -- positive dead zone
		if (i<0) and (i>-80) then i = 0.0 end  -- negative dead zone

		i = i*2 -- give some gain to the servo arm
		if (i>0) then i = i + 100 end
		if (i<0) then i = i  end -- spread the positive from the negative Vspeeds
		
	end

	if mode == 2 then  -- voltage on A1
	--	i = getValue('thr')

		cellResult = getValue("A1")                          --## Appel du tableau retourné par le capteur A1
		model.setGlobalVariable(0, 0, i) -- jusy for debug
       
  		cellsumpercent = percentcell(cellResult/batType)      --## Pourcentage du pack
  
		i = (cellsumpercent - 50) * 10   -- resultat entre -500 et +500

	end

	serialWrite(i ..'\n')
	
end

local function background()
	-- Called periodically while the Special Function switch is off
	-- switch off power on port 0 = aux1 --serialSetPower(port_nr, value)
	serialSetPower(0, 0) 
  end

return {run=run, background=background, init=init}