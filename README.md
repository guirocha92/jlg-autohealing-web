# Azure Auto-Healing Web Tier

Infrastructure-as-code technical assessment for Johns Lyng Group.

## Goal

Build a static NGINX website on Azure that remains available after one VM fails
and automatically restores its instance capacity.

## Planned requirements

- Provision the infrastructure using Terraform.
- Run at least two Linux web instances behind a load balancer.
- Automatically replace a terminated instance.
- Provide enough spare capacity for the surviving instance to handle the assumed workload.
- Make repeated deployments produce no changes when the configuration and infrastructure are unchanged.

## Why Azure

Azure is relevant to the role's Microsoft cloud environment. An existing Azure
account is available for optional deployment and testing.

## Cost and validation

The brief requests an estimated ongoing cost of no more than AUD 20 per month.
The estimate and any budget difference will be documented before deployment.
Temporary trial credits will not be counted as a reduction in ongoing cost.

## Current status

Repository setup only. Terraform configuration, the architecture diagram,
deployment instructions, cost estimates and validation evidence will be added
as the project develops. No infrastructure has been deployed for this project.
