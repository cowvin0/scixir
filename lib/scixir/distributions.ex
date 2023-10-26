defmodule Scixir.Distributions do
  alias Scixir.Math

  def pdf_norm(x, mu, sd) do
    pi = :math.pi()
    expon = - Math.pow((x - mu) / sd, 2)) / 2 
    denom = 1 / (pi * Math.pow(2 * pi, 0.5))
    :math.e(expon) * denom
  end
end
