KPL/FK


Psyche Frames Kernel
===============================================================================

   This frame kernel (F-kernel) contains complete set of frame
   definitions for asteroid Psyche (PSYCHE), the Psyche Spacecraft
   (PSYC), the spacecraft's structures and science instruments, and 
   Deep Space Optical Communications (DSOC) Ground Sites. This frame
   kernel also contains name - to - NAIF ID mappings for PSYCHE science
   instruments and spacecraft structures (see the last section of the
   file.)


Version and Date
-------------------------------------------------------------------------------

   Version 0.8 -- June 14, 2022 -- Matt Barnes, NAIF/JPL

      *  Added frames and name/ID mapping for PSYC_DSM<1,2>_BASE, 
         PSYC_DSM<1,2>_AXIS1, PSYC_DSM<1,2>_AXIS2, and 
         PSYC_DSM<1,2>_EP_<A,B,C,D> (IDs -255210 through -255214 and 
         -255220 through -255224).

      *  Added frames and name/ID mapping for PSYC_CGT<1-12> (IDs 
         -255231 through -255242).

      *  Swapped MAG1 and MAG2 in diagram to correctly label the 
         outboard sensor as MAG1.

   Version 0.7 -- May 14, 2021 -- Matt Barnes, NAIF/JPL

      Added frames PSYC_DSOC_PALOMAR_TOPO and PSYC_DSOC_OCTL_TOPO 
      as well as name/ID mapping for PSYC_DSOC_PALOMAR (-255195) 
      and PSYC_DSCO_OCTL (-255196) per [11].

   Version 0.6 -- April 26, 2021 -- Matt Barnes, NAIF/JPL

      Changed all IDs to reflect change from -69 to -255 for Psyche 
      Spacecraft (PSYC) per [10]

   Version 0.5 -- June 3, 2019 -- Boris Semenov, NAIF/JPL

      *  Added the PSYC_DSOC_MECH/-69192 frame.

      *  Redefined PSYC_DSOC_BASE to be relative to PSYC_DSOC_MECH and 
         changed its description and alignment.

   Version 0.4 -- May 17, 2019 -- Masha Liukis, Boris Semenov, NAIF/JPL

      *  Added new reference documents.

      *  Updated frame definitions per latest specifications (see [7],
         [8]), including changing alignments for PSYC_IMGA, PSYC_IMGB,
         PSYC_MAG1, PSYC_MAG2, PSYC_HGA, PSYC_ST1, and PSYC_ST2.

      *  Added frame definitions and name/ID mapping for the sun
         sensors PSYC_SS(N), N = 1..8 (IDs -6909n, n = 1..8)

      *  Added frame definitions and name/ID mapping for DSOC,
         PSYC_DSOC_BASE (ID -69190) and PSYC_DSOC (ID -69191)

      *  Renamed LGA frames from PSYC_LGA_PZ, PSYC_LGA_PY, and
         PSYC_LGA_MY to PSYC_LGA_MZ, PSYC_LGA_PX, and PSYC_LGA_MX and
         changed their alignments accordingly (see [7]).

      *  Added mechanical GRNS frame definitions (see [7]):
         PSYC_GRS_MECH (ID -69151), PSYC_NS_MECH (ID -69161);
         previously defined PSYC_GRS and PSYC_NS frames represent
         scientific frames.

   Version 0.3 -- February 5, 2018 -- Masha Liukis, NAIF/JPL

      Replaced references to fluxgate magnetometer with references to
      magnetometer.

      Replaced FGM (fluxgate magnetometer) with MAG (magnetometer) for
      frames names:

         PSYC_FGM1 with PSYC_MAG1
         PSYC_FGM2 with PSYC_MAG2

   Version 0.2 -- January 31, 2018 -- Masha Liukis, NAIF/JPL

      Replaced references to camera with references to imager.

      Replaced FC (framing camera) with IMG (imager) for frames names:

         PSYC_FC1 with PSYC_IMGA
         PSYC_FC2 with PSYC_IMGB

   Version 0.1 -- January 29, 2018 -- Boris Semenov, NAIF/JPL

      Changed placeholder alignments in the LGA, ST, FC and GRS/NS
      frames. Updated some descriptions, diagrams, indentation and
      paragraph wrapping.

   Version 0.0 -- April 5, 2017 -- Masha Liukis, NAIF/JPL

      Preliminary version.


References
-------------------------------------------------------------------------------

   1. ``Frames Required Reading''

   2. ``Kernel Pool Required Reading''

   3. ``C-Kernel Required Reading''

   4. ``PC-Kernel Required Reading''

   5. 02_Psyche_CSR_Redacted_Science.pdf.

   6. Foldout G1. Flight System Overview.

   7. PSYCHE_Final_Ext_Freeze_02_05_19.pdf.

   8. Psyche_ASC_FOV_STIRs-Rev_1c.docx.

   9. PSYCHE_ACTION_ITEM_62295.pdf

  10. Spacecraft/Mission Identifier Code Document 820-013,
      Module OPS-6-21-04, Rev. N, 4/15/2021

  11. D-102342_Psyche_PCMD_RevB_20210119_Signed.pdf. 

  12. Thruster Alignment Requirements, Document G058871, Rev. 7. 

  13. Email `Re: Psyche Thruster FK Updates', Don Han, JPL, 
      3/24/2022

Contact Information
-------------------------------------------------------------------------------

   Matt Barnes, NAIF/JPL, (818) 354-5942, matthew.j.barnes@jpl.nasa.gov


Implementation Notes
-------------------------------------------------------------------------------

   This file is used by the SPICE system as follows: programs that make
   use of this frame kernel must `load' the kernel, normally during
   program initialization. The SPICELIB routine FURNSH and CSPICE
   function furnsh_c load a kernel file into the kernel pool as shown
   below.

      CALL FURNSH ( 'frame_kernel_name' )    -- FORTRAN
      furnsh_c ( "frame_kernel_name" );      -- C
      cspice_furnsh, frame_kernel_name       -- IDL
      cspice_furnsh( 'frame_kernel_name' )   -- MATLAB

   This file was created and may be updated with a text editor or word
   processor.


Psyche Mission NAIF ID Codes -- Summary Section
========================================================================

   The following names and NAIF ID codes are assigned to the Psyche
   asteroid, Psyche spacecraft, its structures and science instruments
   (the keywords implementing these definitions are located in the
   section "Psyche Mission NAIF ID Codes -- Definition Section" at the
   end of this file):

   Psyche Targets:

      Name                   ID
      --------------------   -------
      PSYCHE                  2000016

   Psyche Spacecraft and Spacecraft Structures names/IDs:

      PSYC                    -255
      PSYC_SPACECRAFT         -255000
      PSYC_SA_PY              -255010
      PSYC_SA_MY              -255020
      PSYC_HGA                -255030
      PSYC_LGA_MZ             -255040
      PSYC_LGA_PX             -255050
      PSYC_LGA_MX             -255060
      PSYC_ST1                -255070
      PSYC_ST2                -255080
      PSYC_SS1                -255091
      PSYC_SS2                -255092
      PSYC_SS3                -255093
      PSYC_SS4                -255094
      PSYC_SS5                -255095
      PSYC_SS6                -255096
      PSYC_SS7                -255097
      PSYC_SS8                -255098

   Imagers (IMG) names/IDs:

      PSYC_IMGA               -255110
      PSYC_IMGB               -255130

   Gamma Ray and Neutron Spectrometers (GRNS) names/IDs:

      PSYC_GRS                -255150
      PSYC_NS                 -255160

   Magnetometers (MAG) names/IDs:

      PSYC_MAG1               -255170
      PSYC_MAG2               -255180

   DAPM-actuated Stationary Plasma thruster Modules (DSM) names/IDs:

      PSYC_DSM1_BASE          -255210
      PSYC_DSM1_EP_A          -255213
      PSYC_DSM1_EP_C          -255214
      PSYC_DSM2_BASE          -255220
      PSYC_DSM2_EP_B          -255223
      PSYC_DSM2_EP_D          -255224

   Cold Gas Thruster (CGT) names/IDs:

      PSYC_CGT1               -255231
      PSYC_CGT2               -255232
      PSYC_CGT3               -255233
      PSYC_CGT4               -255234
      PSYC_CGT5               -255235
      PSYC_CGT6               -255236
      PSYC_CGT7               -255237
      PSYC_CGT8               -255238
      PSYC_CGT9               -255239
      PSYC_CGT10              -255240
      PSYC_CGT11              -255241
      PSYC_CGT12              -255242

   Deep Space Optical Communications (DSOC) names/IDs:

      PSYC_DSOC_BASE          -255190
      PSYC_DSOC               -255191

   Deep Space Optical Communications (DSOC) Ground Site names/IDs:

      PSYC_DSOC_PALOMAR       -255195
      PSYC_DSOC_OCTL          -255196


Psyche Frames
========================================================================

   The following Psyche frames are defined in this kernel file:

           Name                  Relative to           Type       NAIF ID
      ======================  ===================  ============   =======

   Psyche Target frames:
   ---------------------
      PSYCHE_FIXED            J2000                PCK            2000016


   Psyche Spacecraft and Spacecraft Structures frames:
   ---------------------------------------------------

      PSYC_SPACECRAFT         PSYC_SPACECRAFT      CK             -255000
      PSYC_SA_PY              PSYC_SPACECRAFT      CK             -255010
      PSYC_SA_MY              PSYC_SPACECRAFT      CK             -255020
      PSYC_HGA                PSYC_SPACECRAFT      FIXED          -255030
      PSYC_LGA_MZ             PSYC_SPACECRAFT      FIXED          -255040
      PSYC_LGA_PX             PSYC_SPACECRAFT      FIXED          -255050
      PSYC_LGA_MX             PSYC_SPACECRAFT      FIXED          -255060
      PSYC_ST1                PSYC_SPACECRAFT      FIXED          -255070
      PSYC_ST2                PSYC_SPACECRAFT      FIXED          -255080
      PSYC_SS1                PSYC_SPACECRAFT      FIXED          -255091
      PSYC_SS2                PSYC_SPACECRAFT      FIXED          -255092
      PSYC_SS3                PSYC_SPACECRAFT      FIXED          -255093
      PSYC_SS4                PSYC_SPACECRAFT      FIXED          -255094
      PSYC_SS5                PSYC_SPACECRAFT      FIXED          -255095
      PSYC_SS6                PSYC_SPACECRAFT      FIXED          -255096
      PSYC_SS7                PSYC_SPACECRAFT      FIXED          -255097
      PSYC_SS8                PSYC_SPACECRAFT      FIXED          -255098

   IMGA and IMGB frames:
   -------------------

      PSYC_IMGA               PSYC_SPACECRAFT      FIXED          -255110
      PSYC_IMGB               PSYC_SPACECRAFT      FIXED          -255130

   GRNS frames:
   ------------

      PSYC_GRS                PSYC_SPACECRAFT      FIXED          -255150
      PSYC_GRS_MECH           PSYC_SPACECRAFT      FIXED          -255151

      PSYC_NS                 PSYC_SPACECRAFT      FIXED          -255160
      PSYC_NS_MECH            PSYC_SPACECRAFT      FIXED          -255161

   MAG1 and MAG2 frames:
   ---------------------

      PSYC_MAG1               PSYC_SPACECRAFT      FIXED          -255170
      PSYC_MAG2               PSYC_SPACECRAFT      FIXED          -255180

   DSM Frames:
   -----------

      PSYC_DSM1_BASE          PSYC_SPACECRAFT      FIXED          -255210
      PSYC_DSM1_AXIS1         PSYC_DSM1_BASE       CK             -255211
      PSYC_DSM1_AXIS2         PSYC_DSM1_AXIS1      CK             -255212
      PSYC_DSM1_EP_A          PSYC_DSM1_AXIS2      FIXED          -255213
      PSYC_DSM1_EP_C          PSYC_DSM1_AXIS2      FIXED          -255214
      PSYC_DSM2_BASE          PSYC_SPACECRAFT      FIXED          -255220
      PSYC_DSM2_AXIS1         PSYC_DSM2_BASE       CK             -255221
      PSYC_DSM2_AXIS2         PSYC_DSM2_AXIS1      CK             -255222
      PSYC_DSM2_EP_B          PSYC_DSM2_AXIS2      FIXED          -255223
      PSYC_DSM2_EP_D          PSYC_DSM2_AXIS2      FIXED          -255224

   CGT Frames:
   -----------

      PSYC_CGT1               PSYC_SPACECRAFT      FIXED          -255231
      PSYC_CGT2               PSYC_SPACECRAFT      FIXED          -255232
      PSYC_CGT3               PSYC_SPACECRAFT      FIXED          -255233
      PSYC_CGT4               PSYC_SPACECRAFT      FIXED          -255234
      PSYC_CGT5               PSYC_SPACECRAFT      FIXED          -255235
      PSYC_CGT6               PSYC_SPACECRAFT      FIXED          -255236
      PSYC_CGT7               PSYC_SPACECRAFT      FIXED          -255237
      PSYC_CGT8               PSYC_SPACECRAFT      FIXED          -255238
      PSYC_CGT9               PSYC_SPACECRAFT      FIXED          -255239
      PSYC_CGT10              PSYC_SPACECRAFT      FIXED          -255240
      PSYC_CGT11              PSYC_SPACECRAFT      FIXED          -255241
      PSYC_CGT12              PSYC_SPACECRAFT      FIXED          -255242

   DSOC Frames:
   ------------

      PSYC_DSOC_MECH          PSYC_SPACECRAFT      FIXED          -255192
      PSYC_DSOC_BASE          PSYC_DSOC_MECH       FIXED          -255190
      PSYC_DSOC               PSYC_DSOC_BASE       CK             -255191

   DSOC Ground Site Frames:
   ------------------------

      PSYC_DSOC_PALOMAR_TOPO  ITRF93               FIXED          -255195
      PSYC_DSOC_OCTL_TOPO     ITRF93               FIXED          -255196


