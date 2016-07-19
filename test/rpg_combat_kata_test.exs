defmodule RpgCombatKataTest do
  use ExUnit.Case
  doctest RpgCombatKata

  test "when a character is damaged" do
    damager = %(Player{})
    player = Player.deal_damage(damager.player_id, %Player{}, 200)
    assert  player == %Player{health: 800}
  end

  test "when a character is killed" do
    damager = %(Player{})
    player = Player.deal_damage(damager.id, %Player{}, 1200)
    assert player == %Player{ health: 0, status: :dead}   
  end

  test "when a character is healed" do
    player = Player.heal(%Player{health: 300}, 200)
    assert player == %Player {health: 500}    
  end

  test "a dead character cannot be healed" do
    assert_raise ArgumentError, fn-> Player.heal(%Player{health: 0, status: :dead}, 100) end
  end

  test "when a character is healed over 1000" do
    player = Player.heal(%Player{health: 300}, 900)
    assert player == %Player{health: 1000}
  end


end
