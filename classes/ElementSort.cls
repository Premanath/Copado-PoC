public class ElementSort
 {
  public list<vlocity_cmt__Element__c> elementList{get;set;}
  public ApexPages.StandardSetController standardSetController;
  private Set<Id> elementIds = new Set<Id>();
  
  public ElementSort(ApexPages.StandardSetController standardSetController){
      this.standardSetController = standardSetController;
      elementList = new List<vlocity_cmt__Element__c>();
      for (vlocity_cmt__Element__c elm : (List<vlocity_cmt__Element__c>)standardSetController.getSelected()){ 
          elementIds.add(elm.Id);
      }
    elementList = [SELECT Name,vlocity_cmt__Type__c,vlocity_cmt__Order__c,vlocity_cmt__ParentElementId__c FROM vlocity_cmt__Element__c WHERE ID IN: elementIds ORDER BY vlocity_cmt__Order__c ];
    }
}