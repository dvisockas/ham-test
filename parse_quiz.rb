# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/hash'

QUIZ_XML_FILENAME = 'quiz_example.xml'
TARGET_FILENAME = 'qa.md'
B_LEVEL_TEST = 'B lygio testas'

xml = File.read(QUIZ_XML_FILENAME)
contents = Hash.from_xml(xml)

categories = contents.dig('quiz', 'category')
b_level_category =
  categories.detect { |category| category['title'] == B_LEVEL_TEST }

File.open(TARGET_FILENAME, 'w') do |file|
  b_level_category['question'].each_with_index do |question_hash, index|
    question = question_hash['text']
    answer = question_hash['choice'][question_hash['answer'].to_i]

    file.write("#{index + 1}\n\nQ: #{question}\n\nA: #{answer}\n\n---\n")
  end
end
