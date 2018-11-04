## Common Properties of Fields
Refer to [Common Properties of Fields](../fields/common.md) chapter for detailed description. 

|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**name**|[name](../intro/names.md) string|1|yes||Name of the field.|
|**description**|string|1|no||Human readable description of the field.|
|**reuse**|[reference](../intro/references.md) string|1|no||Field definition of which to copy.|
|**displayName**|string|1|no||Name of the field to display. If empty, the code generator must use value of property **name** instead. In order to force empty name to display, use "_" (underscore).|
|**displayReadOnly**|[bool](../intro/boolean.md)|1|no|false|Disable modification of the field in visual analysis tool(s).|
|**displayHidden**|[bool](../intro/boolean.md)|1|no|false|Don't display field at all in visual analysis tool(s).|
|**sinceVersion**|[unsigned](../intro/numeric.md)|1|no|0|Version of the protocol in which field was introduced.<br /> Applicable only to members of the [&lt;message&gt;](../messages/messages.md) or [&lt;bundle&gt;](../fields/bundle.md).|
|**deprecated**|[unsigned](../intro/numeric.md)|1|no|max unsigned|Version of the protocol in which field was deprecated.<br />Must be greater than value of **sinceVersion**.<br /> Applipable only to members of the [&lt;message&gt;](../messages/messages.md) or [&lt;bundle&gt;](../fields/bundle.md).|
|**removed**|[bool](../intro/boolean.md)|1|no|false|Indicates whether deprecated field has been removed from being serialized.<br /> Applicable only to members of the [&lt;message&gt;](../messages/messages.md) or [&lt;bundle&gt;](../fields/bundle.md).|
|**failOnInvalid**|[bool](../intro/boolean.md)|1|no|false|Fail *read* operation if read value is invalid.|
|**pseudo**|[bool](../intro/boolean.md)|1|no|false|In case of **true**, don't serialize/deserialize this field.|
|**customizable**|[bool](../intro/boolean.md)|1|no|false|Mark the field to allow compile time customization regardless of code generator's level of customization.|
|**semanticType**|"none", "messageId", "version"|1|no|none|Specify semantic type of the field. It allows code generator to generate special code for special cases.|

