defmodule NarouExTest do
  use ExUnit.Case
  doctest NarouEx

  test "greets the world" do
    assert NarouEx.hello() == :world
  end
end
