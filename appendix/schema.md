# Properties of &lt;schema&gt;
|Property Name|Allowed type / value|Min DSL Version|Required|Description|
|-------------|-------------|-----------|--------|-----------|
|&lt;name&gt;|string|1|yes|Name of the protocol. Allowed to have spaces.|
|&lt;endian&gt;|"big" or "little"|1|no|Endian of the protocol.|
|&lt;description&gt;|string|1|no|Human readable description of the protocol.|
|&lt;version&gt;|[unsigned](../intro/numeric.md)|1|no|Version of the protocol. Defaults to **0**.|
|&lt;dslVersion&gt;|[unsigned](../intro/numeric.md)|1|no|Version of the used DSL. Defaults to **0**.|
|&lt;nonUniqueMsgIdAllowed&gt;|[bool](../intro/boolean.md)|1|no|Allow non-unique numeric message IDs. Defaults to **false**.|

