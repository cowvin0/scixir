defmodule Scixir.Distributions do
  alias Scixir.Math

  def pdf_norm(x, mu, sd) do
    pi = :math.pi()
    expon = - Math.pow((x - mu) / sd, 2) / 2
    denom = 1 / (sd * Math.pow(2 * pi, 0.5))
    :math.exp(expon) * denom
  end

  def pdf_gamma(x, alpha, beta) do 
  end
end