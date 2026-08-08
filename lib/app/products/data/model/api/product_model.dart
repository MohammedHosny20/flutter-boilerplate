import 'package:playx/playx.dart';

class ProductModel extends Equatable {
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
  final ProductDimensionsModel? dimensions;
  final String? warrantyInformation;
  final String? shippingInformation;
  final String? availabilityStatus;
  final List<ProductReviewModel> reviews;
  final String? returnPolicy;
  final int? minimumOrderQuantity;
  final String thumbnail;
  final List<String> images;

  const ProductModel({
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

  factory ProductModel.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return ProductModel(
      id: asInt(map, 'id'),
      title: asString(map, 'title'),
      description: asString(map, 'description'),
      category: asString(map, 'category'),
      price: asDouble(map, 'price'),
      discountPercentage: asDoubleOrNull(map, 'discountPercentage') ?? 0,
      rating: asDoubleOrNull(map, 'rating') ?? 0,
      stock: asIntOrNull(map, 'stock') ?? 0,
      tags: asListStringOrNull(map, 'tags') ?? const [],
      brand: asStringOrNull(map, 'brand'),
      sku: asStringOrNull(map, 'sku'),
      weight: asDoubleOrNull(map, 'weight'),
      dimensions: map['dimensions'] == null
          ? null
          : ProductDimensionsModel.fromJson(asMap(map, 'dimensions')),
      warrantyInformation: asStringOrNull(map, 'warrantyInformation'),
      shippingInformation: asStringOrNull(map, 'shippingInformation'),
      availabilityStatus: asStringOrNull(map, 'availabilityStatus'),
      reviews: asListOrNull<ProductReviewModel>(
            map,
            'reviews',
            fromJson: ProductReviewModel.fromJson,
          ) ??
          const [],
      returnPolicy: asStringOrNull(map, 'returnPolicy'),
      minimumOrderQuantity: asIntOrNull(map, 'minimumOrderQuantity'),
      thumbnail: asStringOrNull(map, 'thumbnail') ?? '',
      images: asListStringOrNull(map, 'images') ?? const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'discountPercentage': discountPercentage,
      'rating': rating,
      'stock': stock,
      'tags': tags,
      if (brand != null) 'brand': brand,
      if (sku != null) 'sku': sku,
      if (weight != null) 'weight': weight,
      if (dimensions != null) 'dimensions': dimensions!.toJson(),
      if (warrantyInformation != null)
        'warrantyInformation': warrantyInformation,
      if (shippingInformation != null)
        'shippingInformation': shippingInformation,
      if (availabilityStatus != null) 'availabilityStatus': availabilityStatus,
      'reviews': reviews.map((e) => e.toJson()).toList(),
      if (returnPolicy != null) 'returnPolicy': returnPolicy,
      if (minimumOrderQuantity != null)
        'minimumOrderQuantity': minimumOrderQuantity,
      'thumbnail': thumbnail,
      'images': images,
    };
  }

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

class ProductDimensionsModel extends Equatable {
  final double width;
  final double height;
  final double depth;

  const ProductDimensionsModel({
    required this.width,
    required this.height,
    required this.depth,
  });

  factory ProductDimensionsModel.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return ProductDimensionsModel(
      width: asDoubleOrNull(map, 'width') ?? 0,
      height: asDoubleOrNull(map, 'height') ?? 0,
      depth: asDoubleOrNull(map, 'depth') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'width': width,
        'height': height,
        'depth': depth,
      };

  @override
  List<Object?> get props => [width, height, depth];
}

class ProductReviewModel extends Equatable {
  final int rating;
  final String comment;
  final String? date;
  final String reviewerName;
  final String? reviewerEmail;

  const ProductReviewModel({
    required this.rating,
    required this.comment,
    required this.reviewerName,
    this.date,
    this.reviewerEmail,
  });

  factory ProductReviewModel.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return ProductReviewModel(
      rating: asIntOrNull(map, 'rating') ?? 0,
      comment: asStringOrNull(map, 'comment') ?? '',
      date: asStringOrNull(map, 'date'),
      reviewerName: asStringOrNull(map, 'reviewerName') ?? '',
      reviewerEmail: asStringOrNull(map, 'reviewerEmail'),
    );
  }

  Map<String, dynamic> toJson() => {
        'rating': rating,
        'comment': comment,
        if (date != null) 'date': date,
        'reviewerName': reviewerName,
        if (reviewerEmail != null) 'reviewerEmail': reviewerEmail,
      };

  @override
  List<Object?> get props => [
        rating,
        comment,
        date,
        reviewerName,
        reviewerEmail,
      ];
}
