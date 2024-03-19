import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Car Store',
      theme: ThemeData(
        primaryColor: Colors.black,
        hintColor: Colors.black,
      ),
      home: IntroPage(),
    );
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  List<Car> cars = [
    Car(name: 'Audi', image: 'lib/cars/audi.jpeg', price: '\$100,000'),
    Car(name: 'Bugatti', image: 'lib/cars/bugatti.jpeg', price: '\$3,000,000'),
    Car(name: 'Rolls Royce', image: 'lib/cars/rolls.jpeg', price: '\$400,000'),
    Car(name: 'Supercar', image: 'lib/cars/supercar.jpeg', price: '\$500,000'),
  ];

  List<Car> wishlist = [];
  List<Car> cart = [];

  void toggleLike(Car car) {
    setState(() {
      if (wishlist.contains(car)) {
        wishlist.remove(car);
      } else {
        wishlist.add(car);
      }
    });
  }

  void addToCart(Car car) {
    setState(() {
      cart.add(car);
    });
  }

  void placeOrder() {
    // Implement your place order logic here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Stack(
              alignment: Alignment.topRight,
              children: [
                Center(
                  child: Text(
                    'DARK LORD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WishlistPage(wishlist: wishlist),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(cart: cart),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: cars.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    margin: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.asset(
                            cars[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cars[index].name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Price: ${cars[index].price}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () => toggleLike(cars[index]),
                              icon: Icon(
                                wishlist.contains(cars[index]) ? Icons.favorite : Icons.favorite_border,
                                color: Colors.black,
                              ),
                            ),
                            IconButton(
                              onPressed: () => addToCart(cars[index]),
                              icon: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            if (cart.isNotEmpty)
              ElevatedButton(
                onPressed: placeOrder,
                child: Text(
                  'Place Order',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Car {
  final String name;
  final String image;
  final String price;

  Car({required this.name, required this.image, required this.price});
}

class WishlistPage extends StatelessWidget {
  final List<Car> wishlist;

  const WishlistPage({Key? key, required this.wishlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              wishlist[index].image,
              width: 100,
              height: 100,
            ),
            title: Text(wishlist[index].name),
            subtitle: Text('Price: ${wishlist[index].price}'),
          );
        },
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Car> cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.asset(
              cart[index].image,
              width: 100,
              height: 100,
            ),
            title: Text(cart[index].name),
            subtitle: Text('Price: ${cart[index].price}'),
          );
        },
      ),
    );
  }
}








