defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Order

  describe "build/2" do
    setup do
      user = build(:user)

      {:ok, user: user}
    end

    test "should be able to return an order", %{user: user} do
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

    test "should not be able to return an order without items in the order", %{user: user} do
      items = []

      response = Order.build(user, items)

      expected_response = {:error, "Invalid parameters!"}

      assert response == expected_response
    end
  end
end
