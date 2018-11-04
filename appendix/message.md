## Properties of &lt;message&gt;
Refer to [Messages](../messages/messages.md) chapter
for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**name**|[name](../intro/names.md) string|1|yes||Name of the message.|
|**id**|[numeric](../intro/numeric.md)|1|yes||Numeric ID of the message.|
|**description**|string|1|no||Human readable description of the interface.|
|**displayName**|string|1|no||Name of the message to display. If empty, the code generator must use value of property **name** instead.|
|**copyFieldsFrom**|[reference](../intro/references.md) string|1|no||Message definition from which fields need to be copied.|
|**order**|[numeric](../intro/numeric.md)|1|no|0|Relative order of the messages with the same **id**.|
|**sinceVersion**|[unsigned](../intro/numeric.md)|1|no|0|Version of the protocol in which message was introduced.|
|**deprecated**|[unsigned](../intro/numeric.md)|1|no|max unsigned|Version of the protocol in which message was deprecated.<br />Must be greater than value of **sinceVersion**.|
|**removed**|[bool](../intro/boolean.md)|1|no|false|Indicates whether deprecated message has been removed from being supported.|
|**sender**|"both", "client", "server"|1|no|both|Endpoint that sends the message.| 
|**customizable**|[bool](../intro/boolean.md)|1|no|false|Mark the message to allow compile time customization regardless of code generator's level of customization.|


The **&lt;message&gt;** also allows listing of fields using
**&lt;fields&gt;** child XML element.

