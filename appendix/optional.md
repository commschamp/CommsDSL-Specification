## Properties of &lt;optional&gt; Field
The **&lt;optional&gt;** field has all the [common](fields.md) properties as
well as ones listed below. Refer to [&lt;optional&gt; Field](../fields/optional.md) chapter
for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**field**|[field](../fields/fields.md)|1|no||Wrapped field.|
|**defaultMode**|"tentative", "missing", "exist"|1|no|tentative|Default mode of the field. See also [Default Mode Strings](#default-mode-strings) below.|
|**cond**|string|1|no||Condition when the field exists.|
|**displayExtModeCtrl**|[bool](../intro/boolean.md)|1|no|false|Disable manual update of the mode in GUI analysis tools.|

Inner field must be specified using **field** property or as 
child XML element. 

Extra child XML elements allowed:

|XML Element|DSL Version|Description|
|:---------:|:---------:|-----------|
|**&lt;field&gt;**|1|Wraps member field.|
|**&lt;cond&gt;**|1|Condition when field exists.|
|**&lt;and&gt;**|1|Logical "and" of conditions.|
|**&lt;or&gt;**|1|Logical "or" of conditions.|

#### Default Mode Strings
|Mode|Accepted Values (case insensitive)|
|----------|:--------------|
|Tentative|"tentative", "tent", "t"|
|Missing|"missing", "miss", "m"|
|Exist|"exist", "exists", "e"|


