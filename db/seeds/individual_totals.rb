%w[< >].each do |condition|
  (0.5..2.5).step(0.5).each {|value| IndividualTotal.find_or_create_by(value: value, condition: condition)}
end