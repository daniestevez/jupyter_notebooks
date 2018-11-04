#!/usr/bin/env python3

#####################
### CONFIGURATION ###
#####################

# Path to GMAT executable

GMAT_PATH = '/home/daniel/GMAT/R2018a/'
GMAT_EXECUTABLE = GMAT_PATH + 'bin/GMAT-R2018a'
GMAT_MOON_IMAGE = GMAT_PATH + 'data/graphics/texture/Moon_HermesCelestiaMotherlode.jpg'

# Groundstation locations
# (latitude, longitude, altitude)
# latitude, longitude in degrees
# altitude in metres above the ellipsoid

PI9CAM = [52.81201944, 6.39616944, 0.025]
DK5LA = [54.722981, 9.634237, 0]

# Receiving Groundstation location

GSRX_LOCATION = PI9CAM
GSTX_LOCATION = DK5LA

# Path to GMAT output script

SCRIPT_PATH = '/tmp/gmat_doppler.script'

# Path to GMAT output report

REPORT_PATH = '/tmp/gmat_doppler_report.txt'

# Frequencies

B0_DOWNLINK = 435.4e6
B1_DOWNLINK = 436.4e6
B1_UPLINK = 145.9e6

# Output filenames

SPECULAR_FILE = '_specular.png'
DOWNLINK_DOPPLER_FILE = '_downlink.png'
UPLINK_DOPPLER_FILE = '_uplink.png'
MOONVIEW_FILE = '_moonview.png'
SKYPLOT_FILE = '_skyplot.png'

# Figure properties

FIGPROPERTIES = {'figsize' : [16, 8], 'facecolor' : 'w'}

#####################

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.patches
from PIL import Image

from astropy.time import Time
import astropy.constants

import subprocess
import sys

N_ARGS = 5

def usage():
    print(f'Usage: {sys.argv[0]} tracking_file start_time end_time output_name')
    sys.exit(1)

MOON_RADIUS = 1737.1
    
mjd_unixtimestamp_offset = 10587.5
seconds_in_day = 3600 * 24

def mjd2unixtimestamp(m):
    return (m - mjd_unixtimestamp_offset) * seconds_in_day

def unixtimestamp2mjd(u):
    return u / seconds_in_day + mjd_unixtimestamp_offset

def load_tracking_file_head(path):
    ncols = 7
    data = np.fromfile(path, sep=' ', count = ncols)
    return data

