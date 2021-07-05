defmodule Exlivery do
  alias Exlivery.Orders.Agent, as: OrdersAgent
  alias Exlivery.Orders.CreateOrUpdate, as: OrdersCreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreateOrUpdate, as: UserCreateOrUpdate

  def start_agents do
    UserAgent.start_link(%{})
    OrdersAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: UserCreateOrUpdate, as: :call
  defdelegate create_or_update_orders(params), to: OrdersCreateOrUpdate, as: :call
end
