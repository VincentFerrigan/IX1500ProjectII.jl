### A Pluto.jl notebook ###
# v0.19.12

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ f1900262-9b44-4c62-9fc9-aaff868bb910
## Packages
begin
	using PlutoUI
	using Primes
	using LinearAlgebra
	using AbstractAlgebra
end

# ╔═╡ e4efab6e-472b-11ed-3bf9-eda6e9d673f1
md"
# Report Project II
# _Encryption and decryption_
    Course code: KTH/ICT:IX1500 - Discrete Mathematics, ht22 
    Date: 2022-10-08
    Version: 0.3
    Vincent Ferrigan, ferrigan@kth.se
    Martin Mellqvist Ekberg, martme@kth.se
"

# ╔═╡ 4b149a25-301f-4e92-9f8c-bebe7609b028
md"
## Task A
### Summary
#### Task
"

# ╔═╡ 499c3100-edbd-4510-b6f6-13694529e9f1
md"
Uppgiften består av att hitta ett klassiskt citat (förslagsvis av en matematiker :-) och kryptera denna klartext. Sedan byter ni chiffertext med en annan grupp försöker sedan knäcka krypteringen för att ta fram klartexten. Ni ska använda RSA kryptering (se 2.2.4 ovan) där $n$ skall vara högst $180$ bitar och e ett litet tal, ca $10^3-10^4$ stort. Se 2.2.4 för hur dessa ska generas. Koda citatet enligt metoden i 2.2.4 (tal med basen $256$). Observera att om meddelandet kodas till talet $m$ så måste $m < n$. Om inte, så dela upp citatet på flera rader och kryptera varje rad för sig. Tips: Nyttiga funktioner som kan behövas: FactorInteger, Partition
"

# ╔═╡ 70ee665c-1c94-4a04-884b-cbad0389e814
md"
#### Result
"

# ╔═╡ fa672ba9-0b7d-432f-9523-e0c5d8fa0971
md"""
In order to create a full encryption key employing *RSA* we use the standard methods. But since we want to create something that is crackable we use smaller numbers than normal.

To generate $p$ and $q$ we generate two random numbers in the range ($10^{15}$ - $10^{20}$) and the use Julia's *nextprime()* fucntion to generate a closeby prime.

$n=p \cdot q$
$ϕ = (p-1) \cdot (q-1)$

We generate a random number $e$ in the range ($10^3$ - $10^4$).

We then calculate our decryption key $d$ by taking the modular inverse of $e$ mod $ϕ$.

Now we can publish our public keys $e$ and $n$ and we keep the rest secret.

We encrypt a message by taking a string of text and converting the characters to their integer ascii counterparts and store this in a vector.

We can then take the scalar product of this vector and a vector consisting of powers of 256 (0, the length of the vector).

This generates a large number that we can then encrypt by taking the message $m$ and

$m^e \ mod(n)$

We decrypt the created message $c$ by taking:

$c^d \ mod(n)$

We finally can extract the characters by taking the remainder after division by 256 repeatedly.

As an example we use the following values:

	p = 6997538501205631649
	q = 5904508917194892811
	n = 41317028478783237270718606574104175339
	ϕ = 41317028478783237257816559155703650880
	e = 23593
	d = 33714891377677060301253948072123370777

Message: *\"Mathematical science shows what is. It is the language of unseen relations between things.\"* - Ada Lovelace

Which is encrypted to:

	14017977394216937714656534468291301637

##### Cracking the code

Cracking a properly full-length RSA key is unfeasible with classical computers but with smaller keys, we can make some attempts at least.

The most simplistic way would be some sort of brute force attack where we simply check every single possible number, but this would be extraordinarily inefficient.

##### Fermat factorization

According to Fermats factorization method, we can write an odd integer (as all primes are) $N$ as:

$N=a^2+b^2=(a+b)(a-b)$

We can therefore use this to calculate $p$ and $q$ by

$p = (a+b)$
$q = (a-b)$

Since

$a \land b \ngtr \sqrt N$

We can assume that no value will be higher than $\sqrt n$. 

If the two primes are reasonably close we can use this to find $a$ and $b$.

The above formula can be rewritten as:

$b^2 = a^2 - N$

Repeatedly calculating this and checking if it's a square will eventually yield the right result.

Having calculated this we use the above identities for $p$ and $q$ as sums or differences of $a$ and $b$.

From there we simply use the standard steps for calculating $ϕ$ and $d$ and then we can decrypt.
"""

