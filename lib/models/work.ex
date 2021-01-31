defmodule NarouEx.Models.Work do
  defstruct(
    novel_type: 0,
    fav_novel_cnt: 0,
    title: "",
    monthly_point: 0,
    biggenre: 0,
    yearly_point: 0,
    istensei: 0,
    isgl: 0,
    isbl: 0,
    writer: "",
    end: 0,
    genre: 0,
    novelupdated_at: DateTime.utc_now(),
    impression_cnt: 0,
    general_firstup: DateTime.utc_now(),
    isstop: 0,
    weekly_point: 0,
    userid: 0,
    pc_or_k: 0,
    story: "",
    review_cnt: 0,
    kaiwaritsu: 49,
    gensaku: "",
    all_point: 0,
    quarter_point: 0,
    keyword: "",
    global_point: 0,
    iszankoku: 0,
    daily_point: 0,
    isr15: 0,
    sasie_cnt: 0,
    istenni: 0,
    all_hyoka_cnt: 15,
    updated_at: DateTime.utc_now(),
    general_lastup: DateTime.utc_now(),
    ncode: "N0000FL",
    length: 0,
    weekly_unique: 0
    )

    @type t() :: %__MODULE__{
      novel_type: Integer.t(),
      fav_novel_cnt: Integer.t(),
      title: String.t(),
      monthly_point: Integer.t(),
      biggenre: Integer.t(),
      yearly_point: Integer.t(),
      istensei: Boolean.t(),
      isgl: Boolean.t(),
      isbl: Boolean.t(),
      writer: String.t(),
      end: Integer.t(),
      genre: Integer.t(),
      novelupdated_at: DateTime.utc_now(),
      impression_cnt: 0,
      general_firstup: DateTime.utc_now(),
      isstop: Boolean.t(),
      weekly_point: Integer.t(),
      userid: Integer.t(),
      pc_or_k: Integer.t(),
      story: String.t(),
      review_cnt: Integer.t(),
      kaiwaritsu: Integer.t(),
      gensaku: String.t(),
      all_point: Integer.t(),
      quarter_point: Integer.t(),
      keyword: String.t(),
      global_point: Integer.t(),
      iszankoku: Boolean.t(),
      daily_point: Integer.t(),
      isr15: Boolean.t(),
      sasie_cnt: Integer.t(),
      istenni: Boolean.t(),
      all_hyoka_cnt: Integer.t(),
      updated_at: DateTime.utc_now(),
      general_lastup: DateTime.utc_now(),
      ncode: String.t(),
      length: Integer.t(),
      weekly_unique: Integer.t()
    }

    @doc """

    ## Examples

    ```
    iex> %{
    ...>  kaiwaritsu: 13,
    ...>  userid: 1,
    ...>  general_lastup: nil,
    ...>  updated_at: nil,
    ...>  novelupdated_at: nil,
    ...>  general_firstup: nil
    ...>  } |> NarouEx.Models.Work.from()
    %NarouEx.Models.Work{
      isgl: 0,
      global_point: 0,
      writer: "",
      pc_or_k: 0,
      title: "",
      isstop: 0,
      userid: 1,
      quarter_point: 0,
      genre: 0,
      iszankoku: 0,
      istensei: 0,
      sasie_cnt: 0,
      kaiwaritsu: 13,
      all_hyoka_cnt: 15,
      general_lastup: nil,
      length: 0,
      fav_novel_cnt: 0,
      ncode: "N0000FL",
      keyword: "",
      weekly_point: 0,
      impression_cnt: 0,
      biggenre: 0,
      gensaku: "",
      isr15: 0,
      all_point: 0,
      end: 0,
      yearly_point: 0,
      istenni: 0,
      updated_at: nil,
      review_cnt: 0,
      monthly_point: 0,
      daily_point: 0,
      weekly_unique: 0,
      story: "",
      novel_type: 0,
      novelupdated_at: nil,
      isbl: 0,
      general_firstup: nil
    }
    ```

    """
    @spec from(map()) :: __MODULE__.t()
    def from(map) when is_map(map) do
      struct(__MODULE__, map)
    end
end