GMAT_TEMPLATE = """
%----------------------------------------
%---------- Spacecraft
%----------------------------------------

Create Spacecraft DSLWP_B;
DSLWP_B.DateFormat = UTCModJulian;
DSLWP_B.Epoch = {epoch};
DSLWP_B.CoordinateSystem = EarthFixed;
DSLWP_B.DisplayStateType = Cartesian;
DSLWP_B.X = {x[0]};
DSLWP_B.Y = {x[1]};
DSLWP_B.Z = {x[2]};
DSLWP_B.VX = {v[0]};
DSLWP_B.VY = {v[1]};
DSLWP_B.VZ = {v[2]};
DSLWP_B.DryMass = 45;
DSLWP_B.DragArea = 0.25;
DSLWP_B.SRPArea = 0.25;

%----------------------------------------
%---------- ForceModels
%----------------------------------------

Create ForceModel LunaProp_ForceModel;
LunaProp_ForceModel.CentralBody = Luna;
LunaProp_ForceModel.PrimaryBodies = {{Luna}};
LunaProp_ForceModel.PointMasses = {{Earth, Jupiter, Mars, Neptune, Saturn, Sun, Uranus, Venus}};
LunaProp_ForceModel.Drag = None;
LunaProp_ForceModel.SRP = On;
LunaProp_ForceModel.RelativisticCorrection = On;
LunaProp_ForceModel.ErrorControl = RSSStep;
LunaProp_ForceModel.GravityField.Luna.Degree = 10;
LunaProp_ForceModel.GravityField.Luna.Order = 10;
LunaProp_ForceModel.GravityField.Luna.StmLimit = 100;
LunaProp_ForceModel.GravityField.Luna.PotentialFile = 'LP165P.cof';

%----------------------------------------
%---------- Propagators
%----------------------------------------

Create Propagator LunaProp;
LunaProp.FM = LunaProp_ForceModel;
LunaProp.Type = PrinceDormand78;
LunaProp.InitialStepSize = 1;
LunaProp.Accuracy = 1e-13;
LunaProp.MinStep = 0;
LunaProp.MaxStep = 10;
LunaProp.MaxStepAttempts = 50;

%----------------------------------------
%---------- GroundStations
%----------------------------------------

Create GroundStation GSRX;
GSRX.CentralBody = Earth;
GSRX.StateType = Spherical;
GSRX.HorizonReference = Ellipsoid;
GSRX.Location1 = {gsrx[0]};
GSRX.Location2 = {gsrx[1]};
GSRX.Location3 = {gsrx[2]};
GSRX.Id = 'Receiving Groundstation';

Create GroundStation GSTX;
GSTX.CentralBody = Earth;
GSTX.StateType = Spherical;
GSTX.HorizonReference = Ellipsoid;
GSTX.Location1 = {gstx[0]};
GSTX.Location2 = {gstx[1]};
GSTX.Location3 = {gstx[2]};
GSTX.Id = 'Transmitting Groundstation';

%----------------------------------------
%---------- Coordinate Systems
%----------------------------------------

Create CoordinateSystem LunaInertial;
LunaInertial.Origin = Luna;
LunaInertial.Axes = BodyInertial;

Create CoordinateSystem LunaFixed;
LunaFixed.Origin = Luna;
LunaFixed.Axes = BodyFixed;

Create CoordinateSystem GSRXTopo;
GSRXTopo.Origin = GSRX;
GSRXTopo.Axes = Topocentric;

Create CoordinateSystem GSTXTopo;
GSTXTopo.Origin = GSRX;
GSTXTopo.Axes = Topocentric;

%----------------------------------------
%---------- Subscribers
%----------------------------------------

Create ReportFile Rep;
Rep.Filename = {report_path};
Rep.Add = {{DSLWP_B.UTCModJulian, DSLWP_B.GSRXTopo.X, DSLWP_B.GSRXTopo.Y, DSLWP_B.GSRXTopo.Z, DSLWP_B.GSRXTopo.VX, DSLWP_B.GSRXTopo.VY, DSLWP_B.GSRXTopo.VZ, Luna.GSRXTopo.X, Luna.GSRXTopo.Y, Luna.GSRXTopo.Z, Luna.GSRXTopo.VX, Luna.GSRXTopo.VY, Luna.GSRXTopo.VZ, DSLWP_B.LunaFixed.X, DSLWP_B.LunaFixed.Y, DSLWP_B.LunaFixed.Z, DSLWP_B.LunaFixed.VX, DSLWP_B.LunaFixed.VY, DSLWP_B.LunaFixed.VZ, GSRX.LunaFixed.X, GSRX.LunaFixed.Y, GSRX.LunaFixed.Z, GSRX.LunaFixed.VX, GSRX.LunaFixed.VY, GSRX.LunaFixed.VZ, DSLWP_B.GSTXTopo.X, DSLWP_B.GSTXTopo.Y, DSLWP_B.GSTXTopo.Z, DSLWP_B.GSTXTopo.VX, DSLWP_B.GSTXTopo.VY, DSLWP_B.GSTXTopo.VZ}};
Rep.WriteHeaders = false;


%----------------------------------------
%---------- Mission Sequence
%----------------------------------------

BeginMissionSequence;
Toggle Rep Off
If DSLWP_B.UTCModJulian <= {start}
    Propagate LunaProp(DSLWP_B) {{DSLWP_B.UTCModJulian = {start}}}
Else
    Propagate BackProp LunaProp(DSLWP_B) {{DSLWP_B.UTCModJulian = {start}}}
EndIf
Toggle Rep On
Propagate LunaProp(DSLWP_B) {{DSLWP_B.UTCModJulian = {end}}}
"""

def run_gmat(tracking_row, start, end):
    data = dict()
    data['start'] = unixtimestamp2mjd(Time(start, format='unix').value)
    data['end'] = unixtimestamp2mjd(Time(end, format='unix').value)
    data['epoch'] = unixtimestamp2mjd(tracking_row[0])
    data['x'] = tracking_row[1:4]
    data['v'] = tracking_row[4:7]
    data['gsrx'] = GSRX_LOCATION
    data['gstx'] = GSTX_LOCATION
    data['report_path'] = REPORT_PATH
    with open(SCRIPT_PATH, 'w') as f:
        f.write(GMAT_TEMPLATE.format(**data))
    subprocess.call([GMAT_EXECUTABLE, '-r', SCRIPT_PATH, '-x', '-m'])

def load_gmat_report(path):
    GMAT_COLS = 31
    data = np.fromfile(path, sep=' ').reshape((-1, GMAT_COLS))
    t = Time(mjd2unixtimestamp(data[:,0]), format='unix')
    return t, data

def rangerate(x):
    return np.sum(x[:,:3] * x[:,3:], axis=1) / np.sqrt(np.sum(x[:,:3]**2, axis=1)) * 1e3

def rangerate2doppler(x, freq):
    return -x * freq / astropy.constants.c.value

