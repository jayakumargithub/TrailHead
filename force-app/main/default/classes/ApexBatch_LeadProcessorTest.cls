@isTest
public class LeadProcessorTest {
    @testSetup 
    static void setup()
   { 
        List<Lead> leadList = new List<Lead>();
        for(integer i=0; i < 200; i++){
            Lead l = new Lead(LastName = 'Name '+ i, Company='Company '+i);
            leadList.add(l);
        } 
       insert  leadList;
    }
    
    @isTest
    static void test(){
         Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(200, [select count() from Lead where LeadSource = 'Dreamforce'],'Count didn\'t match');
    }
}