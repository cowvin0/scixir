defmodule Scixir.Utils do
  def generic_func(func, x, opt) when is_list(x) do
    func.(Nx.tensor(x), opt)
  end

  def generic_func(func, x, loc, scale) do
    func.(x, loc, scale)
  end
end
