defmodule NarouExTest.Models.WorkTest do
  use ExUnit.Case
  alias NarouEx.Models.Work
  doctest Work

  @reference_map %{
    kaiwaritsu: 13,
    userid: 1,
    general_lastup: nil,
    updated_at: nil,
    novelupdated_at: nil,
    general_firstup: nil
  }

  @reference_work %Work{
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

  describe "from/1 with map attribute" do
    test "returns Work struct" do
      sut = @reference_map |> Work.from()
      assert sut |> is_struct(Work)
    end

    test "generated work has map-defined-values" do
      sut = @reference_map |> Work.from()
      expected = @reference_work
      assert sut == expected
    end
  end

  describe "from/1 with unexpected type" do
    test "Raise error(string)" do
      sut = fn () -> "a" |> Work.from() end
      assert_raise FunctionClauseError, sut
    end

    test "Raise error(list)" do
      sut = fn () -> [:hoge] |> Work.from() end
      assert_raise FunctionClauseError, sut
    end

    test "Raise error(tuple)" do
      sut = fn () -> {:hoge} |> Work.from() end
      assert_raise FunctionClauseError, sut
    end

    test "Raise error(charlist)" do
      sut = fn () -> 'a' |> Work.from() end
      assert_raise FunctionClauseError, sut
    end
  end
end
