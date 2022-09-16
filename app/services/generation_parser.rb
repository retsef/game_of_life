class GenerationParser
  FORMAT_REGEX = /Generation (\d+):\n(\d+) (\d+)\n[.,*,\n]+./i.freeze

  def self.parse file
    throw FormatInvalidException unless file.is_a? ActionDispatch::Http::UploadedFile
    generation_source = file.read

    throw FormatInvalidException unless FORMAT_REGEX.match? generation_source

    generation = Generation.new
    number, height, width = FORMAT_REGEX.match(generation_source).captures

    generation.number = number.to_i
    generation.build_world(width: width.to_i, height: height.to_i)

    cells = generation_source.scan(/([.,*])/).flatten

    throw FormatInvalidException unless cells.size == (width.to_i * height.to_i)

    cells.each_with_index do |cell, index|
      generation.world.cells.build(
        x: index % generation.world_width,
        y: index / generation.world_width,
        alive: cell == '*'
      )
    end

    generation
  end

  FormatInvalidException = Class.new(StandardError)
end