# Terraform-New-Relic-Dashboard

## What is this

1. The script will install nr-dashboard-hcl-gen binary on local machine
2. If there is a [exported JSON document](https://docs.newrelic.com/docs/query-your-data/explore-query-data/dashboards/manage-your-dashboard/#dash-json) from New Relic dashboard, the tool will convert it to HCL configuration
3. With using terraform, we will reconfigure or create [`newrelic_one_dashboard`](https://registry.terraform.io/providers/newrelic/newrelic/latest/docs/resources/one_dashboard) using the already converted HCL configuration file.

## Usage

### Option with existed new relic dashboard

Run the script
you will be asked for the json file location and about providing the resource label

```
curl {{ repository.name }}/scripts/install.sh | bash
```

### Option for creating new dashboard on new relic with terraform

edit main.tf file, write new dashboard resource and terraform apply here

You can use [this](https://newrelic.com/blog/how-to-relic/how-to-create-syslog-dashboard-using-new-relic-terraform) documentation to check how to create dashboard in this way.

## What Terraform version should I use?

This is not locked to a specific terraform version and should be safe for anything 0.12.31 and greater.  If you run into any specific issues please submit a bug ticket.  It is advised to use Terraform 0.13+ as 0.12.31 has warnings due to syntax changes.