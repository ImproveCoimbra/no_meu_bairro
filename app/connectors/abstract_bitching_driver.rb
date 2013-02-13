class AbstractBitchingDriver

  attr_accessor :report

  def initialize(report)
    @report = report
  end

  def get_message
    "Foi detectado o problema: #{@report.description}"
  end

  def notify

  end

end
