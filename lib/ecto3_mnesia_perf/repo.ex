defmodule Ecto3MnesiaPerf.Repo do
  use Ecto.Repo,
    otp_app: :ecto3_mnesia_perf,
    adapter: Ecto.Adapters.Mnesia
end
