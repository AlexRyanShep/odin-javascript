# frozen_string_literal: false

# Vehicles superclass
class Vehicle
  attr_accessor :colour
  attr_reader :year, :model
  attr_writer :speed

  @@number_of_vehicles = 0
  def initialize(year, colour, model)
    @speed = 0
    @year = year
    @colour = colour
    @model = model
    @@number_of_vehicles += 1
  end

  def self.number_of_vehicles
    @@number_of_vehicles
  end

  def speed_up(speed)
    @speed += speed
  end

  def brake(speed)
    @speed -= speed
  end

  def turn_off
    @speed = 0
  end

  def speed
    puts "The current speed is #{@speed} mph!"
  end

  def self.mileage_calc(miles, gallons)
    puts "MPG is #{(miles.to_f / gallons).round}"
  end
end

# Convertibles
module Convertible
  def roof_setup
    @roof = 'Down'
  end

  def change_roof
    @roof = @roof == 'Down' ? 'Up' : 'Down'
    puts "The roof is now #{@roof}"
  end
end

# Broom broom, I'm a car
class Car < Vehicle
  include Convertible

  def initialize(year, colour, model)
    super(year, colour, model)
  end
end

# Trucks carry things
class Truck < Vehicle
  attr_writer :capacity

  def initialize(year, colour, model, capacity)
    super(year, colour, model)
    @capacity = capacity
  end

  def capacity
    puts "This #{@model} truck can carry #{@capacity} tonnes"
  end
end

tilda = Car.new(2010, 'Red', 'Volvo')
tilda.roof_setup
tilda.speed
tilda.speed_up(60)
tilda.speed
tilda.change_roof
tilda.brake(20)
tilda.speed
tilda.turn_off
tilda.speed
truck = Truck.new(2020, 'White', 'Semi', 100)

puts truck.capacity
Car.mileage_calc(351, 13)
puts Vehicle.number_of_vehicles

