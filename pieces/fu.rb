require './pieces/piece'

class Fu < Piece
  def kind
    :fu
  end

  def move? before, after
    if @grow == true
      return move_kin before, after
    end

    return true if before[0] == after[0] && before[1] == after[1]
    if @player == :first
      return true if before[0] == after[0] && before[1]-1 == after[1]
    else
      return true if before[0] == after[0] && before[1]+1 == after[1]
    end

    false
  end

  def to_s
    disp "歩"
  end

  def to_i
    1
  end

  def image_name
    name = @grow ? "to" : "fu"
    "#{IMAGE_DIR}#{name}_#{@player.to_s}.png"
  end
end