Spacecraft and Spacecraft Structures Frame Tree
========================================================================

   The diagram below shows the frame hierarchy for the Psyche
   spacecraft and its structure frame (not including science instrument
   frames.)

                                             "J2000" INERTIAL
                                      +--------------------------+
                                      |                          |
                                      |                          |<-pck
                                      |                          |
                                      |                          V
                                      |                    "PSYCHE_FIXED"
                                      |                    --------------
                                      |
   "PSYC_SS(N)" "PSYC_ST1" "PSYC_ST2" |         "PSYC_LGA_PX" "PSYC_LGA_MZ"
   ------------ ---------- ---------- |         ------------- ------------
       ^            ^        ^        |              ^           ^
       |            |        |        |              |           |
       |<-fixed     |<-fixed |<-fixed |<-ck          |<-fixed    |<-fixed
       |            |        |        |              |           |
       |            |        |        V              |           |
       |            |        | "PSYC_SPACECRAFT"     |           |
       +---------------------------------------------------------+
       |            |                 .              |           |
       |<-ck        |<-ck             .              |<-fixed    |<-fixed
       |            |                 .              |           |
       V            V                 .              V           V
   "PSYC_SA_PY" "PSYC_SA_MY"          .         "PSYC_LGA_MX" "PSYC_HGA"
   -----------  -----------           .         ------------- ----------
                                      . 
                                      V
                Individual instrument frame trees are provided
                      in the other sections of this file


Psyche Target Frames
========================================================================

   This section of the file contains the body-fixed frame definition
   for the Psyche mission target -- asteroid Psyche.

   A body-fixed frame is defined for Psyche using standard body-fixed,
   PCK-based frame formation rules:

      -  +Z axis is toward the North pole;

      -  +X axis is toward the prime meridian;

      -  +Y axis completes the right hand frame;

      -  the origin of this frame is at the center of the body.

   The orientation of this frame is computed by evaluating
   corresponding rotation constants provided in the PCK file(s).

   \begindata

      FRAME_PSYCHE_FIXED             =  2000016
      FRAME_2000016_NAME             = 'PSYCHE_FIXED'
      FRAME_2000016_CLASS            =  2
      FRAME_2000016_CLASS_ID         =  2000016
      FRAME_2000016_CENTER           =  2000016
      OBJECT_2000016_FRAME           = 'PSYCHE_FIXED'

   \begintext


Psyche Spacecraft and Spacecraft Structures Frames
========================================================================

   This section of the file contains the definitions of the spacecraft
   and spacecraft structures frames (see [6], [7]).


Psyche Spacecraft Frame
--------------------------------------

   The Psyche spacecraft frame is defined as follows:

      -  +X axis is opposite of the nominal boresight direction of the
         Imager A;

      -  +Z axis is along the normal to the HGA deck, pointing in the
         direction of the HGA boresight;

      -  +Y axis completes the right-hand frame;

      -  the origin of this frame is the launch vehicle interface
         point.

   These diagrams illustrate the PSYCHE_SPACECRAFT frame:


   +Z s/c side (HGA side) view:
   ----------------------------
                                    ^
                                    | toward asteroid

                               Science Deck
                              _____________
    __  ________________     |             |     _______________  ___
   |  \ \               \    |  . ----- .  |    /               \ \  |
   |  / /                \   |.'         `.|   /                / /  |
   |  \ \                 `. . +Zsc    +Ysc| .'                 \ \  |
   |  / /                 | o|      o----> |o |                 / /  |
   |  \ \                 .' .      |      . `.                 \ \  |
   |  / /                /   |`.    |    .'|   \                / /  |
   |__\ \_______________/    | +Xsc v --'  |    \_______________\ \__|
     -Y Solar Array (MY)     |_____________|       +Y Solar Array (PY)
                                       
                                       
                                                       +Zsc is out of
                                                        the page




   -X s/c side (science deck side) view:
   -------------------------------------


                               +Xsc
                              _____ x----> +Ysc
                             |      |
                             |      |      |
                             |      v      |
   o==/ /==================o | +Zsc        |o==================/ /==o
     -Y Solar Array (MY)     |             |       +Y Solar Array (PY)
                             |             |
                             |_____________|
                                 .-| |-.
                          HGA  .'  `-'  `.
                               `.       .'
                                 `-----'
                                                   +Xsc is into the page


   Since the orientation of the PSYC_SPACECRAFT frame is computed
   on-board, sent down in telemetry, and stored in the s/c CK files, it
   is defined as a CK-based frame.

   \begindata

      FRAME_PSYC_SPACECRAFT          = -255000
      FRAME_-255000_NAME             = 'PSYC_SPACECRAFT'
      FRAME_-255000_CLASS            = 3
      FRAME_-255000_CLASS_ID         = -255000
      FRAME_-255000_CENTER           = -255
      CK_-255000_SCLK                = -255
      CK_-255000_SPK                 = -255

   \begintext


Psyche Solar Array Frames
--------------------------------------

   Since the Psyche solar arrays can be articulated (each having one
   degree of freedom), the solar array frames, PSYC_SA_PY and
   PSYC_SA_MY, are defined as CK frames with their orientation given
   relative to the PSYC_SPACECRAFT frame.

   Both array frames are defined as follows (see [6]):

      -  +Y axis is parallel to the longest side of the array,
         positively oriented from the yoke to the end of the wing;

      -  +Z axis is normal to the solar array plane, the solar cells
         facing +Z;

      -  +X axis is defined such that (X,Y,Z) is right handed;

      -  the origin of the frame is located at the yoke geometric
         center.

   The axis of rotation is parallel to the Y axis of the spacecraft and
   solar array frames.

   This diagram illustrates the PSYC_SA_PY and PSYC_SA_MY frames for
   arrays in the zero position:


   +Z s/c side (HGA side) view:
   ----------------------------
                                    ^
                                    | toward asteroid
                                    |
                               Science Deck
                              _____________
    __  ______________+Xsa-y |             |     _______________  ___
   |  \ \               \   ^|  . ----- .  |    /               \ \  |
   |  / /                \  ||.'         `.|   /                / /  |
   |  \ \                 `.|.   +Zsc  +Ysc| .'                 \ \  |
   |  / /       +Ysa-y <----o|      o----> |o----> +Ysa+y       / /  |
   |  \ \                 .' .      |      .|`.                 \ \  |
   |  / /                /   |`.    |    .'||  \                / /  |
   |__\ \_______________/    | +Xsc v --'  |v   \_______________\ \__|
     -Y Solar Array (MY)     |_____________|+Xsa+y +Y Solar Array (PY)
                                       
                                       
                                               +Zsc, +Zsa+y and +Zsa-y are
                                                    out of  the page

                                                Active solar cell is
                                              facing towards the viewer


   These sets of keywords define the PSYC_SA_PY ("plus") and
   PSYC_SA_MY ("minus") solar array frames as CK frames:

   \begindata

      FRAME_PSYC_SA_PY               = -255010
      FRAME_-255010_NAME             = 'PSYC_SA_PY'
      FRAME_-255010_CLASS            = 3
      FRAME_-255010_CLASS_ID         = -255010
      FRAME_-255010_CENTER           = -255
      CK_-255010_SCLK                = -255
      CK_-255010_SPK                 = -255

      FRAME_PSYC_SA_MY               = -255020
      FRAME_-255020_NAME             = 'PSYC_SA_MY'
      FRAME_-255020_CLASS            = 3
      FRAME_-255020_CLASS_ID         = -255020
      FRAME_-255020_CENTER           = -255
      CK_-255020_SCLK                = -255
      CK_-255020_SPK                 = -255

   \begintext


Psyche High Gain Antenna Frame
--------------------------------------

   The Psyche High Gain Antenna is rigidly attached to the +Z side of
   the s/c bus. Therefore, the Psyche HGA frame, PSYC_HGA, is defined
   as a fixed offset frame with its orientation given relative to the
   PSYC_SPACECRAFT frame.

   The PSYC_HGA frame is defined as follows:

      -  +Z axis is in the antenna boresight direction;

      -  +Y axis is nominally co-aligned with the s/c +Y axis;

      -  +X axis completes the right handed frame;

      -  the origin of the frame is located at the geometric center of
         the HGA dish outer rim circle.

   The following spacecraft to high gain antenna rotation matrix is
   provided in [7]:

         HGA:  0.984808       0       -0.173648
               0              1        0
               0.173648       0        0.984808

   This diagram illustrates the PSYC_HGA frame:

   -X s/c side (science deck side) view:
   -------------------------------------

                               +Xsc
                              _____ x----> +Ysc
                             |      |
                             |      |      |
                             |      v      |
   o==/ /==================o | +Zsc        |o==================/ /==o
     -Y Solar Array (MY)     |             |       +Y Solar Array (PY)
                             |             |
                             |_+Xhga ______|
                                 .-|^|-.
                          HGA  .'  `*----> +Yhga
                               `.   |   .'
                                 `--|--'
                                    v
                               +Zhga               +Xsc is into the page

                                                  +Zhga is into the page at
                                                     10 degrees angle.

                                                  +Xhga is into the page at
                                                     80 degrees angle.

   As seen on the diagram (see [7]), a single rotation by +10 degrees
   about +Y is needed to align the s/c frame with the HGA frame.

   The frame definitions below contain the opposite of this rotation
   because Euler angles specified in it define transformation from
   HGA to the s/c frame (see [1]).

   This set of keywords defines the HGA frame as a fixed offset frame:

   \begindata

      FRAME_PSYC_HGA                 = -255030
      FRAME_-255030_NAME             = 'PSYC_HGA'
      FRAME_-255030_CLASS            = 4
      FRAME_-255030_CLASS_ID         = -255030
      FRAME_-255030_CENTER           = -255
      TKFRAME_-255030_SPEC           = 'ANGLES'
      TKFRAME_-255030_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255030_ANGLES         = ( 0.0, -10.0, 0.0 )
      TKFRAME_-255030_AXES           = ( 1,     2,   3   )
      TKFRAME_-255030_UNITS          = 'DEGREES'

   \begintext


