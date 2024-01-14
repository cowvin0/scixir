defmodule Scixir.Stats.Uniform do
  import Nx.Defn
  alias alias Scixir.Utils

  def pdf(x, loc \\ 0, scale \\ 1), do: Utils.generic_func(&pdf_nx/3, [x, loc, scale])

  defnp pdf_nx(x, loc, scale) do
    if x < loc or x > scale do
      0
    else
      1 / (scale - loc)
    end
  end

  def cdf(x, loc \\ 0, scale \\ 1)
  def cdf(x, loc, scale) when x >= loc and x <= scale, do: Utils.generic_func(&cdf_nx/3, [x, loc, scale])
  def cdf(x, loc, _scale) when x < loc, do: 0
  def cdf(x, _loc, scale) when x > scale, do: 1

  defnp cdf_nx(x, loc, scale), do: (x - loc) / (scale - loc)

  def ppf(q, loc \\ 0, scale \\ 1), do: Utils.generic_func(&ppf_nx/3, [q, loc, scale])

  defnp ppf_nx(q, loc, scale), do: loc + q * (scale - loc)

  def logpdf(x, loc \\ 0, scale \\ 1), do: pdf(x, loc, scale) |> Nx.log()

  def logcdf(x, loc \\ 0, scale \\ 1), do: cdf(x, loc, scale) |> Nx.log()

  def sf(x, loc \\ 0, scale \\ 1), do: Nx.subtract(1, cdf(x, loc, scale))

  def isf(q, loc \\ 0, scale \\ 1), do: Utils.generic_func(&isf_nx/3, [q, loc, scale])

  defn isf_nx(q, loc \\ 0, scale \\ 1), do: (1 - q) * (scale - loc)

  defn entropy(loc \\ 0, scale \\ 1), do: Nx.log(scale - loc)

  defn mean(loc \\ 0, scale \\ 1), do: (scale + loc) / 2

  defn median(loc \\ 0, scale \\ 1), do: mean(loc, scale)

  defn var(loc \\ 0, scale \\ 1), do: ((scale - loc) ** 2) / 12


  defn std(loc \\ 0, scale \\ 1), do: Nx.sqrt(var(loc, scale))

end
