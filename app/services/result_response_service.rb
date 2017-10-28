class ResultResponseService
  attr_accessor :success, :response, :status

  def initialize(success, status, response)
    @success = success
    @response = response
    @status = status
  end
end
