defmodule RpgCombatKataTest do
  use ExUnit.Case
  doctest RpgCombatKata

  import CombatKata.{Damage, Health}
  alias CombatKata.Player

  test "when a character is damaged" do
    damager = %Player{}
    damaged = %Player{}

    player = deal_damage(damager.id, damaged, 200)
    assert  player == %Player{health: 800}
  end

  test "when a character is killed" do
    damager = %Player{}
    damaged = %Player{}

    IO.puts "#{damager.id} is damaging #{damaged.id}"

    player = deal_damage(damager.id, damaged, 1200)
    assert player == %Player{ health: 0, status: :dead}   
  end

  test "when a character is healed" do
    player = heal(%Player{health: 300}, 200)
    assert player == %Player {health: 500}    
  end

  test "a dead character cannot be healed" do
    assert_raise ArgumentError, fn-> heal(%Player{health: 0, status: :dead}, 100) end
  end

  test "when a character is healed over 1000" do
    player = heal(%Player{health: 300}, 900)
    assert player == %Player{health: 1000}
  end

  test "a character can damage other character" do
    
  end


end
