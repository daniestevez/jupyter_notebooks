KPL/FK
 
   FILE: spice/observatories.tf
 
   This file was created by PINPOINT.
 
   PINPOINT Version 3.3.0 --- December 13, 2021
   PINPOINT RUN DATE/TIME:    2025-04-13T11:08:43
   PINPOINT DEFINITIONS FILE: observatories.defs
   PINPOINT PCK FILE:         spice/pck00011.tpc
   PINPOINT SPK FILE:         spice/observatories.bsp
 
   The input definitions file is appended to this
   file as a comment block.
 
 
   Body-name mapping follows:
 
\begindata
 
   NAIF_BODY_NAME                      += 'DWINGELOO'
   NAIF_BODY_CODE                      += 399999
 
   NAIF_BODY_NAME                      += 'STOCKERT'
   NAIF_BODY_CODE                      += 399998
 
\begintext
 
 
   Reference frame specifications follow:
 
 
   Topocentric frame DWINGELOO_TOPO
 
      The Z axis of this frame points toward the zenith.
      The X axis of this frame points North.
 
      Topocentric frame DWINGELOO_TOPO is centered at the
      site DWINGELOO, which has Cartesian coordinates
 
         X (km):                  0.3839320759962E+04
         Y (km):                  0.4303981249486E+03
         Z (km):                  0.5057954488692E+04
 
      and planetodetic coordinates
 
         Longitude (deg):         6.3963051768586
         Latitude  (deg):        52.8121435723961
         Altitude   (km):         0.2500000000102E-01
 
      These planetodetic coordinates are expressed relative to
      a reference spheroid having the dimensions
 
         Equatorial radius (km):  6.3781366000000E+03
         Polar radius      (km):  6.3567519000000E+03
 
      All of the above coordinates are relative to the frame ITRF93.
 
 
\begindata
 
   FRAME_DWINGELOO_TOPO                =  1399999
   FRAME_1399999_NAME                  =  'DWINGELOO_TOPO'
   FRAME_1399999_CLASS                 =  4
   FRAME_1399999_CLASS_ID              =  1399999
   FRAME_1399999_CENTER                =  399999
 
   OBJECT_399999_FRAME                 =  'DWINGELOO_TOPO'
 
   TKFRAME_1399999_RELATIVE            =  'ITRF93'
   TKFRAME_1399999_SPEC                =  'ANGLES'
   TKFRAME_1399999_UNITS               =  'DEGREES'
   TKFRAME_1399999_AXES                =  ( 3, 2, 3 )
   TKFRAME_1399999_ANGLES              =  (   -6.3963051768586,
                                             -37.1878564276039,
                                             180.0000000000000 )
 
 
\begintext
 
   Topocentric frame STOCKERT_TOPO
 
      The Z axis of this frame points toward the zenith.
      The X axis of this frame points North.
 
      Topocentric frame STOCKERT_TOPO is centered at the
      site STOCKERT, which has Cartesian coordinates
 
         X (km):                  0.4031508075949E+04
         Y (km):                  0.4751650812260E+03
         Z (km):                  0.4903598836802E+04
 
      and planetodetic coordinates
 
         Longitude (deg):         6.7220323303174
         Latitude  (deg):        50.5694630928919
         Altitude   (km):         0.4340000000002E+00
 
      These planetodetic coordinates are expressed relative to
      a reference spheroid having the dimensions
 
         Equatorial radius (km):  6.3781366000000E+03
         Polar radius      (km):  6.3567519000000E+03
 
      All of the above coordinates are relative to the frame ITRF93.
 
 
\begindata
 
   FRAME_STOCKERT_TOPO                 =  1399998
   FRAME_1399998_NAME                  =  'STOCKERT_TOPO'
   FRAME_1399998_CLASS                 =  4
   FRAME_1399998_CLASS_ID              =  1399998
   FRAME_1399998_CENTER                =  399998
 
   OBJECT_399998_FRAME                 =  'STOCKERT_TOPO'
 
   TKFRAME_1399998_RELATIVE            =  'ITRF93'
   TKFRAME_1399998_SPEC                =  'ANGLES'
   TKFRAME_1399998_UNITS               =  'DEGREES'
   TKFRAME_1399998_AXES                =  ( 3, 2, 3 )
   TKFRAME_1399998_ANGLES              =  (   -6.7220323303174,
                                             -39.4305369071081,
                                             180.0000000000000 )
 
\begintext
 
 
Definitions file observatories.defs
--------------------------------------------------------------------------------
 
begindata
 
   SITES = ( 'DWINGELOO', 'STOCKERT' )
 
   DWINGELOO_FRAME = 'ITRF93'
   DWINGELOO_CENTER = 399
   DWINGELOO_IDCODE = 399999
   DWINGELOO_LATLON = ( 52.8121435723961, 6.39630517685863, 0.025 )
   DWINGELOO_UP = 'Z'
   DWINGELOO_NORTH = 'X'
   BODY399999_RADII = ( 0.0, 0.0, 0.0 )
 
   STOCKERT_FRAME = 'ITRF93'
   STOCKERT_CENTER = 399
   STOCKERT_IDCODE = 399998
   STOCKERT_LATLON = ( 50.56946309289191, 6.722032330317412, 0.434 )
   STOCKERT_UP = 'Z'
   STOCKERT_NORTH = 'X'
 
begintext
 
begintext
 
[End of definitions file]
 
