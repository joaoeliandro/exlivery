defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.CreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      OrderAgent.start_link(%{})
      UserAgent.start_link(%{})

      cpf = "12312312300"
      user = build(:user, cpf: cpf)

      UserAgent.save(user)

      item1 = build(:item)
      item2 = build(:item, quantity: 2)

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "should be able to save the order", %{user_cpf: user_cpf, item1: item1, item2: item2} do
      params = %{
        user_cpf: user_cpf,
        items: [item1, item2]
      }

      response = CreateOrUpdate.call(params)

      assert {:ok, _uuid} = response
    end

    test "should not be able to save the order with user not found", %{
      item1: item1,
      item2: item2
    } do
      params = %{
        user_cpf: "cpf_wrong",
        items: [
          item1,
          item2
        ]
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end

    test "should not be able to save the order with invalid items", %{
      user_cpf: user_cpf,
      item2: item2
    } do
      params = %{
        user_cpf: user_cpf,
        items: [
          %{
            category: :wrong_category,
            description: "Pizza de calabresa",
            quantity: 1,
            unity_price: Decimal.new("28.00")
          },
          item2
        ]
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid items"}

      assert response == expected_response
    end

    test "should not be able to save the order no items", %{
      user_cpf: user_cpf
    } do
      params = %{
        user_cpf: user_cpf,
        items: []
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
