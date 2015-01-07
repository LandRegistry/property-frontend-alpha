require 'oily_png'

def checkmultiplepolygons()
  assert_operator $map_details['polygon_count'], :>, 1, 'Expected different amount of polygons'
end


When(/^I check the title plan \(public view\)$/) do
  wait_for_map_to_load()

  $polygon_main = "tmpimg-#{Time.new.to_i}-main.png"
  page.execute_script("extentGeoJson.setStyle({weight: 8, opacity: 1});")
  save_screenshot($polygon_main, :selector => "#map")

  # Get names for the 2 files we will produce
  $polygon_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  $polygon_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  # Hide Map Layer
  page.execute_script("map.removeLayer(openspaceLayer);")

  # Make the shape more vivid
  page.execute_script("extentGeoJson.setStyle({opacity: 1, weight: 0, fillOpacity: 1});")

  # Take a screen show of the map id div tag
  save_screenshot($polygon_file1, :selector => "#map")

  # Remove the geojson layer of the map
  page.execute_script("map.removeLayer(extentGeoJson);")

  # Now take another screenshot without the geojson there
  save_screenshot($polygon_file2, :selector => "#map")

  # readd the layer back in to in sure the map is correct for other tests
  page.execute_script("map.addLayer(extentGeoJson);")

  page.execute_script("extentGeoJson.setStyle({fillOpacity: 0});")

  # Compare the images to get the polygon details
  $map_details = get_polygon_details($polygon_file1, $polygon_file2)

  # Re add the map layer
  page.execute_script("map.addLayer(openspaceLayer);")
  wait_for_map_to_load()

end

When(/^I check the title plan \(private view\)$/) do
  wait_for_map_to_load()

  $polygon_orig = "tmpimg-#{Time.new.to_i}-orig.png"
  save_screenshot($polygon_orig, :selector => "#map")

  $polygon_main = "tmpimg-#{Time.new.to_i}-main.png"
  page.execute_script("extentGeoJson.setStyle({weight: 8, opacity: 1});")
  save_screenshot($polygon_main, :selector => "#map")

  # Get names for the 2 files we will produce
  $polygon_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  $polygon_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  # Hide Map Layer
  page.execute_script("map.removeLayer(openspaceLayer);")

  # Make the shape more vivid
  page.execute_script("extentGeoJson.setStyle({weight: 0, fillOpacity: 1});")
  page.execute_script("easementGeoJson.setStyle({fillOpacity: 1});")
  page.execute_script("extentGeoJson.bringToBack();")

  puts page.evaluate_script("easementGeoJson.options")

  # Take a screen show of the map id div tag
  save_screenshot($polygon_file1, :selector => "#map")

  # Remove the geojson layer of the map
  page.execute_script("map.removeLayer(extentGeoJson);")
  page.execute_script("map.removeLayer(easementGeoJson);")

  # Now take another screenshot without the geojson there
  save_screenshot($polygon_file2, :selector => "#map")

  # readd the layer back in to in sure the map is correct for other tests
  page.execute_script("map.addLayer(extentGeoJson);")
  page.execute_script("map.addLayer(easementGeoJson);")
  page.execute_script("extentGeoJson.bringToFront();")

  page.execute_script("extentGeoJson.setStyle({fillOpacity: 0});")

  # Compare the images to get the polygon details
  $map_details = get_polygon_details($polygon_file1, $polygon_file2)

  # Re add the map layer
  page.execute_script("map.addLayer(openspaceLayer);")
  wait_for_map_to_load()

end

def checkwholepolyginisinview()
  # Check to see if the min/max x and y don't touch the border for each polygon
  $map_details['polygons'].each do |polygon|
    assert_not_equal polygon['x.min'], 0, 'The Polygon occupies more than the screen'
    assert_not_equal polygon['y.min'], 0, 'The Polygon occupies more than the screen'
    assert_not_equal polygon['x.max'], $map_details['width'] - 1, 'The Polygon occupies more than the screen'
    assert_not_equal polygon['y.max'], $map_details['height'] - 1, 'The Polygon occupies more than the screen'
  end
end

def checkthepolygonsmatchthetitle()
  # Check to see of the coordinates exist on the html source code
  for i in 0..($regData['extent']['geometry']['coordinates'].count) -1
    for j in 0..($regData['extent']['geometry']['coordinates'][i].count) -1
      assert_match($regData['extent']['geometry']['coordinates'][i][j][0].to_s, page.body, 'expected map co-ordinates not present')
      assert_match($regData['extent']['geometry']['coordinates'][i][j][1].to_s, page.body, 'expected map co-ordinates not present')
    end
  end
end

