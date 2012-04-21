class Board
  attr_accessor :ghost_coordinates, :macpan_coordinates, :pellet_coordinates, :valid_coordinates

  def ghost_coordinates
    @ghost_coordinates ||= []
  end

  def macpan_coordinates
    @macpan_coordinates ||= []
  end

  def pellet_coordinates
    @pellet_coordinates ||= []
  end

  def valid_coordinates
    @valid_coordinates ||= []
  end

  def valid?(location)
    valid_coordinates.include?(location)
  end
end
