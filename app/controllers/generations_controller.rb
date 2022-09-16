class GenerationsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_simulation
  before_action :find_generation, only: %i[show]

  def index
    @generations ||= @simulation.generations
  end

  def show; end

  private

  def find_simulation
    @simulation ||= Simulation.find(params[:simulation_id])
  end

  def find_generation
    @generation ||= @simulation.generations.find(params[:id])
  end
end