module Tui
  class Window
    getter buffer
    def initialize(@name : String, @dimension : Tui::Dimension, @refresh_channel : Channel(Nil))
      @ncurse_window = NCurses::Window.new(
        x: @dimension.x,
        y: @dimension.y,
        height: @dimension.height,
        width: @dimension.width
      )
      @buffer = [] of Int32 | LibNCurses::KeyCode
    end

    def refresh
      ncurse_window.border
      ncurse_window.refresh
    end

    def print_buffer
      ncurse_window.mvaddstr(string_buffer, x: 1, y: 1)
      @refresh_channel.send(nil)
    end

    def print(string : String)
      ncurse_window.mvaddstr(string, x: 1, y: 1)
      @refresh_channel.send(nil)
    end

    def read
      while ((x = ncurse_window.getch))
        next if x == -1
        @buffer << x
        if x == 10
          ncurse_window.erase
          break
        end
      end
    end

    private def string_buffer
      @buffer.map do |byte|
        x = byte.to_i
        next if x == 10
        x.chr rescue nil
      end.compact.join
    end

    private getter ncurse_window

    delegate mvaddstr, to: ncurse_window
    delegate border, to: ncurse_window
  end
end
