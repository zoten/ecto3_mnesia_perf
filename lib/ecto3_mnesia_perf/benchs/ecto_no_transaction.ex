defmodule Ecto3MnesiaPerf.Benches.EctoNoTransaction do
  @moduledoc """
  Test insert in transaction
  """

  alias Ecto3MnesiaPerf.Test1

  def run(data) do
    data
    |> Enum.map(fn item ->
      Test1.create(item)
    end)
  end
end
