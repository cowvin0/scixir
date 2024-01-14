defmodule Scixir.Special do
  import Nx.Constants
  import Nx.Defn
  alias Scixir.Utils

  def gamma(x) do
    Utils.generic_func(&gamma_nx/1, [x])
  end

  defnp gamma_nx(x) do

    g = 7

    p = Nx.tensor([
        0.99999999999980993,
        676.5203681218851,
        -1259.1392167224028,
        771.32342877765313,
        -176.61502916214059,
        12.507343278686905,
        -0.13857109526572012,
        9.9843695780195716e-6,
        1.5056327351493116e-7
    ])

    result = 
      while acum = 0, i <- x, unroll: true do
        
      end

    if x < 0.5 do
      pi() / (Nx.sin(pi() * x) * gamma_nx(1 - x))
    else
      z = x - 1
      xs = while acc = 0.0, i <- Nx.linspace(1, 8, n: 8, type: :u8), unroll: true do
        acc + p[i] / (z + i)
      end
      x = p[0] + xs
      t = z + g + 0.5
      Nx.sqrt(2 * pi()) * Nx.pow(t, z + 0.5) * Nx.exp(- 1 * t) * x
    end
  end


  @spec beta(number, number) :: number
  def beta(a, b) do
    gamma(a) * gamma(b) / gamma(a + b)
  end

end
