global with sharing class new_SidebarMapController {

	public String googleAPIKey {get; set;}
	
	public new_SidebarMapController(Apexpages.Standardcontroller ctrl) { 
		Google_Settings__c google = Google_Settings__c.getValues('Map Key');
		googleAPIKey = google.maps_api_key__c;
	}
	
	@RemoteAction
	global static String getAddress(String objectId) {
		
		AddressDataWrapper wrapper = new AddressDataWrapper();
		
		if(objectId != null && !objectId.equals('') && !objectId.equals('null')) {
			Id objId = Id.valueOf(objectId);		
			String queryString = '';
			try {
				if (objId.getSobjectType() == Schema.Account.getSObjectType()) {
					wrapper.address = getAccountAddress(objId);
					wrapper.instruction = 'show';
					
					// handle the case that a PersonAccount is being displayed
					// Needed because PersonAccounts are enabled in this org.
					if(wrapper.address.contains('null')) {
						Account a = [select ispersonaccount, personcontactid from account where id =: objId];
						if(a.ispersonaccount) {
							wrapper.address = getContactAddress(a.personcontactid);
							if(wrapper.address.contains('null')) {
								wrapper.instruction = 'empty';
							}
						}
					} 	
				} else {
					wrapper.instruction = 'hide';
				}
			} catch (QueryException qe) {
				wrapper.instruction = 'error';
				wrapper.errorMessage = qe.getMessage();
			}	
		}else {
			wrapper.instruction = 'hide';	
		}

		return JSON.serialize(wrapper);
	}
	
	private static String getAccountAddress (Id objId) {
		
		String queryString = 'select BillingStreet, BillingState, BillingPostalCode, BillingCountry, BillingCity from account where id = \''+objId+'\' limit 1';
		System.debug('~~ Query for Address ['+queryString+']');
		Account a = ((List<Account>)Database.query(queryString)).get(0);
		return a.billingstreet + ' ' + a.billingcity + ' ' + a.billingState + ' ' + a.billingpostalcode;
	}
	
	private static String getContactAddress (Id objId) {
		String queryString = 'select mailingStreet, mailingState, mailingPostalCode, mailingCountry, mailingCity from contact where id = \''+objId+'\' limit 1';
		System.debug('~~ Query for Address ['+queryString+']');
		Contact c = ((List<Contact>)Database.query(queryString)).get(0);
		return c.mailingStreet + ' ' + c.mailingcity + ' ' + c.mailingstate + ' ' + c.mailingpostalcode;
	}
	
	
	public class AddressDataWrapper {
		
		public String address {get; set;}
		public String instruction {get; set;}
		public String errorMessage {get; set;}
		
		
	}
}