trigger VU_AccountContact on VU_AccountContact__c (before insert, after insert, before update, after update) {
vlocity_cmt.DRGlobal.triggerHandler(Trigger.new);
}