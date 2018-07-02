global class FNNOptions implements vlocity_cmt.VlocityOpenInterface
{    
public Boolean invokeMethod(String methodName, Map<String, Object> input, Map<String, Object> outMap, Map<String, Object> options)
{
if (methodName.equals('PopulateOptions'))
{
System.debug('Apex Pick List invoked ');
PopulateOptions(input, outMap, options);
}
return true;
}
    
    //FNNOptions.PopulateOptions

// Get All Relationship Types for Account when the Omniscript is compiled.

public void PopulateOptions(Map<String, Object> input, Map<String, Object> outMap, Map<String, Object> options)
{
List<Map<String,String>> options1 = new List<Map<String, String>>();
Map<String, String> tempMap = new Map<String, String>();
tempMap.put('name', '132'); // Language Independent
tempMap.put('value', '02 9866 5297'); // Displayed in Picklist UI
options1.add(tempMap);
    tempMap = new Map<String, String>();
tempMap.put('name', '465'); // Language Independent
tempMap.put('value', '02 9866 5298'); // Displayed in Picklist UI
options1.add(tempMap);
    tempMap = new Map<String, String>();
tempMap.put('name', '789'); // Language Independent
tempMap.put('value', '02 9866 5299'); // Displayed in Picklist UI
options1.add(tempMap);
    tempMap = new Map<String, String>();
tempMap.put('name', '1747'); // Language Independent
tempMap.put('value', '02 9866 5300'); // Displayed in Picklist UI
options1.add(tempMap);
    tempMap = new Map<String, String>();
tempMap.put('name', '15454'); // Language Independent
tempMap.put('value', '02 9866 5301'); // Displayed in Picklist UI
options1.add(tempMap);
System.debug(options1);
outMap.put('options',options1);
}
}