defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  describe "save/1" do
    test "should be able to save a user" do
      user = build(:user)

      UserAgent.start_link(%{})

      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      cpf = "12312312312"

      {:ok, cpf: cpf}
    end

    test "should be able to return a user", %{cpf: cpf} do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      response = UserAgent.get(cpf)

      expected_response =
        {:ok,
         %User{
           address: "Rua Sao Jose, 61",
           age: 22,
           cpf: "12312312312",
           email: "eliandrogermano@gmail.com",
           name: "Joao Eliandro"
         }}

      assert response == expected_response
    end

    test "should not be able to return a user" do
      response = UserAgent.get("00000000000")

      expected_response = {:error, "User not found"}

      assert response == expected_response
    end
  end
end