# ╔═╡ e3a3f577-6bdf-489a-9c7c-36ef655c25a0
md"""
##### Encrypting a message
"""

# ╔═╡ b1a72120-c2ac-4372-a585-2ae7ad112440
md"""
###### Enter your friend's public key($n$, $e$)

`n = `$(@bind input_senders_n html"<input type=text size=50 >")

`e = `$(@bind input_senders_e html"<input type=text size=50 >")

###### Enter the message you want to encrypt

$(@bind input_x TextField((64,10)))
"""

# ╔═╡ 94d0e0b8-1181-4d44-a1e6-18169a0d4e4a
md"""
$(@bind encipher html"<input type=button value='Generate text as encipher code'>")
"""
#This encrypted message must be less than n

# ╔═╡ 2f917c1c-fa83-4c67-92a2-2b006d919d8a
md"""
###### Enter your private key($n$, $d$)

`n = `$(@bind input_receivers_n html"<input type=text size=50 >")

`d = `$(@bind input_receivers_d html"<input type=text size=50 >")

###### Enter the message you want to decrypt

$(@bind input_y TextField((64,10)))
"""

# ╔═╡ 3acbb96e-7c57-413c-8737-d2c65aadbef3
md"""
$(@bind decipher html"<input type=button value='Generate decrypted message'>")
"""
#This encrypted message must be less than n

# ╔═╡ 249bb53f-adb3-4069-9911-76ef4b2c8c81
md"""
### The Five Steps
"""

# ╔═╡ 62289d80-e74e-4586-942f-d910b15c9d07
md"""
##### Step 1: Choose p, q
"""

# ╔═╡ fc74f886-39c3-4f96-be08-0797a06cc277
md"""
##### Step 2: Compute n
"""

# ╔═╡ d8195945-cfbb-47b4-b493-68d1bce1fb08
md"""
##### Step 3: Compute ϕ
"""

# ╔═╡ 9709b14c-1efe-4a8a-9ff4-f9204b067080
md"""
##### Step 4: Choose e
"""

# ╔═╡ e8dbe061-8e49-4b87-adc0-ad6151aad34d
md"""
##### Step 5: Compute d
"""

# ╔═╡ 551cec3c-83dd-4f3f-9d86-142cca8c6de5
md"""
#### Crack
"""

# ╔═╡ 10a37457-faf1-418f-921b-7e2b5a9e33b3
md"""
###### Enter your nemesis's public key($n$, $e$)

`n = `$(@bind input_crack_n html"<input type=text size=50 >")

`e = `$(@bind input_crack_e html"<input type=text size=50 >")

`tries = `$(@bind input_crack_tries html"<input type=text size=46 >")

###### Enter the message you want to crack

$(@bind input_z TextField((64,10)))
"""

# ╔═╡ 2daade8d-dbd3-471f-95a8-3474d5d2547b
md"""
$(@bind crack html"<input type=button value='Generate private key d and the decrypted message'>")
"""
#This encrypted message must be less than n

# ╔═╡ cba96317-b014-4ea1-b98b-33c08ed2da09
md"
##### Conclusions
"

# ╔═╡ 3992d19b-634e-494c-a3d2-6cf118605c08
md"
### Code
"

# ╔═╡ 72a51084-e43f-4eeb-96ad-a95fdf9beb51
md"""
#### Pluto-Notebook
##### Packages
* IteractiveUtils?
* PlutoUI
* Random
* Primes
* LinearAlgebra
* AbstractAlgebra
"""

