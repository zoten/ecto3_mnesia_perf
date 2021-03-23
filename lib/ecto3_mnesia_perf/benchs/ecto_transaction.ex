defmodule Ecto3MnesiaPerf.Benches.EctoTransaction do
  @moduledoc """
  Test insert in transaction
  """

  alias Ecto3MnesiaPerf.Test1

  def run(data) do
    Test1.create_many(data)
  end
end
