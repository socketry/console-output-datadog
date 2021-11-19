# Getting Started

This guide explains how to use `console-output-datadog` for correlating logs.

## Installation

Add the gem to your project:

~~~ bash
$ bundle add console
~~~

## Usage

This output wrapper adds the datadog `trace_id` and `span_id` to log messages.

<pre>&gt; <font color="#00AFFF">CONSOLE_OUTPUT</font><font color="#00A6B2">=</font><font color="#00AFFF">Console::Output::Datadog,Console::Output::Default</font> <font color="#005FD7">./example.rb</font>
<font color="#AA5500">  0.0s     warn:</font> <b>Object</b> <font color="#717171">[oid=0x64] [ec=0x78] [pid=118793] [2021-11-19 18:13:30 +1300]</font>
               | {&quot;dd&quot;:{&quot;trace_id&quot;:&quot;602300336988272683&quot;,&quot;span_id&quot;:&quot;351497567211870727&quot;}}
               | Hello World
<font color="#AA0000">  0.0s    error:</font> <b>Object</b> <font color="#717171">[oid=0x64] [ec=0x78] [pid=118793] [2021-11-19 18:13:30 +1300]</font>
               | {&quot;dd&quot;:{&quot;trace_id&quot;:&quot;602300336988272683&quot;,&quot;span_id&quot;:&quot;351497567211870727&quot;}}
               |   <font color="#AA0000"><b>RuntimeError</b></font>: Boom
               |   → <font color="#710000">./example.rb:12</font><font color="#7C7E79"> in `block in &lt;main&gt;&apos;</font>
               |     <font color="#710000">/home/samuel/.gem/ruby/2.7.4/gems/ddtrace-0.54.0/lib/ddtrace/tracer.rb:283</font><font color="#7C7E79"> in `trace&apos;</font>
               |     <font color="#710000">./example.rb:8</font><font color="#7C7E79"> in `&lt;main&gt;&apos;</font>
</pre>
