enum ProductSortType {
  relevance(''),
  priceLowToHigh('price'),
  priceHighToLow('-price');

  final String apiValue;
  const ProductSortType(this.apiValue);
}
