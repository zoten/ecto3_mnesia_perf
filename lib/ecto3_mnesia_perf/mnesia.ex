defmodule Ecto3MnesiaPerf.Mnesia do
  def start do
    :mnesia.start()
    :mnesia.wait_for_tables([:test1], 1000)
  end

  def setup do
    :mnesia.stop()

    IO.inspect(:mnesia.create_schema([node()]))
    IO.inspect(:mnesia.start())
    IO.inspect(:mnesia.create_table(
      :test1,
      [
        disc_copies: [node()],
        record_name: Ecto3MnesiaPerf.Test1,
        attributes: [:id, :name, :bin, :int, :defaultstring, :active, :updated_at, :inserted_at],
        type: :set
    ]))

  end

  def teardown do
    IO.inspect(:mnesia.delete_table(:test1))
  end
end
