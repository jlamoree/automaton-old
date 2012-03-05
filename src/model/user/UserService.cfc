<cfcomponent output="false">

	<cffunction name="init" returntype="UserService" access="public" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="getUser" returntype="User" access="public" output="false">
		<cfargument name="userId" type="numeric" required="false" default="0"/>
		<cfargument name="username" type="string" required="false" default=""/>
		
		<cfset var user = "null"/>
		
		<cfif not arguments.userId and not len(arguments.username)>
			<cfthrow type="InvalidArgumentsException" message="The userId or the username must be provided."/>
		</cfif>

		<cfset user = createObject("component", "model.user.User").init()/>
		<cfif arguments.userId gt 0>
			<cfset user.setUserId(arguments.userId)/>
		<cfelse>
			<cfset user.setUsername(arguments.username)/>
		</cfif>
		<cfreturn user/>
	</cffunction>

</cfcomponent>