## Properties of &lt;schema&gt;
|Property Name|Allowed type / value|DSL Version|Required|Default Value|Description|
|:-----------:|:------------------:|:---------:|:------:|:-----------:|-----------|
|**name**|string|1|yes||Name of the protocol. Allowed to have spaces.|
|**endian**|"big" or "little"|1|no|little|Endian of the protocol.|
|**description**|string|1|no||Human readable description of the protocol.|
|**version**|[unsigned](../intro/numeric.md)|1|no|0|Version of the protocol.|
|**dslVersion**|[unsigned](../intro/numeric.md)|1|no|0|Version of the used DSL.|
|**nonUniqueMsgIdAllowed**|[bool](../intro/boolean.md)|1|no|false|Allow non-unique numeric message IDs.|

