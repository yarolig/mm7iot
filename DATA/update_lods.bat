REM mmarch create 02_mm3.events.lod lod . Games\2DEvents.txt
REM mmarch add 02_mm3.events.lod Games\2DEvents.txt Games\mm3*.STR
mmarch add Games.lod Games\mm3*.*dm Games\MM3*.blv Games\MM3*.dlv
mmarch add events.lod Games\2DEvents.txt Games\mm3*.STR Games\MAPSTATS.TXT

pause