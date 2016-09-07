<#
Copyright 2016 Iain Brighton

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

function Remove-NSLDAPAuthenticationPolicy {
    <#
    .SYNOPSIS
        Removes an existing LDAP authentication policy.

    .DESCRIPTION
        Removes an existing LDAP authentication policy.

    .PARAMETER Session
        The NetScaler session object.

    .PARAMETER Name
        The name of the LDAP authentication policy to remove.

    .EXAMPLE
        Remove-NSLDAPAuthenticationPolicy -Name 'pol_ldap_DC1'

        Removes the LDAP authentication policy named 'pol_ldap_DC1'.

    .PARAMETER Force
        Suppress confirmation when removing a responder action.
    #>
    [cmdletbinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param(
        $Session = $script:session,

        [parameter(Mandatory = $true, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
        [string[]]$Name,

        [switch]$Force
    )

    begin {
        _AssertSessionActive
    }

    process {
        foreach ($item in $Name) {
            if ($Force -or $PSCmdlet.ShouldProcess($item, 'Delete LDAP Authentication Policy')) {
                try {
                    _InvokeNSRestApi -Session $Session -Method DELETE -Type authenticationldappolicy -Resource $item -Action delete
                }
                catch {
                    throw $_
                }
            }
        }
    }
}
