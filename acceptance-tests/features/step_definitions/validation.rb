#required fields
def checkTitleNumber()
  assert_match(/#{$regData['title_number']}/i, page.body, 'Expected to see title number')
end

def checkPricePaid()
  assert_match(/#{$regData['price_paid']['fields']['amount']}/i, page.body, 'Expected to see price paid')
end

def checkTenure()
  assert_match(/#{$regData['property_description']['fields']['tenure']}/i, page.body, 'Expected to see tenure value')
end

def checkPropertyAddress()

  # The address is unstructured, so is 1 long string. The application is trying to split the address
  # by commas and displaying it in multiple lines. We need to do the same to check it
  unstructured_address_parts = $regData['property_description']['fields']['addresses'][0]['full_address'].split(',')

  unstructured_address_parts.each do |address_parts|
    assert_match(/#{address_parts}/i, page.body, 'Expected to see full address')
  end

end
