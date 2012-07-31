/usr/lib/ruby/gems/1.9.1/gems/x10-cm17a-1.0.1/lib/x10.rb
 2009-09-21 19:50:25.669977482 -0800
 x10.rb 2009-09-21 19:47:48.269007712 -0800
 @@ -60,7 +60,11 @@
 # Make a canonical X10 device address from the house number and
 # unit. House and unit numbers are zero based.
 def make_address(house, unit)
    (house + ?a).chr + (unit+1).to_s
  if "a"[0].respond_to?(:-) then
    (house + ?a).chr + (unit+1).to_s
  else # ruby 1.9 doesn't do character math
    (house + 97).chr + (unit+1).to_s
  end
 end
 
# Parse a canonical X10 device address into house number and unit
 @@ -77,7 +81,11 @@
 fail X10::X10Error, "Bad X10 device address [#{address}]"
 end
 
  house = address[0] - ?a
   if address[0].respond_to?(:-) then
    house = address[0] - ?a
   else #ruby 1.9 doesn't have :-
    house = address.getbyte(0) - 97
   end
  [house, unit]
 end
 