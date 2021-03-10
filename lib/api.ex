defmodule NarouEx.API do
  @moduledoc """
  API Interface to Shosetsuka-ni-naro
  API Documentation: https://dev.syosetu.com/man/api/
  """

  alias NarouEx.Models.{Work, Works}
  alias NarouEx.API.Queries

  @endpoint_url "https://api.syosetu.com/novelapi/api/"

  @doc """
  Fetch works list of specific user.

  ## Examples

    ```
    NarouEx.API.fetch_by_user(1623940)
    :ok,
    [
      %NarouEx.Models.Work{
        isr15: 0,
        biggenre: 4,
        updated_at: "2021-01-26 06:03:51",
        weekly_unique: 0,
        all_hyoka_cnt: 15,
        weekly_point: 0,
        story: "ポストアポカリプスSF百合ファンタジー\n\n今から300年ほど前のこと。\nこの惑星エミーラには高度な文明が築かれていました。人の必要とする殆どのものを生み出す自動工場、地球の反対側のことすら瞬時にわかるという通信網。人々の生活圏は惑星中を埋め尽くし、重力のくびきを脱そうとしつつありました。しかしそんな文明の絶頂期が長く続くことはなかったのです。\n\n長い黄昏の時代を経て、人々の暮らしは安定しつつあります。少なくとも恐ろしい暴走無人機が片端から人を殺そうとうろついてはいませんし、それらを討ち滅ぼすために軍隊が街ごと焦土に変えてしまうようなこともなくなりました。ただし、そんな機械や爆弾を作れるだけのわざ自体を忘れてもしまいましたが。\n\nそんな時代に彼女は生まれて、そして気がついてしまいました。私は、この世界で生きていくのに向いていない。\nとても恵まれた境遇に生まれたにもかかわらず、それでも彼女は思ってしまうのです。息苦しいと。彼女は苦し紛れにあがき、そして一つの希望を手にします。古代の力を今に取り戻す古術学者の道。古代、人々が貴族と平民とに分かたれず、誰もが平等に、そして豊かに暮らしていたとされる理想の時代。\n\n彼女のあこがれは世界を動かす複雑な歯車の動きとたまたま噛み合って、そして一つの出会いを生み出しました。人の力が今よりもずっと強かった時代、人が貪欲にその勢力圏を広げ、自分たち自身すらも征服しようとした努力の結晶、全自律無人機。人の姿をして、人のように語り、そして機械のように力強いもの。\n\n彼女たちの出会いが世界に何をもたらすのか。全自律無人機の高度な演算能力をもってすら、それは予測のできないことでした。\n\n特設サイトを公開しています。ショートPVなどもありますので、ご興味の方は是非ご覧ください。\nhttps://emilla.space",
        review_cnt: 0,
        isstop: 0,
        length: 222113,
        quarter_point: 16,
        keyword: "残酷な描写あり ガールズラブ 冒険 人工知能 シリアス 女主人公 アンドロイド ロボット 未来 人外 ポストアポカリプス",
        impression_cnt: 0,
        daily_point: 0,
        isbl: 0,
        general_firstup: "2019-04-26 23:23:28",
        writer: "壕野一廻",
        iszankoku: 1,
        genre: 403,
        title: "明ける世界の夢見る機械",
        sasie_cnt: 4,
        general_lastup: "2021-01-25 22:46:49",
        global_point: 326,
        pc_or_k: 2,
        ncode: "N7878FL",
        userid: 1623940,
        novel_type: 1,
        istenni: 0,
        isgl: 1,
        monthly_point: 2,
        yearly_point: 154,
        all_point: 144,
        novelupdated_at: "2021-01-25 22:46:49",
        fav_novel_cnt: 91,
        gensaku: "",
        kaiwaritsu: 49,
        istensei: 0,
        end: 1
      }
    ]
    ```
  """
  @spec fetch_by_user(Queries.user_id() | Queries.user_ids(), non_neg_integer() | 0) :: {:ok, list(Work.t())} | {:error, atom()}
  def fetch_by_user(user_id, cooldown_duration \\ 0) when is_integer(user_id) or is_list(user_id) and is_integer(cooldown_duration) do
    queries = %__MODULE__.Queries{} |> Queries.encode_userid(user_id)
    :timer.sleep(cooldown_duration)
    case queries |> generate_url() |> HTTPoison.get() do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, result} = body |> :zlib.gunzip() |> parse_body()
        {:ok, result}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, :not_found}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  @spec generate_url(__MODULE__.Queries.t()) :: String.t()
  defp generate_url(query_parameters) when is_struct(query_parameters, __MODULE__.Queries) do
    endpoint_uri = @endpoint_url
    |> URI.parse()
    queries = query_parameters |> Map.from_struct() |> URI.encode_query()
    %{endpoint_uri | query: queries }
    |> URI.to_string()
  end

  @spec parse_body(String.t()) :: {:ok, Works.t()} | {:error, atom()}
  defp parse_body(body) when is_bitstring(body) do
    case body |> Jason.decode() do
      {:ok, decoded_response} when is_list(decoded_response) ->
        result = decoded_response
        |> Enum.drop(1)
        |> Enum.map(&keys_to_atoms/1)
        |> Enum.map(&Work.from/1)
        {:ok, result}
      {:ok, _decoded_response} ->
        {:error, :unexpected_response_body}
      {:error, reason} ->
        IO.inspect reason
        {:error, reason}
    end
  end

  @spec keys_to_atoms(map()) :: {atom(), any()} | %{}
  defp keys_to_atoms(json) when is_map(json) do
    Map.new(json, &reduce_keys_to_atoms/1)
  end

  @spec reduce_keys_to_atoms({binary(), any()}) :: {atom(), any()}
  defp reduce_keys_to_atoms({key, val}) when is_map(val), do: {String.to_atom(key), keys_to_atoms(val)}
  defp reduce_keys_to_atoms({key, val}) when is_list(val), do: {String.to_atom(key), Enum.map(val, &keys_to_atoms(&1))}
  defp reduce_keys_to_atoms({key, val}), do: {String.to_atom(key), val}

end
