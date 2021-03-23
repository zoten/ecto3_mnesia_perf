defmodule Ecto3MnesiaPerf do
  @moduledoc """
  Documentation for `Ecto3MnesiaPerf`.
  """

  alias Ecto3MnesiaPerf.Benches.EctoTransaction
  alias Ecto3MnesiaPerf.Benches.EctoNoTransaction
  alias Ecto3MnesiaPerf.Benches.NoEctoTransaction
  alias Ecto3MnesiaPerf.Mnesia
  alias Ecto3MnesiaPerf.Test1

  require Logger

  @n 100

  @doc """
  Hello world.

  ## Examples

      iex> Ecto3MnesiaPerf.hello()
      :world

  """
  def bench() do
    bench(@n)
  end

  def bench(n) do
    Logger.info("Starting bench with n == #{n}")
    setup()

    data = Test1.n_items(n)

    Test1.delete_all()
    {time_ecto_trans, _} = :timer.tc(fn -> EctoTransaction.run(data) end)

    count = Test1.count()
    Logger.info("Check: count #{count} [#{count == n}]")

    Test1.delete_all()
    {time_ecto_no_trans, _} = :timer.tc(fn -> EctoNoTransaction.run(data) end)

    count = Test1.count()
    Logger.info("Check: count #{count} [#{count == n}]")

    Test1.delete_all()
    {time_no_ecto_trans, _} = :timer.tc(fn -> NoEctoTransaction.run(data) end)

    count = Test1.count()
    Logger.info("Check: count #{count} [#{count == n}]")

    Logger.info("Ecto Trans: #{time_ecto_trans}μs")
    Logger.info("Ecto No Trans: #{time_ecto_no_trans}μs")
    Logger.info("No Ecto Trans: #{time_no_ecto_trans}μs")

    teardown()
  end

  def setup do
    :mnesia.start()
    Mnesia.setup()
  end

  def teardown do
    Mnesia.teardown()
  end
end
