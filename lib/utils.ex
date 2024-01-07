defmodule Scixir.Utils do
  def generic_func(func, x, loc, scale) when is_list(x) do
    func.(Nx.tensor(x), loc, scale)
  end

  def generic_func(func, x, loc, scale) do
    func.(x, loc, scale)
  end
end
