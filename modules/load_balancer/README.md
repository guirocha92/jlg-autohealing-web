# Public web load balancer

This module defines the public entry point and traffic distribution for the
web tier.

## Resources

- A static Standard public IP address.
- A Standard Azure Load Balancer using that public IP as its frontend.
- A backend pool for the web VM Scale Set instances.
- An HTTP health probe for `/` on port 80.
- A rule that sends frontend TCP port 80 to backend TCP port 80.
- An outbound rule that gives backend instances controlled Internet access.

With the current root defaults, the top-level resources are named
`pip-jlg-web-lab` and `lb-jlg-web-lab`.

## Traffic behaviour

Visitors connect to the public IP on TCP port 80. The load-balancing rule
selects a healthy instance from `be-web` and forwards the connection to port
80 on that instance.

The HTTP probe requests `/` every five seconds. After two consecutive failed probes, the backend is removed from rotation for new connections. A successful probe can make it eligible for traffic again. The probe controls traffic routing; it does not create or repair virtual machines.

The inbound rule has `disable_outbound_snat = true` because outbound access is
configured separately. The outbound rule gives each backend instance 1,024
SNAT ports through the frontend public IP. This is enough for the small lab
workload and lets private instances download packages without individual
public IP addresses.

## Inputs and outputs

| Input | Purpose | Default |
| --- | --- | --- |
| `name_prefix` | Project and environment used in names | Required |
| `resource_group_name` | Resource group to use | Required |
| `location` | Azure region | Required |
| `tags` | Tags for supported resources | `{}` |
| `public_ip_zones` | Availability zones used by the public IP | Required |

The `backend_address_pool_id` output connects the VM Scale Set instances to the load balancer. The `health_probe_id` output allows VM Scale Set automatic repair to use the probe results, while `public_ip_address` exposes the address used by website visitors.

## Run from the project root

```powershell
terraform fmt -recursive
terraform init
terraform validate
terraform plan
```

The root compute module attaches every VM Scale Set instance to the backend pool. New and replacement instances join the same pool automatically.

## References

- [Azure Load Balancer components](https://learn.microsoft.com/en-us/azure/load-balancer/components)
- [Azure Load Balancer health probes](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-custom-probe-overview)
- [Azure Load Balancer outbound rules](https://learn.microsoft.com/en-us/azure/load-balancer/outbound-rules)
- [Terraform `azurerm_lb_rule`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule)
