import 'package:flutter_boilerplate/app/products/data/model/api/product_model.dart';
import 'package:flutter_boilerplate/app/products/domain/domain.dart';

extension ProductModelMapper on ProductModel {
  Product toEntity() {
    return Product(
      id: id,
      title: title,
      description: description,
      category: category,
      price: price,
      discountPercentage: discountPercentage,
      rating: rating,
      stock: stock,
      tags: tags,
      brand: brand,
      sku: sku,
      weight: weight,
      dimensions: dimensions?.toEntity(),
      warrantyInformation: warrantyInformation,
      shippingInformation: shippingInformation,
      availabilityStatus: availabilityStatus,
      reviews: reviews.map((e) => e.toEntity()).toList(),
      returnPolicy: returnPolicy,
      minimumOrderQuantity: minimumOrderQuantity,
      thumbnail: thumbnail,
      images: images,
    );
  }
}

extension ProductDimensionsModelMapper on ProductDimensionsModel {
  ProductDimensions toEntity() {
    return ProductDimensions(
      width: width,
      height: height,
      depth: depth,
    );
  }
}

extension ProductReviewModelMapper on ProductReviewModel {
  ProductReview toEntity() {
    return ProductReview(
      rating: rating,
      comment: comment,
      date: date == null ? null : DateTime.tryParse(date!),
      reviewerName: reviewerName,
      reviewerEmail: reviewerEmail,
    );
  }
}

extension ProductModelListMapper on List<ProductModel> {
  List<Product> toEntity() => map((e) => e.toEntity()).toList();
}
