<cfcomponent extends="mxunit.framework.TestCase">

	<cffunction name="testGetUser" returntype="void" access="public" output="false">
		<cfset var userService = createObject("component", "model.user.UserService").init()/>
		<cfset var user = "null"/>

		<cfset user = userService.getUser(username="unittest")/>
		<cfset assertEquals("unittest", user.getUsername(), "Incorrect username.")/>
		<cfset assertEquals("Unit", user.getFirstName(), "Incorrect firstName.")/>
		<cfset assertEquals("Test", user.getLastName(), "Incorrect lastName.")/>
		<cfset assertEquals("test@autocfml.com", user.getEmail(), "Incorrect email.")/>
		
		<cfset assertTrue(user.verifyPassword("password"), "Incorrect password verification.")/>
	</cffunction>

</cfcomponent>