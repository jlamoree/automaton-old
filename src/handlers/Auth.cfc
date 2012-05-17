<cfcomponent extends="coldbox.system.EventHandler" output="false">

	<cfproperty name="userService" inject="userService"/>
	<cfproperty name="sessionStorage" inject="coldbox:plugin:sessionStorage"/>
	<cfproperty name="log" inject="logbox:logger:{this}"/>

	<cffunction name="index" returntype="void" access="public" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset arguments.event.setValue("pageTitle", "Login")/>
		<cfset arguments.event.setLayout("main")>
		<cfset arguments.event.setView("auth/index")/>
	</cffunction>

	<cffunction name="processLogin" returntype="void" access="public" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset var _event = arguments.event/>
		<cfset var user = "null"/>
		<cfset var result = structNew()/>

		<cfset result.status = "unknown"/>
		<cfset result.message = ""/>

		<cfif not len(_event.getValue("username", "")) or not len(_event.getValue("password", ""))>
			<cfset result.status = "failure"/>
			<cfset result.message = "Please enter your username and password."/>
		</cfif>

		<cfif not result.status eq "failure">
			<cftry>
				<cfset user = variables.userService.getUser(username=_event.getValue("username"))/>
				<cfcatch>
					<cfset result.status = "failure"/>
					<cfset result.message = "Please enter a valid username and password. #cfcatch.message#"/>
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfif result.status eq "failure">
			<cfif structKeyExists(variables, "log") and variables.log.canError()>
				<cfset variables.log.error(result.message)/>
			</cfif>
		</cfif>
		
		<cfif not result.status eq "failure">
			<cfif not user.getIsActive()>
				<cfset result.status = "failure"/>
				<cfset result.message = "Your account is not active."/>
			<cfelseif not user.verifyPassword(_event.getValue("password"))>
				<cfset result.status = "failure"/>
				<cfset result.message = "Please enter a valid username and password."/>
			<cfelse>
				<cfset variables.sessionStorage.setVar("user", user)/>
				<cfset result.status = "success"/>
			</cfif>
		</cfif>

		<cfif result.status eq "success">
			<cfset setNextEvent("Home.index")/>
		<cfelse>
			<cfif structKeyExists(variables, "log") and variables.log.canError()>
				<cfset variables.log.error(result.message)/>
			</cfif>
			<cfset variables.flash.put("result", result)/>
			<cfset setNextEvent("Auth.index")/>
		</cfif>
	</cffunction>

	<cffunction name="logout" returntype="void" access="public" output="false">
		<cfargument name="event" type="coldbox.system.web.context.RequestContext" required="true"/>

		<cfset var _event = arguments.event/>

		<cfif variables.sessionStorage.exists("user")>
			<cfset variables.sessionStorage.deleteVar("user")/>
		</cfif>
		<cfset setNextEvent("Home.index")/>
	</cffunction>

</cfcomponent>
