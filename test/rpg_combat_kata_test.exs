defmodule RpgCombatKataTest do
  use ExUnit.Case
  doctest RpgCombatKata

  import CombatKata.{Damage, Health}
  alias CombatKata.Player

  test "when a character is damaged" do
    damager = %Player{}
    damaged = %Player{}

    player = deal_damage(damager, damaged, 200)
    assert  player.health ==  800
  end

  test "when a character is killed" do
    damager = %Player{}
    player = deal_damage(damager, %Player{}, 1200)
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
    assert_raise ArgumentError, fn-> deal_damage(player, player, 200) end 
  end

  test "a character cannot heals other character" do
    player1 = %Player{}
    player2 = %Player {}

    assert_raise ArgumentError, fn-> heal(player1, player2, 200) end
  end

  test "If target is 5 levels or more above the player, damage is reduced by 50%" do
    player1 = %Player{}
    player2 = %Player{level: 6}

    player_damaged = deal_damage(player1, player2, 200)
    player_damaged2 = deal_damage(player1, player2, 125)

    assert player_damaged.health == 900
    assert player_damaged2.health == 937.5
  end

  test "If player is 5 levels or more above the target, damaged is boosted by 50%" do
    player1 = %Player{level: 6}
    player2 = %Player{}

    player_damaged = deal_damage(player1, player2, 100)
    player_damaged2 = deal_damage(player1, player2, 225)

    assert player_damaged.health == 850
    assert player_damaged2.health == 662.5
  end

end
