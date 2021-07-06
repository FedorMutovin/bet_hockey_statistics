class Operation::CreateService
  attr_accessor :operational
  attr_reader :model_klass, :params

  def initialize(model_klass, params)
    @model_klass = model_klass
    @params = params
  end

  def call
    create_operation!
    self
  end

  private

  def create_operation!
    self.operational = model_klass.create(params)
  end
end
