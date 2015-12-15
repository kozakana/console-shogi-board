class Piece
  attr_accessor :player, :grow
  
  def initialize player=nil, grow=nil
    @player = player
    @grow   = grow
  end

  def kind
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  def ==(pce)
    @player == pce.player
  end

  # 盤外かどうかのチェックはここでは無し
  def move? before, after
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  # それぞれのクラスで実装
  def to_s
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  def write_image pos
    system "convert #{BOARD_FILE} #{image_name} -geometry #{position pos} -composite state.png"
  end

  def write_stand idx
    pos = @player==:first ? STAND_OFFSET_Y : 0
    system "convert #{BOARD_FILE} #{image_name} -geometry +#{idx*STAND_PIECE_X}+#{pos} -composite state.png"
  end
  
  private

  def disp pce
    str = ""
    if @player == :first
      str += "\e[32m"
    else
      str += "\e[31m"
    end

    if @grow == true
      str += "*"
    else
      str += " "
    end
    str += pce
    str += "\e[0m"
    str
  end

  def move_ou before, after
    return false unless before[0]-1 <= after[0] && after[0] <= before[0]+1
    return false unless before[1]-1 <= after[1] && after[1] <= before[1]+1
    true
  end

  def move_kin before, after
    return false unless move_ou before, after
    
    if @player == :first
      return false if before[0]-1 == after[0] && before[1]+1 == after[1]
      return false if before[0]+1 == after[0] && before[1]+1 == after[1]
    else
      return false if before[0]-1 == after[0] && before[1]-1 == after[1]
      return false if before[0]+1 == after[0] && before[1]-1 == after[1]
    end
    true
  end

  def position pos
    pos_x = (9-pos[0])*SQUARE_X + OFFSET_X 
    pos_y = (pos[1]-1)*SQUARE_Y + OFFSET_Y
    "+#{pos_x}+#{pos_y}"
  end
end
