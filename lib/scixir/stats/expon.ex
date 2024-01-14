defmodule Scixir.Stats.Expon do
  import Nx.Constants
  import Nx.Defn
  alias Scixir.Utils

  def pdf(x, loc \\ 0, scale \\ 1) do
    Utils.generic_func(&pdf_nx/3, [x, loc, scale])
  end

  defn pdf_nx(x, loc, scale) do
    if x >= 0 do
      y = (x - loc) / scale
      Nx.exp(- y) / scale
    else
      0
    end
  end

  def cdf(x, loc \\ 0, scale \\ 1) do
    Utils.generic_func(&cdf_nx/3, [x, loc, scale])
  end

  defn cdf_nx(x, loc \\ 0, scale \\ 1) do
    if Nx.greater_equal(x, 0) do
      y = (x - loc) / scale
      1 - Nx.exp(- y)
    else
      0
    end
  end

  def ppf(q, loc \\ 1, scale \\ 1) do
    Utils.generic_func(&ppf_nx/3, [q, loc, scale])
  end

  defn ppf_nx(q, loc, scale) do
    - scale * Nx.log(1 - q) + loc
  end

  def logpdf(x, loc \\ 0, scale \\ 1) do
    pdf(x, loc, scale) |> Nx.log()
  end

  def logcdf(x, loc \\ 0, scale \\ 1) do
    cdf(x, loc, scale) |> Nx.log()
  end

  def sf(x, loc \\ 0, scale \\ 1) do
    if x > loc do
      Nx.subtract(1, cdf(x, loc, scale))
    else
      1
    end
  end

  def isf(q, loc \\ 0, scale \\ 1) do
    Utils.generic_func(&isf_nx/3, [q, loc, scale])
  end

  defn isf_nx(q, loc, scale) do
    - scale * Nx.log(q) + loc
  end

  defn entropy(_loc \\ 0, scale \\ 1) do
    1 + Nx.log(scale)
  end

  defn mean(loc \\ 0, scale \\ 1) do
    scale + loc
  end

  defn median(loc \\ 0, scale \\ 1) do
    Nx.log(2) * scale + loc
  end

  defn var(_loc \\ 0, scale \\ 1) do
    scale ** 2
  end
  
  defn std(_loc \\ 0, scale \\ 1) do
    scale
  end
end