Psyche Low Gain Antenna Frames
--------------------------------------

   PSYC has three Low Gain Antennas (LGAs) (see [7]): LGA-Z pointing
   along the s/c -Z axis, LGA+X pointing along the s/c +X axis, and
   LGA-X pointing along the s/c -X axis. All three LGAs are rigidly
   attached to the s/c bus. Therefore, their frames -- PSYC_LGA_MZ,
   PSYC_LGA_PX, and PSYC_LGA_MX -- are defined as a fixed offset frames
   with orientation given relative to the PSYC_SPACECRAFT frame.

   Each of the PSYC LGA frames -- PSYC_LGA_MZ, PSYC_LGA_PX, and
   PSYC_LGA_MX -- is defined as follows:

      -  +Z axis is in the antenna boresight direction;

      -  +X axis

            for LGA+X, is nominally co-aligned with the s/c -Y axis,

            for LGA-X, is nominally co-aligned with the s/c +Y axis,

            for LGA-Z, is nominally co-aligned with the s/c +X axis;

      -  +Y axis completes the right handed frame;

      -  the origin of the frame is located at the geometric center of
         the LGA outer patch.

   The following spacecraft to low gain antennas rotation matrices are
   provided in [7]:

         LGA_MZ:  1     0     0
                  0    -1     0
                  0     0    -1

         LGA_PX:  0    -1     0
                  0     0    -1
                  1     0     0

         LGA_MX:  0     1     0
                  0     0    -1
                 -1     0     0

   This diagram illustrates the PSYC LGA frames:

   -X s/c side (science deck side) view:
   -------------------------------------

                      +Zlga-z ^
                              |
                              |  +Xsc
                  +Ylga-z<----x___x---->_+Ysc
                          +Xlga-z |      |
                           |      |      |
                     +Ylga-x      v      +Ylga+x
  o==/ /==================o|^   +Zsc    ^|o==================/ /==o
   -Y Solar Array (MY)     ||           ||       +Y Solar Array (PY)
                           ||           ||
                    +Zlga-x|o----> <----x|+Zlga+x
                           +Xlga-x +Xlga+x
                       HGA  .    -      .
                             `.       .'
                               `-----'
                                               +Xsc, +Zlga+x, and +Xlga-z
                                                   are into the page

                                               +Zlga-x is out of the page

   As seen on the diagram, a single rotation by +180 degrees about X
   is needed to align the s/c frame with the PSYC_LGA_MZ frame,
   a rotation by +90 degrees about Y followed by a rotation by -90 degrees
   about Z is needed to align the s/c frame with the PSYC_LGA_PX frame, and
   a rotation by -90 degrees about Y followed by +90 degrees about Z is
   needed to align the s/c frame with the PSYC_LGA_MX frame.

   The frame definitions below contain the opposite of these rotations
   because Euler angles specified in them define transformation from
   LGA to the s/c frame (see [1]).

   These sets of keywords define the LGA frames:

   \begindata

      FRAME_PSYC_LGA_MZ              = -255040
      FRAME_-255040_NAME             = 'PSYC_LGA_MZ'
      FRAME_-255040_CLASS            = 4
      FRAME_-255040_CLASS_ID         = -255040
      FRAME_-255040_CENTER           = -255
      TKFRAME_-255040_SPEC           = 'ANGLES'
      TKFRAME_-255040_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255040_ANGLES         = ( -180.0, 0.0, 0.0 )
      TKFRAME_-255040_AXES           = (    1,   2,   3   )
      TKFRAME_-255040_UNITS          = 'DEGREES'

      FRAME_PSYC_LGA_PX              = -255050
      FRAME_-255050_NAME             = 'PSYC_LGA_PX'
      FRAME_-255050_CLASS            = 4
      FRAME_-255050_CLASS_ID         = -255050
      FRAME_-255050_CENTER           = -255
      TKFRAME_-255050_SPEC           = 'ANGLES'
      TKFRAME_-255050_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255050_ANGLES         = ( 0.0, -90.0, 90.0 )
      TKFRAME_-255050_AXES           = ( 1,     2,    3   )
      TKFRAME_-255050_UNITS          = 'DEGREES'

      FRAME_PSYC_LGA_MX              = -255060
      FRAME_-255060_NAME             = 'PSYC_LGA_MX'
      FRAME_-255060_CLASS            = 4
      FRAME_-255060_CLASS_ID         = -255060
      FRAME_-255060_CENTER           = -255
      TKFRAME_-255060_SPEC           = 'ANGLES'
      TKFRAME_-255060_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255060_ANGLES         = ( 0.0, 90.0, -90.0 )
      TKFRAME_-255060_AXES           = ( 1,    2,     3   )
      TKFRAME_-255060_UNITS          = 'DEGREES'

   \begintext


