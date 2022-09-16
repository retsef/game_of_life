class Simulation::Actions::Component < Simulation::BaseComponent
  def running?
    simulation.running?
  end
end