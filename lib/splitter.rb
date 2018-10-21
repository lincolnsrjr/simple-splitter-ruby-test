require 'fileutils'

class Splitter
  attr_reader :found_trace

  INPUT_PATH = 'data/input'.freeze
  OUTPUT_PATH = 'data/output'.freeze
  TRACE_PATTERN = '-------------------------------'.freeze

  def run
    content = load
    questions, answers = parse(content)
    save(questions, answers)
  end

  private

  def save(*content)
    content.each { |file| save_file(file[:name], file[:content]) }
  end

  def save_file(name, content)
    return unless name || content || content.empty?

    path = "../#{OUTPUT_PATH}/#{name}"
    FileUtils.mkdir_p path

    File.open("#{path}/#{name}_#{Time.now}.md", "a") { |file| file.puts(content) }
  end

  def parse(content)
    return if content.nil? || content.empty?

    questions, answers, @found_trace = '', '', false

    content.each_line { |line| parse_line(line, questions, answers) }

    [
      { name: 'questions', content: questions },
      { name: 'answers', content: answers }
    ]
  end

  def parse_line(line, questions, answers)
    @found_trace = !@found_trace if line.include?(TRACE_PATTERN)

    questions << line unless found_trace
    answers << line if found_trace
  end

  def load
    Dir["../#{INPUT_PATH}/*"].map { |file_path| File.open(file_path).read }
                             .join("\n")
  end
end

Splitter.new.run