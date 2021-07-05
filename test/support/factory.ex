defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Users.User
  alias Exlivery.Orders.{Item, Order}

  def user_factory do
    %User{
      name: "Joao Eliandro",
      email: "eliandrogermano@gmail.com",
      cpf: "12345678900",
      age: 22,
      address: "Rua Sao Jose, 61"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "Pizza de calabresa",
      quantity: 1,
      unity_price: Decimal.new("28.00")
    }
  end

  def order_factory do
    %Order{
      delivery_address: "Rua Sao Jose, 61",
      items: [
        build(:item),
        build(:item,
          description: "Temaki de salmao",
          category: :japanese,
          quantity: 5,
          unity_price: Decimal.new("30.00")
        )
      ],
      total_price: Decimal.new("178.00"),
      user_cpf: "12345678900"
    }
  end
end
