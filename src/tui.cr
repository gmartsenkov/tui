require "./tui/*"

module Tui
  extend self
  @@windows = [] of Tui::Window
  @@refresh_channel = Channel(Nil).new

  def init
    NCurses.init
  end

  def main_loop()
    loop do
      @@refresh_channel.receive
      windows.each(&.refresh)
    end
  end

  def add_win(name : String, dimension : Tui::Dimension)
    @@windows << Tui::Window.new(name, dimension, @@refresh_channel)
  end

  def windows
    @@windows
  end

  def cbreak
    NCurses.cbreak
  end

  def echo
    NCurses.echo
  end

  def noecho
    NCurses.noecho
  end
end
