defmodule Scixir.Stats.Normal do
  import Nx.Constants
  import Nx.Defn

  @spec pdf([number], number, number) :: number
  defn pdf(x, mu \\ 0, sigma \\ 1) do
    x = Nx.tensor(x)
    pi = pi()
    expon = - Nx.pow((x - mu) / sigma, 2) / 2
    denom = 1 / (sigma * (2 * pi) ** 0.5)
    Nx.exp(expon) * denom
  end


  defn cdf(x, mu \\ 0, sigma \\ 1) do
    x = Nx.tensor(x)
    quoc = (x - mu) / (sigma * Nx.sqrt(2))
    (1 + Nx.erf(quoc)) / 2
  end

  defn ppf(q, mu \\ 0, sigma \\ 1) do
    q = Nx.tensor(q)
    mu + sigma * Nx.sqrt(2) * Nx.erf_inv(2 * q - 1) 
  end

  defn logpdf(x, mu \\ 0, sigma \\ 1) do
    pdf(x, mu, sigma) |> Nx.log()
  end

  defn logcdf(x, mu \\ 0, sigma \\ 1) do
    cdf(x, mu, sigma) |> Nx.log()
  end

  defn sf(x, mu \\ 0, sigma \\ 1) do
    1 - cdf(x, mu, sigma)
  end

  defn isf(q, mu \\ 0, sigma \\ 1) do
    q = Nx.tensor(q)
    ppf(1 - q, mu, sigma)
  end

  defn entropy(_mu \\ 0, sigma \\ 1) do
    Nx.log(2 * pi() * e() * sigma ** 2) / 2 
  end

  defn mean(mu \\ 0, _sigma \\ 1) do
    mu
  end

  defn median(mu \\ 0, _sigma \\ 1) do
    mu
  end

  defn var(_mu \\ 0, sigma \\ 1) do
    sigma ** 2
  end

  defn std(_mu \\ 0, sigma \\ 1) do
    sigma
  end 

end
