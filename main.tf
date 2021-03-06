terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
}

provider "datadog" {
  api_key = var.apikey
  app_key = var.appkey
}
#Add datadog monitor
resource "datadog_monitor_json" "monitor_json" {
  monitor = <<-EOF
{
	"name": "Service frontend has a high average latency on env:dev serviceteam:domainarchitecture",
	"type": "query alert",
	"query": "avg(last_1m):avg:trace.servlet.request{env:dev,service:frontend,serviceteam:domainarchitecture} > 0.5",
	"message": "`frontend` average latency is too high.\n\n@martin.francis@ferguson.com",
	"tags": [
		"harnessdemo"
	],
	"options": {
		"thresholds": {
			"critical": 0.5,
			"warning": 0.1
		},
		"notify_audit": false,
		"require_full_window": false,
		"notify_no_data": false,
		"no_data_timeframe": 10,
		"renotify_interval": 0,
		"locked": false,
		"silenced": {},
		"include_tags": true,
		"escalation_message": ""
	},
	"priority": 3
}
EOF
}

