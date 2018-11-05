defmodule Bench.FloatTest do
  use ExUnit.Case
  use ExUnitProperties

  cases = [
    {0.1, 0},
    {0.4, 0},
    {0.5, 0},
    {0.9, 0},
    {0.49, 0},
    {0.0, 0},
    {0.01, 1},
    {0.04, 1},
    {0.05, 1},
    {0.09, 1},
    {0.049, 1},
    {0.00, 1},
    {0.0000000000000001, 15},
    {0.0000000000000004, 15},
    {0.00000000000000049, 15},
    {0.0000000000000005, 15},
    {0.0000000000000009, 15},
    {0.00000000000000001, 15},
    {0.00000000000000004, 15},
    {0.000000000000000049, 15},
    {0.00000000000000005, 15},
    {0.00000000000000009, 15},
    {12.3415, 3}
  ]

  for {f, p} <- cases do
    test "return the same as built in for #{f} and -#{f} with precision #{p}" do
      f = unquote(f)
      p = unquote(p)
      assert Float.round(f, p) == Bench.Float.IoLib.round(f, p)
      assert Float.round(-f, p) == Bench.Float.IoLib.round(-f, p)

      assert Float.round(f, p) == Bench.Float.ToList.round(f, p)
      assert Float.round(-f, p) == Bench.Float.ToList.round(-f, p)

      assert Float.round(f, p) == Bench.Float.ToBin.round(f, p)
      assert Float.round(-f, p) == Bench.Float.ToBin.round(-f, p)
    end
  end

  property "Float.round and Bench.Float.round works in the same way" do
    check all f <- float(),
              p <- integer(0..15) do
      assert Float.round(f, p) == Bench.Float.IoLib.round(f, p)
      assert Float.round(f, p) == Bench.Float.ToList.round(f, p)
      assert Float.round(f, p) == Bench.Float.ToBin.round(f, p)
    end
  end
end
