@isTest
public class AddPrimaryContactTest {
     
@testSetup
    public static void setup(){
       List<Account> accountsNy = new List<Account>();
        List<Account> accountsCA= new List<Account>();
        for(integer i=0; i<50; i++){
            Account acc = new Account(Name='Account '+i,BillingState = 'NY');
            accountsNy.add(acc);
        }
         for(integer i=0; i<50; i++){
            Account acc = new Account(Name='Account '+i,BillingState = 'CA');
             accountsCA.add(acc);
        }
        
        if(accountsNy.size() > 0){
            insert accountsNy;
        }
         if(accountsCA.size() > 0){
            insert accountsCA;
        }
    }
    
    @isTest
    public static void test(){
        
        Contact c = new Contact(FirstName='FirstName',LastName='LastName');
        insert c;
        String state = 'CA';
        AddPrimaryContact apc = new AddPrimaryContact(c, state); 
        Test.startTest();
        System.enqueueJob(apc);
        Test.stopTest();
        System.assertEquals(50, [select count() from account where BillingState = :state],'count did\'t match');

    }
}