defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  describe "build/5" do
    test "should be able to return a user" do
      response =
        User.build(
          "Name Test",
          "example@test.com",
          "12312312312",
          18,
          "Rua dos Testes"
        )

      expected_response =
        {:ok,
         %User{
           address: "Rua dos Testes",
           age: 18,
           cpf: "12312312312",
           email: "example@test.com",
           name: "Name Test"
         }}

      assert response == expected_response
    end

    test "should not be able to return a minor user" do
      response =
        User.build(
          "Name Test",
          "example@test.com",
          "12312312312",
          17,
          "Rua dos Testes"
        )

      expected_response = {:error, "Invalid parameters"}

      assert response == expected_response
    end
  end
end
