require 'csv'

def rescue_error(e, error_num, row, line_num)
  p '-------------------------'
  p "[error #{error_num}:line #{line_num}]: #{e} | #{row.to_hash}"
  error_num += 1
end

def load_file(klass)
  error_num = 1
  line_num = 2
  csv_text = File.read(Rails.root.join('db', 'data', "#{klass}.csv"))
  csv = CSV.parse(csv_text, headers: true)

  p "loading #{klass} ..."

  csv.each do |row|
    begin
      register = klass.find_by_id(row['id'])

      klass.create!(row.to_hash) unless register
    rescue StandardError => e
      error_num = rescue_error(e, error_num, row, line_num)
    end

    line_num += 1
  end

  p "... done #{klass}"
end

load_file(Reference)
load_file(Unit)
load_file(Exam)
load_file(ExamReference)
load_file(Food)
load_file(Meal)
