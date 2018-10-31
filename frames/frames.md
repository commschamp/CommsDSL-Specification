# Frames
Every communication protocol must ensure that the message is successfully 
delivered over the I/O link to the other side. The serialised message payload 
must be wrapped in some kind of transport information prior to being sent and 
unwrapped on the other side when received. The **CommsDSL** allows specification
of such transport wraping using **&lt;frame&gt;** XML node.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame ...>
        ...
    </frame>
</schema> 
```

#### Name
Every frame definition must specify its [name](../intro/names.md) using
**name** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        ...
    </frame>
</schema> 
```

#### Description
It is possible to provide a description of the frame about what it is and
how it is expected to be used. This description is only for documentation
purposes and may find it's way into the generated code as a comment for the
generated class. The [property](../intro/properties.md) is **description**.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        <description>
            Some long
            multiline
            description
        </description>
        ...
    </frame>
</schema>
```

#### Layers
The protocol framing is defined using so called "layers", which are additional
abstraction on top of [fields](../fields/fields.md), where every such layer
has a specific purpose. For example:
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <enum name="MsgId" type="uint8" semanticType="messageId">
            <validValue name="Msg1" val=0x1" />
            <validValue name="Msg2" val=0x2" />
        </enum>
    </fields>
    
    <frame name="ProtocolFrame">
        <id name="Id" field="MsgId" />
        <payload name="Data" />
    </frame>
</schema>
```
The example above defines simple protocol framing where 1 byte of numeric message 
ID precedes the message payload.
```
ID (1 byte) | PAYLOAD
```

Available layers are:
- [&lt;payload&gt;](frames/payload.md) - Message payload.
- [&lt;id&gt;](frames/id.md) - Numeric message ID.
- [&lt;size&gt;](frames/size.md) - Remaining size (length).
- [&lt;sync&gt;](frames/sync.md) - Synchronization bytes.
- [&lt;checksum&gt;](frames/checksum.md) - Checksum.
- [&lt;value&gt;](frames/checksum.md) - Extra value, usually to be assigned to one of the
[&lt;interface&gt;](../interfaces/interfaces.md) fields.
- [&lt;custom&gt;](frames/custom.md) - Any other custom layer, not provided by **CommsDSL**. 

If there is any other [property](../intro/properties.md) defined as XML child
of the **&lt;frame&gt;**, then all the layers must be wrapped in 
**&lt;layers&gt;** XML element for separation.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame>
        <name value="ProtocolFrame" />
        <layers>
            <id name="Id" field="MsgId" />
            <payload name="Data" />
        </layers>
    </frame>
</schema>
```

All this layers have [common](common.md) as well as their own specific set of 
properties.

Use [properties table](../appendix/frame.md) for future references.
