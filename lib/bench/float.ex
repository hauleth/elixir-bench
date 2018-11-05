defmodule Bench.Float do
  defmodule IoLib do
    def round(float, 0) when is_float(float), do: :erlang.round(float) |> :erlang.float()

    def round(float, precision) when is_float(float) and precision in 1..15 do
      str = :io_lib.format('~.*f', [precision, float])

      :erlang.list_to_float(str)
    end
  end

  defmodule ToBin do
    def round(float, 0) when is_float(float), do: :erlang.round(float) |> :erlang.float()

    def round(float, precision) when is_float(float) and precision in 1..15 do
      str = :erlang.float_to_binary(float, decimals: precision)

      :erlang.binary_to_float(str)
    end
  end

  defmodule ToList do
    def round(float, 0) when is_float(float), do: :erlang.round(float) |> :erlang.float()

    def round(float, precision) when is_float(float) and precision in 1..15 do
      str = :erlang.float_to_list(float, decimals: precision)

      :erlang.list_to_float(str)
    end
  end
end
