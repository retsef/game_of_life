class SimulationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_simulation, only: %i[show start pause]
  before_action :init_simulation, only: %i[new create]

  def index
    @simulations ||= Simulation.all
  end

  def show; end

  def start
    if @simulation.repeated?
      flash[:alert] = t('.error')
      return
    end

    @simulation.touch :running_at

    SimulationJob.perform_now(@simulation)

    flash[:notice] = t('.success')
  end

  def pause
    @simulation.update(running_at: nil)

    flash[:notice] = t('.success')
  end

  def new; end

  def create
    generation = GenerationParser.new.call(simulation_params[:generation_source])

    if generation.failure?
      flash[:alert] = t('.error')
      render :new
      return
    end

    if generation.value!.update(simulation: @simulation)
      redirect_to @simulation, notice: t('.success')
    else
      flash[:alert] = t('.error')
      render :new
    end
  end

  private

  def simulation_params
    params.require(:simulation).permit(:generation_source)
  end

  def init_simulation
    @simulation ||= Simulation.new
  end

  def find_simulation
    @simulation ||= Simulation.find(params[:id])
  end
end
