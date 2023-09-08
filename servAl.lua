local function init()
	-- Called once when the script is loaded
	  -- switch on power on port 0 = aux1 --serialSetPower(port_nr, value)
	--serialSetPower(0, 1)
  end
  
  local function run()
	-- switch on power on port 0 = aux1 --serialSetPower(port_nr, value)
	serialSetPower(0, 1)  -- set power on AUX1

	i = (getValue('Alt'))    -- should be a float with altitude in centimeters
	if i<0 then i=0.0 end
	i = i*6 - 150*6 -- give some gain to the servo arm : 300 m ==> 1800 usec on the servo ==> ~180 deg, 150m should be horizontal
	
	serialWrite(i ..'\n')
end

local function background()
	-- Called periodically while the Special Function switch is off
	-- switch off power on port 0 = aux1 --serialSetPower(port_nr, value)
	serialSetPower(0, 0) 
  end

return {run=run, background=background, init=init}