Psyche Star Tracker Frames
--------------------------------------

   The star trackers (ST1 and ST2) are rigidly attached to the +X side
   of the s/c bus. Therefore, the star tracker frames, PSYC_ST1 and
   PSYC_ST2, are defined as fixed offset frames with their orientation
   given relative to the PSYC_SPACECRAFT frame.

   The star tracker frames are defined as follows:

      -  +Z axis is in the star tracker boresight direction;

      -  +Y axis

            for PSYC_ST1, is nominally co-aligned with the s/c -Z axis,

            for PSYC_ST2, is nominally co-aligned with the s/c +Z axis;

      -  +X axis completes the right handed frame;

      -  the origin of the frame is located at the star tracker focal
         point.

   The following spacecraft to star tracker rotation matrices are
   provided in [7]:

         ST1:    -0.6394      -0.7689        0
                  0            0            -1
                  0.7689      -0.6394        0

         ST2:    -0.6127       0.7907        0
                  0            0             1
                  0.7907       0.6122        0

   This diagram illustrates the star tracker frames:


   +Z s/c side (HGA side) view:
   ----------------------------
                                    ^
                                    | toward asteroid
                                    |
                               Science Deck
                              _____________
    __  ________________     |             |     _______________  ___
   |  \ \               \    |  . ----- .  |    /               \ \  |
   |  / /                \   |.'         `.|   /                / /  |
   |  \ \                 `. .   +Zsc  +Ysc| .'                 \ \  |
   |  / /                   o|      o----> |o                   / /  |
   |  \ \                 .' .      |      . `.                 \ \  |
   |  / /                /   |`.  +Xst2  +Xst1 \                / /  |
   |__\ \_______________/    | +Xsc v ^ ^  |    \_______________\ \__|
     -Y Solar Array (MY)     |_______/___\_|       +Y Solar Array (PY)
                              +Yst2 o     * +Yst1
                                     \   /
                                      v v
                                +Zst2     +Zst1

                                              +Zsc, +Yst2 are out of
                                                the page

                                              +Yst1 is into the page

   As seen on the diagram (see [7]), a rotation by -39.75 degrees about Z
   followed by a rotation by +90 degrees about Y followed by a rotation by
   -90.0 degrees about Z is needed to align the s/c frame with the ST1
   frame, and a rotation by +37.76 degrees about Z followed by a rotation by
   +90 degrees about Y followed by a rotation by +90.0 degrees about Z
    is needed to align the s/c frame with the ST2 frame.

   The frame definitions below contain the opposite of these rotations
   because Euler angles specified in them define transformation from
   ST to the s/c frame (see [1]).

   The sets of keywords below define the star tracker frames.

   \begindata

      FRAME_PSYC_ST1                 = -255070
      FRAME_-255070_NAME             = 'PSYC_ST1'
      FRAME_-255070_CLASS            = 4
      FRAME_-255070_CLASS_ID         = -255070
      FRAME_-255070_CENTER           = -255
      TKFRAME_-255070_SPEC           = 'ANGLES'
      TKFRAME_-255070_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255070_ANGLES         = ( 39.75, -90.0, 90.0 )
      TKFRAME_-255070_AXES           = (  3,      2,    3   )
      TKFRAME_-255070_UNITS          = 'DEGREES'

      FRAME_PSYC_ST2                 = -255080
      FRAME_-255080_NAME             = 'PSYC_ST2'
      FRAME_-255080_CLASS            = 4
      FRAME_-255080_CLASS_ID         = -255080
      FRAME_-255080_CENTER           = -255
      TKFRAME_-255080_SPEC           = 'ANGLES'
      TKFRAME_-255080_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255080_ANGLES         = ( -37.76, -90.0, -90.0 )
      TKFRAME_-255080_AXES           = (   3,      2,     3   )
      TKFRAME_-255080_UNITS          = 'DEGREES'

   \begintext


Sun Sensor Frames
------------------------------

   The frame for each of the 8 Sun Sensors (SS's) mounted on the
   s/c is defined as follows:

      -  +Z axis is along the sensor's boresight;

      -  +Y axis is parallel to the XY plane of the s/c frame;

      -  +X axis is completes the right hand frame;

      -  the origin of the frame is located at the geometric center of the
         sensor.

   The following SS boresight directions and azimuth/elevation pairs with
   respect to the s/c frame are provided in the table on slide #23 of [7]:

      Cosine Sensor  Elevation     Azimuth         X         Y        Z
      Head           Angle, deg    Angle, deg
      -------------  ------------  ----------   --------  -------  --------
      Head 1               -22     84.63454     0.08670   0.92312  -0.37461
      Head 2                22     84.63454     0.08670   0.92312   0.37461
      Head 3               -30     35.26439     0.70711   0.50000  -0.50000
      Head 4                30     35.26439     0.70711   0.50000   0.50000
      Head 5               -30    -35.26439     0.70711  -0.50000  -0.50000
      Head 6                30    -35.26439     0.70711  -0.50000   0.50000
      Head 7               -22    -84.63454     0.08670  -0.92312  -0.37461
      Head 8                22    -84.63454     0.08670  -0.92312   0.37461

   A matrix rotating vectors from the s/c frame to the sensor frame can
   be constructed from the azimuth and elevation pair as follows ([7], [8]):

         Msc->ss = |90.0-EL|  * |AZ|
                            Y       Z

   The frame definitions below contain the opposite of this rotation
   because Euler angles specified in it define transformation from the
   instrument to the s/c frame (see [1]).

   \begindata

      FRAME_PSYC_SS1            = -255091
      FRAME_-255091_NAME        = 'PSYC_SS1'
      FRAME_-255091_CLASS       = 4
      FRAME_-255091_CLASS_ID    = -255091
      FRAME_-255091_CENTER      = -255
      TKFRAME_-255091_SPEC      = 'ANGLES'
      TKFRAME_-255091_RELATIVE  = 'PSYC_SPACECRAFT'
      TKFRAME_-255091_ANGLES    = (    -84.63454,    -112.000,      0.000 )
      TKFRAME_-255091_AXES      = (      3,             2,          1     )
      TKFRAME_-255091_UNITS     = 'DEGREES'

      FRAME_PSYC_SS2            = -255092
      FRAME_-255092_NAME        = 'PSYC_SS2'
      FRAME_-255092_CLASS       = 4
      FRAME_-255092_CLASS_ID    = -255092
      FRAME_-255092_CENTER      = -255
      TKFRAME_-255092_SPEC      = 'ANGLES'
      TKFRAME_-255092_RELATIVE  = 'PSYC_SPACECRAFT'
      TKFRAME_-255092_ANGLES    = (    -84.63454,     -68.000,      0.000 )
      TKFRAME_-255092_AXES      = (      3,             2,          1     )
      TKFRAME_-255092_UNITS     = 'DEGREES'

      FRAME_PSYC_SS3            = -255093
      FRAME_-255093_NAME        = 'PSYC_SS3'
      FRAME_-255093_CLASS       = 4
      FRAME_-255093_CLASS_ID    = -255093
      FRAME_-255093_CENTER      = -255
      TKFRAME_-255093_SPEC      = 'ANGLES'
      TKFRAME_-255093_RELATIVE  = 'PSYC_SPACECRAFT'
      TKFRAME_-255093_ANGLES    = (    -35.26439,     -120.000,      0.000 )
      TKFRAME_-255093_AXES      = (      3,              2,          1     )
      TKFRAME_-255093_UNITS     = 'DEGREES'

      FRAME_PSYC_SS4            = -255094
      FRAME_-255094_NAME        = 'PSYC_SS4'
      FRAME_-255094_CLASS       = 4
      FRAME_-255094_CLASS_ID    = -255094
      FRAME_-255094_CENTER      = -255
      TKFRAME_-255094_SPEC      = 'ANGLES'
      TKFRAME_-255094_RELATIVE  = 'PSYC_SPACECRAFT'
      TKFRAME_-255094_ANGLES    = (   -35.26439,      -60.000,      0.000 )
      TKFRAME_-255094_AXES      = (     3,              2,          1     )
      TKFRAME_-255094_UNITS     = 'DEGREES'

      FRAME_PSYC_SS5            = -255095
      FRAME_-255095_NAME        = 'PSYC_SS5'
      FRAME_-255095_CLASS       = 4
      FRAME_-255095_CLASS_ID    = -255095
      FRAME_-255095_CENTER      = -255
      TKFRAME_-255095_SPEC      = 'ANGLES'
      TKFRAME_-255095_RELATIVE  = 'PSYC_SPACECRAFT'
      TKFRAME_-255095_ANGLES    = (    35.26439,     -120.000,      0.000 )
      TKFRAME_-255095_AXES      = (     3,              2,          1     )
      TKFRAME_-255095_UNITS     = 'DEGREES'

      FRAME_PSYC_SS6            = -255096
      FRAME_-255096_NAME        = 'PSYC_SS6'
      FRAME_-255096_CLASS       = 4
      FRAME_-255096_CLASS_ID    = -255096
      FRAME_-255096_CENTER      = -255
      TKFRAME_-255096_SPEC      = 'ANGLES'
      TKFRAME_-255096_RELATIVE  = 'PSYC_SPACECRAFT'
      TKFRAME_-255096_ANGLES    = (    35.26439,      -60.000,      0.000 )
      TKFRAME_-255096_AXES      = (     3,              2,          1     )
      TKFRAME_-255096_UNITS     = 'DEGREES'

      FRAME_PSYC_SS7            = -255097
      FRAME_-255097_NAME        = 'PSYC_SS7'
      FRAME_-255097_CLASS       = 4
      FRAME_-255097_CLASS_ID    = -255097
      FRAME_-255097_CENTER      = -255
      TKFRAME_-255097_SPEC      = 'ANGLES'
      TKFRAME_-255097_RELATIVE  = 'PSYC_SPACECRAFT'
      TKFRAME_-255097_ANGLES    = (    84.63454,    -112.000,      0.000 )
      TKFRAME_-255097_AXES      = (     3,             2,          1     )
      TKFRAME_-255097_UNITS     = 'DEGREES'

      FRAME_PSYC_SS8            = -255098
      FRAME_-255098_NAME        = 'PSYC_SS8'
      FRAME_-255098_CLASS       = 4
      FRAME_-255098_CLASS_ID    = -255098
      FRAME_-255098_CENTER      = -255
      TKFRAME_-255098_SPEC      = 'ANGLES'
      TKFRAME_-255098_RELATIVE  = 'PSYC_SPACECRAFT'
      TKFRAME_-255098_ANGLES    = (    84.63454,     -68.000,      0.000 )
      TKFRAME_-255098_AXES      = (     3,             2,          1     )
      TKFRAME_-255098_UNITS     = 'DEGREES'

   \begintext


IMGA and IMGB Imager Frames
========================================================================

   This section of the file contains the definitions of the Imager A
   (IMGA) and Imager B (IMGB) frames.


IMGA and IMGB Frame Tree
--------------------------------------

   The diagram below shows the IMGA and IMGB frame hierarchy.

                               "J2000" INERTIAL
           +--------------------------+
           |                          |
           |<-pck                     |
           |                          |
           V                          |
      "PSYCHE_FIXED"                  |
      --------------                  |
                                      |
                                      |<-ck
                                      |
                                      V
                               "PSYC_SPACECRAFT"
           +-----------------------------------------------------+
           |                                                     |
           |<-fixed                                              |<-fixed
           |                                                     |
           V                                                     V
       "PSYC_IMGA"                                           "PSYC_IMGB"
       ----------                                            ----------


IMGA and IMGB Frames
--------------------------------------

   The Imager A and B frames -- PSYC_IMGA and PSYC_IMGB -- are defined
   as follows:

      -  +Z axis points along the imager boresight;

      -  +X axis is parallel to the apparent image columns [TBD]; it is
         nominally co-aligned with the s/c +Z axis;

      -  +Y axis completes the right handed frame; it is nominally
         parallel to the apparent image lines [TBD].

      -  the origin of the frame is located at the imager focal point.

   The following spacecraft to imager rotation matrices are
   provided in [7]:

         IMGA:    0            0             1
                  0            1             0
                 -1            0             0

         IMGB:    0            0             1
                 -0.0645       0.9979        0
                 -0.9979      -0.0645        0

   This diagram illustrates the IMGA and IMGB imager frames:

   +Z s/c side (HGA side) view:
   ----------------------------
                                    ^
                                    | toward asteroid

                        +Zimgb         +Zimga
                              ^        ^
                               \ +Yimgb|
                                \  .-> |     +Yimga
                              ___o'___ o---->
    __  ________________    +Ximgb    +Ximga     _______________  ___
   |  \ \               \    |  . ----- .  |    /               \ \  |
   |  / /                \   |.'         `.|   /                / /  |
   |  \ \                 `. . +Zsc    +Ysc| .'                 \ \  |
   |  / /                 | o|      o----> |o |                 / /  |
   |  \ \                 .' .      |      . `.                 \ \  |
   |  / /                /   |`.    |    .'|   \                / /  |
   |__\ \_______________/    | +Xsc v --'  |    \_______________\ \__|
     -Y Solar Array (MY)     |_____________|       +Y Solar Array (PY)
                                       
                                       
                                                   +Zsc, +Ximga, and +Ximgb
                                                     are out of the page

   As seen on the diagram (see [7]), a rotation by -90 degrees about Y is
   required to align the s/c frame with the Imager A frame, and a rotation
   by 3.7 degrees about Z followed by a rotation by -90 degrees about Y are
   needed to align the s/c frame with the Imager B frame.

   The frame definitions below contain the opposite of this rotation
   because Euler angles specified in it define transformation from the
   instrument to the s/c frame (see [1]).

   The sets of keywords below define the imager frames:

   \begindata

      FRAME_PSYC_IMGA                = -255110
      FRAME_-255110_NAME             = 'PSYC_IMGA'
      FRAME_-255110_CLASS            = 4
      FRAME_-255110_CLASS_ID         = -255110
      FRAME_-255110_CENTER           = -255
      TKFRAME_-255110_SPEC           = 'ANGLES'
      TKFRAME_-255110_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255110_ANGLES         = ( 0.0, 90.0, 0.0 )
      TKFRAME_-255110_AXES           = ( 1,    2,   3   )
      TKFRAME_-255110_UNITS          = 'DEGREES'

      FRAME_PSYC_IMGB                = -255130
      FRAME_-255130_NAME             = 'PSYC_IMGB'
      FRAME_-255130_CLASS            = 4
      FRAME_-255130_CLASS_ID         = -255130
      FRAME_-255130_CENTER           = -255
      TKFRAME_-255130_SPEC           = 'ANGLES'
      TKFRAME_-255130_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255130_ANGLES         = ( -3.7, 90.0, 0.0 )
      TKFRAME_-255130_AXES           = (  3,    2,   1   )
      TKFRAME_-255130_UNITS          = 'DEGREES'

   \begintext


GRNS frames
========================================================================

   This section of the file contains definitions of the Gamma Ray
   Spectrometer (GRS) and Neutron Spectrometer (NS) frames.


GRNS Frame Tree
--------------------------------------

   The diagram below shows the GRSN frames hierarchy.

                               "J2000" INERTIAL
                         +--------------------------+
                                      |
                                      |<-ck
                                      |
                                      V
                               "PSYC_SPACECRAFT"
           +-----------------------------------------------------+
           |                 |                 |                 |
           |<-fixed          |<-fixed          |<-fixed          |<-fixed
           |                 |                 |                 |
           V                 V                 V                 V
       "PSYC_GRS"         "PSYC_GRS_MECH"     "PSYC_NS"       "PSYC_NS_MECH"
       ----------         ---------------     ---------       --------------


GRNS Instruments Science Frames
--------------------------------------

   The Gamma Ray Spectrometer (GRS) and Neutron Spectrometer (NS)
   science frames -- PSYC_GRS (ID -255150) and PSYC_NS (ID -255160) -- are
   defined as follows:

      -  +Z axis points along the instrument boresight;

      -  +Y axis is co-aligned with the s/c +Y axis;

      -  +X axis completes the right handed frame;

      -  the origin of the frame is located at the geometric center of
         the detector.

   These frames are defined as fixed offset frames relative to the
   PSYC_SPACECRAFT frame.


   -X s/c side (science deck side) view:
   -------------------------------------

                               +Xsc
                              _____ x----> +Ysc
                             |      |
                             |      |      |
                             |      v      |
   o==/ /==================o | +Zsc        |o==================/ /==o
     -Y Solar Array (MY)     |             |       +Y Solar Array (PY)
                             |             |
                             |_____________|
                             |   .-| |-.
                             | .'  `-'  `. HGA
                             | `.       .'
                             |   `-----'
                        +Zns |o----> +Yns
                             ||
                             || +Xns
                             |v
                       +Zgrs |o----> +Ygrs
                              |
                              |
                              v +Xgrs

                                                 +Xsc is into the page

                                                 +Zgrs and +Zns are out
                                                     of the page

   As seen on the diagram (see [6], [7]), a rotation by -90 degrees about Y
   is needed to align the s/c frame with the GRS and NS science frames.

   The frame definitions below contain the opposite of this rotation
   because Euler angles specified in it define transformation from the
   instrument to the s/c frame (see [1]).

   The keywords below define the GRNS frames.

   \begindata

      FRAME_PSYC_GRS                 = -255150
      FRAME_-255150_NAME             = 'PSYC_GRS'
      FRAME_-255150_CLASS            = 4
      FRAME_-255150_CLASS_ID         = -255150
      FRAME_-255150_CENTER           = -255
      TKFRAME_-255150_SPEC           = 'ANGLES'
      TKFRAME_-255150_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255150_ANGLES         = ( 0.0, 90.0, 0.0 )
      TKFRAME_-255150_AXES           = ( 1,    2,   3   )
      TKFRAME_-255150_UNITS          = 'DEGREES'

      FRAME_PSYC_NS                  = -255160
      FRAME_-255160_NAME             = 'PSYC_NS'
      FRAME_-255160_CLASS            = 4
      FRAME_-255160_CLASS_ID         = -255160
      FRAME_-255160_CENTER           = -255
      TKFRAME_-255160_SPEC           = 'ANGLES'
      TKFRAME_-255160_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255160_ANGLES         = ( 0.0, 90.0, 0.0 )
      TKFRAME_-255160_AXES           = ( 1,    2,   3   )
      TKFRAME_-255160_UNITS          = 'DEGREES'

   \begintext


