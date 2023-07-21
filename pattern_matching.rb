arr = [1, 2, 3, 4, 5, 'potatoes', 6, 7, 8]


case arr
in [*start, 5, a, 6, *fin]
  puts "#{start} + #{a} + #{fin}"
else
  puts :no_match
end

case [1, 2, 3, [4, 5, 6]]
in [1, 2, 3, [4, a, _] => arr]
  puts a
  p arr
end

case { a: 'apple', b: 'banana', c: 'etc' }
in { a: 'aardvark', b: 'bat' }
  puts :no_match
in { a: 'appsle'}
  puts :match
else
  puts :no_match
end

def times_two(x)
  x * 2
end

y = 4

case {a: 1, b: 2}
in {a: Integer, **nil} # this will not match the pattern having keys other than a:
  p a
in {a: Integer, b: Integer, **nil}
  p "matched a whole"
else
  p "not matched"
end# frozen_string_literal: true

test = "I want to strip out the potatoes word that doesn't belong"

puts test

case test.split
in [*a, 'potatoes', *b]
  puts "#{a.join(' ')} #{b.join(' ')}"
end