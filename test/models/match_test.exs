defmodule Melo.MatchTest do
  use Melo.ModelCase

  alias Melo.Match

  @valid_attrs %{away_score: 42, date: %{day: 17, month: 4, year: 2010}, home_score: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Match.changeset(%Match{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Match.changeset(%Match{}, @invalid_attrs)
    refute changeset.valid?
  end
end
