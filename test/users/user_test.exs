defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  import Exlivery.Factory

  describe "build/5" do
    test "should be able to return a user" do
      response =
        User.build(
          "Joao Eliandro",
          "eliandrogermano@gmail.com",
          "12345678900",
          22,
          "Rua Sao Jose, 61"
        )

      expected_response =
        {:ok, build(:user)}

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
