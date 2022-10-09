module MyCrypto

using Primes
using LinearAlgebra

export set_n, set_p, set_ϕ, set_e, set_d, set_two_random_primes

# Set n
set_n = (p, q) -> BigInt(p) * BigInt(q)

# Set ϕ, Euler totient function
set_ϕ = (p, q) -> BigInt(p - 1) * BigInt(q - 1)

"""
    set_e(ϕ, uptil=10)

Returns a set of coprimes e to give ϕ

# ϕ must not share a factor with e
# e does not have to be a large int? 
"""
function set_e(ϕ, uptil=10)
    e = Set()
    for i ∈ 3:ϕ
        gcd(i, ϕ) == 1 && push!(e, i)
        length(e) >= uptil && break
    end
    return e
end

"""
    set_d(e, ϕ)

Returns d
# Alternative to set_d = (e, ϕ) -> BigInt(powermod(e, -1, BigInt(ϕ)))
# Will invmod return a BigInt? Are we allowed to use invmod?
"""
set_d = (e, ϕ) -> invmod(e, ϕ) 

"""
    twoRandomPrimes(range_low, range_high)

Returns two random large primes, p and q within given range
"""
function set_two_random_primes(range_low, range_high)
    # Set p and q
    p = BigInt(0)
    q = BigInt(0)
    while p == q
        p = prime(rand(range_low:range_high))
        q = prime(rand(range_low:range_high))
    end
    return (p, q)
end

end #  module
