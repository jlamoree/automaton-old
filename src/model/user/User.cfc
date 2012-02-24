<cfcomponent accessors="true" output="false">

	<cfproperty name="userId" type="numeric"/>
	<cfproperty name="username" type="string"/>
	<cfproperty name="password" type="string"/>
	<cfproperty name="firstName" type="string"/>
	<cfproperty name="lastName" type="string"/>

	<cffunction name="init" returntype="User" access="public" output="false">
		<cfreturn this/>
	</cffunction>

</cfcomponent>