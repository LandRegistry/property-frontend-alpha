Then(/^I can see the following information displayed$/) do |table|
 if (table != '')
   table.raw.each do |value|
     if (value[0] != 'INFORMATION') then
       send 'check' + value[0].gsub(/ /, '').gsub(/'/, '')
     end
   end
 end
end

Then(/^I cannot see the following information displayed$/) do |table|
 if (table != '')
   table.raw.each do |value|
     if (value[0] != 'INFORMATION') then
       send 'checkNotExist' + value[0].gsub(/ /, '').gsub(/'/, '')
     end
   end
 end
end
