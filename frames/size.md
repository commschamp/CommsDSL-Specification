## &lt;size&gt; Layer
The **&lt;size&gt;** layer represents **remaining** serialization length of the
[frame](frames.md). The [frame](frames.md) definition must **NOT** contain more 
than one **&lt;size&gt;** layer. 
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        <size name="Size">
            <int name="SizeField" type="uint16" />
        </size>
        <id name="Id">
            <int name="IdField" type="uint8" />  
        </id>
        <payload name="Data" />
    </frame>
</schema>
```
Some protocols may specify that the field of the **&lt;size&gt;** layer
contains its own length as well. The **CommsDSL** allows implementation of 
such case by adding usage of **serOffset** property to the field of the
**&lt;size&gt;** layer.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        <size name="Size">
            <int name="SizeField" type="uint16" serOffset="2"/>
        </size>
        <id name="Id">
            <int name="IdField" type="uint8" />  
        </id>
        <payload name="Data" />
    </frame>
</schema>
```

The example below implements `ID (2 bytes) | SIZE (2 bytes) | PAYLOAD` framing
where `SIZE` value includes length of the header (`ID` + `SIZE`) in addition to
the length of `PAYLOAD`.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        <id name="Id">
            <int name="IdField" type="uint16" />  
        </id>
        <size name="Size">
            <int name="SizeField" type="uint16" serOffset="4"/>
        </size>
        <payload name="Data" />
    </frame>
</schema>
```

The **&lt;size&gt;** layer doesn't have
any extra properties in addition to [common](common.md) ones.
