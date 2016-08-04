defmodule CombatKata.Player do

  def __struct__() do
#    reseed_random()
    %{__struct__: __MODULE__, id: get_next(), health: 1000, level: 1, status: :alive, type: :mele}
  end

  def reseed_random do
    :random.seed(:os.timestamp())
  end

  def get_next do
    :random.uniform(10000000)
  end
end
