defmodule Scixir.Stats.Norm do
  import Nx.Constants
  import Nx.Defn
  alias Scixir.Utils

  def pdf(x, loc \\ 0, scale \\ 1) do
    Utils.generic_func(&pdf_nx/3, [x, loc, scale])
  end

  defnp pdf_nx(x, loc, scale) do
    pi = pi()
    expon = - Nx.pow((x - loc) / scale, 2) / 2
    denom = 1 / (scale * (2 * pi) ** 0.5)
    Nx.exp(expon) * denom
  end

  def cdf(x, loc \\ 0, scale \\ 1) do
    Utils.generic_func(&cdf_nx/3, [x, loc, scale])
  end

  defnp cdf_nx(x, loc, scale) do
    quoc = (x - loc) / (scale * Nx.sqrt(2))
    (1 + Nx.erf(quoc)) / 2
  end

  def ppf(q, loc \\ 0, scale \\ 1) do
    Utils.generic_func(&ppf_nx/3, [q, loc, scale])
  end

  defnp ppf_nx(q, loc, scale) do
    loc + scale * Nx.sqrt(2) * Nx.erf_inv(2 * q - 1) 
  end

  def logpdf(x, loc \\ 0, scale \\ 1) do
    pdf(x, loc, scale) |> Nx.log()
  end

  def logcdf(x, loc \\ 0, scale \\ 1) do
    cdf(x, loc, scale) |> Nx.log()
  end

  def sf(x, loc \\ 0, scale \\ 1) do
    Nx.subtract(1, cdf(x, loc, scale))
  end

  def isf(q, loc \\ 0, scale \\ 1) do
    Utils.generic_func(&isf_nx/3, [q, loc, scale])
  end

  defp isf_nx(q, loc, scale) do
    ppf(Nx.subtract(1, q), loc, scale)
  end

  defn entropy(_loc \\ 0, scale \\ 1) do
    Nx.log(2 * pi() * e() * scale ** 2) / 2 
  end

  defn mean(loc \\ 0, _scale \\ 1) do
    loc 
  end

  defn median(loc \\ 0, _scale \\ 1) do
    loc
  end

  defn var(_loc \\ 0, scale \\ 1) do
    scale ** 2
  end

  defn std(_loc \\ 0, scale \\ 1) do
    scale
  end 
end