# ╔═╡ e0c3b4fa-2481-4a5b-9e62-aaa121718f2c
md"#### Task A
##### Functions"

# ╔═╡ 9dffd0c9-f78d-438d-84f2-3f15902f40d1
"""
    set_n(p, q)

Returns the product of given arguments p and q
"""
set_n = (p, q) -> BigInt(p) * BigInt(q)

# ╔═╡ 7376b099-d71d-4fa3-a896-83cb6ff83193
"""
    set_ϕ(p, q)

Returns ϕ(n) = (p-1)(p-q)
A.k.a Euler totient function
"""
set_ϕ = (p, q) -> BigInt(p - 1) * BigInt(q - 1)

# ╔═╡ 5ae27040-706e-4f03-8f1d-ddbaec923e57
"""
    set_e(ϕ, uptil=10)

Returns a set of coprimes e to give ϕ. 
The lenght of the set equals uptil that has a default value of 10

e ∈ {1, 2..., ϕ(n)-1} s.t. gcd(e, ϕ) == 1
e and ϕ(n) are relatively prime (coprimes)

### Comments and open issues
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

# ╔═╡ 5c75a1a7-c248-41a5-9908-a3eed543d94d
"""
    set_d(e, ϕ)

Returns private key d, s.t. de ≡ 1 mod (ϕ)

### Comments and open issues
* Alternative to set_d = (e, ϕ) -> BigInt(powermod(e, -1, BigInt(ϕ)))
* Will invmod return a BigInt? Are we allowed to use invmod?
"""
set_d = (e, ϕ) -> invmod(BigInt(e), BigInt(ϕ))

# ╔═╡ f6c41a7b-ba3f-475f-a736-d37d22eae37c
"""
	set_d2(e, ϕ)

Returns private key d using powermod
"""
set_d2 = (e, ϕ) -> BigInt(powermod(BigInt(e), -1, BigInt(ϕ)))

# ╔═╡ 471cf9f8-8ecb-4cce-b522-70e97df6f8fe
"""
    set_random_primes_p_q(range_low, range_high)

Returns two distinct random primes, p and q within given range

### Comments and open issues
* It takes time to compute large numbers
* Should we simply devide it 
"""
function set_random_primes_p_q(range_low, range_high)
    p = BigInt(nextprime(rand(range_low:range_high)))
    #q = BigInt(nextprime(p, 2))
	q = BigInt(nextprime(rand(range_low:range_high)))
    
    (p != q ? (p, q) : set_random_primes_p_q(range_low, range_high)
    )
end

# ╔═╡ 12e01839-c852-4c90-922d-b841be4e4cd2
p, q = set_random_primes_p_q(10^15,10^20)

# ╔═╡ af7d4a6a-eb18-496f-99e9-37366d48539a
n = set_n(p, q)

# ╔═╡ 2fd9bddc-25d9-4ec0-b280-abf6b411b064
ϕ = set_ϕ(p, q)

# ╔═╡ 77b72a7e-938c-4b9a-a535-ff9e58f2a92c
begin
setof_e = set_e(ϕ, 10000)
e = pop!(setof_e)
end

# ╔═╡ 6f43f1f6-f6fc-4945-bd7d-f7a6c0c09e52
d = set_d(e, ϕ)

# ╔═╡ 468e1ba4-d783-4ebf-80ba-16fb42fec055
md"""
Please note that your 
* n is $n 
* e is $e

* d is $d
* p is $p
* ϕ is $ϕ
* q is $q
"""

# ╔═╡ a623010a-b0e2-4b3f-910e-602826317a70
md"""
#### Decrypting a message

Please note that your 
* n is $n 
* d is $d
"""

# ╔═╡ df5a8df6-6db3-4d37-859e-00dff0eac42e
"""
    encrypt(x, e, n)

