class Simulation::BaseComponent < ApplicationComponent
  attr_reader :simulation

  def initialize(simulation)
    @simulation = simulation
  end
end
