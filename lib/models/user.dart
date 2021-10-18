class User {
  static String id = '';
  static String name = '';
  static String email = '';
  static String password = '';
  static String rePassword = '';
  static String phone = '';
  static List<dynamic> address = [];
  static String cartId = '';
  static String chatId = '';

  static setValues(id, name, email, phone, address, cartId, chatId) {
    User.setId(id);
    User.setEmail(email);
    User.setName(name);
    User.setPhone(phone);
    User.setAddress(address);
    User.setCartId(cartId);
    User.setChatId(chatId);
  }

  static setEmail(email) {
    User.email = email;
  }

  static setName(name) {
    User.name = name;
  }

  static setPhone(phone) {
    User.phone = phone;
  }

  static setAddress(address) {
    User.address = address;
  }

  static setId(id) {
    User.id = id;
  }

  static setCartId(cartId) {
    User.cartId = cartId;
  }

  static setChatId(chatId) {
    User.chatId = chatId;
  }
}
