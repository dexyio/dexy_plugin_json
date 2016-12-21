defmodule DexyPluginJsonTest do

  use ExUnit.Case
  use DexyLib
  alias DexyPluginJson, as: JSON

  doctest DexyPluginJson

  test "the truth" do
    assert {_, "true"} = JSON.encode %{args: [true], opts: %{}}
    assert {_, "false"} = JSON.encode %{args: [false], opts: %{}}
    assert {_, "null"} = JSON.encode %{args: [nil], opts: %{}}
    assert {_, "1"} = JSON.encode %{args: [1], opts: %{}}
  end

end
