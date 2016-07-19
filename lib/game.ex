defmodule Player do

  #@on_load :reseed_random

  defstruct  health: 1000, level: 1, status: :alive, playid: 1

  
  def deal_damage(id_damager, %Player{ health: player_health} = player, damage) when damage > player_health do
    %Player {
      health: 0,
      status: :dead,
      level: player.level
    }
  end

  def deal_damage(id_damager, %Player{ playid: id_damaged} = player , _ ) when id_damager == id_damaged do
    raise ArgumentError, "You cannot damage yourself"
  end

  def deal_damage(id_damager, %Player{health: player_health } = player, damage) do
    %Player {
      health: player.health - damage,
      level: player.level
    }
  end

  def heal(%Player{health: _ , level: _,  status: :dead}, _ ) do
    raise ArgumentError, "A dead player cannot be healed"
  end

  def heal(%Player{status: :alive, health: player_health} = player, health) when player_health + health > 1000 do
    %Player {
      health: 1000,
      level: player.level
    }
  end

  def heal(player, health) do
    %Player {
      health: player.health + health,
      level: player.level
    }
  end

  def reseed_random do
    :random.seed(:os.timestamp())
  end
end
