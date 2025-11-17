BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1','.ps1')
}

Describe "ParseTable" {
    It "Returns ArgumentException when bad input" {
        {ParseTable -Cell tata} | Should -Throw -ExceptionType ([System.ArgumentException])
    }
    It "Returns ArgumentException when bad input" {
        {ParseTable -Cell 1111} | Should -Throw -ExceptionType ([System.ArgumentException])
    }
    It "Returns ArgumentException when bad input" {
        {ParseTable -Cell a1e1} | Should -Throw -ExceptionType ([System.ArgumentException])
    }

    It "Returns [2, 23] when input is 'B23'" {
        ParseTable -Cell B23 | Should -Be "[2,23]"
    }
    
    It "Returns [28, 23] when input is 'AB23'" {
        ParseTable -Cell AB23 | Should -Be "[28,23]"
    }

    # It "Returns [16384, 1048576] when input is 'XFD1048576'" {
    #     ParseTable -Cell XFD1048576 | Should -Be "[16384,1048576]"
    # }
}