Returns powermod(x, e, n) that is mod(x^e, n)
Which computes ``x^e\\mod (n)``
"""
encrypt = (x, e, n) -> powermod(BigInt(x), BigInt(e), BigInt(n))

# ╔═╡ f2ec0a3a-e43c-4780-ae07-ef5a3d5b8eb8
encrypt2 = (x, e, n) -> modulo_power(x, e, n) 

# ╔═╡ e8301b1c-c95b-4a04-aede-4efff289b180
"""
    decrypt(y, d, n)

Returns powermod(y, d, n) that is mod(y^d, n)
Which computes ``y^d \\mod n``, where ``d = e^{-1}``
"""
decrypt = (y, d, n) -> powermod(BigInt(y), BigInt(d), BigInt(n))

# ╔═╡ 7265b37b-ff31-498e-8a7c-5455d5cac2e1
decrypt2 = (y, d, n) -> modulo_power(y, d, n)

# ╔═╡ e3ae1141-e767-4071-88bb-3d4b687fa11c
"""
	to_num(message)

Returns a vector of 
"""
function to_num(message)
    vector = []
    for c in message
        push!(vector, Int(c))
    end
    return vector
end

# ╔═╡ 2ae4fcd1-222f-456b-b30f-869573e302be
"""
	to_ascii(vector)

Returns a string
"""
function to_ascii(vector)
    string = ""
    for n in vector
        string *= Char(n)
    end
    return string
end

# ╔═╡ b38d6f6b-aafc-4fbe-988b-5af30a056424
function str2base(vector, base)
	len = length(vector)
	r = Vector{BigInt}(1:len)
	result = BigInt(0)
	
	for i in 1:len
    	r[i] = BigInt(base)^(r[i]-1)
	end
	result = dot(vector, r)
	return result
end

# ╔═╡ 5616a159-dc0a-466c-9b91-cd98420a3e02
"""
	encription(input_n, input_e, input_x)

### Arguments
* `input_n`: public key n
* `input_e`: public key e
* `input_x`: string message to be encrypted
"""
function encription(input_n, input_e, input_x)
	vector_x = to_num(input_x)
	n = tryparse(BigInt, "$input_n")
	e = tryparse(BigInt, "$input_e")
	typeof(n) == Nothing && return "$input_n ain't a number"
	typeof(e) == Nothing && return "$input_e ain't a number"

	x = BigInt(0)
	x = str2base(vector_x, 256)
	
	return encrypt(x, e, n)
end

# ╔═╡ 5edcfcf7-c3ea-4d1a-b980-3b12e879407a
let
	encipher
		
	e_message = encription(input_senders_n, input_senders_e, input_x)
	md"""
###### Your message was encrypted to: 
	
$e_message
"""
end

# ╔═╡ 081364db-1854-49f6-b4fe-3ddf027a318a
"""
	mbr2base(n, base)

Returns a string
"""
function nbr2base(n, base)
	res_str = ""
	while n != zero(n)
		n, r = divrem(n, base)
		res_str *= Char(r)
	end
	return res_str
end

# ╔═╡ 706d2a7f-ce3b-465d-a809-fd4be181d871
"""
	decription(input_n, input_d, input_y)

### Arguments
* `input_n`: public key n
* `input_d`: private key d
* `input_y`: encrypted message to be decrypted
"""
function decription(input_n, input_d, input_y)
	n = tryparse(BigInt, "$input_n")
	d = tryparse(BigInt, "$input_d")
	y = tryparse(BigInt, "$input_y")
	typeof(n) == Nothing && return "$input_n ain't a number"
	typeof(d) == Nothing && return "$input_e ain't a number"
	typeof(y) == Nothing && return "$input_y ain't a number"

	return nbr2base(decrypt(y, d, n), 256)
end

# ╔═╡ 77844cde-c285-4c1a-82d3-79b180fe16d5
let
		decipher
		
		d_message = decription(input_receivers_n, input_receivers_d, input_y)
		md"""
###### Your message has been decrypted to: 
		
$d_message
"""
end

# ╔═╡ 0768dc6e-1bf0-488a-8757-82e0b109aca4
"""

	hanno(n, e, tries)

