defmodule Scixir.Special do
  import Nx.Defn
  import Nx.Constants

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
      pi() / (Nx.sin(pi() * x) * gamma(1 - x))

    else 
      z = x - 1
      xs = for i <- 1..8, do: Enum.at(p, i) / (z + i)
      x = Enum.at(p, 0) + Enum.sum(xs)
      t = z + g + 0.5
      Nx.sqrt(2 * pi()) * Nx.pow(t, z + 0.5) * Nx.exp(-1 * t) * x 
    end
  end

  @spec beta(number, number) :: number
  def beta(a, b) do
    gamma(a) * gamma(b) / gamma(a + b)
  end

end
