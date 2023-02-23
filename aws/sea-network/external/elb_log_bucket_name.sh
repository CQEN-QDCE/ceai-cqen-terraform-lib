#!/bin/sh

aws configservice describe-config-rules --config-rule-names ASEA-ELB_LOGGING_ENABLED  --profile ${1} | jq -r '.ConfigRules[0].InputParameters'