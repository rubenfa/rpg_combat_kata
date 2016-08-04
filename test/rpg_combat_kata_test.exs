defmodule RpgCombatKataTest do
  use ExUnit.Case
  doctest RpgCombatKata

  import CombatKata.{Damage, Health}
  alias CombatKata.Player
  alias CombatKata.Atack

  test "when a character is damaged" do
    damager = %Player{}
    damaged = %Player{}

    player = deal_damage(damager, damaged, %Atack{damage: 200})
    assert  player.health ==  800
  end

  test "when a character is killed" do
    damager = %Player{}
    player = deal_damage(damager, %Player{}, %Atack{damage: 1200})
    assert player.health  ==  0
    assert player.status == :dead
  end

  test "when a character is healed" do
    player = %Player{health: 300}
    player_healed = heal(player, player, 200)
    assert player_healed.health == 500    
  end

  test "a dead character cannot be healed" do
    assert_raise ArgumentError, fn-> heal(%Player{}, %Player{health: 0, status: :dead}, 100) end
  end

  test "when a character is healed over 1000" do
    player = %Player{health: 300}
    player_healed = heal(player, player,  900)
    assert player_healed.health == 1000
  end

  test "a character cannot damage himself" do
    player = %Player{}
    assert_raise ArgumentError, fn-> deal_damage(player, player, %Atack{damage: 200}) end 
  end

  test "a character cannot heals other character" do
    player1 = %Player{}
    player2 = %Player {}

    assert_raise ArgumentError, fn-> heal(player1, player2, 200) end
  end

  test "If target is 5 levels or more above the player, damage is reduced by 50%" do
    player1 = %Player{}
    player2 = %Player{level: 6}

    player_damaged = deal_damage(player1, player2, %Atack{damage: 200})
    player_damaged2 = deal_damage(player1, player2, %Atack{damage: 125})

    assert player_damaged.health == 900
    assert player_damaged2.health == 937.5
  end

  test "If player is 5 levels or more above the target, damaged is boosted by 50%" do
    player1 = %Player{level: 6}
    player2 = %Player{}

    player_damaged = deal_damage(player1, player2, %Atack{damage: 100})
    player_damaged2 = deal_damage(player1, player2, %Atack{damage: 225})

    assert player_damaged.health == 850
    assert player_damaged2.health == 662.5
  end

  test "A player can damage a target in range of 2m when is of mele type" do
    player1 = %Player{type: :mele}
    player2 = %Player{}

    player_damaged = deal_damage(player1, player2, %Atack{damage: 200, distance: 2})
    assert player_damaged.health == 800
  end

  test "A player can damage a target in range of 20m when is of range type" do
    player1 = %Player{type: :range}
    player2 = %Player{}

    player_damaged = deal_damage(player1, player2, %Atack{damage: 200, distance: 20})
    assert player_damaged.health == 800
  end

  test "A player cannot damage a target in range of 3m when is of mele type" do
    player1 = %Player{type: :mele}
    player2 = %Player{}

    assert_raise(
      ArgumentError,
      "You cannot atack a target further 2m",
      fn ->  deal_damage(player1, player2, %Atack{damage: 200, distance: 3}) end)
  end 

  test "A player cannot damage a target in range of 21m when is of mele type" do
    player1 = %Player{type: :ranged}
    player2 = %Player{}

    assert_raise(
      ArgumentError,
      "You cannot atack a target further 20m",
      fn ->  deal_damage(player1, player2, %Atack{damage: 200, distance: 21}) end)
  end  
end

