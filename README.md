# Ecto3MnesiaPerf

Just a simple test to see performance differences between different insert modes.
There is no calculation or file save, just console log

## Bench

```
iex -S mix

> Ecto3MnesiaPerf.bench(10)
...
> Ecto3MnesiaPerf.bench(100)
...
> Ecto3MnesiaPerf.bench(1000)
...
> Ecto3MnesiaPerf.bench(5000)
...

```

As we can see from example data below, there is an exponential degrading in performance using
Repo.transaction from ecto3_mnesia, to be profiled. The degrading (atm we can see it only from ecto adapter debug log) grows with time as long as transaction goes on.

### Example run

```
# n = 10
22:10:16.196 [info] Ecto Trans: 2774μs
22:10:16.196 [info] Ecto No Trans: 4182μs
22:10:16.196 [info] No Ecto Trans: 251μs
```

```
# n = 100
22:12:25.826 [info] Ecto Trans: 50411μs
22:12:25.826 [info] Ecto No Trans: 41042μs
22:12:25.826 [info] No Ecto Trans: 1995μs
```

```
# n = 1000
22:13:07.756 [info] Ecto Trans: 3082055μs
22:13:07.756 [info] Ecto No Trans: 657412μs
22:13:07.756 [info] No Ecto Trans: 52967μs
```

```
# n = 5000
22:15:35.972 [info] Ecto Trans: 59823903μs
22:15:35.972 [info] Ecto No Trans: 5523222μs
22:15:35.972 [info] No Ecto Trans: 96745μs
```