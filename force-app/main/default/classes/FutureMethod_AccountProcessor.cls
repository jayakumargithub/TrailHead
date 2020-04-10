public class AccountProcessor {
    @future
    public static void countContacts(set<Id> accIds){
        integer contactCount = 0;
        List<Account> accountToUpdate = new List<Account>();
        
        List<Account> acList = [SELECT Id, (select Id from Contacts) from Account where Id in: accIds];
         
        System.debug('acList :' + acList.size());
        for(Account acc : acList){
            acc.Number_of_Contacts__c = acc.Contacts.size(); 
        }
        
        update acList;
    
    }
}