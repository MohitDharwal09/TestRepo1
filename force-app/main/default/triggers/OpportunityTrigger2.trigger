trigger OpportunityTrigger2 on Opportunity (after update) 
{
    Set<Id> idset = new Set<Id>();
    String info = '';
    if(trigger.isAfter)
    {
        if(trigger.isUpdate)
        {
            for(Opportunity opp:trigger.new)
            {
                if(opp.Id !=  null)
                {
                    idset.add(opp.Id);
                    info = opp.Info__c;
                }
            }
            System.debug('Info :'+ info);
            List<OpportunityLineItem> oliList = [SELECT Id,Name,OpportunityId,Opp_Info__c FROM OpportunityLineItem where OpportunityId In:idset];
            System.debug(oliList);
            List<OpportunityLineItem> oliList2 = new List<OpportunityLineItem>();
            for(OpportunityLineItem oli:oliList)
            {
                if(oli.Id !=  null)
                {
                 	oli.Opp_Info__c = info;  
                	oliList2.add(oli);   
                }
            }
            System.debug('OLI LisT :'+oliList2);
            update oliList2;
        }
    }
}