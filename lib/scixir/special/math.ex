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

  @spec log(number(), number()) :: float()
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

  @spec exp(number) :: number
  defdelegate exp(x), to: :math

  @spec sqrt(number) :: number
  defdelegate sqrt(x), to: :math

  @spec gamma(number) :: number
  def gamma(x) do

    g = 7
    p = [
        0.99999999999980993,
        676.5203681218851,
        -1259.1392167224028,
        771.32342877765313,
        -176.61502916214059,
        12.507343278686905,
        -0.13857109526572012,
        9.9843695780195716e-6,
        1.5056327351493116e-7
    ]

    if x < 0.5 do
      pi() / (:math.sin(pi() * x) * gamma(1 - x))

    else 
      z = x - 1
      xs = for i <- 1..8, do: Enum.at(p, i) / (z + i)
      x = Enum.at(p, 0) + Enum.sum(xs)
      t = z + g + 0.5
      sqrt(2 * pi()) * pow(t, z + 0.5) * exp(-1 * t) * x 
    end
  end

  @spec beta(number, number) :: number
  def beta(a, b) do
    gamma(a) * gamma(b) / gamma(a + b)
  end

end
