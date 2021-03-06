=begin
A friend of mine takes a sequence of numbers from 1 to n (where n > 0).
Within that sequence, he chooses two numbers, a and b.
He says that the product of a and b should be equal to the sum of all numbers in
the sequence, excluding a and b.
Given a number n, could you tell me the numbers he excluded from the sequence?
The function takes the parameter: n (don't worry, n is always strictly greater
than 0 and small enough so we shouldn't have overflow) and returns an array of
the form:

[(a, b), ...] or [[a, b], ...] or {{a, b}, ...} or or [{a, b}, ...]
with all (a, b) which are the possible removed numbers in the sequence 1 to n.

[(a, b), ...] or [[a, b], ...] or {{a, b}, ...} or ...will be sorted in
increasing order of the "a".

It happens that there are several possible (a, b). The function returns an empty
array if no possible numbers are found which will prove that my friend has not
told the truth! (Go: in this case return nil).

(See examples for each language in "RUN EXAMPLES")

#Examples:

removNb(26) should return [(15, 21), (21, 15)]
or

removNb(26) should return { {15, 21}, {21, 15} }
or

removeNb(26) should return [[15, 21], [21, 15]]
or

removNb(26) should return [ {15, 21}, {21, 15} ]
or

in C:
removNb(26) should return  **an array of pairs {{15, 21}{21, 15}}**
tested by way of strings.
=end

=begin

def removNb(n)
  number_list = []
  sum = (1..n).inject(0, &:+)

  (1..n).each do |numA|
    n.downto(1) do |numB|
      number_list << [numA, numB] if sum - (numA + numB) == numA * numB
    end
  end
  number_list
end
=end
#-------------------------
# the above code although passes the tests...it fails the time test
#below is a code that me and @Tagrand did whilst paring remotely
#this passes the codewars time test too

def removNb(n)
  number_list = []
  sum = (1..n).inject(0, &:+)

  low_limit = sum / n

  mid_point = Math.sqrt(sum).to_i

   a = mid_point
   b = mid_point

    until (a == low_limit || b > n)
      total = sum - (a + b)
      product = a * b
       if total == product
         number_list << [a, b]
         a -= 1
      elsif total < product
         a -= 1
      else
         b += 1
      end
    end

  other_answers = number_list.map{|arr| arr.reverse}
  answer = number_list + other_answers
  answer.sort!
end
