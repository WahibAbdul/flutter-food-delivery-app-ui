import 'package:flutter/material.dart';
import 'package:food_delivery/data/data.dart';

import '../models/order.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => new _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart (${currentUser.cart.length})'),
      ),
      body: _buildBody(context),
      bottomSheet: Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          boxShadow: [
            BoxShadow(color: Colors.black26, offset: Offset(0, -1), blurRadius: 6.0),
          ],
        ),
        child: TextButton(
          child: Text("CHECKOUT"),
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle: MaterialStateProperty.all(
              Theme.of(context).textTheme.titleLarge,
            ),
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView.separated(
      itemCount: currentUser.cart.length + 1,
      itemBuilder: (context, index) {
        if (index < currentUser.cart.length) {
          Order order = currentUser.cart[index];
          return _buildCartItem(context, order);
        } else {
          double totalPrice = 0;
          currentUser.cart.forEach((order) => totalPrice += order.quantity * order.food.price);
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Estimated Delivery Time:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      "25 mins",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Cost:",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      "\$${totalPrice.toStringAsFixed(2)}",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.green[700]),
                    ),
                  ],
                ),
                SizedBox(height: 80.0)
              ],
            ),
          );
        }
      },
      separatorBuilder: (context, index) {
        return Divider(
          height: 1,
          color: Colors.grey,
        );
      },
    );
  }
}

Widget _buildCartItem(BuildContext context, Order order) {
  return Container(
    padding: EdgeInsets.all(20.0),
    height: 170,
    child: Row(
      children: [
        Expanded(
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image(
                  image: AssetImage(order.food.imageUrl),
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.food.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      order.restaurant.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(height: 10.0),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(width: 0.8, color: Colors.black54),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "-",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Text(
                            "${order.quantity}",
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SizedBox(width: 20.0),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "+",
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          "\$${order.food.price * order.quantity}",
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ],
    ),
  );
}
