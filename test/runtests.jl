using Test
using Revise

include("../src/MyCrypto.jl")
using .MyCrypto

@testset "Test set n och phi" begin
    p, q = (5, 11)  # Chooose p, q
    n = set_n(p,q)  # compute n
    ϕ = set_ϕ(p,q)  # compute ϕ(n)

    @test n == 55
    @test ϕ == 40

    e = 7           # choose e
    d = set_d(e, ϕ) # compute d

    @test d == 23

    d2 = BigInt(powermod(e, -1, BigInt(ϕ))) # alternative to set_d(e, ϕ)
    @test d == d2
end
@testset "Test set n phi, " begin
    p, q = set_random_primes_p_q(100, 1000) # Chooose p, q
    @test isprime(p) == true
    @test isprime(q) == true
    @test p != q

    n = set_n(p,q)                          # compute n
    ϕ = set_ϕ(p,q)                          # compute ϕ(n)

    setof_e = set_e(ϕ, 10)                  # choose e
    e = pop!(setof_e)

    d = set_d(e, ϕ)                         # compute d
    d2 = BigInt(powermod(e, -1, BigInt(ϕ))) # alternative to set_d(e, ϕ)

    @test d == d2
    @test mod(*(d,e), ϕ) == 1               # de ≣ 1 mod (ϕ)
    @test mod(*(d2,e), ϕ) == 1               # de ≣ 1 mod (ϕ)
    
    message = 1000000000000000
    e_message = encrypt(message, e, n)
    d_message = decrypt(e_message, d, n)
    println(message)

    @test d_message == message
end

p, q = set_random_primes_p_q(10^2, 10^4)
print("p: ", p, " q: ", q)