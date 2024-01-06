defmodule Scixir.Stats.Gompertz do
  import Nx.Defn

  @spec pdf([number], number, number) :: number
  defn pdf(x, a \\ 1, b \\ 1) do
    # a e^(bx - a/b * (e^bx - 1))
    x = Nx.tensor(x)
    bx = b * x
    exp_inner = Nx.exp(bx) - 1
    exp_outer = Nx.exp(bx - a / b * exp_inner)
    a * exp_outer
  end

  @spec logpdf([number], number, number) :: number
  defn logpdf(x, a \\ 1, b \\ 1) do
    # ln(a) + bx - a/b * (e^bx - 1)
    x = Nx.tensor(x)
    bx = b * x
    exp_inner = Nx.exp(bx) - 1
    Nx.log(a) + bx - a / b * exp_inner
  end

  @spec cdf([number], number, number) :: number
  defn cdf(x, a \\ 1, b \\ 1) do
    # 1 - e^(-a/b * (e^bx - 1))
    # -expm1(-a/b * (e^bx - 1))
    x = Nx.tensor(x)
    exp_inner = Nx.exp(b * x) - 1
    -Nx.expm1(-a / b * exp_inner)
  end

  @spec logcdf([number], number, number) :: number
  defn logcdf(x, a \\ 1, b \\ 1) do
    # ln(1 - e^(-a/b * (e^bx - 1)))
    # log1p(-e^(-a/b * (e^bx - 1)))
    x = Nx.tensor(x)
    exp_inner = Nx.exp(b * x) - 1
    exp_outer = Nx.exp(-a / b * exp_inner)
    Nx.log1p(-exp_outer)
  end

  @spec sf([number], number, number) :: number
  defn sf(x, a \\ 1, b \\ 1) do
    # e^(-a/b * (e^bx - 1))
    x = Nx.tensor(x)
    exp_inner = Nx.exp(b * x) - 1
    Nx.exp(-a / b * exp_inner)
  end

  @spec logsf([number], number, number) :: number
  defn logsf(x, a \\ 1, b \\ 1) do
    # -a/b * (e^bx - 1)
    x = Nx.tensor(x)
    exp_inner = Nx.exp(b * x) - 1
    -a / b * exp_inner
  end

  @spec ppf([number], number, number) :: number
  defn ppf(x, a \\ 1, b \\ 1) do
    # 1/b * ln(1 - b/a * ln(1 - x))
    # 1/b * log1p(-b/a * ln(1 - x))
    x = Nx.tensor(x)
    ln_inner = Nx.log(1 - x)
    ln_outer = Nx.log1p(-b / a * ln_inner)
    ln_outer / b
  end

  @spec isf([number], number, number) :: number
  defn isf(x, a \\ 1, b \\ 1) do
    # 1/b * ln(1 - b/a * ln(x))
    # 1/b * log1p(-b/a * ln(x))
    x = Nx.tensor(x)
    ln_inner = Nx.log(x)
    ln_outer = Nx.log1p(-b / a * ln_inner)
    ln_outer / b
  end

  @spec median(number, number) :: number
  defn median(a \\ 1, b \\ 1) do
    # 1/b * ln(1 + b/a * ln2)
    # 1/b * log1p(b/a * ln2)
    ln_outer = Nx.log1p(b / a * Nx.log(2))
    ln_outer / b
  end
end
