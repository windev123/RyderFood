import 'package:flutter/widgets.dart';

class Item {
  String title;
  Color color;
  String price;
  String sell;
  String imageUrl;
  Item(this.title, this.color, this.price, this.sell, this.imageUrl);
}

List<Item> getGridItems() {
  return <Item>[
    Item('ครัวซอง', Color.fromARGB(255, 240, 240, 255), '50', '2',
        'https://s359.kapook.com/pagebuilder/37a6ec5e-712d-462c-9e2d-6b63c39e9777.jpg'),
    Item('ข้าวคลุกกะปิ', Color.fromARGB(255, 240, 240, 255), '40', '1',
        'https://many-menu.com/wp-content/uploads/2021/01/%E0%B8%A3%E0%B8%B9%E0%B8%9B-%E0%B8%AB%E0%B8%A5%E0%B8%B1%E0%B8%81-%E0%B8%82%E0%B8%AD%E0%B8%87-%E0%B8%AA%E0%B8%B9%E0%B8%95%E0%B8%A3-%E0%B8%82%E0%B9%89%E0%B8%B2%E0%B8%A7%E0%B8%84%E0%B8%A5%E0%B8%B8%E0%B8%81%E0%B8%81%E0%B8%B0%E0%B8%9B%E0%B8%B4-%E0%B8%AB%E0%B8%A1%E0%B8%B9%E0%B8%AB%E0%B8%A7%E0%B8%B2%E0%B8%99.jpg'),
    Item('ก๋วยจั๊บ', Color.fromARGB(255, 240, 240, 255), '40', '2',
        'https://s.isanook.com/wo/0/rp/r/w728/ya0xa0m1w0/aHR0cHM6Ly9zLmlzYW5vb2suY29tL3dvLzAvdWQvMzcvMTg3NzMzLzguanBn.jpg'),
    Item('แซลมอน', Color.fromARGB(255, 240, 240, 255), '175', '3',
        'https://s.isanook.com/he/0/ud/6/32241/salmon.jpg'),
    Item('ปลาทู', Color.fromARGB(255, 240, 240, 255), '25', '2',
        'https://static.thairath.co.th/media/4DQpjUtzLUwmJZZSBzParjp5ffxZWkzXjBL2jHa5rX5A.jpg'),
    Item('มาม่าเผ็ด', Color.fromARGB(255, 240, 240, 255), '50', '4',
        'https://static5-th.orstatic.com/userphoto/Article/0/3H/000ORK131F8F514AC41C7Cj.jpg'),
  ];
}
