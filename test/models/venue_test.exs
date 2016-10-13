defmodule Melo.VenueTest do
  use Melo.ModelCase

  alias Melo.Venue

  @valid_attrs %{location: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Venue.changeset(%Venue{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Venue.changeset(%Venue{}, @invalid_attrs)
    refute changeset.valid?
  end
end
