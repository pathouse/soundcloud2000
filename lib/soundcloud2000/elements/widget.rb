require 'curses'

require_relative 'color'

module Soundcloud2000
  module Elements
    class Widget
      ROW_SEPARATOR = ?|
      LINE_SEPARATOR = ?-
      INTERSECTION = ?+

      attr_reader :height, :width, :x, :y
      attr_reader :window

      def initialize(height = Curses.lines, width = Curses.cols, x = 0, y = 0)
        @height, @width, @x, @y = height, width, x, y
        @window = Curses::Window.new(height, width, x, y)
      end

      def reset
        window.box(ROW_SEPARATOR, LINE_SEPARATOR, INTERSECTION)
      end

      def refresh
        window.refresh
      end

      def render
        reset
        yield
        refresh
      end

      def draw
        raise NotImplementedError
      end

      def color(name, inverse = nil, &block)
        window.attron(Color.get(name, inverse), &block)
      end

    end
  end
end