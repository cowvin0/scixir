# defmodule Scixir.Stats.Bernoulli do
#   import Nx.Defn
#   alias Scixir.Utils

#   def pdf(k, p, loc) do
#     Utils.generic_func(&pdf_nx/3, [x, loc, scale])
#   end

#   defnp pdf_nx(x, loc, scale) do
#     pi = pi()
#     expon = - Nx.pow((x - loc) / scale, 2) / 2
#     denom = 1 / (scale * (2 * pi) ** 0.5)
#     Nx.exp(expon) * denom
#   end

# end
