# tax_test_app

## Installation:

    bundle install

## Running specs:

    rspec

## Example input:

    spec/support/product_params.json

## Example output:

    export/*.csv

## NOTE

For **Input 3**:

> Quantity, Product, Price

> 1, imported bottle of perfume, 27.99

> 1, bottle of perfume, 18.99

> 1, packet of headache pills, 9.75

> 1, box of imported chocolates, 11.25

Expected Output is:

> 1, imported bottle of perfume, 32.19

> 1, bottle of perfume, 20.89

> 1, packet of headache pills, 9.75

> 1, box of imported chocolates, 11.85

> Sales Taxes: 6.70

> Total: 74.68

Correct output is:

> 1, imported bottle of perfume, 32.19

> 1, bottle of perfume, 20.89

> 1, packet of headache pills, 9.75

> 1, box of imported chocolates, 11.8

> Sales Taxes: 6.65

> Total: 74.63

Reason:

For cart item '1, box of imported chocolates, 11.25':

- `base_tax_rate == 0`(%);
- `import_tax_rate == 5`(%);
- tax calculation:
  - `tax == 11.25 * (0 + 5) / 100.0` (returns `0.5625`);
  - `rounded_tax == (0.5625 * 20).round / 20.0` (returns `0.55` that is nearest `0.05` rounded value for `0.5625`);

That causes sales tax and total to differ by 0.05 from expected result.
