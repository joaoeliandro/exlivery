defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  alias Exlivery.Orders.Item

  import Exlivery.Factory

  describe "build/4" do
    test "should be able to return an item" do
      response =
        Item.build(
          "Pizza de calabresa",
          :pizza,
          "28.00",
          1
        )

      expected_response = {:ok, build(:item)}

      assert response == expected_response
    end

    test "should not be able to return an item with invalid category" do
      response =
        Item.build(
          "Pizza de calabresa",
          :invalidcategory,
          "28.00",
          1
        )

      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end

    test "should not be able to return an item with invalid price" do
      response =
        Item.build(
          "Pizza de calabresa",
          :pizza,
          "invalid price",
          1
        )

      expected_response = {:error, "Invalid price!"}

      assert response == expected_response
    end

    test "should not be able to return an item with invalid quantity" do
      response =
        Item.build(
          "Pizza de calabresa",
          :pizza,
          "28.00",
          0
        )

      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end
  end
end
