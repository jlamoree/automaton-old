<cfcomponent accessors="true" output="false">

	<cfproperty name="userId" type="numeric"/>
	<cfproperty name="username" type="string"/>
	<cfproperty name="passwordSalt" type="string"/>
	<cfproperty name="passwordHash" type="string"/>
	<cfproperty name="firstName" type="string"/>
	<cfproperty name="lastName" type="string"/>
	<cfproperty name="email" type="string"/>
	<cfproperty name="isActive" type="boolean"/>
	<cfproperty name="createDate" type="date"/>
	<cfproperty name="modifyDate" type="date"/>

	<cffunction name="init" returntype="User" access="public" output="false">
		<cfreturn this/>
	</cffunction>

	<cffunction name="setPassword" returntype="void" access="public" output="false">
		<cfargument name="password" type="string" required="true"/>

		<cfset variables.password = arguments.password/>
		<cfset setPasswordHash(createPasswordHash(arguments.password, getUsername()))/>
	</cffunction>

	<cffunction name="verifyPassword" returntype="boolean" access="public" output="false">
		<cfargument name="password" type="string" required="true"/>

		<cfif not structKeyExists(variables, "passwordSalt")>
			<cfreturn false/>
		</cfif>
		<cfreturn compareNoCase(createPasswordHash(arguments.password), getPasswordHash()) eq 0/>
	</cffunction>

	<cffunction name="hasPassword" returntype="boolean" access="public" output="false">
		<cfreturn structKeyExists(variables, "passwordHash") and len(variables.passwordHash) gt 0/>
	</cffunction>
	
	<cffunction name="createPasswordHash" returntype="string" access="public" output="false">
		<cfargument name="password" type="string" required="true" />
		
		<cfif not structKeyExists(variables, "passwordSalt")>
			<cfset variables.passwordSalt = createUUID()/>
		</cfif>
		<cfreturn lcase(hash(arguments.password & variables.passwordSalt, "sha1")) />
	</cffunction>

</cfcomponent>