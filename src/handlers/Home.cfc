<cfcomponent extends="coldbox.system.EventHandler" output="false">

	<cffunction name="index" access="public" returntype="void" output="false">
		<cfargument name="event" type="any"/>

		<cfset arguments.event.setValue("pageTitle", "Welcome")/>
		<cfset arguments.event.setLayout("main")>
		<cfset arguments.event.setView("home/index")/>
	</cffunction>

</cfcomponent>
