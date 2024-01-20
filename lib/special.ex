defmodule Scixir.Special do
  import Nx.Constants
  import Nx.Defn
  alias Scixir.Utils

  def gamma(x) do
    Utils.generic_func(&gamma_nx/1, [x])
  end

  defnp gamma_nx(x) do
    x = Nx.as_type(x, :f64)

    which_x = fn x_less -> 
      g = 7 |> Nx.as_type(:f64)

      p = Nx.tensor([
          0.99999999999980993,
          676.5203681218851,
          -1259.1392167224028,
          771.32342877765313,
          -176.61502916214059,
          12.507343278686905,
          -0.13857109526572012, 9.9843695780195716e-6,
          1.5056327351493116e-7
      ], type: :f64)

      z = x_less - 1
      xs = 
        while acc = Nx.as_type(0.0, :f64), i <- Nx.linspace(1, 8, n: 8, type: :u8), unroll: true do
          acc + p[i] / (z + i) 
        end
      
      t = z + g + 0.5
      x_less = p[0] + xs
      over = (z + 0.5) * Nx.log(t) - t + Nx.log(x_less)

      Nx.sqrt(2 * pi()) * Nx.exp(over)
    end

    if x < 0.5 do
      pi() / (Nx.sin(pi() * x) * which_x.(1 - x))
    else
      which_x.(x)
    end
  end

  def lgamma(x) do
    Utils.generic_func(&gamma_nx/1, [x])
  end

  defnp lgamma_nx(x) do
    x = Nx.as_type(x, :f64)

    which_x = fn x_less -> 
      g = 7 |> Nx.as_type(:f64)

      p = Nx.tensor([
          0.99999999999980993,
          676.5203681218851,
          -1259.1392167224028,
          771.32342877765313,
          -176.61502916214059,
          12.507343278686905,
          -0.13857109526572012, 9.9843695780195716e-6,
          1.5056327351493116e-7
      ], type: :f64)

      z = x_less - 1
      xs = 
        while acc = Nx.as_type(0.0, :f64), i <- Nx.linspace(1, 8, n: 8, type: :u8), unroll: true do
          acc + p[i] / (z + i) 
        end
      
      t = z + g + 0.5
      x_less = p[0] + xs
      over = (z + 0.5) * Nx.log(t) - t + Nx.log(x_less)

      0.5 * Nx.log(2 * pi()) + over
    end

    if x < 0.5 do
      Nx.log(pi()) - Nx.log(Nx.sin(pi() * x)) - which_x.(1 - x)
    else
      which_x.(x)
    end
  end

  @spec beta(number, number) :: number
  def beta(a, b) do
    beta_nx(a, b)
  end

  defn beta_nx(a, b) do
    lgamma_nx(a)
    |> Nx.add(lgamma_nx(b))
    |> Nx.subtract(lgamma_nx(a + b))
    |> Nx.exp()
  end

end
