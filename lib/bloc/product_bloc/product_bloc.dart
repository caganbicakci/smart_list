import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_list/data/repository/product_repositroy.dart';
import 'package:smart_list/models/category.dart';

import '../../models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepo;
  late List<Product>? products;
  late List<Category>? categories;
  late List<Product>? predictedProducts;

  ProductBloc(this.productRepo) : super(ProductInitial()) {
    on<ProductLoadEvent>((event, emit) async {
      emit(ProductLoadingState());
      categories = await productRepo.getProductCategories();
      products = await productRepo.getProducts();

      if (products != null && categories != null) {
        emit(ProductLoadedState(products: products!, categories: categories!));
      } else {
        emit(ProductErrorState());
      }
    });

    on<LoadProductByCategory>((event, emit) async {
      emit(ProductLoadingState());
      List<Product> productsByCategory = [];
      for (var product in products!) {
        if (product.categoryId == event.categoryId) {
          productsByCategory.add(product);
        }
      }

      emit(ProductLoadedState(
          products: productsByCategory, categories: categories!));
    });
  }
}
