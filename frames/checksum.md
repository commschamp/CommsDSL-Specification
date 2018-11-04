## &lt;checksum&gt; Layer
The **&lt;checksum&gt;** layer represents checksum bytes, usually (but not always) 
present at the end of the [frame](frames.md). 
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        <sync name="Sync">
            ...
        </sync>
        <size name="Size">
            ...
        </size>
        <id name="Id">
            ...  
        </id>
        <payload name="Data" />
        <checksum name="Checksum" ...>
            <int name="ChecksumField" type="uint16" />
        </checksum>
    </frame>
</schema>
```
The **&lt;checksum&gt;** layer has all the [common](common.md) properties
as well as extra properties and elements described below.

#### Checksum Algorithm
The checksum calculation algorithm must be specified using **alg**
[property](../intro/properties.md). Supported values are:
- **sum** - Sum of all the bytes.
- **crc-ccitt** (aliases: **crc_ccitt**) - [CRC-16-CCITT](https://en.wikipedia.org/wiki/Cyclic_redundancy_check)
where polynomial is `0x1021`, initial value is `0xffff`, final XOR value is `0`, and no reflection of bytes.
- **crc-16** (aliases: **crc_16**) - [CRC-16-IBM](https://en.wikipedia.org/wiki/Cyclic_redundancy_check),
where polynomial is `0x8005`, initial value is `0`, final XOR value is `0`, reflection is performed on every
byte as well as final value.
- **crc-32** (aliases: **crc_32**) - [CRC-32](https://en.wikipedia.org/wiki/Cyclic_redundancy_check),
where polynomial is `0x04C11DB7`, initial value is `0xffffffff`, final XOR value is `0xffffffff`, reflection is
performed on every byte as well as final value.
- **custom** - Custom algorithm, code for which needs to be provided to the
code generator, so it can copy it to the generated code.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        ...
        <payload name="Data" />
        <checksum name="Checksum" alg="crc-16" ...>
            <int name="ChecksumField" type="uint16" />
        </checksum>
    </frame>
</schema>
```

When **custom** algorithm is selected, its name must be provided using 
**algName** property.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        ...
        <payload name="Data" />
        <checksum name="Checksum" alg="custom" algName="MyCustomChecksumCalc" ...>
            <int name="ChecksumField" type="uint16" />
        </checksum>
    </frame>
</schema>
```
The provided name of the custom algorithm can be used by the code generator
to locate the required external implementation file and use appropriate 
class / function name when the calculation functionality needs to be invoked.

#### Calculation Area
The **custom** layer definition must also specify the layers, data of which is
used to calculate the checksum. It is done using **from** property that is
expected to specify name of the layer where checksum calculation starts.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        <sync name="Sync">
            ...
        </sync>
        <size name="Size">
            ...
        </size>
        <id name="Id">
            ...  
        </id>
        <payload name="Data" />
        <checksum name="Checksum" alg="crc-16" from="Size">
            <int name="ChecksumField" type="uint16" />
        </checksum>
    </frame>
</schema>
```
The example above defines `SYNC | SIZE | ID | PAYLOAD | CHECKSUM` frame where
the checksum is calculated on `SIZE` + `ID` + `PAYLOAD` bytes.

Some protocols may put checksum value as prefix to the area on which the
checksum needs to be calculated. In this case use **until** property (instead
of **from**) to specify layers for checksum calculation.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        <sync name="Sync">
            ...
        </sync>
        <size name="Size">
            ...
        </size>
        <id name="Id">
            ...  
        </id>
        <checksum name="Checksum" alg="crc-16" until="Data">
            <int name="ChecksumField" type="uint16" />
        </checksum>
        <payload name="Data" />
    </frame>
</schema>
```

#### Checksum Verification Order
The default behavior of the **&lt;checksum&gt;** layer is to perform calculation
after all relevant layers and their fields have been successfully read and
processed. However, it is possible to
force the checksum verification right away (without reading fields of other layers
and/or message payload).
It is usually possible to do when value of the [&lt;size&gt;](size.md) field
is already processed, so the right location of checksum value is known, 
and it is not included in checksum calculation. To force immediate checksum
verification use **verifyBeforeRead** [property](../intro/properties.md) with
[boolean](../intro/boolean.md) value.
```
<?xml version="1.0" encoding="UTF-8"?>
<schema endian="big" ...>
    <frame name="ProtocolFrame">
        <sync name="Sync">
            ...
        </sync>
        <size name="Size">
            ...
        </size>
        <id name="Id">
            ...  
        </id>
        <checksum name="Checksum" alg="crc-16" until="Data" verifyBeforeRead="true">
            <int name="ChecksumField" type="uint16" />
        </checksum>
        <payload name="Data" />
    </frame>
</schema>
```

Use [properties table](../appendix/checksum.md) for future references.