GRNS Instruments Mechanical Frames
--------------------------------------

   The Gamma Ray Spectrometer (GRS) mechanical frame -- PSYC_GRS_MECH
   (ID -255151) -- is defined as follows:

      -  +Z axis is co-aligned with the s/c +Z axis;

      -  +Y axis is co-aligned with the s/c +Y axis;

      -  +X axis completes the right handed frame, and is co-aligned with
         with s/c +X axis;

      -  the origin of the frame is located at the geometric center of
         the detector.


   The Neutron Spectrometer (NS) mechanical frame -- PSYC_NS_MECH (ID
   -255161) -- is defined as follows:

      -  +Z axis is co-aligned with the s/c -Z axis;

      -  +Y axis is co-aligned with the s/c -X axis;

      -  +X axis completes the right handed frame, and is co-aligned with
         the s/c -Y axis;

      -  the origin of the frame is located at the geometric center of
         the detector.

   These frames are defined as fixed offset frames relative to the
   PSYC_SPACECRAFT frame.

   The following spacecraft to GRS and NS rotation matrices are
   provided in [7]:

         GRS:     1            0             0
                  0            1             0
                  0            0             1

         NS:      0           -1             0
                 -1            0             0
                  0            0            -1

   -X s/c side (science deck side) view:
   -------------------------------------

                                  +Xsc
                              _____ x----> +Ysc
                             |      |
                             |      |      |
                             |      v      |
   o==/ /==================o |    +Zsc     |o==================/ /==o
     -Y Solar Array (MY)     |             |       +Y Solar Array (PY)
                             |             |
                             |_____________|
                             |   .-| |-.
                             | .'  `-'  `. HGA
                        +Zns |^`.       .'
                             ||  '-----'
                    +Xns <---|o
                             |+Yns
                             |
                             |
                       +Xgrs |x----> +Ygrs
                              |
                              |
                              v +Zgrs

                                             +Xsc and +Xgrs are into the page

                                             +Yns in out of the page

   As seen on the diagram (see [7]), the GRS_MECH frame is co-aligned
   with the s/c frame, and a rotation by +90 degrees about Z followed by
   a rotation by +180 degrees around Y is needed to align the s/c frame with
   the NS_MECH frame.

   The frame definitions below contain the opposite of this rotation
   because Euler angles specified in it define transformation from the
   instrument to the s/c frame (see [1]).

   The keywords below define the GRNS mechanical frames.

   \begindata

      FRAME_PSYC_GRS_MECH            = -255151
      FRAME_-255151_NAME             = 'PSYC_GRS_MECH'
      FRAME_-255151_CLASS            = 4
      FRAME_-255151_CLASS_ID         = -255151
      FRAME_-255151_CENTER           = -255
      TKFRAME_-255151_SPEC           = 'ANGLES'
      TKFRAME_-255151_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255151_ANGLES         = ( 0.0, 0.0, 0.0 )
      TKFRAME_-255151_AXES           = ( 1,   2,   3   )
      TKFRAME_-255151_UNITS          = 'DEGREES'

      FRAME_PSYC_NS_MECH             = -255161
      FRAME_-255161_NAME             = 'PSYC_NS_MECH'
      FRAME_-255161_CLASS            = 4
      FRAME_-255161_CLASS_ID         = -255161
      FRAME_-255161_CENTER           = -255
      TKFRAME_-255161_SPEC           = 'ANGLES'
      TKFRAME_-255161_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255161_ANGLES         = ( -90.0, -180.0, 0.0 )
      TKFRAME_-255161_AXES           = (   3,      2,   1   )
      TKFRAME_-255161_UNITS          = 'DEGREES'

   \begintext


MAG frames
========================================================================

   This section of the file contains definitions of the Magnetometer
   (MAG) frames.

MAG Frame Tree
--------------------------------------

   The diagram below shows the MAG frame hierarchy.


                               "J2000" INERTIAL
                               +--------------+
                                      |
                                      |<-ck
                                      |
                                      V
                               "PSYC_SPACECRAFT"
           +-----------------------------------------------------+
           |                                                     |
           |<-fixed                                              |<-fixed
           |                                                     |
           V                                                     V
      "PSYC_MAG1"                                           "PSYC_MAG2"
      -----------                                           -----------


