set Cap to (do shell script "ioreg -w0 -l | grep ExternalChargeCapable")
tell Cap to set {wallPower} to {last word of paragraph 1}
if wallPower = "Yes" then
 return 0
else
 set Cap to (do shell script "ioreg -wO -l | grep Capacity")
 tell Cap to set {Available, Max} to {last word of paragraph 2, last word of paragraph 1}
 set Pct to round (100 * Available / Max)

 if Pct <= 4 then
 tell application "iTunes"
  pause
 end tell
 set volume 100
 do shell script "say -v \"Zarvox\" \"LOW BATTERY\" "
 if Pct <= 3 then
  beep 5
  do shell script "say -v \"Zarvox\" \"PLUG ME IN NOW\""
 end if
 end if
end if