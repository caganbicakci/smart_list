import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_list/constants/strings.dart';
import '../bloc/cart_bloc/cart_bloc.dart';

import '../widgets/product_list_widget.dart';

import '../bloc/product_bloc/product_bloc.dart';
import '../models/category.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            context.read<ProductBloc>().add(ProductLoadEvent());
          }
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProductLoadedState) {
            return Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    spacing: 5,
                    children: getCategoryWidgets(state.categories),
                  ),
                ),
                ProductListWidget(products: state.products),
              ],
            );
          }
          if (state is ProductErrorState) {
            return const Center(child: Text(SOMETHING_WENT_WRONG));
          }
          return Container();
        },
      ),
    ));
  }

  List<Widget> getCategoryWidgets(List<Category> categories) {
    List<Widget> categoryWidgets = [];
    for (int i = 0; i < categories.length; i++) {
      categoryWidgets.add(categoryWidget(categories[i]));
    }
    return categoryWidgets;
  }

  Widget categoryWidget(Category category) {
    return MaterialButton(
      color: Colors.white,
      onPressed: () {
        context
            .read<ProductBloc>()
            .add(LoadProductByCategory(categoryId: category.categoryId));
      },
      child: Text(
        category.categoryName,
        style: const TextStyle(color: Colors.blueGrey),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: const BorderSide(color: Colors.blueGrey),
      ),
    );
  }
}
