<#
Copyright 2019 Iain Brighton

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
#>

function Remove-NSVPNUrl {
    <#
    .SYNOPSIS
        Removes an existing SSL VPN url/bookmark.

    .DESCRIPTION
        Removes an existing SSL VPN url/bookmark.

    .EXAMPLE
        Remove-NSVPNUrl -Name 'SalesForce'

        Removes the SSL VPN link/bookmark named 'SalesForce'.

    .PARAMETER Session
        The NetScaler session object.

    .PARAMETER Name
        The name of the SSL VPN link/bookmark to remove.

    .PARAMETER Force
        Suppress confirmation when removing a SSL VPN url/bookmark.
    #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        $Session = $script:session,

        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string[]] $Name,

        [switch] $Force
    )

    begin {
        _AssertSessionActive
    }

    process {
        foreach ($item in $Name) {
            if ($Force -or $PSCmdlet.ShouldProcess($item, 'Delete url/bookmark')) {
                try {
                    _InvokeNSRestApi -Session $Session -Method DELETE -Type vpnurl -Resource $item -Action delete
                }
                catch {
                    throw $_
                }
            }
        }
    }
}
