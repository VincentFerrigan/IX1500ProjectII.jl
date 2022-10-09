using Test
using Revise

include("../src/MyCrypto.jl")
using .MyCrypto

@testset "Test set n och phi" begin
    p = 5
    q = 11
    e = 7
    n = set_n(p,q)
    ϕ = set_ϕ(p,q)
    @test n == 55
    @test ϕ == 40
    d = set_d(e, ϕ)
    @test d == 23
    d2 = BigInt(powermod(e, -1, BigInt(ϕ))) 
    println("d: ", d, "d2: ", d2)
    @test d == d2

    for ee in set_e(ϕ)
        println(ee)
    end

end

# p, q = set_two_random_primes(10^15, 10^20)
println(set_e(40, 1))