def compute_moonbounce(data):
    N_GRIDPOINTS = 1000
    long, lat = np.meshgrid(np.linspace(-np.pi, np.pi, N_GRIDPOINTS), np.linspace(-np.pi/2, np.pi/2, N_GRIDPOINTS))
    moon_x = MOON_RADIUS * np.cos(long) * np.cos(lat)
    moon_y = MOON_RADIUS * np.sin(long) * np.cos(lat)
    moon_z = MOON_RADIUS * np.sin(lat)
    min_dist = np.empty(data.shape[0])
    reflection_point_long = np.empty(data.shape[0])
    reflection_point_lat = np.empty(data.shape[0])
    for j in range(data.shape[0]):
        dist = np.sqrt((data[j,19]-moon_x)**2 + (data[j,20]-moon_y)**2 + (data[j,21]-moon_z)**2) + np.sqrt((data[j,13]-moon_x)**2 + (data[j,14]-moon_y)**2 + (data[j,15]-moon_z)**2) 
        min_dist[j] = np.min(dist)
        minpoint = np.unravel_index(np.argmin(dist), dist.shape)
        reflection_point_long[j] = long[minpoint]
        reflection_point_lat[j] = lat[minpoint]
        # check that the Moon is not blocking the direct path
        direct_dist = np.sqrt(np.sum(data[j,1:4]**2))
        if min_dist[j] <= direct_dist + 1e-2: # some tolerance
            min_dist[j] = np.nan
            reflection_point_long[j] = np.nan
            reflection_point_lat[j] = np.nan
    return min_dist, reflection_point_long, reflection_point_lat

def plot_specular(reflection_point_long, reflection_point_lat):
    plt.figure(**FIGPROPERTIES)
    plt.plot(np.rad2deg(reflection_point_long), np.rad2deg(reflection_point_lat))
    plt.annotate('start', xy = (np.rad2deg(reflection_point_long[0]), np.rad2deg(reflection_point_lat[0])))
    plt.annotate('end', xy = (np.rad2deg(reflection_point_long[-1]), np.rad2deg(reflection_point_lat[-1])))
    plt.imshow(Image.open(GMAT_MOON_IMAGE), extent=[-180,180,-90,90])
    plt.title('Specular reflection point')
    plt.xlabel('Longitude (deg)')
    plt.ylabel('Latitude (deg)')
    plt.savefig(sys.argv[4] + SPECULAR_FILE)

def plot_downlink_doppler(direct_t, direct_doppler, moonbounce_t, moonbounce_doppler, freq):
    plt.figure(**FIGPROPERTIES)
    plt.plot(direct_t.datetime, direct_doppler)
    plt.plot(moonbounce_t.datetime, moonbounce_doppler)
    plt.title(f'Downlink Doppler at {freq*1e-6:.1f}MHz')
    plt.xlabel('UTC Time')
    plt.ylabel('Doppler (Hz)')
    plt.legend(['Direct', 'Moonbounce'])
    plt.savefig(sys.argv[4] + DOWNLINK_DOPPLER_FILE)

def plot_uplink_doppler(t, doppler, freq):
    plt.figure(**FIGPROPERTIES)
    plt.plot(t.datetime, doppler)
    plt.title(f'Uplink Doppler correction at {freq*1e-6:.1f}MHz')
    plt.xlabel('UTC Time')
    plt.ylabel('Doppler (Hz)')
    plt.savefig(sys.argv[4] + UPLINK_DOPPLER_FILE)

def compute_azeldist(x):
    az = np.arctan2(x[:,1], -x[:,0])
    el = np.arctan2(x[:,2], np.sqrt(x[:,0]**2 + x[:,1]**2))
    dist = np.sqrt(np.sum(x**2, axis = 1))
    return az, el, dist

def angular_radius(r, d):
    return np.arcsin(r/d)

