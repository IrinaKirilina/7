require "./instance_counter"
require "./station"
require "./valid"

class Route
  
  include InstanceCounter

  attr_reader :stations, :name

  NAME_FORMAT = /^[a-zа-я\d]{3}/i

  def initialize(name, first_station, last_station)
    @stations = [first_station, last_station]
    @name = name

    validate!

    register_instance
  end

  def add_station(station)
    stations.insert(-2, station)
  end

  def delete_station(station)
    stations.delete(station)
  end

  protected

  def validate!
    validate_name!
    validate_station!(@stations.first, "First station")
    validate_station!(@stations.last, "Last station")

    true
  end

  def validate_name!
    puts name
    raise "Необходимо ввести наимеование маршрута" if name.nil?
    raise "Наимение мрашрута должо содержать не менее 3 символов" if name.length < 3
    raise "Неверный формат наименования маршрута" if name !~ NAME_FORMAT
  end

  def validate_station!(station, station_title)
    raise "Необходимо ввести #{station_title}" if station.nil?
    raise "Неверный формат #{station_title}" unless station.is_a?(Station)
  end
end