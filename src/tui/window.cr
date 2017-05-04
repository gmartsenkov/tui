module Tui
  class Window
    getter buffer
    def initialize(@name : String, @dimension : Tui::Dimension, @refresh_channel : Channel(Tui::Refresh))
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
      @refresh_channel.send(refresh_object(0))
    end

    private def refresh_object(delay : Int32)
      Tui::Refresh.new(delay, self)
    end

    def print(string : String)
      ncurse_window.mvaddstr(string, x: 1, y: 1)
      @refresh_channel.send(refresh_object(0))
    end

    def read(delay : Int)
      while ((x = ncurse_window.getch))
        if x == -1
          @refresh_channel.send(refresh_object(0))
        else
          @buffer << x
          if x == 10
            @refresh_channel.send(refresh_object(0))
            break
          end
        end
      end
    end

    def string_buffer
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
