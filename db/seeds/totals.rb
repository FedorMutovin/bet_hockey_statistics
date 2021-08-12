%w[< >].each do |condition|
  (4.5..8.5).step(0.5).each {|value| Total.find_or_create_by(value: value, condition: condition)}
end