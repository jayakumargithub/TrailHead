@isTest
public class DailyLeadProcessorTest {
    
    @testSetup
    public static void testSetup(){
        List<Lead> leads = new List<Lead>();
        for(integer i=1; i <= 100; i++){
            Lead l  = new Lead(LastName='LeadName' +i, Company='LeadAccount');
            leads.add(l);
        }
        if(leads.size() > 0){
            insert leads;
        }
    }
	@isTest
    public static void test(){
        Test.startTest();
        string cornEexp = '0 0 0 15 3 ? 2022';
        String jobId = System.schedule('DailyLeadPocessor',cornEexp, new DailyLeadProcessor()); 
        List<Lead> lt = [SELECT Id FROM Lead where LeadSource = 'Dreamforce' limit 200];
        System.assertEquals(0, lt.size(), 'Tasks exist before job has run'); 
        Test.stopTest();
        
        List<Lead> leads = [SELECT Id FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(100, leads.size(), 'Lead Updated!');
    }
}