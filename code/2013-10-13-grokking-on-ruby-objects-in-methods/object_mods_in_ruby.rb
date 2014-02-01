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