Returns p, q, d

Hanno Böcks "Fermat Attack on RSA"

``n = a^2 - b^2 = (a+b)(a-b)``

``b^2 = a^2 -n``

``a = \\lceil \\sqrt{n} \\rceil``
"""
function hanno(n, e, tries = 1000000)
	a = ceil(BigInt(isqrt(n)))
	b = BigInt(0)
	i = 0
	while i < tries
		b2 = a^2 - n
		
		if is_square(b2)
			b = sqrt(b2)
			break
		end
		a += 1
		i += 1
	end
	
	p = a + b
	q = a - b

	ϕ = set_ϕ(p, q)
	d = set_d(e, ϕ)
	return p, q, d
end

# ╔═╡ dc46d70a-f2bd-4618-8fef-617e32943438
"""
	cracking(input_n, input_e, input_z, input_t)

### Arguments
* `input_n`: public key n
* `input_e`: public key e
* `input_z`: encrypted message to be decrypted
* `input_t`: Number of tries (iterations)
"""
function cracking(input_n, input_e, input_z, input_t)
	n = tryparse(BigInt, "$input_n")
	e = tryparse(BigInt, "$input_e")
	z = tryparse(BigInt, "$input_z")
	t = tryparse(BigInt, "$input_t")
	typeof(n) == Nothing && return "$input_n ain't a number"
	typeof(e) == Nothing && return "$input_e ain't a number"
	typeof(z) == Nothing && return "$input_z ain't a number"
	p, q, d = hanno(n, e, t)

	return p, q, d, nbr2base(decrypt(z, d, n), 256)
end

# ╔═╡ a3af17d8-c88e-468b-a0b4-7f4963ba0f62
let
		crack
		
		p, q, d, z_msg = cracking(input_crack_n, input_crack_e, input_z, input_crack_tries)
		md"""
