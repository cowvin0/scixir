defmodule Scixir.Math do

  @spec pow(number, number) :: number

  def pow(_, 0), do: 1
  def pow(0, exponent) when exponent >= 0, do : 0

  def pow(base, exponent) when base <= 0 and is_float(exponent) do
    :math.pow(-base, exponent) * -1
    end

  defdelegate pow(base, exponent), to: :math

end
