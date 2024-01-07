defmodule Scixir.Stats.Gompertz do
  import Nx.Defn
  alias Scixir.Utils

  def pdf(x, loc \\ 0, scale \\ 1) do
    Utils.generic_func(&pdf_nx/3, x, loc, scale)
  end

  defn pdf_nx(x, loc, scale) do
    scalex = scale * x
    exp_inner = Nx.exp(scalex) - 1
    exp_outer = Nx.exp(scalex - loc / scale * exp_inner)
    loc * exp_outer
  end

  @spec logpdf([number], number, number) :: number
  defn logpdf(x, loc \\ 1, scale \\ 1) do
    x = Nx.tensor(x)
    scalex = scale * x
    exp_inner = Nx.exp(scalex) - 1
    Nx.log(loc) + scalex - loc / scale * exp_inner
  end

  @spec cdf([number], number, number) :: number
  defn cdf(x, loc \\ 1, scale \\ 1) do
    x = Nx.tensor(x)
    exp_inner = Nx.exp(scale * x) - 1
    -Nx.expm1(-loc / scale * exp_inner)
  end

  @spec logcdf([number], number, number) :: number
  defn logcdf(x, loc \\ 1, scale \\ 1) do
    x = Nx.tensor(x)
    exp_inner = Nx.exp(scale * x) - 1
    exp_outer = Nx.exp(-loc / scale * exp_inner)
    Nx.log1p(-exp_outer)
  end

  @spec sf([number], number, number) :: number
  defn sf(x, loc \\ 1, scale \\ 1) do
    x = Nx.tensor(x)
    exp_inner = Nx.exp(scale * x) - 1
    Nx.exp(-loc / scale * exp_inner)
  end

  @spec logsf([number], number, number) :: number
  defn logsf(x, loc \\ 1, scale \\ 1) do
    x = Nx.tensor(x)
    exp_inner = Nx.exp(scale * x) - 1
    -loc / scale * exp_inner
  end

  @spec ppf([number], number, number) :: number
  defn ppf(x, loc \\ 1, scale \\ 1) do
    x = Nx.tensor(x)
    ln_inner = Nx.log(1 - x)
    ln_outer = Nx.log1p(-scale / loc * ln_inner)
    ln_outer / scale 
  end

  @spec isf([number], number, number) :: number
  defn isf(x, loc \\ 1, scale \\ 1) do
    x = Nx.tensor(x)
    ln_inner = Nx.log(x)
    ln_outer = Nx.log1p(-scale / loc * ln_inner)
    ln_outer / scale 
  end

  @spec median(number, number) :: number
  defn median(loc \\ 1, scale \\ 1) do
    ln_outer = Nx.log1p(scale / loc * Nx.log(2))
    ln_outer / scale
  end
end
