global with sharing class new_CloseAndNextController {

	
	public new_CloseAndNextController() {}

	@RemoteAction
	global static String closeAndNext(String caseId) {
		
		if(caseId != null ) {
			if(Id.valueOf(caseId).getSObjectType() == Schema.Sobjecttype.CASE.getSObjectType()) {
				try {
					Case c = [select id, status from case where id = :caseId limit 1];
					c.status = 'Closed';
					update c;
					
					List<Case> openCases = [select id from case where ownerid = :UserInfo.getUserId() and status in ('New', 'Escalated') order by lastmodifieddate asc];
					return openCases.get(0).id;
					
				} catch (QueryException qe) {
					// case doesn't exist
				} catch (DMLException dmle) {
					// something happened with the update
				}
			}
		}
		return null;
		
	}
}