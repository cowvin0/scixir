defmodule Scixir.Utils do

  def generic_func(func, args) do
    args = Enum.map(args, fn x -> 
      cond do
        is_list(x) -> 
          Nx.tensor(x)
        true -> 
          x
      end
    end)
    apply(func, args)
  end

end
