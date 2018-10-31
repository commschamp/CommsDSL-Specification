## &lt;payload&gt; Layer
The **&lt;payload&gt;** layer represents message payload. It is the only 
**must-have** layer in the [frame](frames.md) definition. It doesn't have
any extra properties in addition to [common](common.md) ones.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema ...>
    <frame name="ProtocolFrame">
        ...
        <payload name="Data">
    </frame>
</schema>
```
