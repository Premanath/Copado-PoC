Global with sharing class BillAvailability implements vlocity_cmt.GlobalInterfaces.ProductAvailabilityInterface{
   Global List<PricebookEntry> getAvailableProducts (SObject item, List<PriceBookEntry> retval) {
            retval = new List<PriceBookEntry> ();
            try{
                Id itemId = (Id)item.get('Pricebook2Id');
                retval = [Select Id
                                 ,Pricebook2Id
                                 ,Product2Id
                                 ,ProductCode
                                 ,Product2.Description
                                 ,UnitPrice
                                 ,Name
                                 ,Product2.Name
                                 ,Product2.vlocity_cmt__JSONAttribute__c
                                 ,vlocity_cmt__RecurringPrice__c 
                                 ,IsActive
                                from PricebookEntry
                                where Pricebook2Id = :itemId and Product2.Name like 'A%'];
            }catch(Exception e){
                throw e;
            }
       
       
       for (PriceBookEntry pbe: retval) {
           pbe.Product2.Name = 'Bill ' + pbe.Product2.Name;
       }
       
       return retval;
    }
   
    
}