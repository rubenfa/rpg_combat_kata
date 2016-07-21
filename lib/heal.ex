defmodule CombatKata.Health do 

  alias CombatKata.Player

  def heal(%Player{status: :dead}, _ ) do
    raise ArgumentError, "A dead player cannot be healed"
  end

  def heal(%Player{status: :alive, health: player_health} = player, health) when player_health + health > 1000 do
   %Player {
     health: 1000,
     level: player.level,
     id: player.id
    }
  end


  def heal(player, health) do
    %Player {
      health: player.health + health,
      level: player.level,
      id: player.id
    }
  end
end
