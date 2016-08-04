defmodule CombatKata.Damage do

  alias CombatKata.Player
  alias CombatKata.Atack

  def deal_damage(%Player{id: id_player}, %Player{ id: id_target} , _ ) when id_player == id_target do 
     raise ArgumentError, "You cannot damage yourself"
  end

  def deal_damage(%Player{type: player_type}, _, %Atack{distance: distance} ) when player_type == :mele and distance > 2 do
    raise ArgumentError, "You cannot atack a target further 2m"
  end

  def deal_damage(%Player{type: player_type}, _, %Atack{distance: distance} ) when player_type == :ranged and distance > 20 do
    raise ArgumentError, "You cannot atack a target further 20m"
  end
  
  def deal_damage(_, %Player{ health: target_health} = target, %Atack{damage: damage}) when damage > target_health do
    %Player {
      health: 0,
      status: :dead,
      level: target.level,
      id: target.id
    }
  end  

  def deal_damage(%Player{} = player , %Player{} = target, %Atack{damage: damage}) do
    %Player {
      health: target.health - calculate_damage(player, target, damage),
      level: target.level,
      id: target.id
    }
  end

  defp calculate_damage(%Player{level: player_level }, %Player{ level: target_level}, damage)
  when player_level < target_level and  player_level + 5 <= target_level   do
      damage * 0.50
  end

  defp calculate_damage(%Player{level: player_level }, %Player{ level: target_level}, damage)
  when target_level < player_level  and  target_level + 5 <= player_level   do
      damage * 1.50
  end

  defp calculate_damage(_, _, damage) do
    damage
  end

end
