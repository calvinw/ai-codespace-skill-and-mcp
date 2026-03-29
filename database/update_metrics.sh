#!/bin/bash
cd "$(dirname "$0")"
dolt sql < update_financial_metrics.sql 
dolt sql < update_segment_metrics.sql 
dolt sql < update_subsegment_metrics.sql
