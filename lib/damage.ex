defmodule CombatKata.Damage do

  alias CombatKata.Player

  def deal_damage(id_damager, %Player{ id: id_damaged} , _ ) when id_damager == id_damaged do
     raise ArgumentError, "You cannot damage yourself"
  end
  
  def deal_damage(id_damager, %Player{ health: player_health} = player, damage) when damage > player_health do
    %Player {
      health: 0,
      status: :dead,
      level: player.level,
      id: player.id
    }
  end  

  def deal_damage(id_damager, %Player{health: player_health } = player, damage) do
    %Player {
      health: player.health - damage,
      level: player.level,
      id: player.id
    }
  end

  


end