MAG1 and MAG2 Frames
--------------------------------------

   The following frames are defined for the dual Magnetometers (MAG)
   (see [7]): PSYC_MAG1 (ID -255170) and PSYC_MAG2 (ID -255180). These frames
   are defined as fixed offset frames relative to the PSYC_SPACECRAFT
   frame.

   Each of the PSYC MAG frames -- PSYC_MAG1 and PSYC_MAG2 -- is defined
   as follows:

      -  +X axis is nominally co-aligned with the s/c +Y axis;

      -  +Y axis is nominally co-aligned with the s/c -Z axis;

      -  +Z axis completes the right handed frame, and is nominally
         co-aligned with the s/c -X axis;

      -  the origin of the frame is located at the geometric center of
         the detector.

   The following spacecraft to magnetometer rotation matrices are
   provided in [7]:

         MAG1:    0     1     0
                  0     0    -1
                 -1     0     0

         MAG2:    0     1     0
                  0     0    -1
                 -1     0     0

   -X s/c side (science deck side) view:
   -------------------------------------

                               +Xsc
                              _____ x----> +Ysc
                             |      |
                             |      |      |
                             |      v      |
   o==/ /==================o | +Zsc        |o==================/ /==o
     -Y Solar Array (MY)     |             |       +Y Solar Array (PY)
                             |             |
                             |_____________|
                                 .-| |-.   |
                           HGA .'  `-'  `. |
                               `.       .' |^ +Ymag2
                                 `-----'   ||
                                    +Zmag2 |o----> +Xmag2
                                           |
                                           |^ +Ymag1
                                           ||
                                    +Zmag1 |o----> +Xmag1

                                                    +Xsc is into the page

                                                    +Zmag1 and +Zmag2
                                                       are into the page

   As seen on the diagram (see [7]), a rotation by -90.0 degrees about Y
   followed by a rotation by +90.0 degrees around Z is needed to align the
   s/c frame with both MAG frames.

   The frame definitions below contain the opposite of this rotation
   because Euler angles specified in it define transformation from the
   instrument to the s/c frame (see [1]).

   The keywords below define the MAG frames.

   \begindata

      FRAME_PSYC_MAG1                = -255170
      FRAME_-255170_NAME             = 'PSYC_MAG1'
      FRAME_-255170_CLASS            = 4
      FRAME_-255170_CLASS_ID         = -255170
      FRAME_-255170_CENTER           = -255
      TKFRAME_-255170_SPEC           = 'ANGLES'
      TKFRAME_-255170_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255170_ANGLES         = ( 0.0, 90.0, -90.0 )
      TKFRAME_-255170_AXES           = ( 1,    2,     3   )
      TKFRAME_-255170_UNITS          = 'DEGREES'

      FRAME_PSYC_MAG2                = -255180
      FRAME_-255180_NAME             = 'PSYC_MAG2'
      FRAME_-255180_CLASS            = 4
      FRAME_-255180_CLASS_ID         = -255180
      FRAME_-255180_CENTER           = -255
      TKFRAME_-255180_SPEC           = 'ANGLES'
      TKFRAME_-255180_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255180_ANGLES         = ( 0.0, 90.0, -90.0 )
      TKFRAME_-255180_AXES           = ( 1,    2,     3   )
      TKFRAME_-255180_UNITS          = 'DEGREES'

   \begintext


DSM Frames
========================================================================

   This section of the file contains definitions of the DAPM actuated 
   Stationary Plasma Thruster (SPT) Modules (DSM) frames.


DSM Frame Tree
--------------------------------------

   The diagram below shows the DSM frame hierarchy.


                               "J2000" INERTIAL
                               +--------------+
                                      |
                                      |<-ck
                                      |
                                      V
                               "PSYC_SPACECRAFT"
           +-----------------------------------------------------+
           |                                                     |
           |<-fixed                                       fixed->|
           |                                                     |
           V                                                     V
      "PSYC_DSM1_BASE"                                 "PSYC_DSM2_BASE"
      ----------------                                 ----------------
           |                                                     |
           |<-ck                                             ck->|
           |                                                     |
           V                                                     V
      "PSYC_DSM1_AXIS1"                               "PSYC_DSM2_AXIS1"
      -----------------                               -----------------
           |                                                     |
           |<-ck                                             ck->|
           |                                                     |
           V                                                     V
      "PSYC_DSM1_AXIS2"                               "PSYC_DSM2_AXIS2"
      -----------------                               -----------------
           |         |                                 |          |
           |         |<-fixed                   fixed->|          |
           |         |                                 |          |
           |         V                                 V          |
           |   "PSYC_DSM1_EP_A"                "PSYC_DSM2_EP_B"   |
           |   ----------------                ----------------   |
           |                                                      |
           |<-fixed                                        fixed->|
           |                                                      |
           V                                                      V
      "PSYC_DSM1_EP_C"                                 "PSYC_DSM2_EP_D"
      ----------------                                 ----------------
                                      
                                      
DSM Frames
--------------------------------------

   The following frames are defined for the two DSMs. For DSM1:

      PSYC_DSM1_BASE  (ID -255210), 
      PSYC_DSM1_AXIS1 (ID -255211), 
      PSYC_DSM1_AXIS2 (ID -255212), 
      PSYC_DSM1_EP_A  (ID -255213), and 
      PSYC_DSM1_EP_C  (ID -255214).

   And for DSM2:

      PSYC_DSM2_BASE  (ID -255220), 
      PSYC_DSM2_AXIS1 (ID -255221),
      PSYC_DSM2_AXIS2 (ID -255222), 
      PSYC_DSM2_EP_B  (ID -255223), and 
      PSYC_DSM2_EP_D  (ID -255224). 

   Per [12], DSM1 is on the +X or East face of the spacecraft and 
   DSM2 is on the -X or West face. Each DSM articulates via two gimbals 
   Axis1 and Axis2. The two rotation axes intersect at the DAPM point 
   of each DSM. Each DSM contains two Hall Effect Thrusters (HET). The 
   HET which is outermost on each DSM, i.e. furthest from the DAPM, is 
   HET1 - the primary HET. The other HET which is closer to the DAPM is 
   HET2 - the redundant HET.

   HET1 and HET2 are designated as follows for each DSM, per [13]:

      -  DSM1_HET1 --> DSM1_EP_A

      -  DSM1_HET2 --> DSM1_EP_C

      -  DSM2_HET1 --> DSM2_EP_B

      -  DSM2_HET2 --> DSM2_EP_D

   The PSYC_DSM1_BASE and PSYC_DSM2_BASE frames are oriented as follows:

      -  +X axis is along gimbal rotation axis AXIS1 in stowed position.
         For PSYC_DSM1_BASE, this is S/C +X; for PSYC_DSM2_BASE, 
         this is S/C -X.

      -  +Y axis is along gimbal rotation axis AXIS2 in stowed postion.
         For both frames, this is S/C -Z

      -  +Z axis completes the right-handed frame and is aligned with
         S/C +Y for DSM1 and S/C -Y for DSM2. The +Z axis also points 
         toward the end of the DSM.

      -  the origin of the frame is located at the DAPM point.

   The transformation from the S/C frame to PSYC_DSM1_BASE consists 
   of a rotation of -90 deg about X axis. The transformation from the 
   S/C frame to PSYC_DSM2_BASE consists of a rotation of -90 deg about 
   the X axis followed by a 180 deg rotation about the Y axis.

   The PSYC_DSM<1,2>_AXIS1 (ID -255211/-255221) and PSYC_DSM<1,2>_AXIS2
   (ID -255212/-255222) frames define the rotation of the gimbal 
   movements for the AXIS1 and AXIS2 gimbals. For both DSMs, 
   the AXIS1 rotation axis is aligned with the BASE frame +X and 
   the AXIS2 rotation axis is aligned with the BASE frame +Y in 
   the stowed configuration. In the stowed configuration (gimbal 
   angles = 0), the BASE, AXIS1, and AXIS2 frames are coaligned.
   The origin of these frames is at the DAPM point. The rotaion is 
   provided in C Kernels and these frames are defined as CK frames 
   below.

   The frames PSYC_DSM1_EP_A (ID -255213), PSYC_DSM1_EP_C (ID -255214), 
   PSYC_DSM2_EP_B (ID -255223), and PSYC_DSM2_EP_D (ID -255224) define 
   the thruster frames and are aligned as follows:
   
      -  +Z axis is normal to the thruster surface in the direction 
         of the plume (anti-thrust). Per [12] table 5, the thrust 
         unit vectors for AXIS1 rotation = AXIS2 rotation = 0.0 are:

                        DSM1                DSM2
                   EP_A      EP_C      EP_B      EP_D
            X:  -0.75471  -0.89879   0.75471   0.89879
            Y:  -0.65606  -0.43838   0.65606   0.43838
            Z:   0.00000   0.00000   0.00000   0.00000

      -  +X axis points toward the base of the DSM (toward the DAPM) 
         and is in the SPT exit plane.

      -  +Y axis completes the right handed frame.

      -  the origin of the frame is located at the center of the 
         SPT exit plane.

   Diagrams [TBD].

   Given the above defintion, the transformation from the 
   corresponding AXIS2 frame to the thruster frame consists 
   of a rotation about the Y axis of 49.0 deg for thruster 1 
   (EP_A, EP_B) or 64.0 deg for thruster 2 (EP_C, EP_D).

   The frame definitions are given in the keywords below.

   \begindata

      FRAME_PSYC_DSM1_BASE           = -255210
      FRAME_-255210_NAME             = 'PSYC_DSM1_BASE'
      FRAME_-255210_CLASS            = 4
      FRAME_-255210_CLASS_ID         = -255210
      FRAME_-255210_CENTER           = -255
      TKFRAME_-255210_SPEC           = 'ANGLES'
      TKFRAME_-255210_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255210_ANGLES         = ( 90.0, 0.0, 0.0 )
      TKFRAME_-255210_AXES           = ( 1,   2,   3   )
      TKFRAME_-255210_UNITS          = 'DEGREES'

      FRAME_PSYC_DSM1_AXIS1          = -255211
      FRAME_-255211_NAME             = 'PSYC_DSM1_AXIS1'
      FRAME_-255211_CLASS            = 3
      FRAME_-255211_CLASS_ID         = -255211
      FRAME_-255211_CENTER           = -255
      CK_-255211_SCLK                = -255
      CK_-255211_SPK                 = -255

      FRAME_PSYC_DSM1_AXIS2          = -255212
      FRAME_-255212_NAME             = 'PSYC_DSM1_AXIS2'
      FRAME_-255212_CLASS            = 3
      FRAME_-255212_CLASS_ID         = -255212
      FRAME_-255212_CENTER           = -255
      CK_-255212_SCLK                = -255
      CK_-255212_SPK                 = -255

      FRAME_PSYC_DSM1_EP_A           = -255213
      FRAME_-255213_NAME             = 'PSYC_DSM1_EP_A'
      FRAME_-255213_CLASS            = 4
      FRAME_-255213_CLASS_ID         = -255213
      FRAME_-255213_CENTER           = -255
      TKFRAME_-255213_SPEC           = 'ANGLES'
      TKFRAME_-255213_RELATIVE       = 'PSYC_DSM1_AXIS2'
      TKFRAME_-255213_ANGLES         = ( 0.0, -49.0, 0.0 )
      TKFRAME_-255213_AXES           = (   1,     2,   3 )
      TKFRAME_-255213_UNITS          = 'DEGREES'

      FRAME_PSYC_DSM1_EP_C           = -255214
      FRAME_-255214_NAME             = 'PSYC_DSM1_EP_C'
      FRAME_-255214_CLASS            = 4
      FRAME_-255214_CLASS_ID         = -255214
      FRAME_-255214_CENTER           = -255
      TKFRAME_-255214_SPEC           = 'ANGLES'
      TKFRAME_-255214_RELATIVE       = 'PSYC_DSM1_AXIS2'
      TKFRAME_-255214_ANGLES         = ( 0.0, -64.0, 0.0 )
      TKFRAME_-255214_AXES           = (   1,     2,   3 )
      TKFRAME_-255214_UNITS          = 'DEGREES'

      FRAME_PSYC_DSM2_BASE           = -255220
      FRAME_-255220_NAME             = 'PSYC_DSM2_BASE'
      FRAME_-255220_CLASS            = 4
      FRAME_-255220_CLASS_ID         = -255220
      FRAME_-255220_CENTER           = -255
      TKFRAME_-255220_SPEC           = 'ANGLES'
      TKFRAME_-255220_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255220_ANGLES         = ( 90.0, 180.0, 0.0 )
      TKFRAME_-255220_AXES           = ( 1,   2,   3   )
      TKFRAME_-255220_UNITS          = 'DEGREES'

      FRAME_PSYC_DSM2_AXIS1          = -255221
      FRAME_-255221_NAME             = 'PSYC_DSM2_AXIS1'
      FRAME_-255221_CLASS            = 3
      FRAME_-255221_CLASS_ID         = -255221
      FRAME_-255221_CENTER           = -255
      CK_-255221_SCLK                = -255
      CK_-255221_SPK                 = -255

      FRAME_PSYC_DSM2_AXIS2          = -255222
      FRAME_-255222_NAME             = 'PSYC_DSM2_AXIS2'
      FRAME_-255222_CLASS            = 3
      FRAME_-255222_CLASS_ID         = -255222
      FRAME_-255222_CENTER           = -255
      CK_-255222_SCLK                = -255
      CK_-255222_SPK                 = -255

      FRAME_PSYC_DSM2_EP_B           = -255223
      FRAME_-255223_NAME             = 'PSYC_DSM2_EP_B'
      FRAME_-255223_CLASS            = 4
      FRAME_-255223_CLASS_ID         = -255223
      FRAME_-255223_CENTER           = -255
      TKFRAME_-255223_SPEC           = 'ANGLES'
      TKFRAME_-255223_RELATIVE       = 'PSYC_DSM2_AXIS2'
      TKFRAME_-255223_ANGLES         = ( 0.0, -49.0, 0.0 )
      TKFRAME_-255223_AXES           = (   1,     2,   3 )
      TKFRAME_-255223_UNITS          = 'DEGREES'

      FRAME_PSYC_DSM2_EP_D           = -255224
      FRAME_-255224_NAME             = 'PSYC_DSM2_EP_D'
      FRAME_-255224_CLASS            = 4
      FRAME_-255224_CLASS_ID         = -255224
      FRAME_-255224_CENTER           = -255
      TKFRAME_-255224_SPEC           = 'ANGLES'
      TKFRAME_-255224_RELATIVE       = 'PSYC_DSM2_AXIS2'
      TKFRAME_-255224_ANGLES         = ( 0.0, -64.0, 0.0 )
      TKFRAME_-255224_AXES           = (   1,     2,   3 )
      TKFRAME_-255224_UNITS          = 'DEGREES'

   \begintext


CGT frames
========================================================================

   This section of the file contains definitions of the Cold Gas 
   Thruster (CGT) frames.


CGT Frame Tree
--------------------------------------

   The diagram below shows the CGT frame hierarchy.


                               "J2000" INERTIAL
                               +--------------+
                                      |
                                      |<-ck
                                      |
                                      V
                              "PSYC_SPACECRAFT"
                              -----------------
                                      |
                                      |<-fixed
                                      |
                                      V
                              "PSYC_CGT<1-12>"
                              ----------------

CGT Frames
--------------------------------------

   The following frames are defined for the Cold Gas Thrusters: 
   PSYC_CGT<1-12> (IDs -255231 through -255242).

   Per [12], the CGT orientations are defined by a clock angle and a 
   tilt angle. The clock angle is a rotation about the S/C Z axis, 
   and the tilt is an elevation of the plume direction from the S/C 
   XY plane.

   The CGT frames are defined as follows:

      -  +Z axis is the plume (anti-thrust) direction. It is rotated 
         from the S/C X axis by the angle 'clock' and is elevated out 
         of the S/C XY plane by the angle 'tilt'.

      -  +Y axis is in the S/C XY plane and is separated from S/C Y 
          by the angle 'clock'.

      -  +X axis completes the right-handed frame.

      -  The origin of the frame is at the center of the nozzle exit 
         plane

   The transformation from Spacecraft to CGT frame consists of a 
   rotation of 'clock' degrees about the Z axis followed by a rotation 
   of (90 - 'tilt') degrees about the Y axis.

   Per [12], the values of clock and tilt for each CGT are:

        CGT       Clock      Tilt
      -------    -------    -------
       CGT1       180.0       0.0
       CGT2         0.0       0.0
       CGT3         0.0       0.0
       CGT4       180.0       0.0
       CGT5        90.0     -32.0
       CGT6       270.0     -32.0
       CGT7         0.0       0.0
       CGT8       180.0       0.0
       CGT9       180.0       0.0
       CGT10        0.0       0.0
       CGT11       90.0     -32.0
       CGT12      270.0     -32.0
 
   This set of keywords defines the CGT frames as fixed offset 
   frames:

   \begindata

      FRAME_PSYC_CGT1                = -255231
      FRAME_-255231_NAME             = 'PSYC_CGT1'
      FRAME_-255231_CLASS            = 4
      FRAME_-255231_CLASS_ID         = -255231
      FRAME_-255231_CENTER           = -255
      TKFRAME_-255231_SPEC           = 'ANGLES'
      TKFRAME_-255231_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255231_ANGLES         = ( 180.0, -90.0, 0.0 )
      TKFRAME_-255231_AXES           = (     3,     2,   1 )
      TKFRAME_-255231_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT2                = -255232
      FRAME_-255232_NAME             = 'PSYC_CGT2'
      FRAME_-255232_CLASS            = 4
      FRAME_-255232_CLASS_ID         = -255232
      FRAME_-255232_CENTER           = -255
      TKFRAME_-255232_SPEC           = 'ANGLES'
      TKFRAME_-255232_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255232_ANGLES         = ( 0.0, -90.0, 0.0 )
      TKFRAME_-255232_AXES           = (   3,     2,   1 )
      TKFRAME_-255232_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT3                = -255233
      FRAME_-255233_NAME             = 'PSYC_CGT3'
      FRAME_-255233_CLASS            = 4
      FRAME_-255233_CLASS_ID         = -255233
      FRAME_-255233_CENTER           = -255
      TKFRAME_-255233_SPEC           = 'ANGLES'
      TKFRAME_-255233_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255233_ANGLES         = ( 0.0, -90.0, 0.0 )
      TKFRAME_-255233_AXES           = (   3,     2,   1 )
      TKFRAME_-255233_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT4                = -255234
      FRAME_-255234_NAME             = 'PSYC_CGT4'
      FRAME_-255234_CLASS            = 4
      FRAME_-255234_CLASS_ID         = -255234
      FRAME_-255234_CENTER           = -255
      TKFRAME_-255234_SPEC           = 'ANGLES'
      TKFRAME_-255234_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255234_ANGLES         = ( 180.0, -90.0, 0.0 )
      TKFRAME_-255234_AXES           = (     3,     2,   1 )
      TKFRAME_-255234_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT5                = -255235
      FRAME_-255235_NAME             = 'PSYC_CGT5'
      FRAME_-255235_CLASS            = 4
      FRAME_-255235_CLASS_ID         = -255235
      FRAME_-255235_CENTER           = -255
      TKFRAME_-255235_SPEC           = 'ANGLES'
      TKFRAME_-255235_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255235_ANGLES         = ( -90.0, -122.0, 0.0 )
      TKFRAME_-255235_AXES           = (     3,      2,   1 )
      TKFRAME_-255235_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT6                = -255236
      FRAME_-255236_NAME             = 'PSYC_CGT6'
      FRAME_-255236_CLASS            = 4
      FRAME_-255236_CLASS_ID         = -255236
      FRAME_-255236_CENTER           = -255
      TKFRAME_-255236_SPEC           = 'ANGLES'
      TKFRAME_-255236_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255236_ANGLES         = ( -270.0, -122.0, 0.0 )
      TKFRAME_-255236_AXES           = (      3,      2,   1 )
      TKFRAME_-255236_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT7                = -255237
      FRAME_-255237_NAME             = 'PSYC_CGT7'
      FRAME_-255237_CLASS            = 4
      FRAME_-255237_CLASS_ID         = -255237
      FRAME_-255237_CENTER           = -255
      TKFRAME_-255237_SPEC           = 'ANGLES'
      TKFRAME_-255237_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255237_ANGLES         = ( 0.0, -90.0, 0.0 )
      TKFRAME_-255237_AXES           = (   3,     2,   1 )
      TKFRAME_-255237_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT8                = -255238
      FRAME_-255238_NAME             = 'PSYC_CGT8'
      FRAME_-255238_CLASS            = 4
      FRAME_-255238_CLASS_ID         = -255238
      FRAME_-255238_CENTER           = -255
      TKFRAME_-255238_SPEC           = 'ANGLES'
      TKFRAME_-255238_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255238_ANGLES         = ( 180.0, -90.0, 0.0 )
      TKFRAME_-255238_AXES           = (     3,     2,   1 )
      TKFRAME_-255238_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT9                = -255239
      FRAME_-255239_NAME             = 'PSYC_CGT9'
      FRAME_-255239_CLASS            = 4
      FRAME_-255239_CLASS_ID         = -255239
      FRAME_-255239_CENTER           = -255
      TKFRAME_-255239_SPEC           = 'ANGLES'
      TKFRAME_-255239_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255239_ANGLES         = ( 180.0, -90.0, 0.0 )
      TKFRAME_-255239_AXES           = (     3,     2,   1 )
      TKFRAME_-255239_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT10               = -255240
      FRAME_-255240_NAME             = 'PSYC_CGT10'
      FRAME_-255240_CLASS            = 4
      FRAME_-255240_CLASS_ID         = -255240
      FRAME_-255240_CENTER           = -255
      TKFRAME_-255240_SPEC           = 'ANGLES'
      TKFRAME_-255240_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255240_ANGLES         = ( 0.0, -90.0, 0.0 )
      TKFRAME_-255240_AXES           = (   3,     2,   1 )
      TKFRAME_-255240_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT11               = -255241
      FRAME_-255241_NAME             = 'PSYC_CGT11'
      FRAME_-255241_CLASS            = 4
      FRAME_-255241_CLASS_ID         = -255241
      FRAME_-255241_CENTER           = -255
      TKFRAME_-255241_SPEC           = 'ANGLES'
      TKFRAME_-255241_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255241_ANGLES         = ( -90.0, -122.0, 0.0 )
      TKFRAME_-255241_AXES           = (     3,      2,   1 )
      TKFRAME_-255241_UNITS          = 'DEGREES'

      FRAME_PSYC_CGT12               = -255242
      FRAME_-255242_NAME             = 'PSYC_CGT12'
      FRAME_-255242_CLASS            = 4
      FRAME_-255242_CLASS_ID         = -255242
      FRAME_-255242_CENTER           = -255
      TKFRAME_-255242_SPEC           = 'ANGLES'
      TKFRAME_-255242_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255242_ANGLES         = ( -270.0, -122.0, 0.0 )
      TKFRAME_-255242_AXES           = (      3,      2,   1 )
      TKFRAME_-255242_UNITS          = 'DEGREES'

   \begintext


DSOC frames
========================================================================

   This section of the file contains definitions of the Deep Space
   Optical Communications (DSOC) frames.


DSOC Frame Tree
--------------------------------------

   The diagram below shows the DSOC frame hierarchy.


                               "J2000" INERTIAL
                               +--------------+
                                      |
                                      |<-ck
                                      |
                                      V
                               "PSYC_SPACECRAFT"
           +-----------------------------------------------------+
           |
           |<-fixed
           |
           V
      "PSYC_DSOC_MECH"
      ----------------
           |
           |<-fixed
           |
           V
      "PSYC_DSOC_BASE"
      ----------------
           |
           |<-ck
           |
           V
       "PSYC_DSOC"
       -----------


DSOC Frames
--------------------------------------

   The following frames are defined for the DSOC instrument:
   PSYC_DSOC_MECH (ID -255192), PSYC_DSOC_BASE (ID -255190), and
   PSYC_DSOC (ID -255191).

   The DSOC is rigidly attached to the +X side of the s/c bus but its
   optical component has time-variable orientation to precisely point
   at the Earth. Given this the DSOC mechanical frame, PSYC_DSOC_MECH,
   is defined as a fixed offset frame with its orientation given
   relative to the PSYC_SPACECRAFT frame; the DSOC base frame,
   PSYC_DSOC_BASE, is defined as a fixed offset frame with its
   orientation given relative to the PSYC_DSOC_MECH frame; and the DSOC
   optics frame, PSYC_DSOC, is defined as a CK-based frame.

   The PSYC_DSOC_MECH frame is defined as follows (see [9]):

      -  +Z axis is opposite of the boresight direction at zero
         position and is nominally co-aligned with the HGA
         anti-boresight;

      -  +Y axis is normal to the DSOC mounting plate and points away 
         from the instrument toward the center of the spacecraft;

      -  +X axis completes the right handed frame;

      -  the origin of the frame is located at the DSOC optics focal
         point.

   The PSYC_DSOC_BASE frame is defined as follows (see [7]):

      -  +Z axis is in the boresight direction at zero position and is
         nominally co-aligned with the HGA boresight;

      -  +Y axis is nominally co-aligned with the DSOC mechanical +X
         axis;

      -  +X axis completes the right handed frame and is nominally
         co-aligned with the DSOC mechanical +Y axis;

      -  the origin of the frame is located at the DSOC optics focal
         point.

   In zero position the DSOC optics frame is co-aligned with the DSOC
   base frame.

   This diagram illustrates the DSOC mechanical (dsocm) and base
   (dsocb) frames:

   +Z s/c side (HGA side) view:
   ----------------------------
                                    ^
                                    | toward asteroid

                               Science Deck
                              _____________
    __  ________________     |             |     _______________  ___
   |  \ \               \    |  . ----- .  |    /               \ \  |
   |  / /                \   |.'         `.|   /                / /  |
   |  \ \                 `. . +Zsc    +Ysc| .'                 \ \  |
   |  / /                   o       o----> |o |                 / /  |
   |  \ \          +Xdsocm   +Ydsocm|      . `.                 \ \  |
   |  / /          +Ydsocb   +Xdsocb|     '|   \                / /  |
   |__\ \_______________   <.     ^ v +Xsc |    \_______________\ \__|
     -Y Solar Array          `-.^/_________|       +Y Solar Array (PY)
                                *      
                                v      
                                 +Zdsocb                
                                             +Zsc is out of the page.

                                            +Zdsocm (not marked) is into
                                           the page, tilted 10 degrees
                                              from -Zsc towards -Xsc.
 
                                            +Zdsocb is out of the page,
                                           tilted 10 degrees from +Zsc
                                                  towards +Xsc.

   Nominally three rotations are needed to align the s/c frame with the
   DSOC mechanical frame -- first by +10 degrees about Y, second by
   -117 degrees about Z, third by 180 degrees about X.
 
   Nominally two rotations are needed to align the DSOC mechanical
   frame with the DSOC base frame -- first by 180 degrees about X,
   second by -90 degrees about Z.
 
   The DSOC mechanical and base frame definitions below contain the
   opposite of these rotations because Euler angles specified in them
   define transformations from instrument to relative-to frames
   (see [1]).
 
   This set of keywords defines the DSOC mechanical and base frames as
   a fixed offset frame and DSOC optics frame as a CK-based frame:

   \begindata

      FRAME_PSYC_DSOC_MECH           = -255192
      FRAME_-255192_NAME             = 'PSYC_DSOC_MECH'
      FRAME_-255192_CLASS            = 4
      FRAME_-255192_CLASS_ID         = -255192
      FRAME_-255192_CENTER           = -255
      TKFRAME_-255192_SPEC           = 'ANGLES'
      TKFRAME_-255192_RELATIVE       = 'PSYC_SPACECRAFT'
      TKFRAME_-255192_ANGLES         = ( -10.0, 117.0, 180.0 )
      TKFRAME_-255192_AXES           = (   2,     3,     1   )
      TKFRAME_-255192_UNITS          = 'DEGREES'

      FRAME_PSYC_DSOC_BASE           = -255190
      FRAME_-255190_NAME             = 'PSYC_DSOC_BASE'
      FRAME_-255190_CLASS            = 4
      FRAME_-255190_CLASS_ID         = -255190
      FRAME_-255190_CENTER           = -255
      TKFRAME_-255190_SPEC           = 'ANGLES'
      TKFRAME_-255190_RELATIVE       = 'PSYC_DSOC_MECH'
      TKFRAME_-255190_ANGLES         = ( 180.0, 90.0, 0.0 )
      TKFRAME_-255190_AXES           = (   1,    3,   3   )
      TKFRAME_-255190_UNITS          = 'DEGREES'

      FRAME_PSYC_DSOC                = -255191
      FRAME_-255191_NAME             = 'PSYC_DSOC'
      FRAME_-255191_CLASS            = 3
      FRAME_-255191_CLASS_ID         = -255191
      FRAME_-255191_CENTER           = -255
      CK_-255191_SCLK                = -255
      CK_-255191_SPK                 = -255

   \begintext


DSOC Ground Site frames
========================================================================

   This section of the file contains definitions of the Deep Space
   Optical Communications (DSOC) ground site frames for Palomar and 
   OCTL.


DSOC Ground Site Frame Tree
--------------------------------------

   The diagram below shows the DSOC Ground Site frame hierarchy.


                            "J2000" INERTIAL
                            +--------------+
                                   |
                                   |<-binary pck
                                   |
                                   V
                                "ITRF93"
              +------------------------------------------+
              |                                          |
              |<-fixed                           fixed-> |
              |                                          |
              V                                          V
     "PSYC_DSOC_PALOMAR_TOPO"                  "PSYC_DSOC_OCTL_TOPO"
     ------------------------                  ---------------------


DSOC Ground Site Frames
--------------------------------------

   Topocentric frame PSYC_DSOC_PALOMAR_TOPO
 
   The Z axis of this frame points toward the zenith.
   The X axis of this frame points North.
 
   Topocentric frame PSYC_DSOC_PALOMAR_TOPO is centered at the
   site PSYC_DSOC_PALOMAR, which has Cartesian coordinates
 
      X (km):                 -0.2410495899218E+04
      Y (km):                 -0.4758573867720E+04
      Z (km):                  0.3487972589076E+04
 
   and planetodetic coordinates
 
      Longitude (deg):      -116.8648800000000
      Latitude  (deg):        33.3563000000000
      Altitude   (km):         0.1709300000001E+01
 
   These planetodetic coordinates are expressed relative to
   a reference spheroid having the dimensions
 
      Equatorial radius (km):  6.3781370000000E+03
      Polar radius      (km):  6.3567523142450E+03
 
   All of the above coordinates are relative to the frame ITRF93.
 
 
   \begindata
 
      FRAME_PSYC_DSOC_PALOMAR_TOPO        =  -255195
      FRAME_-255195_NAME                  =  'PSYC_DSOC_PALOMAR_TOPO'
      FRAME_-255195_CLASS                 =  4
      FRAME_-255195_CLASS_ID              =  -255195
      FRAME_-255195_CENTER                =  -255195
 
      OBJECT_-255195_FRAME                =  'PSYC_DSOC_PALOMAR_TOPO'
 
      TKFRAME_-255195_RELATIVE            =  'ITRF93'
      TKFRAME_-255195_SPEC                =  'ANGLES'
      TKFRAME_-255195_UNITS               =  'DEGREES'
      TKFRAME_-255195_AXES                =  ( 3, 2, 3 )
      TKFRAME_-255195_ANGLES              =  ( -243.1351200000000,
                                                -56.6437000000000,
                                                180.0000000000000 )
 
   \begintext

 
   Topocentric frame PSYC_DSOC_OCTL_TOPO
 
   The Z axis of this frame points toward the zenith.
   The X axis of this frame points North.
 
   Topocentric frame PSYC_DSOC_OCTL_TOPO is centered at the
   site PSYC_DSOC_OCTL, which has Cartesian coordinates
 
      X (km):                 -0.2448933358431E+04
      Y (km):                 -0.4667932945234E+04
      Z (km):                  0.3582751572991E+04
 
   and planetodetic coordinates
 
      Longitude (deg):      -117.6828100000000
      Latitude  (deg):        34.3817700000000
      Altitude   (km):         0.2259499999998E+01
 
   These planetodetic coordinates are expressed relative to
   a reference spheroid having the dimensions
 
      Equatorial radius (km):  6.3781370000000E+03
      Polar radius      (km):  6.3567523142450E+03
 
   All of the above coordinates are relative to the frame ITRF93.
 
 
   \begindata
 
      FRAME_PSYC_DSOC_OCTL_TOPO           =  -255196
      FRAME_-255196_NAME                  =  'PSYC_DSOC_OCTL_TOPO'
      FRAME_-255196_CLASS                 =  4
      FRAME_-255196_CLASS_ID              =  -255196
      FRAME_-255196_CENTER                =  -255196
 
      OBJECT_-255196_FRAME                =  'PSYC_DSOC_OCTL_TOPO'
 
      TKFRAME_-255196_RELATIVE            =  'ITRF93'
      TKFRAME_-255196_SPEC                =  'ANGLES'
      TKFRAME_-255196_UNITS               =  'DEGREES'
      TKFRAME_-255196_AXES                =  ( 3, 2, 3 )
      TKFRAME_-255196_ANGLES              =  ( -242.3171900000000,
                                             -55.6182300000000,
                                             180.0000000000000 )
 
   \begintext


Psyche Mission NAIF ID Codes -- Definition Section
========================================================================

   This section contains name to NAIF ID mappings for the Psyche
   mission.


Psyche Target IDs:
-------------------------------------------------------------

   This table summarizes Psyche Target IDs:

      Name                   ID       Synonyms
      ---------------------  -------  ---------------------------
      PSYCHE                 2000016  '16 PSYCHE'

   Name-ID Mapping keywords:

   \begindata

      NAIF_BODY_NAME                += ( '16 PSYCHE' )
      NAIF_BODY_CODE                += ( 2000016 )

      NAIF_BODY_NAME                += ( 'PSYCHE' )
      NAIF_BODY_CODE                += ( 2000016 )

   \begintext


Psyche Spacecraft ID
-------------------------------------------------------------

   This table summarizes Psyche Spacecraft IDs:

      Name                   ID
      ---------------------  -------
      PSYC                   -255

   Name-ID Mapping keywords:

   \begindata

      NAIF_BODY_NAME                += ( 'PSYC' )
      NAIF_BODY_CODE                += ( -255 )

   \begintext


Psyche Spacecraft Structures IDs
--------------------------------------

   This table summarizes Psyche Spacecraft Structure IDs:

      Name                   ID
      ---------------------  -------
      PSYC                   -255
      PSYC_SPACECRAFT        -255000
      PSYC_SA_PY             -255010
      PSYC_SA_MY             -255020
      PSYC_HGA               -255030
      PSYC_LGA_MZ            -255040
      PSYC_LGA_PX            -255050
      PSYC_LGA_MX            -255060
      PSYC_ST1               -255070
      PSYC_ST2               -255080
      PSYC_SS1               -255091
      PSYC_SS2               -255092
      PSYC_SS3               -255093
      PSYC_SS4               -255094
      PSYC_SS5               -255095
      PSYC_SS6               -255096
      PSYC_SS7               -255097
      PSYC_SS8               -255098

   Name-ID Mapping keywords:

   \begindata

      NAIF_BODY_NAME                += ( 'PSYC_SPACECRAFT' )
      NAIF_BODY_CODE                += ( -255000 )

      NAIF_BODY_NAME                += ( 'PSYC_SA_PY' )
      NAIF_BODY_CODE                += ( -255010 )

      NAIF_BODY_NAME                += ( 'PSYC_SA_MY' )
      NAIF_BODY_CODE                += ( -255020 )

      NAIF_BODY_NAME                += ( 'PSYC_HGA' )
      NAIF_BODY_CODE                += ( -255030 )

      NAIF_BODY_NAME                += ( 'PSYC_LGA_MZ' )
      NAIF_BODY_CODE                += ( -255040 )

      NAIF_BODY_NAME                += ( 'PSYC_LGA_PX' )
      NAIF_BODY_CODE                += ( -255050 )

      NAIF_BODY_NAME                += ( 'PSYC_LGA_MX' )
      NAIF_BODY_CODE                += ( -255060 )

      NAIF_BODY_NAME                += ( 'PSYC_ST1' )
      NAIF_BODY_CODE                += ( -255070 )

      NAIF_BODY_NAME                += ( 'PSYC_ST2' )
      NAIF_BODY_CODE                += ( -255080 )

      NAIF_BODY_NAME                += ( 'PSYC_SS1' )
      NAIF_BODY_CODE                += ( -255091 )

      NAIF_BODY_NAME                += ( 'PSYC_SS2' )
      NAIF_BODY_CODE                += ( -255092 )

      NAIF_BODY_NAME                += ( 'PSYC_SS3' )
      NAIF_BODY_CODE                += ( -255093 )

      NAIF_BODY_NAME                += ( 'PSYC_SS4' )
      NAIF_BODY_CODE                += ( -255094 )

      NAIF_BODY_NAME                += ( 'PSYC_SS5' )
      NAIF_BODY_CODE                += ( -255095 )

      NAIF_BODY_NAME                += ( 'PSYC_SS6' )
      NAIF_BODY_CODE                += ( -255096 )

      NAIF_BODY_NAME                += ( 'PSYC_SS7' )
      NAIF_BODY_CODE                += ( -255097 )

      NAIF_BODY_NAME                += ( 'PSYC_SS8' )
      NAIF_BODY_CODE                += ( -255098 )

   \begintext


IMGA and IMGB IDs
--------------------------------------

   This table summarizes IMGA and IMGB IDs:

      Name                   ID
      ---------------------  -------
      PSYC_IMGA              -255110
      PSYC_IMGB              -255130

   Name-ID Mapping keywords:

   \begindata

      NAIF_BODY_NAME                += ( 'PSYC_IMGA' )
      NAIF_BODY_CODE                += ( -255110 )

      NAIF_BODY_NAME                += ( 'PSYC_IMGB' )
      NAIF_BODY_CODE                += ( -255130 )

   \begintext


GRS and NS IDs
--------------------------------------

   This table summarizes GRS and NS IDs:

      Name                   ID
      ---------------------  -------
      PSYC_GRS               -255150
      PSYC_NS                -255160

   Name-ID Mapping keywords:

   \begindata

      NAIF_BODY_NAME                += ( 'PSYC_GRS' )
      NAIF_BODY_CODE                += ( -255150 )

      NAIF_BODY_NAME                += ( 'PSYC_NS' )
      NAIF_BODY_CODE                += ( -255160 )

   \begintext


MAG IDs
--------------------------------------

   This table summarizes MAG IDs:

      Name                   ID
      ---------------------  -------
      PSYC_MAG1              -255170
      PSYC_MAG2              -255180

   Name-ID Mapping keywords:

   \begindata

      NAIF_BODY_NAME                += ( 'PSYC_MAG1' )
      NAIF_BODY_CODE                += ( -255170 )

      NAIF_BODY_NAME                += ( 'PSYC_MAG2' )
      NAIF_BODY_CODE                += ( -255180 )

   \begintext


DSM IDs
--------------------------------------

   This table summarizes DSM IDs:

      Name                   ID
      ---------------------  -------
      PSYC_DSM1_BASE         -255210
      PSYC_DSM1_EP_A         -255213
      PSYC_DSM1_EP_C         -255214
      PSYC_DSM2_BASE         -255220
      PSYC_DSM2_EP_B         -255223
      PSYC_DSM2_EP_D         -255224

   Name-ID Mapping keywords:

   \begindata

      NAIF_BODY_NAME                += ( 'PSYC_DSM1_BASE' )
      NAIF_BODY_CODE                += ( -255210 )

      NAIF_BODY_NAME                += ( 'PSYC_DSM1_EP_A' )
      NAIF_BODY_CODE                += ( -255213 )

      NAIF_BODY_NAME                += ( 'PSYC_DSM1_EP_C' )
      NAIF_BODY_CODE                += ( -255214 )

      NAIF_BODY_NAME                += ( 'PSYC_DSM2_BASE' )
      NAIF_BODY_CODE                += ( -255220 )

      NAIF_BODY_NAME                += ( 'PSYC_DSM2_EP_B' )
      NAIF_BODY_CODE                += ( -255223 )

      NAIF_BODY_NAME                += ( 'PSYC_DSM2_EP_D' )
      NAIF_BODY_CODE                += ( -255224 )

   \begintext


CGT IDs
--------------------------------------

   This table summarizes CGT IDs:

      Name                   ID
      ---------------------  -------
      PSYC_CGT1              -255231
      PSYC_CGT2              -255232
      PSYC_CGT3              -255233
      PSYC_CGT4              -255234
      PSYC_CGT5              -255235
      PSYC_CGT6              -255236
      PSYC_CGT7              -255237
      PSYC_CGT8              -255238
      PSYC_CGT9              -255239
      PSYC_CGT10             -255240
      PSYC_CGT11             -255241
      PSYC_CGT12             -255242

   Name-ID Mapping keywords:

   \begindata

      NAIF_BODY_NAME                += ( 'PSYC_CGT1' )
      NAIF_BODY_CODE                += ( -255231 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT2' )
      NAIF_BODY_CODE                += ( -255232 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT3' )
      NAIF_BODY_CODE                += ( -255233 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT4' )
      NAIF_BODY_CODE                += ( -255234 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT5' )
      NAIF_BODY_CODE                += ( -255235 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT6' )
      NAIF_BODY_CODE                += ( -255236 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT7' )
      NAIF_BODY_CODE                += ( -255237 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT8' )
      NAIF_BODY_CODE                += ( -255238 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT9' )
      NAIF_BODY_CODE                += ( -255239 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT10' )
      NAIF_BODY_CODE                += ( -255240 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT11' )
      NAIF_BODY_CODE                += ( -255241 )

      NAIF_BODY_NAME                += ( 'PSYC_CGT12' )
      NAIF_BODY_CODE                += ( -255242 )

   \begintext

DSOC IDs
--------------------------------------

   This table summarizes DSOC IDs:

      Name                   ID
      ---------------------  -------
      PSYC_DSOC_BASE         -255190
      PSYC_DSOC              -255191

   Name-ID Mapping keywords:

   \begindata

      NAIF_BODY_NAME                += ( 'PSYC_DSOC_BASE' )
      NAIF_BODY_CODE                += ( -255190 )

      NAIF_BODY_NAME                += ( 'PSYC_DSOC' )
      NAIF_BODY_CODE                += ( -255191 )

   \begintext


DSOC Ground Site IDs
--------------------------------------

   This table summarizes DSOC Ground Site IDs:

      Name                   ID
      ---------------------  -------
      PSYC_DSOC_PALOMAR      -255195
      PSYC_DSOC_OCTL         -255196

   Name-ID Mapping keywords:

   \begindata
 
      NAIF_BODY_NAME                += ( 'PSYC_DSOC_PALOMAR' )
      NAIF_BODY_CODE                += ( -255195 )
 
      NAIF_BODY_NAME                += ( 'PSYC_DSOC_OCTL' )
      NAIF_BODY_CODE                += ( -255196 )

   \begintext


End of FK.
