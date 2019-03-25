## &lt;custom&gt; Layer
The **&lt;custom&gt;** layer represent any other protocol specific layer, 
functionality of which cannot be impelemented using other provided layers.
The code generator must allow injection of the externally implemented code
of the layer functionality when generating code relevant to the 
transport [framing](frames.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        <size name="Size">
            ...
        </size>
        <custom name="SomeCustomLayer">
            <int name="SomeField" type="uint8" />
        </custom>
        <id name="Id">
            ...  
        </id>
        <payload name="Data" />
    </frame>
</schema>
```

The **&lt;value&gt;** layer has all the [common](common.md) properties
as well as extra properties and elements described below.

#### ID Replacement
Most protocol frames are expected to use [&lt;id&gt;](id.md) layer to
process numeric ID of the message. However, there are protocols that may
use the same field not only for numeric ID, but also for some extra flags.
In this case [&lt;id&gt;](id.md) layer cannot be used, because it expects the
whole field to be dedicated to storage of the numeric ID. In such case
**&lt;custom&gt;** layer needs to be used but marked as one replacing the 
[&lt;id&gt;](id.md) with **idReplacement** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        <size name="Size">
            ...
        </size>
        <custom name="IdAndFlags" idReplacement="true">
            <bitfield name="IdAndFlagsField">
                <int name="Id" type="uint16" bitLength="12" />
                <set name="Flags" bitLength="4">
                    ...
                </set>
            </bitfield>
        </custom>
        <payload name="Data" />
    </frame>
</schema>
```

Use [properties table](../appendix/custom.md) for future references.
