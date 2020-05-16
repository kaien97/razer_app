require "json"
file = File.open "./tableServices.json"
data = JSON.load file

t = Time.now.beginning_of_hour
t_a = []
for i in (2..10)
  t_a.append((t+i.hours).strftime("%-l%P, %-d %b"))
end
Business.all.each do |b|
  b.update(timings_available: t_a.shuffle[0..5])
end

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
                  phone_number: "6" + rand.to_s[2..8],
                  timings_available: t.shuffle[0..4]
                  )
end
