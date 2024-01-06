defmodule Scixir.Special do
  @e :math.exp(1)
  @pi :math.pi()

  @spec pow(number, number) :: number

  def pow(_, 0), do: 1
  def pow(0, exponent) when exponent >= 0, do: 0

  def pow(base, exponent) when base <= 0 and is_float(exponent) do
    :math.pow(-base, exponent) * -1
    end

  defdelegate pow(base, exponent), to: :math

  @spec e() :: number
  def e() do
    @e
  end

  @spec pi() :: number
  def pi() do
    @pi
  end

  def log(x, base \\ e()) do
    log_local(x, base)
  end

  def log1p(x, base \\ e()) do
    log_local(1 + x, base)
  end

  defp log_local(x, base) when x <= 0 or base == 1 or base < 0 do
    raise ArithmeticError, message: "x and base must be positive and base different of 1"
  end

  defp log_local(x, base) do
    :math.log10(x) / :math.log10(base)
  end

  defdelegate exp(x), to: :math

end
