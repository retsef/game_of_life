class SimulationJob < ApplicationJob
  include Turbo::Streams::Broadcasts
  queue_as :simulations

  def perform(simulation)
    return unless simulation.running?

    old_generation = simulation.latest_generation
    new_generation = simulation.next!
    simulation.touch :latest_run_at

    # Replace through websocket the old generation with the new one
    simulation.broadcast_replace_to simulation,
                                    partial: 'generations/world',
                                    locals: { generation: new_generation },
                                    target: "generation_#{old_generation.id}"

    # Replace header generation number
    simulation.broadcast_replace_to simulation,
                                    partial: 'simulations/show_header',
                                    target: "header_simulation_#{simulation.id}"

    SimulationJob.set(wait: 0.5.second).perform_later(simulation)
  end
end
