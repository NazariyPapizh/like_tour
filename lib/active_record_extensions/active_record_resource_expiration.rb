module ActiveRecordResourceExpiration
  attr_accessor :_action_controller

  def _get_action_controller
    @_action_controller ||= ActionController::Base.new
  end

  def expire_fragment key, options = nil
    _get_action_controller.expire_fragment(key, options)
  end

  def expire_page options = {}
    _get_action_controller.expire_page(options)
  end
end