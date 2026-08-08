import 'package:equatable/equatable.dart';

/// Domain entity representing a product from the catalog.
class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double discountPercentage;
  final double rating;
  final int stock;
  final List<String> tags;
  final String? brand;
  final String? sku;
  final double? weight;
  final ProductDimensions? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ProductReview> reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final String thumbnail;
  final List<String> images;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.stock,
    required this.tags,
    required this.thumbnail,
    required this.images,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews = const [],
    this.returnPolicy,
    this.minimumOrderQuantity,
  });

  double get discountedPrice => price - (price * discountPercentage / 100);

  bool get isLowStock =>
      availabilityStatus?.toLowerCase().contains('low') == true || stock <= 10;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        price,
        discountPercentage,
        rating,
        stock,
        tags,
        brand,
        sku,
        weight,
        dimensions,
        warrantyInformation,
        shippingInformation,
        availabilityStatus,
        reviews,
        returnPolicy,
        minimumOrderQuantity,
        thumbnail,
        images,
      ];
}

class ProductDimensions extends Equatable {
  final double width;
  final double height;
  final double depth;

  const ProductDimensions({
    required this.width,
    required this.height,
    required this.depth,
  });

  @override
  List<Object?> get props => [width, height, depth];
}

class ProductReview extends Equatable {
  final int rating;
  final String comment;
  final DateTime? date;
  final String reviewerName;
  final String? reviewerEmail;

  const ProductReview({
    required this.rating,
    required this.comment,
    required this.reviewerName,
    this.date,
    this.reviewerEmail,
  });

  @override
  List<Object?> get props => [
        rating,
        comment,
        date,
        reviewerName,
        reviewerEmail,
      ];
}
