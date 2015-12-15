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
  end

  def position pos
    pos_x = (9-pos[0])*SQUARE_X + OFFSET_X 
    pos_y = (pos[1]-1)*SQUARE_Y + OFFSET_Y
    "+#{pos_x}+#{pos_y}"
  end

  def write_image kind, pos
    koma = "./image/#{kind.to_s}"
    p $0
    system "convert ./image/board.png #{koma} -geometry #{position pos} -composite state.png"
  end
end
