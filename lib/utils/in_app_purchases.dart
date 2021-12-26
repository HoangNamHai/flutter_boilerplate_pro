// RevCat configuration
const kRevCatApiKey = 'appl_chlrKneYzuaxuFIbpHHCpTppnON';
const kEntitlementID = 'Premium';

// Additional information for products
const kBasicInfo = '''
✓   Free access
✓   Benefit 1
✓   Benefit 2
✓   Benefit 3
✓   ...
''';

const kPremiumInfo = '''
✓   Premium access
✓   Benefit 1
✓   Benefit 2
✓   Benefit 3
✓   ...
''';

class ProductInfo {
  final String name;
  final String tag;

  ProductInfo({this.name = '', this.tag = ''});
}

Map<String, ProductInfo> kProductsInfo = {
  'fbp_1499_1m': ProductInfo(name: 'Monthly', tag: ''),
  'fbp_3599_3m': ProductInfo(name: 'Quarterly', tag: '20% OFF'),
  'fbp_8999_1y_1w0': ProductInfo(name: 'Yearly', tag: '50% OFF'),
};
