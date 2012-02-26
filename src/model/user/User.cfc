<cfcomponent output="false">

	<cfproperty name="userId" type="numeric"/>
	<cfproperty name="username" type="string"/>
	<cfproperty name="password" type="string"/>
	<cfproperty name="firstName" type="string"/>
	<cfproperty name="lastName" type="string"/>

	<cffunction name="init" returntype="User" access="public" output="false">
		<cfset foo = "bar"/>
		
		<cfreturn this/>
	</cffunction>

	<cffunction name="getUserId" returntype="numeric" access="public" output="false">
		<cfreturn variables.userId/>
	</cffunction>
	<cffunction name="setUserId" returntype="void" access="public" output="false">
		<cfargument name="userId" type="numeric" required="true"/>
		<cfset variables.userId = arguments.userId/>
	</cffunction>

	<cffunction name="getUsername" returntype="string" access="public" output="false">
		<cfreturn variables.username/>
	</cffunction>
	<cffunction name="setUsername" returntype="void" access="public" output="false">
		<cfargument name="username" type="string" required="true"/>
		<cfset variables.username = arguments.username/>
	</cffunction>

	<cffunction name="getPassword" returntype="string" access="public" output="false">
		<cfreturn variables.password/>
	</cffunction>
	<cffunction name="setPassword" returntype="void" access="public" output="false">
		<cfargument name="password" type="string" required="true"/>
		<cfset variables.password = arguments.password/>
	</cffunction>
	
	<cffunction name="getFirstName" returntype="string" access="public" output="false">
		<cfreturn variables.firstName/>
	</cffunction>
	<cffunction name="setFirstName" returntype="void" access="public" output="false">
		<cfargument name="firstName" type="string" required="true"/>
		<cfset variables.firstName = arguments.firstName/>
	</cffunction>

	<cffunction name="getLastName" returntype="string" access="public" output="false">
		<cfreturn variables.lastName/>
	</cffunction>
	<cffunction name="setLastName" returntype="void" access="public" output="false">
		<cfargument name="lastName" type="string" required="true"/>
		<cfset variables.lastName = arguments.lastName/>
	</cffunction>

</cfcomponent>