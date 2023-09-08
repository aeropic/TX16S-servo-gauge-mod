local function init()
	-- Called once when the script is loaded
	  -- switch on power on port 0 = aux1 --serialSetPower(port_nr, value)
	--serialSetPower(0, 1)
  end
  
  local function run()
	-- switch on power on port 0 = aux1 --serialSetPower(port_nr, value)
	serialSetPower(0, 1)  -- set power on AUX1
	i = getValue('thr')
--	i = (100*getValue('VSpd'))    -- should be a float with vertical speed in cm/sec
--	if (i>0) and (i< 30) then i = 0.0 end  -- positive dead zone
--	if (i<0) and (i>-80) then i = 0.0 end  -- negative dead zone
--	i = i*7 -- give some gain to the servo arm
	serialWrite(i ..'\n')
end

local function background()
	-- Called periodically while the Special Function switch is off
	-- switch off power on port 0 = aux1 --serialSetPower(port_nr, value)
	serialSetPower(0, 0) 
  end

return {run=run, background=background, init=init}