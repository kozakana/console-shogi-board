class BoardData
  LINE_TITLE  = ["一", "二", "三", "四", "五", "六", "七", "八", "九"]
  IMAGE_DIR   = File.expand_path(File.dirname(__FILE__)) + "/image/"
  BOARD_FILE  = File.expand_path(File.dirname(__FILE__)) + "/state.png"
  WORKING_DIR = File.expand_path(File.dirname(__FILE__)) + "/"
  OFFSET_X = 136
  OFFSET_Y = 190
  SQUARE_X = 83
  SQUARE_Y = 83
  STAND_OFFSET_Y = 980
  STAND_PIECE_X  = 60

  def initialize
    Piece.const_set(:IMAGE_DIR, IMAGE_DIR)
    Piece.const_set(:BOARD_FILE, BOARD_FILE)
    Piece.const_set(:OFFSET_X, OFFSET_X)
    Piece.const_set(:OFFSET_Y, OFFSET_Y)
    Piece.const_set(:SQUARE_X , SQUARE_X)
    Piece.const_set(:SQUARE_Y , SQUARE_Y)
    Piece.const_set(:STAND_OFFSET_Y , STAND_OFFSET_Y)
    Piece.const_set(:STAND_PIECE_X , STAND_PIECE_X)
    @data = []
    @piece_stand = {}
    @piece_stand[:first]  = []
    @piece_stand[:second] = []

    @data << [
              Kyo.new(:second, false), NilPiece.new,
              Fu.new(:second, false),  NilPiece.new, 
              NilPiece.new,            NilPiece.new,
              Fu.new(:first, false),   NilPiece.new,
              Kyo.new(:first, false)
             ]

    @data << [
              Kei.new(:second, false), Kaku.new(:second, false),
              Fu.new(:second, false),  NilPiece.new,
              NilPiece.new,            NilPiece.new,
              Fu.new(:first, false),   Hi.new(:first, false),
              Kei.new(:first, false)
             ]

    @data << [
              Gin.new(:second, false), NilPiece.new,
              Fu.new(:second, false),  NilPiece.new,
              NilPiece.new,            NilPiece.new,
              Fu.new(:first, false),   NilPiece.new,
              Gin.new(:first, false)
             ]

    @data << [
              Kin.new(:second, false), NilPiece.new,
              Fu.new(:second, false),  NilPiece.new,
              NilPiece.new,            NilPiece.new,
              Fu.new(:first, false),   NilPiece.new,
              Kin.new(:first, false)
             ]

    @data << [
              Ou.new(:second,false),    NilPiece.new,
              Fu.new(:second, false),   NilPiece.new,
              NilPiece.new,             NilPiece.new,
              Fu.new(:first, false),    NilPiece.new,
              Ou.new(:first, false)
             ]

    @data << [
              Kin.new(:second, false), NilPiece.new,
              Fu.new(:second, false),  NilPiece.new,
              NilPiece.new,            NilPiece.new,
              Fu.new(:first, false),   NilPiece.new,
              Kin.new(:first, false)
             ]

    @data << [
              Gin.new(:second, false), NilPiece.new,
              Fu.new(:second, false),  NilPiece.new,
              NilPiece.new,            NilPiece.new,
              Fu.new(:first, false),   NilPiece.new,
              Gin.new(:first, false)
             ]

    @data << [
              Kei.new(:second, false), Hi.new(:second, false),
              Fu.new(:second, false),  NilPiece.new,
              NilPiece.new,            NilPiece.new,
              Fu.new(:first, false),   Kaku.new(:first, false),
              Kei.new(:first, false)
             ]

    @data << [
              Kyo.new(:second, false),  NilPiece.new,
              Fu.new(:second, false),   NilPiece.new,
              NilPiece.new,             NilPiece.new,
              Fu.new(:first, false),    NilPiece.new,
              Kyo.new(:first, false)
             ]
  end

  def [](x, y)
    @data[x][y]
  end

  def []=(x, y, piece)
    @data[x][y] = piece
  end

  # TODO　修正中
  def to_stand order, piece
    @piece_stand[order] << piece
  end

  def on_stand? order, piece
    @piece_stand[order].include?(piece)
  end

  def del_piece order, piece
    @piece_stand[order].each_with_index do |p, i|
      if p == piece
        @piece_stand[order].delete_at i
        break
      end
    end
  end

  def disp order
    case order
    when :first
      #disp_first
      disp_image
    when :second
      #disp_second
    end
  end

  def disp_image
    system("cp #{IMAGE_DIR}/board.png #{WORKING_DIR}state.png")
    9.times do |y|
      9.times do |x|
        @data[8-x][y].write_image [9-x, y+1]
      end
    end
    write_piece_stand @piece_stand[:first]
    write_piece_stand @piece_stand[:second]
  end

  def position pos
    pos_x = (9-pos[0])*SQUARE_X + OFFSET_X 
    pos_y = (pos[1]-1)*SQUARE_Y + OFFSET_Y
    "+#{pos_x}+#{pos_y}"
  end

  def write_piece_stand stand
    stand.sort! do |a, b|
      a.to_i <=> b.to_i
    end
    stand.each_with_index do |pce, idx|
      pce.write_stand idx
    end
  end

  def disp_first
    ltitle = LINE_TITLE

    str  = "\e[31m"
    str += "\n☖ 後手持駒："
    @piece_stand[:second].each do |pce|
      str += pce.to_s
    end
    str += "\n\e[0m"
    str += " 9   8   7   6   5   4   3   2   1 \n"

    9.times do |y|
      9.times do |x|
        str += @data[8-x][y].to_s
        str += "|"
      end
      str += "#{ltitle[y]}\n"
    end

    str += "\e[32m☗ 先手持駒："
    @piece_stand[:first].each do |pce|
      str += pce.to_s
    end
    str += "\n\n\e[0m"
    str
  end

  def disp_second
    ltitle = LINE_TITLE.reverse

    str  = "\e[32m"
    str += "\n☗ 先手持駒："
    @piece_stand[:first].each do |pce|
      str += pce.to_s
    end
    str += "\n\e[0m"

    9.times do |y|
      str += "#{ltitle[y]}"
      9.times do |x|
        str += @data[x][8-y].to_s
        str += "|"
      end
      str += "\n"
    end

    str += "   1   2   3   4   5   6   7   8   9 \n"

    str += "\e[31m☖ 後手持駒："
    @piece_stand[:second].each do |pce|
      str += pce.to_s
    end

    str += "\n\n\e[0m"
    str
  end
end
