class TaskController < WebsocketRails::BaseController

  def initialize_session
    # perform application setup here
    controller_store[:message_count] = 0
  end

  def submit
    response = Api::Grid.verify_word message
    new_info = Api::Game.info message
    puts new_info, new_info.class
    WebsocketRails[:play].trigger 'push_info', new_info
    trigger_success response
  end

  def push_info
    #
  end
end