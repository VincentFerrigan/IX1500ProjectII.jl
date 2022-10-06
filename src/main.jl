#=
EXISTING ISSUES

- set_e() function can be prettier
- solve powermod() integer division errors
- Encrypt/decrypt

=#


using Primes
using LinearAlgebra

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
n = BigInt(p)*BigInt(q)

println("n = ",BigInt(n))

# Set ϕ
ϕ = BigInt(p-1)*BigInt(q-1)

println("ϕ = ",BigInt(ϕ))

# Set range for e
e_range_low = 100
e_range_hi = 1000

# Set e
e = BigInt(set_e(ϕ))


println("e = ", e)

#= Set d
Half the time: LoadError: DivideError: integer division error 
WHY?=#
d = BigInt(powermod(e, -1, BigInt(ϕ))) 


#println("d = ", d)


#Just for testing that ascii encoding is right
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

println(cryptolist) #[100, 105, 115, 99, 114, 101, 116, 101, 32, 109, 97, 116, 104]
     
B = 256

r = Vector{BigInt}(1:length(message))

for i in 1:length(message)
    r[i] = BigInt(B)^(r[i]-1)
    
end

println(r)

code = BigInt(0)

code += dot(cryptolist, r)

println(code)

crypted = powermod(code, e, n)

println(crypted)

decrypted = powermod(crypted, d, n)

println(decrypted)

println(mod(decrypted, 256))
println(mod(decrypted, 256))

