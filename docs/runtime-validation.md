# Runtime validation

The environment was deployed in Azure Australia East on 26 September 2026 and tested using the public load-balancer endpoint.

## Results summary

| Test | Result | Evidence |
| --- | --- | --- |
| Terraform deployment | Passed | The saved plan created 13 resources successfully. |
| Initial capacity | Passed | Two VM Scale Set instances were running in Zones 1 and 3. |
| Traffic distribution | Passed | Twenty requests were distributed evenly, with ten served by each instance. |
| Deleted-instance recovery | Passed | Instance 0 was deleted and Azure restored capacity with replacement instance 2. |
| Unhealthy-instance recovery | Passed | NGINX was stopped on instance 1. Azure reported it as unhealthy and automatic repair replaced it with instance 3. |
| Idempotency | Passed | A post-test Terraform plan returned exit code 0 and reported no changes. |
| Request continuity | Partially demonstrated | The surviving instance continued serving the site, although one transient failed request was recorded during each forced disruption. |

## Deleted-instance test

The scale set initially contained instances 0 and 1. Instance 0 was deliberately deleted while a request loop called the website every two seconds.

Azure Monitor autoscale restored the configured capacity of two instances. The final instance IDs were 1 and 2, showing that a new instance had been created rather than the deleted instance being restarted.

The request loop recorded:

- 294 successful HTTP 200 responses.
- One transient connection timeout.
- Successful responses from replacement instance 2 after recovery.

## Unhealthy web-service test

NGINX was deliberately stopped on instance 1 while the VM remained powered on. Azure subsequently reported the instance health as `HealthState/unhealthy`.

The load balancer removed the unhealthy backend from normal traffic, and instance 2 continued serving the website. VM Scale Set automatic instance repair then replaced instance 1 with instance 3.

The request loop recorded:

- 513 successful HTTP 200 responses.
- One transient connection failure during health detection.
- 448 responses from the surviving instance 2.
- 36 responses from replacement instance 3 after it joined the backend pool.
- One HTTP 200 response before the replacement instance’s hostname page was available.

After recovery, the scale set contained:

| Instance | Zone | Provisioning state | Power state |
| --- | --- | --- | --- |
| 2 | 3 | Succeeded | VM running |
| 3 | 1 | Succeeded | VM running |

## Availability observation

Both failure tests demonstrated that Azure restored the required capacity automatically and that the surviving instance continued serving requests after the failed backend was detected.

The aggressive two-second request loop recorded one transient failed connection during each forced disruption. Therefore, the test demonstrates automatic recovery and continued service without a sustained outage, but it does not claim that every in-flight request was preserved.

## Custom page rollout

The cloud-init configuration was updated with a customised NGINX status page. Terraform updated the VM Scale Set model in place without creating or destroying any Azure resources.

After the update, both existing instances reported that the latest VMSS model had been applied. Twelve requests were then sent through the public load balancer:

- Six requests were served by instance 2.
- Six requests were served by instance 3.
- Every response contained the customised Azure Auto-Healing Web Tier page.

This confirmed that the updated page was available from both backend instances and that load balancing continued to operate correctly.



## Final Terraform check

After both Azure-managed replacements completed, Terraform was run again with `-detailed-exitcode`. It reported:

```text
No changes. Your infrastructure matches the configuration.
Final plan exit code: 0
```

This confirms that the deployed infrastructure still matched the Terraform configuration after the runtime recovery tests.
