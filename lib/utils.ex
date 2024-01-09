defmodule Scixir.Utils do
<<<<<<< HEAD
  def generic_func(func, x, opt) when is_list(x) do
    func.(Nx.tensor(x), opt)
=======

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
>>>>>>> refs/remotes/origin/main
  end

end