def plot_moonview(data):
    fig, ax = plt.subplots(1, 2, **FIGPROPERTIES)
    az_dslwp, el_dslwp, dist_dslwp = compute_azeldist(data[:,1:4])
    az_luna, el_luna, dist_luna = compute_azeldist(data[:,7:10])
    angular_radius_luna = angular_radius(MOON_RADIUS, dist_luna)
    max_angular_radius_luna = np.max(angular_radius_luna)
    min_angular_radius_luna = np.min(angular_radius_luna)
    az_diff = (az_dslwp - az_luna + np.pi) % (2*np.pi) - np.pi
    el_diff = (el_dslwp - el_luna + np.pi) % (2*np.pi) - np.pi

    # corrections in azimuth apparent size depending on elevation
    azimuth_radius_luna = np.arccos((np.cos(angular_radius_luna)-np.sin(el_luna)**2)/np.cos(el_luna)**2)
    min_azimuth_radius_luna = np.min(azimuth_radius_luna)
    max_azimuth_radius_luna = np.max(azimuth_radius_luna)
        
    ax[0].add_patch(matplotlib.patches.Ellipse((0,0), 2*np.rad2deg(max_azimuth_radius_luna), 2*np.rad2deg(max_angular_radius_luna), color = '0.75'))
    ax[0].add_patch(matplotlib.patches.Ellipse((0,0), 2*np.rad2deg(min_azimuth_radius_luna), 2*np.rad2deg(min_angular_radius_luna), color = 'gray'))
    ax[0].plot(np.rad2deg(az_diff), np.rad2deg(el_diff))
    ax[0].annotate('start', xy = (np.rad2deg(az_diff[0]), np.rad2deg(el_diff[0])))
    ax[0].annotate('end', xy = (np.rad2deg(az_diff[-1]), np.rad2deg(el_diff[-1])))
    ax[0].set_aspect(min_azimuth_radius_luna/min_angular_radius_luna)
    fig.suptitle('Orbit view from receiving groundstation')
    ax[0].set_xlabel('Azimuth offset from Moon (deg)')
    ax[0].set_ylabel('Elevation offset from Moon (deg)')
    ax[1].set_xlabel('Azimuth offset from Moon (deg)')
    ax[1].set_ylabel('Distance offset from Moon (km)')
    ax[1].add_patch(matplotlib.patches.Ellipse((0,0), 2*np.rad2deg(max_azimuth_radius_luna), 2*MOON_RADIUS, color = '0.75'))
    ax[1].add_patch(matplotlib.patches.Ellipse((0,0), 2*np.rad2deg(min_azimuth_radius_luna), 2*MOON_RADIUS, color = 'gray'))
    ax[1].plot(np.rad2deg(az_diff), dist_dslwp - dist_luna)
    ax[1].annotate('start', xy = (np.rad2deg(az_diff[0]), dist_dslwp[0] - dist_luna[0]))
    ax[1].annotate('end', xy = (np.rad2deg(az_diff[-1]), dist_dslwp[-1] - dist_luna[-1]))
    ax[1].set_aspect(np.rad2deg(min_azimuth_radius_luna)/MOON_RADIUS)
    plt.savefig(sys.argv[4] + MOONVIEW_FILE)

def plot_skyplot(data):
    fig = plt.figure(**FIGPROPERTIES)
    ax = fig.add_subplot(1, 1, 1, polar=True)
    az_dslwp, el_dslwp, _ = compute_azeldist(data[:,1:4])
    az_dslwp = -az_dslwp + np.pi/2
    ax.plot(az_dslwp, 90 - np.rad2deg(el_dslwp))
    ax.annotate('start', xy = (az_dslwp[0], 90 - np.rad2deg(el_dslwp[0])))
    ax.annotate('end', xy = (az_dslwp[-1], 90 - np.rad2deg(el_dslwp[-1])))
    ax.set_xticks(np.arange(0, 2*np.pi, np.pi/4))
    ax.set_xticklabels([f'{i}°' for i in np.arange(90, -360 + 90, -45) % 360])
    ax.set_yticks(range(0, 90, 15))
    ax.set_yticklabels([f'{i}°' for i in  range(90, 0, -15)]);
    ax.set_ylim([0,90])
    plt.title('Skyplot for receiving groundstation')
    plt.savefig(sys.argv[4] + SKYPLOT_FILE)

def main():
    if len(sys.argv) != N_ARGS:
        usage()

    trk = load_tracking_file_head(sys.argv[1])
    start = Time(sys.argv[2])
    end = Time(sys.argv[3])
    run_gmat(trk, start, end)

    t, data = load_gmat_report(REPORT_PATH)

    plot_moonview(data)
    plot_skyplot(data)

    b1_doppler = rangerate2doppler(rangerate(data[:,1:7]), B1_DOWNLINK)
    uplink_doppler = -rangerate2doppler(rangerate(data[:,25:31]), B1_UPLINK)

    plot_uplink_doppler(t, uplink_doppler, B1_UPLINK)
    
    min_dist, reflection_point_long, reflection_point_lat = compute_moonbounce(data)
    plot_specular(reflection_point_long, reflection_point_lat)

    moonbounce_rangerate = np.diff(min_dist)/np.diff(mjd2unixtimestamp(data[:,0])) * 1e3
    moonbounce_doppler = rangerate2doppler(moonbounce_rangerate, B1_DOWNLINK)
    moonbounce_t = Time(mjd2unixtimestamp((data[:-1,0] + data[1:,0])/2), format='unix')

    plot_downlink_doppler(t, b1_doppler, moonbounce_t, moonbounce_doppler, B1_DOWNLINK)    

if __name__ == '__main__':
    main()
