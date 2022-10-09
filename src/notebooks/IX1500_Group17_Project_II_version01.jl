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
end

# ╔═╡ e4efab6e-472b-11ed-3bf9-eda6e9d673f1
md"
# Report Project II
# _Encryption and decryption_
    Course code: KTH/ICT:IX1500 - Discrete Mathematics, ht22 
    Date: 2022-10-08
    Version: 0.1
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

# ╔═╡ e3a3f577-6bdf-489a-9c7c-36ef655c25a0
md"""
##### Encrypting as message
"""

# ╔═╡ b1a72120-c2ac-4372-a585-2ae7ad112440
md"""
###### Enter your friend's public key($n$, $e$)

`n = `$(@bind input_senders_n html"<input type=text size=50 >")

`e = `$(@bind input_senders_e html"<input type=text size=50 >")

###### Enter the message you want to encrypt

$(@bind input_a TextField((55,10)))
"""

# ╔═╡ 94d0e0b8-1181-4d44-a1e6-18169a0d4e4a
md"""
$(@bind cipher html"<input type=button value='Generate text as cipher code'>")
"""
#This encrypted message must be less than n

# ╔═╡ 5616a159-dc0a-466c-9b91-cd98420a3e02
# Testar bara input
function compute(input_n)
	n = tryparse(Int, "$input_n")
	if typeof(n) != Nothing
		return n
	else
		return "That aint a number"
	end
end

# ╔═╡ 5edcfcf7-c3ea-4d1a-b980-3b12e879407a
#testar bara input
let
		cipher
		
		println("DO SOMETHING ", compute(input_senders_n))
		md"""
	What?
	"""
end


# ╔═╡ 0bf68619-096e-438f-ae6a-4362f6936084
# Add button that will calculate. Show calculations
md"""
###### Encrypt the message:

"""

# ╔═╡ 7371513f-3833-48ce-afb9-9ced96355c64
md"#### Cipher Code ?
"

# ╔═╡ a623010a-b0e2-4b3f-910e-602826317a70
md"""
##### Decrypting as message
"""

# ╔═╡ 2f917c1c-fa83-4c67-92a2-2b006d919d8a
md"""
###### Enter your private key($n$, $d$)

`n = `$(@bind input_receivers_n html"<input type=text size=50 >")

`d = `$(@bind input_receivers_d html"<input type=text size=50 >")

###### Enter the message you want to decrypt

$(@bind input_xxxx TextField((55,10)))
"""

# ╔═╡ cba96317-b014-4ea1-b98b-33c08ed2da09
md"
##### Conclusions
"

# ╔═╡ 3992d19b-634e-494c-a3d2-6cf118605c08
md"
### Code
"

# ╔═╡ 72a51084-e43f-4eeb-96ad-a95fdf9beb51
md"## Pluto-Notebook
### Packages
* IteractiveUtils?
* PlutoUI
* Random
* Primes
* LinearAlgebra
"

# ╔═╡ e0c3b4fa-2481-4a5b-9e62-aaa121718f2c
md"#### Task A
##### Functions"

# ╔═╡ 0ef643a1-7867-41a2-af08-7d13c1d6e219


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Primes = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"

[compat]
PlutoUI = "~0.7.43"
Primes = "~0.5.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.0"
manifest_format = "2.0"
project_hash = "9f3837a0c949a0b52a00f9fd4b5810a971d28c7b"

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
# ╟─e3a3f577-6bdf-489a-9c7c-36ef655c25a0
# ╟─b1a72120-c2ac-4372-a585-2ae7ad112440
# ╟─94d0e0b8-1181-4d44-a1e6-18169a0d4e4a
# ╟─5edcfcf7-c3ea-4d1a-b980-3b12e879407a
# ╟─5616a159-dc0a-466c-9b91-cd98420a3e02
# ╟─0bf68619-096e-438f-ae6a-4362f6936084
# ╟─7371513f-3833-48ce-afb9-9ced96355c64
# ╟─a623010a-b0e2-4b3f-910e-602826317a70
# ╟─2f917c1c-fa83-4c67-92a2-2b006d919d8a
# ╟─cba96317-b014-4ea1-b98b-33c08ed2da09
# ╟─3992d19b-634e-494c-a3d2-6cf118605c08
# ╟─72a51084-e43f-4eeb-96ad-a95fdf9beb51
# ╠═f1900262-9b44-4c62-9fc9-aaff868bb910
# ╟─e0c3b4fa-2481-4a5b-9e62-aaa121718f2c
# ╠═0ef643a1-7867-41a2-af08-7d13c1d6e219
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
