# Web network

This module defines the private network for the web instances. The root
configuration supplies the resource group, region, naming prefix and tags.

## Resources

- A virtual network with the default address space `10.20.0.0/16`.
- A web subnet using `10.20.1.0/24`, within that address space.
- A network security group (NSG) with inbound TCP port 80 rules for website
  visitors and Azure Load Balancer health probes.
- An association that attaches the NSG to the web subnet.

With the current root defaults, the resource names are `vnet-jlg-web-lab`,
`snet-jlg-web-lab` and `nsg-jlg-web-lab`.

## Traffic rules

The `Internet` rule permits website requests on port 80. Azure Load Balancer
preserves the visitor's source IP when forwarding requests to a backend VM,
so permitting only the `AzureLoadBalancer` service tag would not be enough
for visitors to reach the website.

The `AzureLoadBalancer` rule explicitly permits health probes on port 80.
Azure's default NSG rules also remain in place, including virtual network
traffic and load balancer probe access. This explicit probe rule documents
the port used by the planned HTTP health check; it does not replace or
restrict those default rules. Inbound SSH from the Internet is not allowed.

The subnet has `default_outbound_access_enabled = false`. The planned public
load balancer will need an explicit outbound rule so the VMs can download
packages such as NGINX. An NSG rule allowing outbound traffic is not, on its
own, an Internet connection.

## Inputs and output

| Input | Purpose | Default |
| --- | --- | --- |
| `name_prefix` | Project and environment used in names | Required |
| `resource_group_name` | Resource group to use | Required |
| `location` | Azure region | Required |
| `tags` | Tags for resources that support them | `{}` |
| `vnet_address_space` | Virtual network address ranges | `["10.20.0.0/16"]` |
| `web_subnet_cidr` | Address range for web instances | `"10.20.1.0/24"` |

The `subnet_id` output will let the compute module attach its instances to
this subnet. Its dependency also makes those consumers wait for the NSG
association to be created.

## Run from the project root

```powershell
terraform fmt -recursive
terraform init
terraform validate
terraform plan
```

The module inherits the root AzureRM provider configuration. Its provider
requirement declares a minimum version; the root configuration controls
which compatible version is selected.

## References

- [Azure network security groups](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)
- [How NSG associations work](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-group-how-it-works)
- [Default outbound access](https://learn.microsoft.com/en-us/azure/virtual-network/ip-services/default-outbound-access)
- [Terraform module structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

At this stage, the configuration includes the network only. The load
balancer, VMs and recovery configuration will be added in later steps.
