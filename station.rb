require "./instance_counter"
require "./valid"

class Station

  include InstanceCounter

  attr_accessor :name

  attr_reader :trains
  
  NAME_FORMATE = /^[a-zа-я\d]{3}/i

  @@all = []

  def initialize(name)
    @name = name
    @trains = []
    @@all << self

    validate!
    
    register_instance
  end

 private

  def arrival(train)
    @trains << train
  end

  def departure(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
    @trains.select { |train| train.type == type }
  end

  def self.all
    @@all
  end

  protected

  def validate!
    raise "Необходимо ввести наименование станции" if name.nil?
    raise "Наименование должно содержать не менее 3 символов" if name.length < 3
    raise "Неверный формат наименования станции" if name !~ NAME_FORMATE
    
    true
  end
end