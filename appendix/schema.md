# Properties of &lt;schema&gt;
|Property Name|Allowed type / value|Min DSL Version|Required|Description|
|-------------|-------------|-----------|--------|-----------|
|**name**|string|1|yes|Name of the protocol. Allowed to have spaces.|
|**endian**|"big" or "little"|1|no|Endian of the protocol.|
|**description**|string|1|no|Human readable description of the protocol.|
|**version**|[unsigned](../intro/numeric.md)|1|no|Version of the protocol. Defaults to **0**.|
|**dslVersion**|[unsigned](../intro/numeric.md)|1|no|Version of the used DSL. Defaults to **0**.|
|**nonUniqueMsgIdAllowed**|[bool](../intro/boolean.md)|1|no|Allow non-unique numeric message IDs. Defaults to **false**.|