Could it be that
* d: $d
* p: $p
* q: $q
* Message: $z_msg
"""
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractAlgebra = "c3fe647b-3220-5bb0-a1ea-a7954cac585d"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Primes = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"

[compat]
AbstractAlgebra = "~0.27.5"
PlutoUI = "~0.7.43"
Primes = "~0.5.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "564c12eaf6a4e9685be392909038899cd523bbc6"

[[deps.AbstractAlgebra]]
deps = ["GroupsCore", "InteractiveUtils", "LinearAlgebra", "MacroTools", "Markdown", "Random", "RandomExtensions", "SparseArrays", "Test"]
git-tree-sha1 = "e506dcc52d993ec7c69ea754b3bbd507d4737891"
uuid = "c3fe647b-3220-5bb0-a1ea-a7954cac585d"
version = "0.27.5"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "0.5.2+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.GroupsCore]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "9e1a5e9f3b81ad6a5c613d181664a0efc6fe6dd7"
uuid = "d5909c97-4eac-4ecc-a3dc-fdd0858a4120"
version = "0.4.0"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "f366daebdfb079fd1fe4e3d560f99a0c892e15bc"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.Parsers]]
deps = ["Dates"]
git-tree-sha1 = "3d5bf43e3e8b412656404ed9466f1dcbf7c50269"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.4.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "Markdown", "Random", "Reexport", "UUIDs"]
git-tree-sha1 = "2777a5c2c91b3145f5aa75b61bb4c2eb38797136"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.43"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "311a2aa90a64076ea0fac2ad7492e914e6feeb81"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RandomExtensions]]
deps = ["Random", "SparseArrays"]
git-tree-sha1 = "062986376ce6d394b23d5d90f01d81426113a3c9"
uuid = "fb686558-2515-59ef-acaa-46db3789a887"
version = "0.4.3"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "6bac775f2d42a611cdfcd1fb217ee719630c4175"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.6"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╟─e4efab6e-472b-11ed-3bf9-eda6e9d673f1
# ╟─4b149a25-301f-4e92-9f8c-bebe7609b028
# ╟─499c3100-edbd-4510-b6f6-13694529e9f1
# ╟─70ee665c-1c94-4a04-884b-cbad0389e814
# ╟─fa672ba9-0b7d-432f-9523-e0c5d8fa0971
# ╟─e3a3f577-6bdf-489a-9c7c-36ef655c25a0
# ╟─468e1ba4-d783-4ebf-80ba-16fb42fec055
# ╟─b1a72120-c2ac-4372-a585-2ae7ad112440
# ╟─94d0e0b8-1181-4d44-a1e6-18169a0d4e4a
# ╟─5edcfcf7-c3ea-4d1a-b980-3b12e879407a
# ╟─5616a159-dc0a-466c-9b91-cd98420a3e02
# ╟─a623010a-b0e2-4b3f-910e-602826317a70
# ╟─2f917c1c-fa83-4c67-92a2-2b006d919d8a
# ╟─3acbb96e-7c57-413c-8737-d2c65aadbef3
# ╟─77844cde-c285-4c1a-82d3-79b180fe16d5
# ╟─706d2a7f-ce3b-465d-a809-fd4be181d871
# ╟─249bb53f-adb3-4069-9911-76ef4b2c8c81
# ╟─62289d80-e74e-4586-942f-d910b15c9d07
# ╠═12e01839-c852-4c90-922d-b841be4e4cd2
# ╟─fc74f886-39c3-4f96-be08-0797a06cc277
# ╠═af7d4a6a-eb18-496f-99e9-37366d48539a
# ╟─d8195945-cfbb-47b4-b493-68d1bce1fb08
# ╠═2fd9bddc-25d9-4ec0-b280-abf6b411b064
# ╟─9709b14c-1efe-4a8a-9ff4-f9204b067080
# ╠═77b72a7e-938c-4b9a-a535-ff9e58f2a92c
# ╟─e8dbe061-8e49-4b87-adc0-ad6151aad34d
# ╠═6f43f1f6-f6fc-4945-bd7d-f7a6c0c09e52
# ╟─551cec3c-83dd-4f3f-9d86-142cca8c6de5
# ╟─10a37457-faf1-418f-921b-7e2b5a9e33b3
# ╟─2daade8d-dbd3-471f-95a8-3474d5d2547b
# ╟─a3af17d8-c88e-468b-a0b4-7f4963ba0f62
# ╟─dc46d70a-f2bd-4618-8fef-617e32943438
# ╟─cba96317-b014-4ea1-b98b-33c08ed2da09
# ╟─3992d19b-634e-494c-a3d2-6cf118605c08
# ╟─72a51084-e43f-4eeb-96ad-a95fdf9beb51
# ╟─f1900262-9b44-4c62-9fc9-aaff868bb910
# ╟─e0c3b4fa-2481-4a5b-9e62-aaa121718f2c
# ╠═9dffd0c9-f78d-438d-84f2-3f15902f40d1
# ╠═7376b099-d71d-4fa3-a896-83cb6ff83193
# ╠═5ae27040-706e-4f03-8f1d-ddbaec923e57
# ╠═5c75a1a7-c248-41a5-9908-a3eed543d94d
# ╠═f6c41a7b-ba3f-475f-a736-d37d22eae37c
# ╠═471cf9f8-8ecb-4cce-b522-70e97df6f8fe
# ╠═df5a8df6-6db3-4d37-859e-00dff0eac42e
# ╠═f2ec0a3a-e43c-4780-ae07-ef5a3d5b8eb8
# ╠═e8301b1c-c95b-4a04-aede-4efff289b180
# ╠═7265b37b-ff31-498e-8a7c-5455d5cac2e1
# ╠═e3ae1141-e767-4071-88bb-3d4b687fa11c
# ╠═2ae4fcd1-222f-456b-b30f-869573e302be
# ╠═b38d6f6b-aafc-4fbe-988b-5af30a056424
# ╠═081364db-1854-49f6-b4fe-3ddf027a318a
# ╠═0768dc6e-1bf0-488a-8757-82e0b109aca4
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