def checkthepolygonsareedgedinred()
  # Check the source code of the html for the stroke of red
  #assert_equal (find(".//*[local-name() = 'path']")['stroke']) , 'red', 'Expected the edging to be red'

  image = ChunkyPNG::Image.from_file($polygon_main)

  # Loop through the polygons
  $map_details['polygons'].each do |polygon|
    # Check the colour of the edging pixels
    polygon['edges'].each do |polygon_edges|

      polygon_edges.each do |polygon_edge_pixels|

        i_x = polygon_edge_pixels[0]
        i_y = polygon_edge_pixels[1]

        r = ChunkyPNG::Color.r(image[i_x,i_y])
        g = ChunkyPNG::Color.g(image[i_x,i_y])
        b = ChunkyPNG::Color.b(image[i_x,i_y])

        # Red has a high r value and low g and b. So lets see if any break that rule
        if ((r != 255) || (g != 0) || (b != 0)) then
          #puts i_x.to_s + ' - ' + i_y.to_s + ' - ' + r.to_s + ':' + g.to_s + ':' + b.to_s
          raise 'Found a colour that isn\'t red on the border.'
        end
      end
    end
  end

end

def checkthemapcantbezoomed()
  # Generate some new map names.
  map_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  map_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  # Save the map area as a screenshot
  save_screenshot(map_file1, :selector => "#map")

  # Send plus key to see if the map zooms
  find(".//*[@id='map']").native.send_key('+')
  wait_for_map_to_load()
  # save a screen with the image after the key press
  save_screenshot(map_file2, :selector => "#map")

  # See if the maps now compare
  maps_match = compare_maps(map_file1, map_file2)

  # If they don't match, then raise a an error
  assert_equal true, maps_match, 'The hash of the Image files does not match, this must mean the images are different'

end

def checkthemapcantbemoved()
    # Generate some new map names.
  map_file1 = "tmpimg-#{Time.new.to_i}-1.png"
  map_file2 = "tmpimg-#{Time.new.to_i}-2.png"

  # Save the map area as a screenshot
  save_screenshot(map_file1, :selector => "#map")

  # Send an arrow key to see if the map zooms
  find(".//*[@id='map']").native.send_key(:arrow_down)
  wait_for_map_to_load()

  # save a screen with the image after the key press
  save_screenshot(map_file2, :selector => "#map")

  # See if the maps now compare
  maps_match = compare_maps(map_file1, map_file2)

  # If they don't match, then raise a an error
  assert_equal true, maps_match, 'The hash of the Image files does not match, this must mean the images are different'

end

def checkthepolygonsareoveramap()

  if (ENV['WEBDRIVER'] != 'Firefox') then

    # Generate some new map names.
    map_file1 = "tmpimg-#{Time.new.to_i}-1.png"
    map_file2 = "tmpimg-#{Time.new.to_i}-2.png"

    # Save the map area as a screenshot
    save_screenshot(map_file1, :selector => "#map")

    # Remove the underlying map layer
    page.execute_script("map.removeLayer(openspaceLayer);")
    wait_for_map_to_load()

    # save a screen with the image after the key press
    save_screenshot(map_file2, :selector => "#map")

    # See if the maps now compare
    maps_match = compare_maps(map_file1, map_file2)

    # If they do match, it means there was no map layer
    assert_equal false, maps_match, 'The two map images match, this means they aren\'t on a map layer'

    # Re add the map layer
    page.execute_script("map.addLayer(openspaceLayer);")

  end

end

def checkthereisnoeasement()
  # Loop through the polygons
  $map_details['polygons'].each do |polygon|
    assert_equal false, polygon['easement'], 'The polygon does not have an easement'
  end
end

def checkthereisadonutpolygon()
  # Check to see if the polygons are donuts
  donut_count = 0
  $map_details['polygons'].each do |polygon|
    next unless polygon['donut'] == true
    donut_count = donut_count + 1
  end
  assert_operator donut_count, :>=, 1, 'There should be a donut Polygon, but isn\'t'
end


def checkthereisanormalpolygon()
  # Check to see if the polygons are donuts
  normal_count = 0
  $map_details['polygons'].each do |polygon|
    next unless polygon['donut'] == false
    normal_count = normal_count + 1
  end
  assert_operator normal_count, :>=, 1, 'There should be a normal Polygon, but isn\'t'
end

Then(/^there are no easements displayed$/) do
  # Check to see if the polygons are donuts
  easement_count = 0
  $map_details['polygons'].each do |polygon|
    next unless polygon['easement'] == true
    easement_count = easement_count + 1
  end
  assert_equal easement_count, 0, 'There shouldn\'t be an easement, but is'
end

def checkthereisaneasement()
  # Check to see if the polygons are donuts
  easement_count = 0
  $map_details['polygons'].each do |polygon|
    next unless polygon['easement'] == true
    easement_count = easement_count + 1
  end
  assert_not_equal easement_count, 0, 'There shouldn\'t be an easement, but is'
end
