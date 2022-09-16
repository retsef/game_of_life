class SimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_simulation, only: %i[show destroy start pause]
  before_action :init_simulation, only: %i[new create]

  def index
    @simulations ||= Simulation.all
  end

  def show; end

  def start
    @simulation.touch :running_at

    SimulationJob.perform_now(@simulation)

    flash[:notice] = 'Simulation started'
  end

  def pause
    @simulation.update(running_at: nil)

    flash[:notice] = 'Simulation paused'
  end

  def new; end

  def create
    if @simulation.update(simulation_params)
      redirect_to @simulation
    else
      render :new
    end
  end

  def destroy
    @simulation.destroy

    redirect_to root_path, notice: 'Simulation was successfully destroyed.'
  end

  private

  def simulation_params
    params.require(:simulation).permit(:generation)
  end

  def init_simulation
    @simulation ||= Simulation.new
  end

  def find_simulation
    @simulation ||= Simulation.find(params[:id])
  end
end