defmodule Ecto3MnesiaPerf.Test1 do
  use Ecto.Schema

  import Ecto.Changeset
  alias Ecto.Multi
  import Ecto.Query

  alias Ecto3MnesiaPerf.Repo
  alias Ecto3MnesiaPerf.Test1

  require Logger

  @derive Jason.Encoder
  @primary_key {:id, :binary_id, autogenerate: false}
  schema "test1" do
    field :name, :string, null: true
    field :bin, :binary
    field :int, :integer, default: 19

    field :defaultstring, :string, default: "aaaaaa"
    field :active, :boolean, default: true
    timestamps()
  end

  # Just for test
  def to_record(%{} = item, now \\ nil) do
    {Test1, item.id, item.name, item.bin, item.int, item.defaultstring, item.active, now, now}
  end

  def delete_all do
    all_query()
    |> Repo.delete_all()
  end

  def create(params) do
    %Test1{}
    |> create_changeset(params)
    |> Repo.insert()
  end

  def create_many(test1s) when is_list(test1s) do
    test1s
    |> Enum.reduce(
      Multi.new(),
      fn test1, acc ->
        Multi.insert(
          acc,
          "insert-" <> test1.id,
          create_changeset(test1)
        )
      end
    )
    |> Repo.transaction()
  end

  # Just for testing purposes
  def n_items(n) do
    << i1 :: unsigned-integer-32, i2 :: unsigned-integer-32, i3 :: unsigned-integer-32>> = :crypto.strong_rand_bytes(12)
    :rand.seed(:exsplus, {i1, i2, i3})

    0..(n - 1)
      |> Enum.map(fn n ->
        id = n |> Integer.to_string() |> String.pad_leading(15, "0")

        elem = %{
          id: id,
          name: "name-" <> id,
          bin: <<(:rand.uniform(1000000000000))::32>>,
          int: :rand.uniform(100000),
          active: false
        }

        # Logger.warn("#{inspect elem}")
        elem
      end)
  end

  def create_changeset(params), do: create_changeset(%Test1{}, params)

  def create_changeset(tst, params) do
    tst
    |> cast(params, [:id, :name, :bin, :int, :defaultstring, :active])
    |> validate_required([:bin, :int])
  end

  def all() do
    Repo.all(all_query())
  end

  def count do
    # not efifcient, just for test
    length(all())
  end

  defp all_query do
    from(u in Test1, select: u)
  end
end
