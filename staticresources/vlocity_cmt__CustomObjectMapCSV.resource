"Name","SourceParentObject__c","DestinationParentObject__c","SourceChildObject__c","DestinationChildObject__c","ParentSourceReferenceField__c","ParentDestinationReferenceField__c"
"Opportunity>Quote","Opportunity","Quote","OpportunityLineItem","QuoteLineItem","OpportunityId","QuoteId"
"Quote>Order","Quote","Order","QuoteLineItem","OrderItem","QuoteId","OrderId"
"Order>Account","Order","Account","OrderItem","Asset","OrderId","AccountId"
"Account>Order","Account","Order","Asset","OrderItem","AccountId","OrderId"
"Account>Quote","Account","Quote","Asset","QuoteLineItem","AccountId","QuoteId"
"QuotePriceAdj>OrderPriceAdj","Quote","Order","QuotePricingAdjustment__c","OrderPriceAdjustment__c","QuoteId__c","OrderId__c"
"QLIPricingAdj>OLIPriceAdj","QuoteLineItem","OrderItem","QuoteLineItemPricingAdjustment__c","OrderItemPriceAdjustment__c","QuoteLineItemId__c","OrderItemId__c"
"OLIPriceAdj>AssetPriceAdj","OrderItem","Asset","OrderItemPriceAdjustment__c","AssetPricingAdjustment__c","OrderItemId__c","AssetId__c"
"AssetPriceAdj>OLIPriceAdj","Asset","QuoteLineItem","AssetPricingAdjustment__c","QuoteLineItemPricingAdjustment__c","AssetId__c","QuoteLineItemId__c"
"AssetPriceAdj>QLIPriceAdj","Asset","OrderItem","AssetPricingAdjustment__c","OrderItemPriceAdjustment__c","AssetId__c","OrderItemId__c"