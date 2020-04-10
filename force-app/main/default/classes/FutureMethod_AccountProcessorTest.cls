@isTest
public class AccountProcessorTest {
	@isTest 
    private static void countContactsAndUpdateAccount(){
        Account account = New Account(Name = 'Account Number 1');
        insert account;
        
        List<Contact> contacts = new List<Contact>();
        contacts.add(New Contact(lastname = 'Related Contact 1', AccountId = account.Id));
        contacts.add(New Contact(lastname = 'Related Contact 2', AccountId = account.Id));
        contacts.add(New Contact(lastname = 'Related Contact 3', AccountId = account.Id));
        contacts.add(New Contact(lastname = 'Related Contact 4', AccountId = account.Id));
        insert contacts;
        
        Set<Id> accountIds = new Set<Id>();
        accountIds.add(account.id);
        
        Test.startTest();
        AccountProcessor.countContacts(accountIds);
        Test.stopTest();
        Account ACC = [SELECT Number_of_Contacts__c FROM Account WHERE id = :account.Id LIMIT 1];
        System.assertEquals( Integer.valueOf(ACC.Number_of_Contacts__c) , 4);
    }
}