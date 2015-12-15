require './pieces/piece'

class Kaku < Piece
  def kind
    :kaku
  end

  def move? before, after
    dist_x = before[0] - after[0]
    dist_y = before[1] - after[1]
    
    return true if dist_x == dist_y
    return true if dist_x == dist_y * (-1)

    if @grow == true
      return move_ou before, after
    end
    
    false
  end

  def to_s
    disp "角"
  end

  def to_i
    6
  end

  def image_name
    name = @grow ? "uma" : "kaku"
    "#{IMAGE_DIR}#{name}_#{@player.to_s}.png"
  end
end
