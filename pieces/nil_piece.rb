require './pieces/piece'

class NilPiece < Piece
  def initialize
    @player = nil
    @grow   = false
  end

  def kind
    :nil
  end

  def ==(pce)
    pce.class == 'NilPiece'
  end

  # TODO:例外にした方がいいかも
  def move? before, after
    false
  end

  def grow status
  end

  def to_s
    "   "
  end

  def write_image pos
    # 何もしない
  end
end
