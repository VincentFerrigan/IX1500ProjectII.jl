# MyCrypto.jl
"""
    MyCrypto

Author:
Date: 2022-10-10
Notes:

Contains:
- set_n
- set_p
- set_ϕ
- set_e
- set_d
- set_random_primes_p_q
- decrypt
- encrypt

"""
module MyCrypto

using Primes
using LinearAlgebra

export set_n, set_p, set_ϕ, set_e, set_d, 
set_random_primes_p_q, isprime, decrypt, encrypt

"""
    set_n(p, q)

Returns the product of given arguments p and q
"""
set_n = (p, q) -> BigInt(p) * BigInt(q)

"""
    set_ϕ(p, q)

Returns ϕ(n) = (p-1)(p-q)
A.k.a Euler totient function
"""
set_ϕ = (p, q) -> BigInt(p - 1) * BigInt(q - 1)

"""
    set_e(ϕ, uptil=10)

Returns a set of coprimes e to give ϕ. 
The lenght of the set equals uptil that has a default value of 10

e ∈ {1, 2..., ϕ(n)-1} s.t. gcd(e, ϕ) == 1
e and ϕ(n) are relatively prime (coprimes)

# Comments and open issues
* ϕ must not share a factor with e
* e does not have to be a large int? 
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

Returns private key d, s.t. de ≣ 1 mod (ϕ)

# Comments and open issues
* Alternative to set_d = (e, ϕ) -> BigInt(powermod(e, -1, BigInt(ϕ)))
* Will invmod return a BigInt? Are we allowed to use invmod?
"""
set_d = (e, ϕ) -> invmod(e, ϕ) 

"""
    set_random_primes_p_q(range_low, range_high)

Returns two distinct random primes, p and q within given range

# Comments and open issues
* It takes time to compute large numbers
* Should we simply devide it 
"""
function set_random_primes_p_q(range_low, range_high)
    p = BigInt(prime(rand(range_low:range_high)))
    q = BigInt(prime(rand(range_low:range_high)))
    
    (p != q ? (p, q) : set_random_primes_p_q(range_low, range_high)
    )
end

"""
    encrypt(x, e, n)

Returns powermod(x, e, n) that is mod(x^e, n)
Which computes ``x^e mod (n)``
"""
encrypt = (x, e, n) -> powermod(x, e, n)

"""
    decrypt(x, d, n)

Returns powermod(y, d, n) that is mod(y^d, n)
Which computes ``y^d mod (n)`` where ``d == e^(-1)``
"""
decrypt = (y, d, n) -> powermod(y, d, n)

end #  module
