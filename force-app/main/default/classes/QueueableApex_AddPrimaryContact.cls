public class AddPrimaryContact implements Queueable {

    private Contact contact;
    private String stateAbr;
    public AddPrimaryContact(Contact conVar, String state){
        this.contact = conVar;
        this.stateAbr = state;
    }
    
    public void execute(QueueableContext context){
        List<Account> accList = [Select Id, BillingState from Account where BillingState =: stateAbr limit 200];
        List<Contact> conList = new List<Contact>();
        for(Account acc : accList){
            Contact c = contact.clone(false,false,false,false);
            c.AccountId = acc.Id;
            conList.add(c);
        }
        
        if(conList.size() > 0){
            insert conList;
        }
    }
}