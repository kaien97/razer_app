require "json"
file = File.open "./tableServices.json"
data = JSON.load file

for b in data
  if ["Clinic", "Dentist"].include?(b["Service"])
    price = rand(50..100)
  else
    price = rand(5..20)
  end


  ba.businesses.create(postal_code: b["Postal Code"],
                  service:        b["Service"],
                  name:        b["Name"],
                  address:     b["Address"],
                  price_min: price*0.9,
                  price_max: price*1.1,
                  phone_number: "6" + rand.to_s[2..8]
                  )
end
