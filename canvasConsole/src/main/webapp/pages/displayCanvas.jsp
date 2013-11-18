<%@taglib prefix="s" uri="/struts-tags" %>

<h2>Canvas Request</h2>
User ID : <s:property value="canvasRequest.userId"/> 
Signing Algoritm : <s:property value="canvasRequest.algorithm"/>
Issued At : <s:property value="canvasRequest.issuedAt"/>
<div class="section"> 
	<div class="sectionHeading">User Context</div>
	<div class="sectionContent" style="display:block">
		<table>
			<tr><td>User Id</td><td><s:property value="canvasRequest.context.userContext.userId"/></td></tr>
			<tr><td>User Name</td><td><s:property value="canvasRequest.context.userContext.userName"/></td></tr>
    		<tr><td>First Name</td><td><s:property value="canvasRequest.context.userContext.firstName"/></td></tr>
    		<tr><td>Last Name</td><td><s:property value="canvasRequest.context.userContext.lastName"/></td></tr>
   			<tr><td>Email</td><td><s:property value="canvasRequest.context.userContext.email"/></td></tr>
    		<tr><td>Full Name</td><td><s:property value="canvasRequest.context.userContext.fullName"/></td></tr>
    		<tr><td>User Locale</td><td><s:property value="canvasRequest.context.userContext.locale"/></td></tr>
    		<tr><td>Language</td><td><s:property value="canvasRequest.context.userContext.language"/></td></tr>
    		<tr><td>Time Zone</td><td><s:property value="canvasRequest.context.userContext.timeZone"/></td></tr>
    		<tr><td>Profile ID</td><td><s:property value="canvasRequest.context.userContext.profileId"/></td></tr>
    		<tr><td>Role ID</td><td><s:property value="canvasRequest.context.userContext.roleId"/></td></tr>
    		<tr><td>User Type</td><td><s:property value="canvasRequest.context.userContext.userType"/></td></tr>
    		<tr><td>Currency ISO Code</td><td><s:property value="canvasRequest.context.userContext.currencyISOCode"/></td></tr>
    		<tr><td>Accessiblity Mode</td><td><s:property value="canvasRequest.context.userContext.accessibilityMode"/></td></tr>
    		<tr><td>Profile Photo URL</td><td><s:property value="canvasRequest.context.userContext.profilePhotoUrl"/></td></tr> 
    		<tr><td>Profile Thumbnail URL</td><td><s:property value="canvasRequest.context.userContext.profileThumbnailUrl"/></td></tr>
    	</table>
	</div>
</div>
<div class="section">
	<div class="sectionHeading">Org Context</div>
	<div class="sectionContent" style="display:none">
		<table>
			<tr><td>Org ID</td><td><s:property value="canvasRequest.context.organizationContext.organizationId"/></td></tr>
			<tr><td>Org Name</td><td><s:property value="canvasRequest.context.organizationContext.name"/></td></tr>
    		<tr><td>Multi Currency</td><td><s:property value="canvasRequest.context.organizationContext.multicurrencyEnabled"/></td></tr>
    		<tr><td>Currency ISO Code</td><td><s:property value="canvasRequest.context.organizationContext.currencyISOCode"/></td></tr>
		</table>
	</div>
</div>
<div class="section">
	<div class="sectionHeading">Link Context</div>
	<div class="sectionContent" style="display:none">
		<table>
			<tr><td>Enterprise URL</td><td><s:property value="canvasRequest.context.linkContext.enterpriseUrl"/></td></tr>
    		<tr><td>Metadata URL</td><td><s:property value="canvasRequest.context.linkContext.metadataUrl"/></td></tr>
    		<tr><td>Partner URL</td><td><s:property value="canvasRequest.context.linkContext.partnerUrl"/></td></tr>
    		<tr><td>Rest URL</td><td><s:property value="canvasRequest.context.linkContext.restUrl"/></td></tr>
    		<tr><td>SObject URL</td><td><s:property value="canvasRequest.context.linkContext.sobjectUrl"/></td></tr>
    		<tr><td>Search URL</td><td><s:property value="canvasRequest.context.linkContext.searchUrl"/></td></tr>
    		<tr><td>Query URL</td><td><s:property value="canvasRequest.context.linkContext.queryUrl"/></td></tr>
    		<tr><td>Recent Items URL</td><td><s:property value="canvasRequest.context.linkContext.recentItemsUrl"/></td></tr>
    		<tr><td>User Profile URL</td><td><s:property value="canvasRequest.context.linkContext.userProfileUrl"/></td></tr>
    		<tr><td>Chatter Feeds URL</td><td><s:property value="canvasRequest.context.linkContext.chatterFeedsUrl"/></td></tr>
    		<tr><td>Chatter Groups URL</td><td><s:property value="canvasRequest.context.linkContext.chatterGroupsUrl"/></td></tr>
    		<tr><td>Chatter Users URL</td><td><s:property value="canvasRequest.context.linkContext.chatterUsersUrl"/></td></tr>
    		<tr><td>Chatter Feed Items URL</td><td><s:property value="canvasRequest.context.linkContext.chatterFeedItemsUrl"/></td></tr>
		</table>
	</div>
</div>
<div class="section">
	<div class="sectionHeading">Environment Context</div>
	<div class="sectionContent" style="display:none">
		<table>
			<tr><td>Location URL</td><td><s:property value="canvasRequest.context.environmentContext.locationUrl"/></td></tr>
			<tr><td>UI Theme</td><td><s:property value="canvasRequest.context.environmentContext.uiTheme"/></td></tr>
			<tr><td>Dimensions - Width</td><td><s:property value="canvasRequest.context.environmentContext.dimensions.width"/></td></tr>
			<tr><td>Dimensions - Height</td><td><s:property value="canvasRequest.context.environmentContext.dimensions.height"/></td></tr>
			<tr><td>System Version - Season</td><td><s:property value="canvasRequest.context.environmentContext.systemVersion.season"/></td></tr>
			<tr><td>System Version - API</td><td><s:property value="canvasRequest.context.environmentContext.systemVersion.api"/></td></tr>
		</table>
	</div>
</div>
<div class="section">
	<div class="sectionHeading">Canvas Client</div>
	<div class="sectionContent" style="display:none">
		<table>
			<tr><td>OAuth Token</td><td><s:property value="canvasRequest.client.OAuthToken"/></td></tr>
    		<tr><td>Client ID</td><td><s:property value="canvasRequest.client.clientId"/></td></tr>
    		<tr><td>Instance ID</td><td><s:property value="canvasRequest.client.instanceId"/></td></tr>
    		<tr><td>Target Origin</td><td><s:property value="canvasRequest.client.targetOrigin"/></td></tr>
    		<tr><td>Instance URL</td><td><s:property value="canvasRequest.client.instanceUrl"/></td></tr>
		</table>
	</div>
</div>
<script type="text/javascript">
	
	$(document).ready(function(){
		$('.sectionHeading').click(function(event){
            $(this).next('.sectionContent').toggle();  
        });
	});
</script>
