defmodule Ecto3MnesiaPerf.Benches.NoEctoTransaction do
  @moduledoc """
  Test insert in transaction with mnesia only (and a little record conversion)
  """

  alias Ecto3MnesiaPerf.Test1

  def run(data) do
    now = NaiveDateTime.utc_now()

    :mnesia.transaction(fn ->
      data
      |> Enum.map(fn item ->
        record = Test1 |> struct!(item) |> Test1.to_record(now)
        :mnesia.write(:test1, record, :write)
      end)
    end)
  end
end
