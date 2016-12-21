defmodule DexyPluginJson do

  use DexyLib
  alias DexyLib.Mappy
  alias DexyLib.JSON

  def encode state = %{args: []} do do_encode state, data!(state) end
  def encode state = %{args: [data]} do do_encode state, data end

  defp do_encode(state = %{opts: opts}, data) when not is_tuple(data) do
    res = data
      |> encode_opts(Map.to_list opts)
      |> JSON.encode!
    {state, res}
  end 
  
  defp encode_opts(data, opts) do
    Enum.reduce opts, data, fn {key, val}, acc ->
      do_encode_opts({key, val}, acc)
    end
  end

  defp do_encode_opts({"strip", val}, data) when is_map(data) do
    cnt = case val do
      "" -> 1
      n -> DexyLib.to_number n, 1
    end
    Enum.reduce(1..cnt, data, fn
      (_, acc) when is_map(acc) ->
        case Enum.at acc, 0 do 
          {_key, val} -> val
          nil -> acc
        end
      (_, acc) ->
        acc
    end)
  end

  defp do_encode_opts({"wrap", val}, data) do
    Map.put(%{}, val, data)
  end

  defp do_encode_opts(_, data), do: data

  def decode state = %{args: []} do do_decode state, data!(state) end
  def decode state = %{args: [data]} do do_decode state, data end

  defp do_decode(state, data) when is_bitstring(data) do
    {state, JSON.decode! data}
  end

  defp data! %{mappy: map} do
    Mappy.val map, "data", nil
  end

end
