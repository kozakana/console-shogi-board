require 'mini_magick'

class BoardImage
  OFFSET_X = 136
  OFFSET_Y = 190
  SQUARE_X = 83
  SQUARE_Y = 83

  def initialize
    @@board   ||= MiniMagick::Image.open("./image/board.png")
    @@ou      ||= MiniMagick::Image.open("./image/ou.png")
    @@gyoku   ||= MiniMagick::Image.open("./image/gyoku.png")
    @@hi      ||= MiniMagick::Image.open("./image/hi.png")
    @@kaku    ||= MiniMagick::Image.open("./image/kaku.png")
    @@kin     ||= MiniMagick::Image.open("./image/kin.png")
    @@gin     ||= MiniMagick::Image.open("./image/gin.png")
    @@kei     ||= MiniMagick::Image.open("./image/kei.png")
    @@kyo     ||= MiniMagick::Image.open("./image/kyo.png")
    @@fu      ||= MiniMagick::Image.open("./image/fu.png")
    @@ryu     ||= MiniMagick::Image.open("./image/ryu.png")
    @@uma     ||= MiniMagick::Image.open("./image/uma.png")
    @@narigin ||= MiniMagick::Image.open("./image/narigin.png")
    @@narikei ||= MiniMagick::Image.open("./image/narikei.png")
    @@narikyo ||= MiniMagick::Image.open("./image/narikyo.png")
    @@to      ||= MiniMagick::Image.open("./image/to.png")

    init_state
  end


  def disp_image
  end

  private

  def init_state
    state = @@board.composite(@@fu) do |c|
      c.geometry(position [1,3])
    end
    state.write "state.png"
  end

  def position pos
    pos_x = (9-pos[0])*SQUARE_X + OFFSET_X 
    pos_y = (pos[1]-1)*SQUARE_Y + OFFSET_Y
    "+#{pos_x}+#{pos_y}"
  end
end


board_image = BoardImage.new

system "convert file1.png file2.png -gravity center -composite out.png"


#image = MiniMagick::Image.open("./image/board.png")
#result = image.composite(MiniMagick::Image.open("./image/kin.png", "png")) do |c|
#  #c.gravity "northeast" 
#  #c.quality "75" 
#  c.geometry "+82+80"
#end
#
#result.write "output_minimagick.jpg" 

