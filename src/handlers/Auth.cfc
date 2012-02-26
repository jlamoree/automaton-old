<cfcomponent extends="coldbox.system.EventHandler" output="false">

	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" type="any"/>

		<cfset arguments.event.setValue("pageTitle", "Login")/>
		<cfset arguments.event.setLayout("main")>
		<cfset arguments.event.setView("auth/index")/>
	</cffunction>

</cfcomponent>
