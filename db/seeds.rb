User.delete_all
User.create(:username => 'puconghan', :email => 'tx2569@columbia.edu', :priority => "high", :basedcountry => "China", :password => 'administrator', :password_confirmation => 'administrator')
User.create(:username => 'nanzhuwang', :email => 'nz2260@columbia.edu', :priority => "high", :basedcountry => "Japan", :password => 'administrator', :password_confirmation => 'administrator')
User.create(:username => 'taocheng', :email => 'ph2369@columbia.edu', :priority => "high", :basedcountry => "India", :password => 'administrator', :password_confirmation => 'administrator')
User.create(:username => 'shujianbu', :email => 'sb3331@columbia.edu', :priority => "high", :basedcountry => "United States", :password => 'administrator', :password_confirmation => 'administrator')
User.create(:username => 'test1', :email => 'test1@columbia.edu', :priority => "low", :basedcountry => "Germany", :password => 'testtest', :password_confirmation => 'administrator')
User.create(:username => 'test2', :email => 'test2@columbia.edu', :priority => "low", :basedcountry => "United States", :password => 'testtest', :password_confirmation => 'testtest')
User.create(:username => 'test3', :email => 'test3@columbia.edu', :priority => "low", :basedcountry => "United States", :password => 'testtest', :password_confirmation => 'testtest')
User.create(:username => 'test4', :email => 'test4@columbia.edu', :priority => "low", :basedcountry => "United States", :password => 'testtest', :password_confirmation => 'testtest')

require 'json'
Gdp.delete_all
JSON.parse(open("#{Rails.root}/doc/gdp.json").read).each do |stuff|
   Gdp.create(stuff)
end

HealthExpenditure.delete_all
JSON.parse(open("#{Rails.root}/doc/healthExpenditure.json").read).each do |stuff|
   HealthExpenditure.create(stuff)
end

ImprovedSanitationFacilities.delete_all
JSON.parse(open("#{Rails.root}/doc/improvedSanitationFacilities.json").read).each do |stuff|
   ImprovedSanitationFacilities.create(stuff)
end

ImprovedWaterSource.delete_all
JSON.parse(open("#{Rails.root}/doc/improvedWaterSource.json").read).each do |stuff|
   ImprovedWaterSource.create(stuff)
end

LiteracyRate.delete_all
JSON.parse(open("#{Rails.root}/doc/literacyRate.json").read).each do |stuff|
   LiteracyRate.create(stuff)
end

Hiv.delete_all
JSON.parse(open("#{Rails.root}/doc/hiv.json").read).each do |stuff|
   Hiv.create(stuff)
end

RuralPopulation.delete_all
JSON.parse(open("#{Rails.root}/doc/ruralPopulation.json").read).each do |stuff|
   RuralPopulation.create(stuff)
end

UnemploymentRate.delete_all
JSON.parse(open("#{Rails.root}/doc/unemploymentRate.json").read).each do |stuff|
   UnemploymentRate.create(stuff)
end