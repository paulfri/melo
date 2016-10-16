defmodule Melo.TeamSeasonTest do
  use Melo.ModelCase

  alias Melo.TeamSeason

  @valid_attrs %{alias: "some content", alias_abbreviation: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TeamSeason.changeset(%TeamSeason{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TeamSeason.changeset(%TeamSeason{}, @invalid_attrs)
    refute changeset.valid?
  end
end
