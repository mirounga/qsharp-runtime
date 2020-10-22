# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License.

<#
    .SYNOPSIS
        Provides the list of artifacts (Packages and Assemblies) generated by this repository.
    
    .PARAMETER OutputFormat
        Specifies if the output of this script should be a hashtable with the artifacts
        as strings with the absolute path (AbsolutePath) or FileInfo structures.
#>
param(
    [ValidateSet('FileInfo','AbsolutePath')]
    [string] $OutputFormat = 'FileInfo'
);


& "$PSScriptRoot/set-env.ps1"

$artifacts = @{
    Packages = @(
        "Microsoft.Azure.Quantum.Client",
        "Microsoft.Quantum.CsharpGeneration",
        "Microsoft.Quantum.Development.Kit",
        "Microsoft.Quantum.EntryPointDriver",
        "Microsoft.Quantum.QSharp.Core",
        "Microsoft.Quantum.Runtime.Core",
        "Microsoft.Quantum.Simulators",
        "Microsoft.Quantum.Xunit"
    ) | ForEach-Object { Join-Path $Env:NUGET_OUTDIR "$_.$Env:NUGET_VERSION.nupkg" };

    Assemblies = @(
        ".\src\Azure\Azure.Quantum.Client\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Azure.Quantum.Client.dll",
        ".\src\Simulation\CsharpGeneration\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Quantum.CsharpGeneration.dll",
        ".\src\Simulation\CsharpGeneration.App\bin\$Env:BUILD_CONFIGURATION\netcoreapp3.1\Microsoft.Quantum.CsharpGeneration.App.dll",
        ".\src\Simulation\CsharpGeneration.App\bin\$Env:BUILD_CONFIGURATION\netcoreapp3.1\Microsoft.Quantum.RoslynWrapper.dll",
        ".\src\Simulation\Core\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Quantum.Runtime.Core.dll",
        ".\src\Simulation\EntryPointDriver\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Quantum.EntryPointDriver.dll",
        ".\src\Simulation\QsharpCore\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Quantum.QSharp.Core.dll",
        ".\src\Simulation\Simulators\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Quantum.Simulation.Common.dll",
        ".\src\Simulation\Simulators\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Quantum.Simulation.QCTraceSimulatorRuntime.dll",
        ".\src\Simulation\Simulators\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Quantum.Simulators.dll",
        ".\src\Xunit\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Quantum.Xunit.dll"
    ) | ForEach-Object { Join-Path $PSScriptRoot (Join-Path ".." $_) };
    
    Native = @(
        "..\submodules\qsharp-runtime\src\simulation\Simulators\bin\$Env:BUILD_CONFIGURATION\netstandard2.1\Microsoft.Quantum.Simulator.Runtime.dll"
    ) | ForEach-Object { Join-Path $PSScriptRoot (Join-Path ".." $_) };
}

if ($OutputFormat -eq 'FileInfo') {
    $artifacts.Packages = $artifacts.Packages | ForEach-Object { Get-Item $_ };
    $artifacts.Assemblies = $artifacts.Assemblies | ForEach-Object { Get-Item $_ };
    $artifacts.Native = $artifacts.Native | ForEach-Object { Get-Item $_ };
}
    
$artifacts | Write-Output;

