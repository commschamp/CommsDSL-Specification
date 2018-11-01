## &lt;sync&gt; Layer
The **&lt;sync&gt;** layer represents synchronization bytes, usually (but not always) 
present at the beginning of the [frame](frames.md). 
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        <sync name="Sync">
            <int name="SyncField" type="uint16" defaultValue="0xabcd">
                <validValue value="0xabcd" />
                <failOnInvalid value="true" />
            </int>
        </sync>
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
The example below implements `SYNC (2 bytes) | ID (2 bytes) | SIZE (2 bytes) | PAYLOAD` framing
where `SYNC` must be `0xab 0xcd` bytes. Note, that read of the `SyncField` will
fail in case its read value is not `0xabcd`. 

The **&lt;sync&gt;** layer doesn't have
any extra properties in addition to [common](common.md) ones.
