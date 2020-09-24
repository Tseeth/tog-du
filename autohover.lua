-- AutoHover.  This will adjust hover height depending on state of landing gear.

-- APPLY TO: system.update()

local gearExtended = Nav.control.isAnyLandingGearExtended()


if  gearExtended == 1 then 
        Nav.axisCommandManager:setTargetGroundAltitude(0)
        else
        Nav.axisCommandManager:setTargetGroundAltitude(100)
    end 
