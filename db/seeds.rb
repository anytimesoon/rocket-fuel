userlist = [
  ['John', 'john@john.com', '123 fake street, New Haven, 12345 CT USA', "john"],
  ['Dan', 'dan@john.com', '3323 Elm Street, New Haven, 23413 CT USA', "dan"],
  ['Rich', 'rich@john.com', '4443 Holden street, New York, 45645 NY USA', "rich"],
  ['Zack', 'zack@john.com', '1432 Hamden street, New York, 23425 NJ USA', "zack"],
]

productlist = [
  ['Ethiopian Yirgacheffe', 9.40, 'In 850 AD, it is said an Ethiopian goat herder discovered the wonders of coffee when his flock grew restless and wouldn’t go to sleep at night. Curious, he discovered that his flock had been eating the cherries of coffee trees. This innovator of caffeinated beverages made his discovery in Yirgacheffe, a region located in south-central Ethiopia. Featuring subtle fruity undertones and a baker’s chocolate finish, this French roast also produces a robust, full-bodied flavor that will get anyone ready to face the day. Whether you are writing code or herding goats, you’ll know Yirgacheffe is the discovery of a lifetime.'],
  ['Dark Kenya AA', 10.60, 'On graduation day, after throwing your mortarboard into the air, you may have thought of the importance of letter grades as a thing of the past, but our Kenya AA beans prove otherwise. The AA designation is the highest grade on the scale and is based on the size, shape, and density of the beans, and after one cup, you’ll know why even an A+ wasn’t lofty enough for this coffee. Maturing in Kenya’s rich volcanic soil, these beans have a sharp, winey flavor with a distinct fruitiness that’s sure to excite the taste buds of even the most jaded coffee aficionado. The dark roast level brings out a heavier body in the bean and accentuates the flavor of this high quality Kenyan coffee. Try it, and find out why these beans are at the top of the class.'],
  ['Tanzanian Peaberry', 9.1, 'Most coffee beans are born twins. Within each cherry on the coffee tree, two beans are grown side by side, resulting in the flat face of most beans. Peaberries, however, occur when only one of the two seeds is fertilized, growing on its own without anything to flatten it. They are individualists, the lone guns of the coffee world. As a result of their independence, many coffee connoisseurs have suggested that each peaberry is infused with all the assets normally reserved for two beans. In our humble opinion, these beans are most certainly unique, punctuated by an intoxicating, chocolaty aroma. The subtle oat-y undertone and rich, winey body is surprisingly versatile and perfect for any time of day.']
]

userlist.each do |name, email, address, password|
  User.create( name: name, email: email, address: address, password: password)
end

productlist.each do |name, price, description|
  Product.create(name: name, price: price, description: description)
end

User.all.each do |user|
  user.slug = user.name.gsub(' ', '-').downcase
end
