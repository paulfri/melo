defmodule Melo.DivisionTest do
  use Melo.ModelCase

  alias Melo.Division

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Division.changeset(%Division{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Division.changeset(%Division{}, @invalid_attrs)
    refute changeset.valid?
  end
end
