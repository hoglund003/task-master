class InstructionsController < ApplicationController
  def index
    @instructions = Instruction.all
  end

  def show
    @instruction = Instruction.find(params[:id])
  end
end
