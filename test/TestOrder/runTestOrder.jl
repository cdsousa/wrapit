using Test
using Serialization

import Pkg
Pkg.activate("$(@__DIR__)/build")
Pkg.develop(path="$(@__DIR__)/build/TestOrder")

if "-s" in ARGS #Serialize mode
    Test.TESTSET_PRINT_ENABLE[] = false
end

result = begin
    @testset "Wrapper declaration order test" begin
        #It is sufficiant to test that we can load the TestOrder module
        @test begin
            using TestOrder
            true
        end
    end
end

if "-s" in ARGS #Serialize mode
    serialize(stdout, result)
else
    result
end
