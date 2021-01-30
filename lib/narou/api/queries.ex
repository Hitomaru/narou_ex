defmodule NarouEx.Narou.API.Queries do
  @default_response_format :json
  defstruct(
    gzip: 5,
    out: @default_response_format,
    of: nil,
    lim: 20,
    st: 1,
    opt: :weekly,
    order: :new,
    userid: nil
  )

  @typep of_element() :: :t |
    :n  | :u  | :w  | :s  | :bg | :g  | :k  | :gf | :gl |
    :nt | :e  | :ga | :l  | :ti | :i  | :ir | :ib | :ig |
    :iz | :it | :it | :p  | :gp | :dp | :wp | :mp | :qp |
    :yp | :f  | :im | :r  | :a  | :ah | :sa | :ka | :nu |
    :ua


  @typep order_element :: :new |
    :favnovelcnt | :reviewcnt | :hyoka | :hyokaasc |
    :dailypoint | :weeklypoint | :monthlypoint | :quarterpoint |
    :yearlypoint | :impressioncnt | :hyokacnt | :hyokacntasc |
    :weekly | :lengthdesc | :lengthasc | :ncodedesc |
    :old

  @typep opt_element :: :weekly

  @typep output_format :: :yaml | :json | :php

  @type t() :: %__MODULE__{
    gzip: 1..5 | nil,
    out: output_format(),
    of: String.t() | nil,
    lim: 1..500,
    st: 1..2000,
    opt: opt_element() | nil,
    order: order_element(),
    userid: integer() | nil
  }

  @spec encode_of(__MODULE__.t(), list(of_element())) :: __MODULE__.t()
  def encode_of(queries, of_elements) when is_struct(queries, __MODULE__) and is_list(of_elements) do
    of_string = of_elements
    |> Enum.map(&Atom.to_string()/1)
    |> Enum.join("-")
    %{queries | of: of_string}
  end
end
