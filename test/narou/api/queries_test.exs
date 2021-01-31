defmodule NarouExTest.Narou.API.QueriesTest do
  use ExUnit.Case
  alias NarouEx.Narou.API.Queries
  doctest Queries

  @reference_user_id 1
  @reference_user_ids [1, 2, 3, 4]
  @reference_user_ids_concatenated "1-2-3-4"

  describe "encode_userid/2 when user_id is integer" do
    test "returns Queries struct" do
      sut = %Queries{} |> Queries.encode_userid(@reference_user_id)
      assert sut |> is_struct(Queries)
    end

    test "returned Queries userid should be changed as 2nd attr" do
      sut = %Queries{} |> Queries.encode_userid(@reference_user_id)
      assert sut.userid == Integer.to_string(@reference_user_id)
    end

    test "Do not change Queries except userid" do
      sut = %Queries{} |> Queries.encode_userid(@reference_user_id)
      expected = %Queries{userid: Integer.to_string(@reference_user_id)}
      assert sut == expected
    end
  end

  describe "encode_userid/2 when user_id is list<integer>" do
    test "returns Queries struct" do
      sut = %Queries{} |> Queries.encode_userid(@reference_user_ids)
      assert sut |> is_struct(Queries)
    end

    test "returned Queries userid should be changed as 2nd attr" do
      sut = %Queries{} |> Queries.encode_userid(@reference_user_ids)
      assert sut.userid == @reference_user_ids_concatenated
    end

    test "Do not change Queries except userid" do
      sut = %Queries{} |> Queries.encode_userid(@reference_user_ids)
      expected = %Queries{userid: @reference_user_ids_concatenated}
      assert sut == expected
    end
  end

  describe "encode_userid/2 when user_id is unexpected type" do
    test "Raise error(string)" do
      sut = fn () -> %Queries{} |> Queries.encode_userid(Integer.to_string(@reference_user_id)) end
      assert_raise FunctionClauseError, sut
    end

    test "Raise error(map)" do
      sut = fn () -> %Queries{} |> Queries.encode_userid(%{hoge: :hige}) end
      assert_raise FunctionClauseError, sut
    end

    test "Raise error(tuple)" do
      sut = fn () -> %Queries{} |> Queries.encode_userid({:hoge}) end
      assert_raise FunctionClauseError, sut
    end

    test "Raise error(charlist)" do
      sut = fn () -> %Queries{} |> Queries.encode_userid({'1'}) end
      assert_raise FunctionClauseError, sut
    end
  end

end
