require './pieces/piece'

class Hi < Piece
  def kind
    :hi
  end

  def move? before, after
    return true if before[0] == after[0]
    return true if before[1] == after[1]

    if @grow == true
      return move_ou before, after
    end
    
    false
  end

  def to_s
    disp "飛"
  end

  def to_i
    7
  end

  def image_name
    name = @grow ? "ryu" : "hi"
    "#{IMAGE_DIR}#{name}_#{@player.to_s}.png"
  end
end
