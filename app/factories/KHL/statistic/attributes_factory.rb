class KHL::Statistic::AttributesFactory
  def initialize(method_name, params)
    @method = method_name
    @block = params.css('.b-data_row')["#{self.class}::#{method_name.upcase}_BLOCK_INDEX".constantize]
                   .css('.dataTable tbody tr')
  end

  def create
    calculate_value(self.class::INDEX[@method])
  end

  private

  def calculate_value(index)
    if @block.count > 4
      calculate_with_periods(index)
    elsif self.class.to_s.include?('HoldingTime')
      index = index.negative? ? index : index - 1
      time = @block[-1].children.text.split(' ')[index]
      convert_time_to_seconds_format(time).to_i
    else
      index = index.negative? ? index : index - 1
      @block[-1].children.text.split(' ')[index].to_i
    end
  end

  def calculate_with_periods(index)
    values = []
    regular_time_periods_count = 0..2
    @block[regular_time_periods_count].each { |block| values << block.children.text.split(' ')[index] }
    if self.class.to_s.include?('HoldingTime')
      values.map { |value| convert_time_to_seconds_format(value).to_i }.sum
    else
      values.map(&:to_i).sum
    end
  end
end
