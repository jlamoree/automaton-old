<cfcomponent extends="coldbox.system.Interceptor" output="false">

	<cfproperty name="sessionStorage" inject="coldbox:plugin:sessionStorage"/>

	<cffunction name="preEvent" access="public" returntype="void" output="false" >
		<cfargument name="event" required="true" type="coldbox.system.web.context.RequestContext"/>
		<cfargument name="interceptData" required="true" type="struct"/>

		<cfset var _event = arguments.event/>

		<cfif _event.getCurrentHandler() eq "Auth">
			<!--- Authentication is in progress --->
			<cfreturn/>
		</cfif>
		
		<cfif variables.sessionStorage.exists("user")>
			<cfset _event.setValue("user", variables.sessionStorage.getVar("user"), true)/>
		</cfif>
	</cffunction>

</cfcomponent>