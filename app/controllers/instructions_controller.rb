class InstructionsController < ApplicationController
  def index
    @instructions = Instruction.all
  end
end
