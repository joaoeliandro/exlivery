defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  alias Exlivery.Orders.Order

  import Exlivery.Factory

  describe "build/2" do
    test "should be able to return an order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item,
          description: "Temaki de salmao",
          category: :japanese,
          quantity: 5,
          unity_price: Decimal.new("30.00")
        )
      ]

      response = Order.build(user, items)

      expected_response = {:ok, build(:order)}

      assert response == expected_response
    end

    test "should not be able to return an order without items in the order" do
      user = build(:user)

      items = []

      response = Order.build(user, items)

      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end
  end
end
