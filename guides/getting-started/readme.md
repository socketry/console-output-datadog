# Getting Started

This guide explains how to use `console-output-datadog` for correlating logs.

## Installation

Add the gem to your project:

~~~ bash
$ bundle add console-output-datadog
~~~

## Usage

This output wrapper adds the datadog `trace_id` and `span_id` to log messages.

