using Primes

#FUNCTIONS

# can be better but my while loop didn't work
# sometimes gcd() isn't found???
function set_e(ϕ)
    e = rand(e_range_low:e_range_hi)
    for i in 1:10000
        if gcd(e, ϕ) === 1
            break
        end
    end
    return e
end

# Set ranges for p and q
range_low = 10^15
range_hi = 10^20

# Set p and q
p = nextprime(rand(range_low:range_hi))
q = nextprime(rand(range_low:range_hi))

println("p = ",p)
println("q = ",q)

# Set n
n = big(p)*big(q)

println("n = ",big(n))

# Set ϕ
ϕ = big(p-1)*big(q-1)

println("ϕ = ",big(ϕ))

# Set range for e
e_range_low = 100
e_range_hi = 1000

# Set e
e = set_e(ϕ)

println("e = ", e)

#= Set d
LoadError: DivideError: integer division error =#
#d = powermod(e, -1, big(ϕ)) 

#println("d = ", d)

message = "discrete math"

#=
Basic syntax for iterating through a string

for c in message
    print(c)
end=#

cryptolist = []

for c in message
    push!(cryptolist, Int(c))
end

println(cryptolist)
     
B = 256

