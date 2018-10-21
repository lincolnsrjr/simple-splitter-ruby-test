class Splitter
  attr_reader :content

  INPUT_PATH = 'data/input'.freeze
  OUTPUT_PATH = 'data/output'.freeze
  TRACE_PATTERN = '-------------------------------'.freeze

  def run
    load
    questions, answers = parse
  end

  private

  def parse
    return if @content.nil? || @content.empty?

    questions, answers, found_trace = '', '', false

    @content.each_line { |line| parse_line(line, found_trace, questions, answers) }

    [questions, answers]
  end

  def parse_line(line, found_trace, questions, answers)
    found_trace = !(line.include?(TRACE_PATTERN) && found_trace)

    answers << line if found_trace
    questions << line unless found_trace
  end

  def load
    Dir["../#{INPUT_PATH}/*"].each { |file_path| append_content(file_path) }
  end

  def append_content(file_path)
    @content ||= ''
    @content << "#{File.open(file_path).read}\n"
  end
end
