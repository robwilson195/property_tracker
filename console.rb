require_relative('models/property')

# Property.delete_all()

property1 = Property.new({
  "address" => "1 Road Street",
  "value" => "10000",
  "number_bedrooms" => "15",
  "buy_let_status" => "buy"
  })

property2 = Property.new({
  "address" => "2 Road Street",
  "value" => "100000",
  "number_bedrooms" => "5",
  "buy_let_status" => "let"
  })

property3 = Property.new({
  "address" => "3 Road Street",
  "value" => "20000",
  "number_bedrooms" => "100",
  "buy_let_status" => "buy"
  })


property1.save()
p property1
property2.save()
property3.save()

property2.value = 50_000
property2.update()

property1.delete()

found_property1 = Property.find_by_id("2")
p found_property1

found_property2 = Property.find_by_address("1 Road Street")
p found_property2
