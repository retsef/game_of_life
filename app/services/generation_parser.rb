require 'dry/monads'

class GenerationParser
  include Dry::Monads[:result, :do]

  FORMAT_REGEX = /Generation (\d+):\n(\d+) (\d+)\n[.,*,\n]+./i.freeze

  def call(file)
    file = yield validate_file(file)
    generation_source = yield read_file(file)
    generation, cells = yield generate_form(generation_source)
    generation = yield build_world_for(generation, cells)

    Success(generation)
  end

  private

  def validate_file(file)
    return Success(file) if file.is_a?(ActionDispatch::Http::UploadedFile) || file.is_a?(File)

    Failure(:invalid_file)
  end

  def read_file(file)
    generation_source = file.read

    return Failure(:invalid_file_format) unless FORMAT_REGEX.match?(generation_source)

    Success(generation_source)
  end

  def generate_form(generation_source)
    generation = Generation.new
    number, height, width = FORMAT_REGEX.match(generation_source).captures

    generation.number = number.to_i
    generation.build_world(width: width.to_i, height: height.to_i)

    cells = generation_source.scan(/([.,*])/).flatten

    return Failure(:invalid_world_size) unless cells.size == (width.to_i * height.to_i)

    Success([generation, cells])
  end

  def build_world_for(generation, cells)
    cells.each_with_index do |cell, index|
      generation.world.cells.build(
        x: index % generation.world_width,
        y: index / generation.world_width,
        alive: cell == '*'
      )
    end

    Success(generation)
  end
end
