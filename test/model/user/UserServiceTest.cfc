<cfcomponent extends="mxunit.framework.TestCase">

	<cffunction name="testGetUser" returntype="void" access="public" output="false">
		<cfset var userService = createObject("component", "model.user.User").init()/>
		<cfset var user = userService.getUser(username="test")/>
		
		<cfset assertEquals("test", user.getUsername(), "Incorrect username.")/>
	</cffunction>

</cfcomponent>