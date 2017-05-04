module Tui
  class Refresh
    getter delay, refresh_object
    def initialize(@delay : Int32, @refresh_object : Tui::Window)
    end
  end
end
