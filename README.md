#Ruby Shopping Basket

How to install

```
git clone git@github.com:gerauf/ruby-shopping-basket.git
cd ruby-shopping-basket
bundle
rspec
```


### assumptions

- Products, ProductCatalogue, Offers and Shipping are all classes worked on by the rest of the team

- Products have a code and a price

- ProductCatalogue has an interface which looks up a product code and returns the correct product

- Offers has an interface which takes the current basket and calculates any offers based on its own implementation

- Shipping has an interface which takes the total basket value (after offers are applied) and calculates shipping fee based on its own internal implementation

- For this test I have ignored the internal implementations of the other classes and solely focused on the basket class and its interfaces, stubbing, mocking and spying on the other classes where necessary
