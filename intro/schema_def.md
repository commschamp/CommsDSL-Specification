## Schema Definition
The **CommsDSL** schema files use [XML](https://en.wikipedia.org/wiki/XML) to
define all the messages, their fields, and framing.

Every schema definition file must contain a valid XML with an encoding
information header as well as **single** root node called **&lt;schema&gt;**:
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    ...
</schema>
```
The schema node may define its properties (described in detail in 
[Schema](../schema/schema.md) chapter).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema name="MyProtocol" endian="big" version="2">
    ...
</schema>
```

#### Common Fields
It can also contain definition of various common fields that can be referenced
by multiple messages. Such fields are defined as children of **&lt;fields&gt;** node.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <fields>
        <int name="SomeField> type="uint8" />
        ...
    </fields>
</schema>
```
There can be multiple **&lt;fields&gt;** elements in the same schema definition file.
The fields are described in detail in [Fields](../fields/fields.md) chapter.

#### Messages
The definition of a single message is done using **&lt;message&gt;** node (described
in detail in [Messages](../messages/messages.md) chapter).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <message name="SomeMessage" id="1">
        ...
    </message>
    
    <message name="SomeOtherMessage" id="2">
        ...
    </message>
</schema>
```
Multiple messages can (but don't have to) be bundled together as children of **&lt;messages&gt;** node.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <messages>
        <message name="SomeMessage" id="1">
            ...
        </message>
        
        <message name="SomeOtherMessage" id="2">
            ...
        </message>
    </messages>
</schema>
```

#### Framing
Transport framing is defined using **&lt;frame&gt;** node (described in detail in
[Frames](../frames/frames.md) chapter).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="SomeFrame">
        <size ... />
        <id ... />
        <payload ... />
    </frame>
</schema> 
```
Multiple frames can (but don't have to) be bundled together as children of **&lt;frames&gt;** node.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frames>
        <frame name="SomeFrame">
            ...
        </frame>
        
        <frame name="SomeOtherFrame">
            ...
        </frame>        
    </frames>
</schema> 
```

#### Interface
There are protocols that put some information, common to all the messages, such as 
protocol version and/or extra flags, into the framing information instead of message payload.
This information needs to be accessible when message payload is being read or
message object is being handled by the application. The 
[COMMS Library](https://github.com/arobenko/comms_champion#comms-library)
handles these cases by having a common interface class for all the messages, which
contains this extra information. In order to support such cases, the **CommsDSL** 
introduces optional node **&lt;interface&gt;** (described in detail in 
[Interfaces](../interfaces/interfaces.md) chapter) for description of such common
interfaces.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <interface name="CommonInterface">
        <int name="version" type="uint16" semanticType="version" />
    </interface>
</schema> 
```
Multiple interfaces can (but don't have to) be bundled together as children of **&lt;interfaces&gt;** node.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <interfaces>
        <interface name="CommonInterface">
            ...
        </interface>
        
        <interface name="SomeOtherInterface">
            ...
        </interface>        
    </interfaces>
</schema> 
```

All the nodes described above are allowed to appear in any order.

