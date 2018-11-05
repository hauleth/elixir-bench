small = 5.55
med = :rand.uniform() |> Float.round(10)
large = :rand.uniform() * 10000

inputs = %{
  "Trivial | small precision" => {small, 1},
  "Medium | small precision" => {med, 1},
  "Large | small precision" => {large, 1},
  "Trivial | med precision" => {small, 5},
  "Medium | med precision" => {med, 5},
  "Large | med precision" => {large, 5},
  "Trivial | large precision" => {small, 12},
  "Medium | large precision" => {med, 12},
  "Large | large precision" => {large, 12}
}

Benchee.run(
  %{
    "built in" => fn {f, p} -> for _ <- 1..1000, do: Float.round(f, p) end,
    "io_lib" => fn {f, p} -> for _ <- 1..1000, do: Bench.Float.IoLib.round(f, p) end,
    "to binary" => fn {f, p} -> for _ <- 1..1000, do: Bench.Float.ToBin.round(f, p) end,
    "to list" => fn {f, p} -> for _ <- 1..1000, do: Bench.Float.ToList.round(f, p) end
  },
  inputs: inputs
)
