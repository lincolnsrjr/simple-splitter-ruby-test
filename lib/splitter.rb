class Splitter
  attr_accessor :content

  INPUT_PATH = 'data/input'.freeze
  OUTPUT_PATH = 'data/output'.freeze

  def load
    Dir["../#{INPUT_PATH}/*"].each { |file_path| append_content(file_path) }
  end

  private

  def append_content(file_path)
    content ||= ''
    content << "#{File.open(file_path).read}\n"
  end
end