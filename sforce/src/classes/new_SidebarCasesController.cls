global class new_SidebarCasesController {

	public new_SidebarCasesController() { }
	
	@RemoteAction
	global static String getCasesAsJSON(String objectId) {
		
		ObjectWrapper ow = new ObjectWrapper();
		ow.parentObjectId = objectId;
		
		if(objectId != null && !objectId.equals('') && !objectId.equals('null')) {
			Id objId = Id.valueOf(objectId);
			List<Case> cases = new List<Case>();
			Map<String, Schema.FieldSet> fieldSets = Schema.SObjectType.Case.fieldSets.getMap();
			List<String> fieldLabels = new List<String>();
			List<String> fieldNames = new List<String>();
			
			// if we are focused on an account or a case hide the component
			if(objId.getSObjectType() != Schema.SObjectType.Account.getSObjectType() && 
					objId.getSobjectType() != Schema.SObjectType.Case.getSObjectType())
				ow.instruction = 'hide';
			else {
				if(objId.getSobjectType() == Schema.SObjectType.Case.getSObjectType()) {
					objId = getAccountId(objId);
				}
				// get the FieldSet name Conosle. Enables Admin configurable cols in this component
				// using this fieldSet we can build a dynamic query for the data
				if(fieldSets.containsKey('Console')) {
					Schema.FieldSet fieldSet = fieldSets.get('Console');
					String query = 'SELECT ';
					for(Schema.FieldSetMember fsm : fieldSet.getFields()) {
						fieldLabels.add(fsm.getLabel());
						fieldNames.add(fsm.getFieldPath());
	            		query += fsm.getFieldPath() + ', ';
	        		}
	        		query += 'Id FROM Case where  accountId = \''+objectId+'\'';
	        		System.debug('~~ query ['+query+']');	
	        		try {	
	        			cases = (List<Case>)Database.query(query);
	        			ow.instruction = 'show';
	        		} catch (QueryException qe) {
	        			System.debug('~~ query ['+qe.getMessage()+']');
	        			ow.instruction = 'error';
	        			ow.errorMessage = qe.getMessage();	
	        		}
				}
				if(cases.isEmpty()) {
					ow.instruction = 'empty';
	 			} 
	
	 			ow.objects = cases;
	 			ow.parentObjectId = objectId;
	 			ow.fieldLabels = fieldLabels;
	 			ow.fieldNames = fieldNames;
	 			ow.objectLabelPlural = Schema.Sobjecttype.Case.getLabelPlural();			 
			}
		} else {
			ow.instruction = 'hide';
		}
		return JSON.serialize(ow);	
	}
	
	private static Id getAccountId(Id caseId) {
		try {
			Case c = [select id, accountid, contactid from case where id =:caseId limit 1];
			if(c.accountId != null)
				return c.accountId;
			else if (c.contactId != null) {
				Contact con = [select id, accountid from contact where id = :c.contactid];
				return con.accountId;
			}
		} catch(QueryException eq) {
			System.debug('Query Exception ['+eq.getMessage()+']');
		}
		return null;
	}
}