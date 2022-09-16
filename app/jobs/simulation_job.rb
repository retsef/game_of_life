class SimulationJob < ApplicationJob
  queue_as :simulations

  def perform(simulation)
    simulation.next!
    simulation.touch :latest_run_at

    return unless simulation.running?

    SimulationJob.set(wait: 1.second).perform_later(simulation)
  end
end
