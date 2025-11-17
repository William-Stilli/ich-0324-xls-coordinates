Import-Module Pester

task Tests {
$configuration = New-PesterConfiguration

$configuration.Run.Path = './XlsCoordinatesConverter-wts.Tests.ps1'
$configuration.CodeCoverage.OutputFormat = 'CoverageGutters'
$configuration.CodeCoverage.OutputPath = "../cov.xml"
$configuration.CodeCoverage.OutputEncoding = "UTF8"
$configuration.CodeCoverage.Path = './XlsCoordinatesConverter-wts.ps1'

$configuration.CodeCoverage.Enabled = $true

Invoke-Pester -Configuration $configuration
}

task Release {
    New-Item -ErrorAction Ignore -ItemType Directory -Name "XlsCoordinatesConverter-wts"
    Copy-Item -Path "./XlsCoordinatesConverter-wts.ps1" -Destination "./XlsCoordinatesConverter-wts/XlsCoordinatesConverter-wts.psm1"
    Add-Content -Path "./XlsCoordinatesConverter-wts/XlsCoordinatesConverter-wts.psm1" -Value "Export-ModuleMember -Function 'ParseTable'"

    $env = @{}
    Get-Content "../.env" | ForEach-Object{
        $name, $value = $_.Split("=")
        $env.Add($name,$value)
    }
    Publish-Module -Path '../XlsCoordinatesConverter-wts' -NuGetApiKey $env["NutGetApiKey"]
}

task Build {
    Invoke-Build Tests
    Invoke-Build Release
}