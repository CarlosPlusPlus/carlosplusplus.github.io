# Check out how this code works.  Typically Ruby is pass by value except that it all depends
# on what actually happens to the arguments that are passed.  Typically when changing a number 
# a new object is created.  The same applies when setting a string variable.  If you use the 
# concatenation operator ( << ) to append onto a string the original object is modified.  The same
# issue applies for some of the ! methods like reverse! and capitalize!
#
# I have never seen another language that works this way in regard to passing arguments to methods.
# Usually you specify arguments to be passed by reference or value explicitly so you have control
# over whether or not the passed arguments come back modified or not.  This is not the case in Ruby.
# It typically follows pass by value but that is not an accurate depiction.  It passes the object address.
# Typically when that argument is modified inside of the method a new object is created thereby preserving 
# the original object address passed in so when you return it is not modified.

def modifyStrings(aString,anotherString)
	puts("\naString gets capitalized(!).")
  aString.capitalize!
  puts("aString =>\n\tAddress: #{aString.object_id}, Value: #{aString}")

  puts("\nanotherString gets reversed(!) and capitalized(!)")
  anotherString.reverse!.capitalize!
  puts("anotherString =>\n\tAddress: #{anotherString.object_id}, Value: #{anotherString}")

  puts("\nReturn ::: aString swap-cased + \" \" + anotherString swap-cased(!)")
	aString.swapcase +  " " + anotherString.swapcase!
end

str1 = "hello"
str2 = "world"

puts "\nOriginal Ruby Objects can be modified in Methods\n".upcase

puts

puts("Str1 => Address: #{str1.object_id}, Value: #{str1}")
puts("Str2 => Address: #{str2.object_id}, Value: #{str2}")

puts "\n#############################################\n"
str3 = modifyStrings(str1,str2)
puts "\n#############################################\n"

puts

puts("Str1 => Address: #{str1.object_id}, Value: #{str1}")
puts("Str2 => Address: #{str2.object_id}, Value: #{str2}")
puts("Str3 => Address: #{str3.object_id}, Value: #{str3}")

puts