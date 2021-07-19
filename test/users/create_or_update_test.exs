defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})

      :ok
    end

    test "should be able to save the user" do
      params = %{
        name: "John Doe",
        address: "Alameda dos Anjos",
        email: "johndoe@example.com",
        cpf: "12300012300",
        age: 23
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:ok, "User created or updated successfully"}

      assert response == expected_response
    end

    test "should not be able to save the user" do
      params = %{
        name: "John Doe",
        address: "Alameda dos Anjos",
        email: "johndoe@example.com",
        cpf: "12300012300",
        age: 13
      }

      response = CreateOrUpdate.call(params)

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
