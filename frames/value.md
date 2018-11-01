## &lt;value&gt; Layer
The **&lt;value&gt;** layer represents extra values (such as protocol version
and/or extra flags), that are applicable to
all the messages, but delivered as part of transport [framing](frames.md) instead
of message payload.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        <size name="Size">
            ...
        </size>
        <value name="Version" ...>
            <int name="VersionField" type="uint8" />
        </value>
        <id name="Id">
            ...  
        </id>
        <payload name="Data" />
    </frame>
</schema>
```
The **&lt;value&gt;** layer has all the [common](common.md) properties
as well as extra properties and elements described below.

#### Interfaces
In most cases the received value must be reassigned to appropriate field of
the [&lt;interface&gt;](../interfaces/interfaces.md). To specify the supported
interfaces use **interfaces** [property](../intro/properties.md). The value
of the property is comma separated list of [reference](../intro/references.md) 
names of the supported interfaces.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <interface name="Interface1">
        <int name="Version" type="uint8" semanticType="version" />
    </interface>
    
    <interface name="Interface2">
        <int name="Version" type="uint8" semanticType="version" />
        <set name="Flags> length="1">
            ...
        </set>
    </interface>
    
    
    <frame name="ProtocolFrame">
        <size name="Size">
            ...
        </size>
        <value name="Version" interfaces="Interface1, Interface2" ...>
            <int name="VersionField" type="uint8" />
        </value>
        <id name="Id">
            ...  
        </id>
        <payload name="Data" />
    </frame>
</schema>
```
In addition to specifying the interfaces themselves, there is a need to
specify the field name in the interface(s), that will hold the processed value,
using **interfaceFieldName** [property](../intro/properties.md).
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <interface name="Interface1">
        <int name="Version" type="uint8" semanticType="version" />
    </interface>
    
    <interface name="Interface2">
        <int name="Version" type="uint8" semanticType="version" />
        <set name="Flags> length="1">
            ...
        </set>
    </interface>
    
    
    <frame name="ProtocolFrame">
        <size name="Size">
            ...
        </size>
        <value name="Version" interfaces="Interface1, Interface2">
            <interfaceFieldName value="Version" />
            <field>
                <int name="VersionField" type="uint8" />
            </field>
        </value>
        <id name="Id">
            ...  
        </id>
        <payload name="Data" />
    </frame>
</schema>
```
**NOTE**, that all the interfaces listed in the **interfaces** property value
must have a field with the name specified as the **interfaceFieldName** value.
Also the specified field's index (among other available fields of the **&lt;interface&gt;**) 
must be the same for all the listed interfaces.

#### Pseudo Value Layer
There are protocols that don't report protocol version in their transport
framing. Instead, they use some special "connection" message that report
protocol version. As the result, all subsequent messages must adhere to the
reported protocol. The **CommsDSL** resolves this problem by defining 
**pseudo** **&lt;value&gt;** layer using **pseudo** [property](../intro/properties.md)
with [boolean](../intro/boolean.md) value. The field of the pseudo **&lt;value&gt;** layer
does not get serialized. However, the code generator must allow external
assignment of the required value to the private data members of the 
**&lt;value&gt;** layer's class.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <interface name="Interface1">
        <int name="Version" type="uint8" semanticType="version" />
    </interface>
    
    <message name="Connect" id="1">
        <int name="ProtocolVersion" type="uint8" />
    </message>
    
    <frame name="ProtocolFrame">
        <size name="Size">
            ...
        </size>
        <id name="Id">
            ...  
        </id>
        <value name="Version" interfaces="Interface1" pseudo="true">
            <interfaceFieldName value="Version" />
            <field>
                <int name="VersionField" type="uint8" />
            </field>
        </value>
        <payload name="Data" />
    </frame>
</schema>
```
The location of the pseudo **&lt;value&gt;** layer within the **&lt;frame&gt;** 
is not important. It is recommended to define it right before the **&lt;payload&gt;**
layer.

As part of processing *Connect* message in the example above, the client code
is expected to retrieve the value of the *ProtocolVersion* field and report
it to the pseudo **&lt;value&gt;** layer within the processing frame. For 
all the subsequent messaged, the pseudo **&lt;value&gt;** layer is responsible 
to assign appropriate value (version in the example above) to the newly created 
message object before message payload gets read. This is because such values 
may have an influence on how the *read* operation is executed (existence of 
some fields may depend on the assigned value).

Use [properties table](../appendix/value.md) for future references.
