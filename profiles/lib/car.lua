-- Car processer

local Base = require('lib/base')
local Convert = require('lib/convert')

Car = Base:subClass()
local settings = {
  name = 'car',
  mode = 'driving',
  default_speed = 90,
  side_road_speed_reduction = 0.8,
  speed_factor = 0.8,
  speed_delta = 11,
  maxspeed_narrow = 40,
  use_fallback_names = false,
  turn_penalty = 10,
  turn_bias = 1.2,         -- invert for countries with left-side driving
  access = {
    tags = Sequence { 'motorcar', 'motor_vehicle', 'vehicle' },
  },
  service_tag_restricted = Set { 'parking_aisle' },
  barrier_whitelist = Set { 'cattle_grid', 'border_control', 'checkpoint', 'toll_booth', 'sally_port', 'gate', 'lift_gate' },
  maxspeed_defaults = {
    urban = 50,
    rural = 90,
    trunk = 110,
    motorway = 130,
  },
  maxspeed_overrides = {
    ['ch:rural'] = 80,
    ['ch:trunk'] = 100,
    ['ch:motorway'] = 120,
    ['de:living_street'] = 7,
    ['ru:living_street'] = 20,
    ['ru:urban'] = 60,
    ['ua:urban'] = 60,
    ['at:rural'] = 100,
    ['de:rural'] = 100,
    ['at:trunk'] = 100,
    ['cz:trunk'] = 0,
    ['ro:trunk'] = 100,
    ['cz:motorway'] = 0,
    ['de:motorway'] = 0,
    ['ru:motorway'] = 110,
    ['gb:nsl_single'] = 60 * Convert.MilesPerHourToKmPerHour,
    ['gb:nsl_dual'] = 70 * Convert.MilesPerHourToKmPerHour,
    ['gb:motorway'] = 70 * Convert.MilesPerHourToKmPerHour,
    ['uk:nsl_single'] = 60 * Convert.MilesPerHourToKmPerHour,
    ['uk:nsl_dual'] = 70 * Convert.MilesPerHourToKmPerHour,
    ['uk:motorway'] = 70 * Convert.MilesPerHourToKmPerHour,
	},
	way_speeds = {
    motorway = 90,
    motorway_link = 45,
    trunk = 85,
    trunk_link = 40,
    primary = 65,
    primary_link = 30,
    secondary = 55,
    secondary_link = 25,
    tertiary = 40,
    tertiary_link = 20,
    unclassified = 25,
    residential = 25,
    living_street = 10,
    service = 15,
  }, 
  tracktype_speeds = {
    grade1 =  60,
    grade2 =  40,
    grade3 =  30,
    grade4 =  25,
    grade5 =  20,
  },
  smoothness_speeds = {
    intermediate = 80,
    bad = 40,
    very_bad = 20,
    horrible = 10,
    very_horrible = 5,
  },
  surface_speeds = {
    cement = 80,
    compacted = 80,
    fine_gravel = 80,

    paving_stones = 60,
    metal = 60,
    bricks = 60,

    grass = 40,
    wood = 40,
    sett = 40,
    grass_paver = 40,
    gravel = 40,
    unpaved = 40,
    ground = 40,
    dirt = 40,
    pebblestone = 40,
    tartan = 40,

    cobblestone = 30,
    clay = 30,

    earth = 20,
    stone = 20,
    rocky = 20,
    sand = 20,

    mud = 10,
  },
}
Car.settings = Table.deep_merge(settings,Car.settings)

function Car:handle_access(d)
  if Base.handle_access(self,d) == false then
    return false
  end
  
  if self:handle_hov(d) == false then
    return false
  end
end

function Car:handle_hov(d)
  local hov = self:tag('hov')
  if hov == 'designated' then
    self:deny(d,"access denied by HOV status", 'hov' )
    return false
  end

  return self:handle_hov_lanes(d)
end

function Car:handle_hov_lanes(d)
  local key,val = self:find_directional_tag(d,'hov:lanes')
  if val and val ~= "" then
    for lane in Base.split_lanes(val) do
      if lane and lane ~= "designated" then
        return true
      end
    end
    self:deny( d, "access denied by HOV lanes", 'highway', hov_lanes )
    return false
  end
end

function Car:handle_speed_calibration(d)
  if d.speed then
    local calibrated = d.speed * self.settings.speed_factor + self.settings.speed_delta
    self:debug( d, "speed calibrated from " .. d.speed .. ' to ' .. calibrated)
    d.speed = calibrated
  end
end


return Car