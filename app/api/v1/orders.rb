# app/api/v1/users.rb
module API
  module V1
    class Orders < Grape::API
      version 'v1', using: :path, vendor: 'samurails-blog'
      resources :orders do

        # get: /orders - return all orders
        desc 'Get All Orders'
        get do
          Orders.all.ordered
        end

        # get; /orders/:id - specific order
        desc 'Delete One Order'
        params do
          requries :id
        end
        get ':id' do
          Order.find(params[:id])
        end

        # get; /orders/owner/:id - return user's order
        desc 'get all orders for specific user'
        params do
          requries :id
        end
        get 'owner/:id' do
          Order.find(owner: params[:id])
        end

        # post: /orders - add new order
        desc 'Add New Order'
        params do
          requires :owner
          requires :name, type: String
          requires :date, type: DateTime
          requires :restaurantName, type: String
          requires :menuImage, type: String
          requires :status, type: String
          requires :totalPrice, type: Integer
          requires :items, type: Array
          requires :friends, type: Array
          requires :groups, type: Array
        end
        post do
          Order.create(
              owner: params[:owner],
              name: params[:name],
              restaurantName: params[:restaurantName],
              date: params[:date],
              menuImage: params[:menuImage],
              status: params[:status],
              totalPrice: params[:totalPrice],
              items: params[:items],
              friends: params[:friends],
              groups: params[:groups]
          )
        end

        # delete: /orders/:id - delete order
        desc 'Delete One Order'
        params do
          requries :id
        end
        delete ':id' do
          Order.find(params[:id]).destroy
        end

        # update: /orders/:id
        desc 'Update One Order'
        params do
          requires :id
          requires :owner
          requires :name, type: String
          requires :date, type: DateTime
          requires :restaurantName, type: String
          requires :menuImage, type: String
          requires :status, type: String
          requires :totalPrice, type: Integer
          requires :items, type: Array
          requires :friends, type: Array
          requires :groups, type: Array
        end
        put ':id' do
          order = Order.find(params[:id])
          order.update(
              owner: params[:owner],
              name: params[:name],
              restaurantName: params[:restaurantName],
              date: params[:date],
              menuImage: params[:menuImage],
              status: params[:status],
              totalPrice: params[:totalPrice],
              items: params[:items],
              friends: params[:friends],
              groups: params[:groups]
          )
        end
      end
    end
  end
end

# Order Class / Collection
# @name
# @date
# @restaurantName
# @menuImage
# @status
# @totalPrince
# @items
# @friends
# @groups


# get:    /orders
# get     /orders/:id
# post:   /orders
# delete: /orders/:id
# put:    /orders/:id
# get:    /orders/owner/:id