# frozen_string_literal: true

def fibs(n)
  fib_arr = [0, 1]
  (n-2).times do
    fib_arr.append(fib_arr[-1] + fib_arr[-2])
  end
  fib_arr
end

def fibs_rec(n, fib_arr = [])
  return fib_arr if fib_arr.length == n

  # This isn't good readable code, but wanted to try and do it in three lines as the challenge mentioned
  fib_arr.append(fib_arr.empty? ? 0 : fib_arr.length == 1 ? 1 : (fib_arr[-1] + fib_arr[-2]))
  fibs_rec(n, fib_arr)
end

puts fibs_rec(8)

