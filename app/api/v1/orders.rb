# app/api/v1/users.rb
module API
  module V1
    class Orders < Grape::API
      version 'v1', using: :path, vendor: 'otlob'
      namespace(:orders, :groups, :friends, :users) do
        resources(:orders, :users, :friends, :groups) do
          # [done]
          # get: /orders      - return all orders
          desc 'return - All Orders'
          get do
            Order.each
          end

          # [done]
          # get; /orders/:id - specific order
          desc 'return - One Orders'
          params do
            requires :id
          end
          get ':id' do
            Order.find_by(params[:id])
          end

          # function
          # post:   /users/:id/orders/      - User's Orders
          desc 'get all orders for specific user'
          params do
            requires :id
          end
          get 'owner/:id' do
            Order.find_by(owner: params[:id])
          end

          # function
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
            # requires :items, type: Array
            # requires :friends, type: Array
            # requires :groups, type: Array
          end
          post do
            O
            Order.create(
                owner: params[:owner],
                name: params[:name],
                restaurantName: params[:restaurantName],
                date: params[:date],
                menuImage: params[:menuImage],
                status: params[:status],
                totalPrice: params[:totalPrice]
            # items: params[:items],
            # friends: params[:friends],
            # groups: params[:groups]
            )
          end
          # function
          # delete: /orders/:id - delete order
          desc 'Delete One Order'
          params do
            requires :id
          end
          delete ':id' do
            Order.find_by(params[:id]).destroy
          end

          # function
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
            # requires :items, type: Array
            # requires :friends, type: Array
            # requires :groups, type: Array
          end
          put ':id' do
            if Order.find_by(params[:id])
              Order.update(
                  owner: params[:owner],
                  name: params[:name],
                  restaurantName: params[:restaurantName],
                  date: params[:date],
                  menuImage: params[:menuImage],
                  status: params[:status],
                  totalPrice: params[:totalPrice]
              # items: params[:items],
              # friends: params[:friends],
              # groups: params[:groups]
              )
            else
              {status: 'order not found'}
            end
          end
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
# @totalPrice
# @items
# @friends
# @groups
#----------------------------------------------
### get:    /orders                 - All Orders
### get     /orders/:id             - One Order
# post:   /users/:id/orders/      - User's Orders
# delete: /users/:id/orders/:id   - Delete Order
# put:    /users/:id/orders/:id   - Update Order
# get:    /users/:id/orders/:id   - One User One Order
#----------------------------------------------
# post:   /orders/:id/groups                - Add Group to Order
# get:    /orders/:id/groups                - List Order's Groups
# delete  /users/:id/orders/:id/groups/:id  - Delete One Group One Order - Owner
#-# put     /users/:id/orders/:id/groups/:id  - Update One Group One Order - Owner
#----------------------------------------------
# post:   /orders/:id/friends                - Add Group to Order
# get:    /orders/:id/friends                - List Order's Friends
# delete  /users/:id/orders/:id/friends/:id  - Delete One Friends One Order - Owner
#-# put   /users/:id/orders/:id/friends/:id  - Update One Friends One Order - Owner
#----------------------------------------------
# put:   /users/:id/order/:id/status
#----------------------------------------------
# get:    /order/:id/items                - get all items
# post:   /users/:id/orders/:id/items     - add item
# delete  /users/:id/orders/:id/items     - delete item
# put     /users/:id/orders/:id/items     - update item
