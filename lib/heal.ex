defmodule CombatKata.Health do 

  alias CombatKata.Player

  def heal(_, %Player{status: :dead}, _ ) do
    raise ArgumentError, "A dead player cannot be healed"
  end

  def heal(%Player{id: player_id}, %Player{id: target_id}, _) when player_id != target_id do
    raise ArgumentError, "A player cannot heal other players"
  end

  def heal(_, %Player{status: :alive, health: target_health} = target, health) when target_health + health > 1000 do
   %Player {
     health: 1000,
     level: target.level,
     id: target.id
    }
  end

  def heal(_, target, health) do
    %Player {
      health: target.health + health,
      level: target.level,
      id: target.id
    }
  end
end
