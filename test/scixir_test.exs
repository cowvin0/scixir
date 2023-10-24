defmodule ScixirTest do
  use ExUnit.Case
  doctest Scixir

  test "greets the world" do
    assert Scixir.hello() == :world
  end
end
