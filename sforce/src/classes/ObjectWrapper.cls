public class ObjectWrapper {

	public List<SObject> objects {get; set;}
	public List<String> fieldLabels {get;set;}
	public List<String> fieldNames {get;set;}
	public String objectLabelPlural {get; set;}
	
	public String parentObjectId {get; set;}
	public String errorMessage {get; set;}
	public String instruction {get; set;}
	
	public ObjectWrapper() {
	}

}