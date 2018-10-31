## &lt;id&gt; Layer
The **&lt;id&gt;** layer represents numeric message ID. The 
[frame](frames.md) definition must **NOT** contain more than one **&lt;id&gt;** 
layer. 
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        <id name="Id">
            <int name="IdField" type="uint8" />  
        </id>
        <payload name="Data" />
    </frame>
</schema>
```
The **&lt;id&gt;** layer doesn't have
any extra properties in addition to [common](common.md) ones.
