global with sharing class QueryCurrencyExchange implements vlocity_cmt.VlocityOpenInterface
{
    global QueryCurrencyExchange() {}
    
    global Boolean invokeMethod(String methodName, Map<String,Object> inputMap, Map<String,Object> outMap, Map<String,Object> options) {
        Boolean result = true;
        try
        {
            if (methodName.equals('GetCurrency'))
            {
                GetCurrency(inputMap,outMap);
            }
            else 
            {
                result = false;
            }   
        } 
        catch(Exception e)
        {
            System.debug('QueryCases:invokeMethod -> exception: '+e);
            result = false;
        }
        
        return result;
    }
    void getAPIData(Map<String, Object> inputMapAPI, Map<String, Object> outMapAPI){
        String sCurrency = (String)inputMapAPI.get('Currency');
        System.debug(sCurrency);
        HttpRequest req = new HttpRequest(); 
        req.setMethod('GET');
        req.setEndpoint('https://api.btcmarkets.net/market/' + sCurrency + '/AUD/tick');
        Http http = new Http();
        
        HTTPResponse res = http.send(req);
        
        Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
        List<Map<String, String>>  returnList = new List<Map<String,String>>();
        Map<String, String> tempMap = new Map<String, String>();
        String str = String.valueOf(m.get('bestAsk'));
        tempMap.put('bestAsk',str);
        tempMap.put('bestBid',String.valueOf(m.get('bestBid'))); 
        tempMap.put('currency',String.valueOf(m.get('currency'))); 
        tempMap.put('instrument', String.valueOf(m.get('instrument'))); 
        tempMap.put('lastPrice', String.valueOf(m.get('lastPrice'))); 
        tempMap.put('timestamp',String.valueOf(m.get('timestamp'))); 
        tempMap.put('volume24h',String.valueOf(m.get('volume24h')));
        returnList.add(tempMap);
        
        outMapAPI.put('options', returnList);
        System.debug(outMapAPI);
        //return outMap;
    }
    
    void GetCurrency(Map<String, Object> inputMap, Map<String, Object> outMap)
    {
        String sAccountId = '0017F00000TTwOT';  //(String)inputMap.get('AccountId');
        System.debug('Id Entered: ' + sAccountId);
        List<Asset> AssetsList = [select Id, ProductCode, vlocity_cmt__ActivationName__c from Asset where vlocity_cmt__ActivationName__c = 'crypto' AND AccountId=:sAccountId];
        
        if(AssetsList != null && AssetsList.size() > 0)
        {
            List<Map<String, String>>  returnList = new List<Map<String,String>>();
            Map<String,Object> inps = new Map<String,Object>();
            Map<String,Object> outps = new Map<String,Object>();
            
            for (Asset a : AssetsList)
            {           
                Map<String, String> tempMap = new Map<String, String>();
                tempMap.put('Id', a.Id);
                tempMap.put('ProductCode', a.ProductCode);
                inps.put('Currency',a.ProductCode);
                getAPIData(inps,outps);
                System.debug(outps.get('options'));
                //tempMap.put('lastprice',String.valueOf(outps.get('options').get('lastPrice')));
                returnList.add(tempMap);
            }
            outMap.put('options', returnList);
            System.debug('These are my Cases' + returnList);
        }
        else{
            outMap.put('caseList', 'NOT FOUND');
        }    
        
    }        
}