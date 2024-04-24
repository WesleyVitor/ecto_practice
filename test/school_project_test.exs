defmodule SchoolProjectTest do
  use ExUnit.Case
  doctest SchoolProject

  test "greets the world" do
    assert SchoolProject.hello() == :world
  end
end
