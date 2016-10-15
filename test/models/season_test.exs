defmodule Melo.SeasonTest do
  use Melo.ModelCase

  alias Melo.Season

  @valid_attrs %{year: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Season.changeset(%Season{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Season.changeset(%Season{}, @invalid_attrs)
    refute changeset.valid?
  end
end
